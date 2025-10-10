package com.bloodbank.controller;

import com.bloodbank.service.DonorService;
import com.bloodbank.service.ReceiverService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HomeServlet extends HttpServlet {

    private final DonorService donorService;
    private final ReceiverService receiverService;

    public HomeServlet() {
        this.donorService = new DonorService();
        this.receiverService = new ReceiverService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Statistiques pour le dashboard
        long totalDonors = donorService.findAll().size();
        long availableDonors = donorService.findAvailableDonors().size();
        long waitingReceivers = receiverService.findWaitingReceivers().size();
        long satisfiedReceivers = receiverService.findAll().stream()
                .filter(receiver -> receiver.getStatus().toString().equals("SATISFAIT"))
                .count();

        request.setAttribute("donorsCount", totalDonors);
        request.setAttribute("availableDonorsCount", availableDonors);
        request.setAttribute("waitingReceiversCount", waitingReceivers);
        request.setAttribute("satisfiedReceiversCount", satisfiedReceivers);
        request.setAttribute("todayDonations", 0); // À implémenter
        request.setAttribute("compatibilityRate", 85); // Exemple
        request.setAttribute("content", "home-content.jsp");

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}