package com.bloodbank.controller;

import com.bloodbank.model.Donor;
import com.bloodbank.model.BloodGroup;
import com.bloodbank.model.Gender;
import com.bloodbank.service.DonorService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class DonorServlet extends HttpServlet {

    private final DonorService donorService;

    public DonorServlet() {
        this.donorService = new DonorService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        System.out.println("DonorServlet - Action: " + action);

        try {
            if ("new".equals(action)) {
                showCreateForm(request, response);
            } else if ("edit".equals(action)) {
                showEditForm(request, response);
            } else {
                listDonors(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            listDonors(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        System.out.println("DonorServlet POST - Action: " + action);

        try {
            if ("create".equals(action)) {
                createDonor(request, response);
            } else if ("update".equals(action)) {
                updateDonor(request, response);
            } else if ("delete".equals(action)) {
                deleteDonor(request, response);
            } else {
                listDonors(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            if ("create".equals(action)) {
                showCreateForm(request, response);
            } else if ("update".equals(action)) {
                showEditForm(request, response);
            } else {
                listDonors(request, response);
            }
        }
    }

    private void listDonors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
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

            List<Donor> donors = donorService.findAll();
            request.setAttribute("donors", donors);
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.getRequestDispatcher("/WEB-INF/views/donor/list.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Erreur lors du chargement des donneurs", e);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.getRequestDispatcher("/WEB-INF/views/donor/form.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Erreur lors du chargement du formulaire", e);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donor donor = donorService.findById(id)
                    .orElseThrow(() -> new ServletException("Donneur non trouvé avec l'ID: " + id));

            request.setAttribute("donor", donor);
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.getRequestDispatcher("/WEB-INF/views/donor/form.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            throw new ServletException("ID invalide: " + request.getParameter("id"));
        }
    }

    private void createDonor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Donor donor = extractDonorFromRequest(request);
            donorService.save(donor);
            request.getSession().setAttribute("success", "Donneur créé avec succès");
            response.sendRedirect(request.getContextPath() + "/donors");
        } catch (Exception e) {
            throw new ServletException("Erreur lors de la création du donneur: " + e.getMessage(), e);
        }
    }

    private void updateDonor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donor donor = donorService.findById(id)
                    .orElseThrow(() -> new ServletException("Donneur non trouvé avec l'ID: " + id));

            updateDonorFromRequest(donor, request);
            donorService.save(donor);
            request.getSession().setAttribute("success", "Donneur modifié avec succès");
            response.sendRedirect(request.getContextPath() + "/donors");

        } catch (NumberFormatException e) {
            throw new ServletException("ID invalide: " + request.getParameter("id"));
        }
    }

    private void deleteDonor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            donorService.delete(id);
            request.getSession().setAttribute("success", "Donneur supprimé avec succès");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/donors");
    }

    private Donor extractDonorFromRequest(HttpServletRequest request) {
        Donor donor = new Donor();
        return updateDonorFromRequest(donor, request);
    }

    private Donor updateDonorFromRequest(Donor donor, HttpServletRequest request) {
        donor.setCin(request.getParameter("cin"));
        donor.setFirstName(request.getParameter("firstName"));
        donor.setLastName(request.getParameter("lastName"));
        donor.setPhone(request.getParameter("phone"));

        String birthDateStr = request.getParameter("birthDate");
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            donor.setBirthDate(LocalDate.parse(birthDateStr));
        }

        String weightStr = request.getParameter("weight");
        if (weightStr != null && !weightStr.isEmpty()) {
            donor.setWeight(Double.parseDouble(weightStr));
        }

        String gender = request.getParameter("gender");
        if (gender != null) {
            donor.setGender(Gender.valueOf(gender));
        }

        String bloodGroup = request.getParameter("bloodGroup");
        if (bloodGroup != null) {
            donor.setBloodGroup(BloodGroup.valueOf(bloodGroup));
        }

        // Contre-indications médicales
        donor.setHasHepatitisB("on".equals(request.getParameter("hasHepatitisB")));
        donor.setHasHepatitisC("on".equals(request.getParameter("hasHepatitisC")));
        donor.setHasHIV("on".equals(request.getParameter("hasHIV")));
        donor.setHasInsulinDiabetes("on".equals(request.getParameter("hasInsulinDiabetes")));
        donor.setIsPregnant("on".equals(request.getParameter("isPregnant")));
        donor.setIsBreastfeeding("on".equals(request.getParameter("isBreastfeeding")));

        return donor;
    }
}