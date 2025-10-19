package com.bloodbank.model;

public enum Gender {
    MALE("Masculin"), FEMALE("Féminin");

    private final String displayName;

    Gender(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
