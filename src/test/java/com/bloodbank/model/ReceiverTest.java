package com.bloodbank.model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class ReceiverTest {

    @Test
    public void testReceiverStatus_Satisfied() {
        Receiver receiver = new Receiver();
        receiver.setMedicalUrgency(MedicalUrgency.NORMAL); // Nécessite 1 sac

        // Simuler qu'il a reçu 1 don (normalement via donations)
        // Pour simplifier le test, on va vérifier la logique métier
        receiver.updateStatus();

        // Initialement, le status devrait être EN_ATTENTE
        assertEquals(ReceiverStatus.EN_ATTENTE, receiver.getStatus());

        // Note: Pour un test complet, il faudrait mock les donations
    }

    @Test
    public void testMedicalUrgencyRequiredBags() {
        assertEquals(1, MedicalUrgency.NORMAL.getRequiredBags());
        assertEquals(3, MedicalUrgency.URGENT.getRequiredBags());
        assertEquals(4, MedicalUrgency.CRITIQUE.getRequiredBags());
    }
}