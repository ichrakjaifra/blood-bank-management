package com.bloodbank.model;

public enum MedicalUrgency {
    CRITIQUE(4), URGENT(3), NORMAL(1);

    private final int requiredBags;

    MedicalUrgency(int requiredBags) {
        this.requiredBags = requiredBags;
    }

    public int getRequiredBags() {
        return requiredBags;
    }
}
