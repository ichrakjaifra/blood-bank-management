package com.bloodbank.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.Period;

@Entity
@Table(name = "donors")
public class Donor {
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

    @Column(nullable = false)
    private Double weight;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Gender gender;

    @Enumerated(EnumType.STRING)
    @Column(name = "blood_group", nullable = false)
    private BloodGroup bloodGroup;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DonorStatus status;

    // Contre-indications médicales
    @Column(name = "has_hepatitis_b")
    private Boolean hasHepatitisB = false;

    @Column(name = "has_hepatitis_c")
    private Boolean hasHepatitisC = false;

    @Column(name = "has_hiv")
    private Boolean hasHIV = false;

    @Column(name = "has_insulin_diabetes")
    private Boolean hasInsulinDiabetes = false;

    @Column(name = "is_pregnant")
    private Boolean isPregnant = false;

    @Column(name = "is_breastfeeding")
    private Boolean isBreastfeeding = false;

    @Column(name = "registration_date")
    private LocalDate registrationDate;

    // Constructeurs
    public Donor() {
        this.registrationDate = LocalDate.now();
        this.status = DonorStatus.DISPONIBLE;
    }

    // Getters et Setters (générer avec Alt+Insert dans IntelliJ)
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

    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }

    public Gender getGender() { return gender; }
    public void setGender(Gender gender) { this.gender = gender; }

    public BloodGroup getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(BloodGroup bloodGroup) { this.bloodGroup = bloodGroup; }

    public DonorStatus getStatus() { return status; }
    public void setStatus(DonorStatus status) { this.status = status; }

    public Boolean getHasHepatitisB() { return hasHepatitisB; }
    public void setHasHepatitisB(Boolean hasHepatitisB) { this.hasHepatitisB = hasHepatitisB; }

    public Boolean getHasHepatitisC() { return hasHepatitisC; }
    public void setHasHepatitisC(Boolean hasHepatitisC) { this.hasHepatitisC = hasHepatitisC; }

    public Boolean getHasHIV() { return hasHIV; }
    public void setHasHIV(Boolean hasHIV) { this.hasHIV = hasHIV; }

    public Boolean getHasInsulinDiabetes() { return hasInsulinDiabetes; }
    public void setHasInsulinDiabetes(Boolean hasInsulinDiabetes) { this.hasInsulinDiabetes = hasInsulinDiabetes; }

    public Boolean getIsPregnant() { return isPregnant; }
    public void setIsPregnant(Boolean isPregnant) { this.isPregnant = isPregnant; }

    public Boolean getIsBreastfeeding() { return isBreastfeeding; }
    public void setIsBreastfeeding(Boolean isBreastfeeding) { this.isBreastfeeding = isBreastfeeding; }

    public LocalDate getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(LocalDate registrationDate) { this.registrationDate = registrationDate; }

    // Méthodes métier
    public int getAge() {
        return Period.between(birthDate, LocalDate.now()).getYears();
    }

    public void determineEligibility() {
        int age = getAge();
        boolean ageValid = age >= 18 && age <= 65;
        boolean weightValid = weight >= 50.0;
        boolean medicalConditionsValid = !hasHepatitisB && !hasHepatitisC && !hasHIV
                && !hasInsulinDiabetes && !isPregnant && !isBreastfeeding;

        if (ageValid && weightValid && medicalConditionsValid) {
            this.status = DonorStatus.DISPONIBLE;
        } else {
            this.status = DonorStatus.NON_ELIGIBLE;
        }
    }

    public boolean isAvailable() {
        return status == DonorStatus.DISPONIBLE;
    }

    @Transient
    public String getFullName() {
        return firstName + " " + lastName;
    }
}