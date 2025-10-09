package com.bloodbank.service;

import com.bloodbank.dao.DonorDAO;
import com.bloodbank.model.Donor;
import com.bloodbank.model.DonorStatus;

import java.util.List;
import java.util.Optional;

public class DonorService {

    private final DonorDAO donorDAO;

    public DonorService() {
        this.donorDAO = new DonorDAO();
    }

    public Optional<Donor> findById(Long id) {
        return donorDAO.findById(id);
    }

    public List<Donor> findAll() {
        return donorDAO.findAll();
    }

    public List<Donor> findAvailableDonors() {
        return donorDAO.findAvailableDonors();
    }

    public Donor save(Donor donor) {
        donor.determineEligibility();
        return donorDAO.save(donor);
    }

    public void delete(Long id) {
        donorDAO.deleteById(id);
    }

    public boolean isDonorAvailable(Donor donor) {
        return donor.isAvailable();
    }

    public Optional<Donor> findByCin(String cin) {
        return donorDAO.findByCin(cin);
    }

    public List<Donor> findByStatus(DonorStatus status) {
        return donorDAO.findByStatus(status);
    }
}