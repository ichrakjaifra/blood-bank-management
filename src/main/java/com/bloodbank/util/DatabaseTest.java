package com.bloodbank.util;


import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DatabaseTest {
    public static void main(String[] args) {
        System.out.println("Test de connexion PostgreSQL avec VALIDATE...");

        EntityManagerFactory emf = null;

        try {
            // Tenter de créer EntityManagerFactory avec validate
            emf = Persistence.createEntityManagerFactory("bloodbank_pu");
            System.out.println("EntityManagerFactory créé avec succès!");

            // Test réussi - validate a fonctionné
            System.out.println("CONNEXION RÉUSSIE AVEC VALIDATE !");
            System.out.println("PostgreSQL ←→ Hibernate ←→ Votre Application");
            System.out.println("Hibernate a validé la configuration SANS modifier la base");
            System.out.println("Votre connexion PostgreSQL est PARFAITE !");

        } catch (Exception e) {
            System.out.println("ÉCHEC de connexion ou validation: " + e.getMessage());

            // Analyse de l'erreur
            if (e.getMessage().contains("validate")) {
                System.out.println("INFO: L'erreur vient de la validation Hibernate,");
                System.out.println("mais la connexion PostgreSQL fonctionne probablement !");
            }

        } finally {
            // 3. Nettoyer
            if (emf != null) {
                emf.close();
                System.out.println("Ressources libérées!");
            }
        }
    }
}
