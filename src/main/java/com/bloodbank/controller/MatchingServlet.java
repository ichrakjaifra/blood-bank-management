package com.bloodbank.controller;

import com.bloodbank.model.Donation;
import com.bloodbank.model.Donor;
import com.bloodbank.model.Receiver;
import com.bloodbank.service.DonationService;
import com.bloodbank.service.DonorService;
import com.bloodbank.service.ReceiverService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class MatchingServlet extends HttpServlet {

    private final DonationService donationService;
    private final DonorService donorService;
    private final ReceiverService receiverService;

    public MatchingServlet() {
        this.donationService = new DonationService();
        this.donorService = new DonorService();
        this.receiverService = new ReceiverService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("showMatching".equals(action)) {
                showMatchingInterface(request, response);
            } else if ("findCompatibleDonors".equals(action)) {
                findCompatibleDonors(request, response);
            } else if ("findCompatibleReceivers".equals(action)) {
                findCompatibleReceivers(request, response);
            } else {
                listAllDonations(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            listAllDonations(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("createDonation".equals(action)) {
                createDonation(request, response);
            } else if ("cancelDonation".equals(action)) {
                cancelDonation(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            showMatchingInterface(request, response);
        }
    }

    private void showMatchingInterface(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // NETTOYAGE DES MESSAGES DE SESSION
        HttpSession session = request.getSession();
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");

        // Transférer les messages de la session vers la request
        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("success"); // Supprimer de la session
        }
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error"); // Supprimer de la session
        }

        List<Donor> availableDonors = donorService.findAvailableDonors();
        List<Receiver> waitingReceivers = receiverService.findWaitingReceivers();
        List<Donation> activeDonations = donationService.findAllActiveDonations();

        request.setAttribute("availableDonors", availableDonors);
        request.setAttribute("waitingReceivers", waitingReceivers);
        request.setAttribute("activeDonations", activeDonations);

        request.getRequestDispatcher("/WEB-INF/views/matching/matching.jsp").forward(request, response);
    }

    private void findCompatibleDonors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // NETTOYAGE DES MESSAGES DE SESSION
        HttpSession session = request.getSession();
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");

        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("success");
        }
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }

        Long receiverId = Long.parseLong(request.getParameter("receiverId"));
        Receiver receiver = receiverService.findById(receiverId)
                .orElseThrow(() -> new ServletException("Receveur non trouvé"));

        List<Donor> compatibleDonors = donationService.findCompatibleDonorsForReceiver(receiver);

        request.setAttribute("receiver", receiver);
        request.setAttribute("compatibleDonors", compatibleDonors);
        request.getRequestDispatcher("/WEB-INF/views/matching/compatibleDonors.jsp").forward(request, response);
    }

    private void findCompatibleReceivers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // NETTOYAGE DES MESSAGES DE SESSION
        HttpSession session = request.getSession();
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");

        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("success");
        }
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }

        Long donorId = Long.parseLong(request.getParameter("donorId"));
        Donor donor = donorService.findById(donorId)
                .orElseThrow(() -> new ServletException("Donneur non trouvé"));

        List<Receiver> compatibleReceivers = donationService.findCompatibleReceiversForDonor(donor);

        request.setAttribute("donor", donor);
        request.setAttribute("compatibleReceivers", compatibleReceivers);
        request.getRequestDispatcher("/WEB-INF/views/matching/compatibleReceivers.jsp").forward(request, response);
    }

    private void listAllDonations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // NETTOYAGE DES MESSAGES DE SESSION
        HttpSession session = request.getSession();
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");

        if (success != null) {
            request.setAttribute("success", success);
            session.removeAttribute("success");
        }
        if (error != null) {
            request.setAttribute("error", error);
            session.removeAttribute("error");
        }

        List<Donation> donations = donationService.findAllActiveDonations();
        request.setAttribute("donations", donations);
        request.getRequestDispatcher("/WEB-INF/views/matching/list.jsp").forward(request, response);
    }

    private void createDonation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long donorId = Long.parseLong(request.getParameter("donorId"));
            Long receiverId = Long.parseLong(request.getParameter("receiverId"));

            Donation donation = donationService.createDonation(donorId, receiverId);

            request.getSession().setAttribute("success", "Donation créée avec succès");
            response.sendRedirect(request.getContextPath() + "/matching?action=showMatching");

        } catch (Exception e) {
            throw new ServletException("Erreur lors de la création de la donation: " + e.getMessage(), e);
        }
    }

    private void cancelDonation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long donationId = Long.parseLong(request.getParameter("donationId"));
            donationService.cancelDonation(donationId);

            request.getSession().setAttribute("success", "Donation annulée avec succès");
            response.sendRedirect(request.getContextPath() + "/matching?action=showMatching");

        } catch (Exception e) {
            throw new ServletException("Erreur lors de l'annulation de la donation: " + e.getMessage(), e);
        }
    }
}