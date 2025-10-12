package com.bloodbank.service;

import com.bloodbank.dao.ReceiverDAO;
import com.bloodbank.model.Receiver;

import java.util.List;
import java.util.Optional;

public class ReceiverService {

    private final ReceiverDAO receiverDAO;

    public ReceiverService() {
        this.receiverDAO = new ReceiverDAO();
    }

    public Optional<Receiver> findById(Long id) {
        return receiverDAO.findById(id);
    }

    public List<Receiver> findAll() {
        List<Receiver> receivers = receiverDAO.findAll();
        receivers.forEach(Receiver::updateStatus);
        return receivers;
    }

    public List<Receiver> findAllByPriority() {
        List<Receiver> receivers = receiverDAO.findAllByPriority();
        receivers.forEach(Receiver::updateStatus);
        return receivers;
    }

    public List<Receiver> findWaitingReceivers() {
        List<Receiver> receivers = receiverDAO.findWaitingReceivers();
        receivers.forEach(Receiver::updateStatus);
        return receivers;
    }

    public Receiver save(Receiver receiver) {
        receiver.updateStatus();
        return receiverDAO.save(receiver);
    }

    public void delete(Long id) {
        receiverDAO.deleteById(id);
    }

    public boolean canReceiverAcceptDonation(Receiver receiver) {
        receiver.updateStatus();
        return receiver.canAcceptMoreDonations();
    }

    public Optional<Receiver> findByCin(String cin) {
        return receiverDAO.findByCin(cin);
    }
}