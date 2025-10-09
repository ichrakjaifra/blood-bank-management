package com.bloodbank.dao;

import com.bloodbank.model.MedicalUrgency;
import com.bloodbank.model.Receiver;
import com.bloodbank.model.ReceiverStatus;

import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

public class ReceiverDAO extends GenericDAOImpl<Receiver, Long> {

    public Optional<Receiver> findByCin(String cin) {
        EntityManager em = getEntityManager();
        try {
            Receiver receiver = (Receiver) em.createQuery(
                            "SELECT r FROM Receiver r WHERE r.cin = :cin")
                    .setParameter("cin", cin)
                    .getSingleResult();
            return Optional.ofNullable(receiver);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Receiver> findByStatus(ReceiverStatus status) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT r FROM Receiver r WHERE r.status = :status ORDER BY r.medicalUrgency, r.firstName")
                    .setParameter("status", status)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Receiver> findWaitingReceivers() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT r FROM Receiver r WHERE r.status = 'EN_ATTENTE' " +
                                    "ORDER BY " +
                                    "CASE r.medicalUrgency " +
                                    "WHEN 'CRITIQUE' THEN 1 " +
                                    "WHEN 'URGENT' THEN 2 " +
                                    "WHEN 'NORMAL' THEN 3 " +
                                    "END, r.registrationDate")
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Receiver> findByMedicalUrgency(MedicalUrgency urgency) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT r FROM Receiver r WHERE r.medicalUrgency = :urgency ORDER BY r.registrationDate")
                    .setParameter("urgency", urgency)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}