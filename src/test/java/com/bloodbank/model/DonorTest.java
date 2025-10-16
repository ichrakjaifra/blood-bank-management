package com.bloodbank.model;

import org.junit.jupiter.api.Test;
import java.time.LocalDate;
import static org.junit.jupiter.api.Assertions.*;

public class DonorTest {

    @Test
    public void testDonorEligibility_Valid() {
        // Créer un donneur éligible
        Donor donor = new Donor();
        donor.setCin("AB123456");
        donor.setFirstName("John");
        donor.setLastName("Doe");
        donor.setBirthDate(LocalDate.now().minusYears(25)); // 25 ans
        donor.setWeight(65.0); // > 50kg
        donor.setGender(Gender.MALE);
        donor.setBloodGroup(BloodGroup.O_POSITIVE);

        // Pas de contre-indications médicales
        donor.setHasHepatitisB(false);
        donor.setHasHepatitisC(false);
        donor.setHasHIV(false);
        donor.setHasInsulinDiabetes(false);
        donor.setIsPregnant(false);
        donor.setIsBreastfeeding(false);

        // Déterminer l'éligibilité
        donor.determineEligibility();

        assertEquals(DonorStatus.DISPONIBLE, donor.getStatus());
        assertTrue(donor.isAvailable());
    }

    @Test
    public void testDonorEligibility_Underweight() {
        // Créer un donneur avec poids insuffisant
        Donor donor = new Donor();
        donor.setCin("CD789012");
        donor.setFirstName("Jane");
        donor.setLastName("Smith");
        donor.setBirthDate(LocalDate.now().minusYears(30));
        donor.setWeight(45.0); // < 50kg - NON ÉLIGIBLE
        donor.setGender(Gender.FEMALE);
        donor.setBloodGroup(BloodGroup.A_POSITIVE);

        // Pas de contre-indications médicales
        donor.setHasHepatitisB(false);
        donor.setHasHepatitisC(false);
        donor.setHasHIV(false);
        donor.setHasInsulinDiabetes(false);
        donor.setIsPregnant(false);
        donor.setIsBreastfeeding(false);

        donor.determineEligibility();

        assertEquals(DonorStatus.NON_ELIGIBLE, donor.getStatus());
        assertFalse(donor.isAvailable());
    }

    @Test
    public void testDonorEligibility_WithMedicalCondition() {
        // Créer un donneur avec contre-indication médicale
        Donor donor = new Donor();
        donor.setCin("EF345678");
        donor.setFirstName("Bob");
        donor.setLastName("Johnson");
        donor.setBirthDate(LocalDate.now().minusYears(28));
        donor.setWeight(70.0);
        donor.setGender(Gender.MALE);
        donor.setBloodGroup(BloodGroup.B_POSITIVE);

        // Contre-indication : Hépatite B
        donor.setHasHepatitisB(true); // NON ÉLIGIBLE
        donor.setHasHepatitisC(false);
        donor.setHasHIV(false);
        donor.setHasInsulinDiabetes(false);
        donor.setIsPregnant(false);
        donor.setIsBreastfeeding(false);

        donor.determineEligibility();

        assertEquals(DonorStatus.NON_ELIGIBLE, donor.getStatus());
        assertFalse(donor.isAvailable());
    }

    @Test
    public void testDonorAgeCalculation() {
        Donor donor = new Donor();
        donor.setBirthDate(LocalDate.now().minusYears(30).minusMonths(6));

        assertEquals(30, donor.getAge());
    }
}