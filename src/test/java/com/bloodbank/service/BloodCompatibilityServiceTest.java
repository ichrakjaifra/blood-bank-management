package com.bloodbank.service;

import com.bloodbank.model.BloodGroup;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class BloodCompatibilityServiceTest {

    @Test
    public void testO_Negative_Compatibility() {
        // Test que O- (donneur universel) est compatible avec tous les groupes Positifs
        assertTrue(BloodCompatibilityService.isCompatible(BloodGroup.O_NEGATIVE, BloodGroup.O_POSITIVE));
        assertTrue(BloodCompatibilityService.isCompatible(BloodGroup.O_NEGATIVE, BloodGroup.A_POSITIVE));
        assertTrue(BloodCompatibilityService.isCompatible(BloodGroup.O_NEGATIVE, BloodGroup.B_POSITIVE));
        assertTrue(BloodCompatibilityService.isCompatible(BloodGroup.O_NEGATIVE, BloodGroup.AB_POSITIVE));
    }

    @Test
    public void testAB_Positive_Compatibility() {
        // Test de réception pour AB+ (receveur universel)

        // AB+ peut recevoir de lui-même (Vrai)
        assertTrue(BloodCompatibilityService.isCompatible(BloodGroup.AB_POSITIVE, BloodGroup.AB_POSITIVE));

        // AB+ peut recevoir de O+ (Vrai, c'est un receveur universel) - L'erreur était ici!
        assertTrue(BloodCompatibilityService.isCompatible(BloodGroup.O_POSITIVE, BloodGroup.AB_POSITIVE));

        // AB+ peut recevoir de A+ (Vrai) - L'erreur était ici!
        assertTrue(BloodCompatibilityService.isCompatible(BloodGroup.A_POSITIVE, BloodGroup.AB_POSITIVE));

        // Exemple d'incompatibilité avec AB+ (AB+ ne peut pas donner à AB+ mais reçoit de O+ et A+)
        // Pour tester le assertFalse, il faut s'assurer qu'on teste un cas où BloodCompatibilityService.isCompatible donne 'false'.
        // Par exemple: B_POSITIVE ne peut pas recevoir de A_POSITIVE
        assertFalse(BloodCompatibilityService.isCompatible(BloodGroup.A_POSITIVE, BloodGroup.B_POSITIVE));
    }

    @Test
    public void testSameBloodGroupCompatibility() {
        // Test que chaque groupe est compatible avec lui-même
        for (BloodGroup group : BloodGroup.values()) {
            assertTrue(BloodCompatibilityService.isCompatible(group, group),
                    group + " devrait être compatible avec lui-même");
        }
    }
}