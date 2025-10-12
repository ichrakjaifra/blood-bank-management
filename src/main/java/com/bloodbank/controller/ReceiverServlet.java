package com.bloodbank.controller;

import com.bloodbank.model.Receiver;
import com.bloodbank.model.BloodGroup;
import com.bloodbank.model.Gender;
import com.bloodbank.model.MedicalUrgency;
import com.bloodbank.service.ReceiverService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class ReceiverServlet extends HttpServlet {

    private final ReceiverService receiverService;

    public ReceiverServlet() {
        this.receiverService = new ReceiverService();
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
            deleteReceiver(request, response);
        } else {
            listReceivers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createReceiver(request, response);
        } else if ("update".equals(action)) {
            updateReceiver(request, response);
        }
    }

    private void listReceivers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Receiver> receivers = receiverService.findAllByPriority();
        request.setAttribute("receivers", receivers);
        request.setAttribute("bloodGroups", BloodGroup.values());
        request.setAttribute("medicalUrgencies", MedicalUrgency.values());
        request.getRequestDispatcher("/WEB-INF/views/receiver/list.jsp").forward(request, response);
    }

    /*private void listReceivers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Receiver> receivers = receiverService.findAll();
        request.setAttribute("receivers", receivers);
        request.setAttribute("bloodGroups", BloodGroup.values());
        request.setAttribute("medicalUrgencies", MedicalUrgency.values());
        request.getRequestDispatcher("/WEB-INF/views/receiver/list.jsp").forward(request, response);
    }*/

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("bloodGroups", BloodGroup.values());
        request.setAttribute("genders", Gender.values());
        request.setAttribute("medicalUrgencies", MedicalUrgency.values());
        request.getRequestDispatcher("/WEB-INF/views/receiver/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Receiver receiver = receiverService.findById(id)
                    .orElseThrow(() -> new ServletException("Receveur non trouvé"));

            request.setAttribute("receiver", receiver);
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.setAttribute("medicalUrgencies", MedicalUrgency.values());
            request.getRequestDispatcher("/WEB-INF/views/receiver/form.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID invalide");
            listReceivers(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            listReceivers(request, response);
        }
    }

    private void createReceiver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Receiver receiver = extractReceiverFromRequest(request);
            receiverService.save(receiver);
            request.getSession().setAttribute("success", "Receveur créé avec succès");
            response.sendRedirect(request.getContextPath() + "/receivers");

        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la création: " + e.getMessage());
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.setAttribute("medicalUrgencies", MedicalUrgency.values());
            request.getRequestDispatcher("/WEB-INF/views/receiver/form.jsp").forward(request, response);
        }
    }

    private void updateReceiver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Receiver receiver = receiverService.findById(id)
                    .orElseThrow(() -> new ServletException("Receveur non trouvé"));

            updateReceiverFromRequest(receiver, request);
            receiverService.save(receiver);
            request.getSession().setAttribute("success", "Receveur modifié avec succès");
            response.sendRedirect(request.getContextPath() + "/receivers");

        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la modification: " + e.getMessage());
            request.setAttribute("bloodGroups", BloodGroup.values());
            request.setAttribute("genders", Gender.values());
            request.setAttribute("medicalUrgencies", MedicalUrgency.values());
            request.getRequestDispatcher("/WEB-INF/views/receiver/form.jsp").forward(request, response);
        }
    }

    private void deleteReceiver(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(request.getParameter("id"));
            receiverService.delete(id);
            request.getSession().setAttribute("success", "Receveur supprimé avec succès");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/receivers");
    }

    private Receiver extractReceiverFromRequest(HttpServletRequest request) {
        Receiver receiver = new Receiver();
        return updateReceiverFromRequest(receiver, request);
    }

    private Receiver updateReceiverFromRequest(Receiver receiver, HttpServletRequest request) {
        receiver.setCin(request.getParameter("cin"));
        receiver.setFirstName(request.getParameter("firstName"));
        receiver.setLastName(request.getParameter("lastName"));
        receiver.setPhone(request.getParameter("phone"));

        String birthDateStr = request.getParameter("birthDate");
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            receiver.setBirthDate(LocalDate.parse(birthDateStr));
        }

        receiver.setGender(Gender.valueOf(request.getParameter("gender")));
        receiver.setBloodGroup(BloodGroup.valueOf(request.getParameter("bloodGroup")));
        receiver.setMedicalUrgency(MedicalUrgency.valueOf(request.getParameter("medicalUrgency")));

        return receiver;
    }
}