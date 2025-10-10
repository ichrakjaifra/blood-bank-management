package com.bloodbank.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JPAUtil {
    private static final Logger logger = LoggerFactory.getLogger(JPAUtil.class);
    private static final String PERSISTENCE_UNIT_NAME = "bloodbank_pu";
    private static EntityManagerFactory factory;

    static {
        try {
            logger.info("Initializing EntityManagerFactory for PU: {}", PERSISTENCE_UNIT_NAME);
            factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
            logger.info("EntityManagerFactory initialized successfully");
        } catch (Exception e) {
            logger.error("Failed to initialize EntityManagerFactory", e);
            throw new ExceptionInInitializerError("Failed to create EntityManagerFactory: " + e.getMessage());
        }
    }

    public static EntityManager getEntityManager() {
        if (factory == null) {
            throw new IllegalStateException("EntityManagerFactory is not initialized");
        }
        return factory.createEntityManager();
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return factory;
    }

    public static void closeFactory() {
        if (factory != null && factory.isOpen()) {
            factory.close();
            factory = null;
        }
    }
}