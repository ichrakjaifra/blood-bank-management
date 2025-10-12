package com.bloodbank.dao;

import com.bloodbank.model.Donation;
import com.bloodbank.model.Donor;
import com.bloodbank.model.Receiver;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

public class DonationDAO extends GenericDAOImpl<Donation, Long> {

    @SuppressWarnings("unchecked")
    public List<Donation> findByDonor(Donor donor) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Donation d WHERE d.donor = :donor AND d.isActive = true")
                    .setParameter("donor", donor)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Donation> findByReceiver(Receiver receiver) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Donation d WHERE d.receiver = :receiver AND d.isActive = true")
                    .setParameter("receiver", receiver)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Donation> findActiveDonations() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Donation d WHERE d.isActive = true ORDER BY d.donationDate DESC")
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Donation> findActiveDonationByDonor(Donor donor) {
        EntityManager em = getEntityManager();
        try {
            Donation donation = (Donation) em.createQuery(
                            "SELECT d FROM Donation d WHERE d.donor = :donor AND d.isActive = true")
                    .setParameter("donor", donor)
                    .getSingleResult();
            return Optional.ofNullable(donation);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }
}