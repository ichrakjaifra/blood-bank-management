package com.bloodbank.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "receivers")
public class Receiver {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "cin", unique = true, nullable = false)
    private String cin;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    private String phone;

    @Column(name = "birth_date", nullable = false)
    private LocalDate birthDate;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Gender gender;

    @Enumerated(EnumType.STRING)
    @Column(name = "blood_group", nullable = false)
    private BloodGroup bloodGroup;

    @Enumerated(EnumType.STRING)
    @Column(name = "medical_urgency", nullable = false)
    private MedicalUrgency medicalUrgency;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ReceiverStatus status;

    @Column(name = "registration_date")
    private LocalDate registrationDate;

    @OneToMany(mappedBy = "receiver", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Donation> donations = new ArrayList<>();

    // Constructeurs
    public Receiver() {
        this.registrationDate = LocalDate.now();
        this.status = ReceiverStatus.EN_ATTENTE;
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCin() { return cin; }
    public void setCin(String cin) { this.cin = cin; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public LocalDate getBirthDate() { return birthDate; }
    public void setBirthDate(LocalDate birthDate) { this.birthDate = birthDate; }

    public Gender getGender() { return gender; }
    public void setGender(Gender gender) { this.gender = gender; }

    public BloodGroup getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(BloodGroup bloodGroup) { this.bloodGroup = bloodGroup; }

    public MedicalUrgency getMedicalUrgency() { return medicalUrgency; }
    public void setMedicalUrgency(MedicalUrgency medicalUrgency) { this.medicalUrgency = medicalUrgency; }

    public ReceiverStatus getStatus() { return status; }
    public void setStatus(ReceiverStatus status) { this.status = status; }

    public LocalDate getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(LocalDate registrationDate) { this.registrationDate = registrationDate; }

    public List<Donation> getDonations() { return donations; }
    public void setDonations(List<Donation> donations) { this.donations = donations; }

    // Méthodes métier
    public int getAge() {
        return java.time.Period.between(birthDate, LocalDate.now()).getYears();
    }

    public int getCurrentDonationCount() {
        return donations.size();
    }

    public int getRequiredDonationCount() {
        return medicalUrgency.getRequiredBags();
    }

    public boolean isSatisfied() {
        return getCurrentDonationCount() >= getRequiredDonationCount();
    }

    public void updateStatus() {
        if (isSatisfied()) {
            this.status = ReceiverStatus.SATISFAIT;
        } else {
            this.status = ReceiverStatus.EN_ATTENTE;
        }
    }

    public boolean canAcceptMoreDonations() {
        return !isSatisfied() && status != ReceiverStatus.SATISFAIT;
    }

    @Transient
    public String getFullName() {
        return firstName + " " + lastName;
    }
}