package com.bloodbank.dao;

import com.bloodbank.model.Donation;
import com.bloodbank.model.Donor;
import com.bloodbank.model.DonorStatus;
import com.bloodbank.model.Receiver;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;
import java.util.Optional;

public class DonationDAO extends GenericDAOImpl<Donation, Long> {

    @Override
    public Optional<Donation> findById(Long id) {
        EntityManager em = getEntityManager();
        try {
            Donation donation = (Donation) em.createQuery(
                            "SELECT d FROM Donation d " +
                                    "LEFT JOIN FETCH d.donor " +
                                    "LEFT JOIN FETCH d.receiver " +
                                    "LEFT JOIN FETCH d.receiver.donations " + // Charger la collection!
                                    "WHERE d.id = :id")
                    .setParameter("id", id)
                    .getSingleResult();
            return Optional.ofNullable(donation);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public List<Donation> findByDonor(Donor donor) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                            "SELECT d FROM Donation d " +
                                    "JOIN FETCH d.donor " +
                                    "JOIN FETCH d.receiver " +
                                    "WHERE d.donor = :donor AND d.isActive = true")
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
                            "SELECT d FROM Donation d " +
                                    "JOIN FETCH d.donor " +
                                    "JOIN FETCH d.receiver " +
                                    "WHERE d.receiver = :receiver AND d.isActive = true")
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
                            "SELECT d FROM Donation d " +
                                    "JOIN FETCH d.donor " +
                                    "JOIN FETCH d.receiver " +
                                    "WHERE d.isActive = true ORDER BY d.donationDate DESC")
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public Optional<Donation> findActiveDonationByDonor(Donor donor) {
        EntityManager em = getEntityManager();
        try {
            Donation donation = (Donation) em.createQuery(
                            "SELECT d FROM Donation d " +
                                    "JOIN FETCH d.donor " +
                                    "JOIN FETCH d.receiver " +
                                    "WHERE d.donor = :donor AND d.isActive = true")
                    .setParameter("donor", donor)
                    .getSingleResult();
            return Optional.ofNullable(donation);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public boolean cancelDonationWithAllAssociations(Long donationId) {
        EntityManager em = getEntityManager();
        EntityTransaction transaction = null;
        try {
            transaction = em.getTransaction();
            transaction.begin();

            // Charger la donation avec TOUTES les associations
            Donation donation = (Donation) em.createQuery(
                            "SELECT d FROM Donation d " +
                                    "LEFT JOIN FETCH d.donor " +
                                    "LEFT JOIN FETCH d.receiver r " +
                                    "LEFT JOIN FETCH r.donations " +
                                    "WHERE d.id = :id")
                    .setParameter("id", donationId)
                    .getSingleResult();

            if (donation != null) {
                donation.setIsActive(false);

                // Mettre à jour le donneur
                Donor donor = donation.getDonor();
                donor.setStatus(DonorStatus.DISPONIBLE);
                em.merge(donor);

                // Mettre à jour le receveur
                Receiver receiver = donation.getReceiver();
                receiver.updateStatus(); // Cette méthode utilise probablement la collection donations
                em.merge(receiver);

                em.merge(donation);
            }

            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de l'annulation de la donation", e);
        } finally {
            em.close();
        }
    }
}