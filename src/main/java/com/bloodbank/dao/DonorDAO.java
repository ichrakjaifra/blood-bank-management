package com.bloodbank.dao;

import com.bloodbank.model.Donor;
import com.bloodbank.model.DonorStatus;

import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

public class DonorDAO extends GenericDAOImpl<Donor, Long> {

    public Optional<Donor> findByCin(String cin) {
        EntityManager em = getEntityManager();
        try {
            Donor donor = (Donor) em.createQuery(
                            "SELECT d FROM Donor d WHERE d.cin = :cin")
                    .setParameter("cin", cin)
                    .getSingleResult();
            return Optional.ofNullable(donor);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Donor> findByStatus(DonorStatus status) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Donor d WHERE d.status = :status ORDER BY d.firstName, d.lastName")
                    .setParameter("status", status)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Donor> findAvailableDonors() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Donor d WHERE d.status = 'DISPONIBLE' ORDER BY d.firstName, d.lastName")
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Donor> findByBloodGroup(com.bloodbank.model.BloodGroup bloodGroup) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Donor d WHERE d.bloodGroup = :bloodGroup ORDER BY d.status, d.firstName")
                    .setParameter("bloodGroup", bloodGroup)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}