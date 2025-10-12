package com.bloodbank.service;

import com.bloodbank.dao.DonationDAO;
import com.bloodbank.dao.DonorDAO;
import com.bloodbank.dao.ReceiverDAO;
import com.bloodbank.model.Donation;
import com.bloodbank.model.Donor;
import com.bloodbank.model.Receiver;
import com.bloodbank.model.DonorStatus;
import com.bloodbank.model.ReceiverStatus;
import java.util.stream.Collectors;

import java.util.List;
import java.util.Optional;

public class DonationService {

    private final DonationDAO donationDAO;
    private final DonorDAO donorDAO;
    private final ReceiverDAO receiverDAO;
    private final BloodCompatibilityService compatibilityService;

    public DonationService() {
        this.donationDAO = new DonationDAO();
        this.donorDAO = new DonorDAO();
        this.receiverDAO = new ReceiverDAO();
        this.compatibilityService = new BloodCompatibilityService();
    }

    public Donation createDonation(Long donorId, Long receiverId) {
        Optional<Donor> donorOpt = donorDAO.findById(donorId);
        Optional<Receiver> receiverOpt = receiverDAO.findById(receiverId);

        if (donorOpt.isEmpty() || receiverOpt.isEmpty()) {
            throw new IllegalArgumentException("Donneur ou receveur non trouvé");
        }

        Donor donor = donorOpt.get();
        Receiver receiver = receiverOpt.get();

        // Validation des règles métier
        validateDonation(donor, receiver);

        // Création de la donation
        Donation donation = new Donation(donor, receiver);

        // Mise à jour des statuts
        donor.setStatus(DonorStatus.NON_DISPONIBLE);
        receiver.updateStatus();

        // Sauvegarde
        donorDAO.save(donor);
        receiverDAO.save(receiver);
        return donationDAO.save(donation);
    }

    private void validateDonation(Donor donor, Receiver receiver) {
        // Vérifier si le donneur est disponible
        if (!donor.isAvailable()) {
            throw new IllegalStateException("Le donneur n'est pas disponible");
        }

        // Vérifier la compatibilité sanguine
        if (!compatibilityService.isCompatible(donor.getBloodGroup(), receiver.getBloodGroup())) {
            throw new IllegalStateException("Incompatibilité sanguine");
        }

        // Vérifier si le receveur peut accepter plus de dons
        if (!receiver.canAcceptMoreDonations()) {
            throw new IllegalStateException("Le receveur ne peut plus accepter de dons");
        }

        // Vérifier si le donneur n'est pas déjà associé
        Optional<Donation> existingDonation = donationDAO.findActiveDonationByDonor(donor);
        if (existingDonation.isPresent()) {
            throw new IllegalStateException("Le donneur est déjà associé à un receveur");
        }
    }

    public List<Donation> findAllActiveDonations() {
        return donationDAO.findActiveDonations();
    }

    public List<Donation> findByDonor(Donor donor) {
        return donationDAO.findByDonor(donor);
    }

    public List<Donation> findByReceiver(Receiver receiver) {
        return donationDAO.findByReceiver(receiver);
    }

    public void cancelDonation(Long donationId) {
        Optional<Donation> donationOpt = donationDAO.findById(donationId);
        if (donationOpt.isPresent()) {
            Donation donation = donationOpt.get();
            donation.setIsActive(false);

            // Réactiver le donneur
            Donor donor = donation.getDonor();
            donor.setStatus(DonorStatus.DISPONIBLE);

            // Mettre à jour le receveur
            Receiver receiver = donation.getReceiver();
            receiver.updateStatus();

            donationDAO.save(donation);
            donorDAO.save(donor);
            receiverDAO.save(receiver);
        }
    }

    public List<Donor> findCompatibleDonorsForReceiver(Receiver receiver) {
        return donorDAO.findAvailableDonors().stream()
                .filter(donor -> compatibilityService.isCompatible(donor.getBloodGroup(), receiver.getBloodGroup()))
                .collect(Collectors.toList());

    }

    public List<Receiver> findCompatibleReceiversForDonor(Donor donor) {
        return receiverDAO.findWaitingReceivers().stream()
                .filter(receiver -> compatibilityService.isCompatible(donor.getBloodGroup(), receiver.getBloodGroup()))
                .filter(Receiver::canAcceptMoreDonations)
                .collect(Collectors.toList());

    }
}