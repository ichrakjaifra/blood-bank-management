package com.bloodbank.controller;

import com.bloodbank.model.Donor;
import com.bloodbank.model.BloodGroup;
import com.bloodbank.model.Gender;
import com.bloodbank.service.DonorService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

        if ("new".equals(action)) {
            showCreateForm(request, response);
        } else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else if ("delete".equals(action)) {
            deleteDonor(request, response);
        } else {
            listDonors(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createDonor(request, response);
        } else if ("update".equals(action)) {
            updateDonor(request, response);
        }
    }

    private void listDonors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Donor> donors = donorService.findAll();
        request.setAttribute("donors", donors);
        request.setAttribute("bloodGroups", BloodGroup.values());
        request.getRequestDispatcher("/WEB-INF/views/donor/list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("bloodGroups", BloodGroup.values());
        request.setAttribute("genders", Gender.values());
        request.getRequestDispatcher("/WEB-INF/views/donor/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donor donor = donorService.findById(id)
                    .orElseThrow(() -> new ServletException("Donneur non trouvé"));

            request.setAttribute("donor", donor);
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.getRequestDispatcher("/WEB-INF/views/donor/form.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID invalide");
            listDonors(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            listDonors(request, response);
        }
    }

    private void createDonor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Donor donor = extractDonorFromRequest(request);
            donorService.save(donor);
            request.setAttribute("success", "Donneur créé avec succès");
            response.sendRedirect(request.getContextPath() + "/donors");

        } catch (Exception e) {

            request.setAttribute("error", "Erreur lors de la création: " + e.getMessage());
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.getRequestDispatcher("/WEB-INF/views/donor/form.jsp").forward(request, response);
        }
    }

    private void updateDonor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donor donor = donorService.findById(id)
                    .orElseThrow(() -> new ServletException("Donneur non trouvé"));

            updateDonorFromRequest(donor, request);
            donorService.save(donor);
            request.setAttribute("success", "Donneur modifié avec succès");
            response.sendRedirect(request.getContextPath() + "/donors");

        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la modification: " + e.getMessage());
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.getRequestDispatcher("/WEB-INF/views/donor/form.jsp").forward(request, response);
        }
    }

    private void deleteDonor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            donorService.delete(id);
            request.setAttribute("success", "Donneur supprimé avec succès");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }

        listDonors(request, response);
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

        donor.setGender(Gender.valueOf(request.getParameter("gender")));
        donor.setBloodGroup(BloodGroup.valueOf(request.getParameter("bloodGroup")));

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