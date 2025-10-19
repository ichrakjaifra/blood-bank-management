package com.bloodbank.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class JPAUtil {
    private static final String PERSISTENCE_UNIT_NAME = "bloodbank_pu";
    private static EntityManagerFactory factory;

    static {
        try {
            Properties props = new Properties();

            // Use classloader instead of absolute path — works inside JAR/WAR
            try (InputStream input = JPAUtil.class.getClassLoader()
                    .getResourceAsStream("config.properties")) {
                if (input == null) {
                    throw new RuntimeException("config.properties not found in classpath!");
                }
                props.load(input);
            }

            Map<String, String> dbSettings = new HashMap<>();
            dbSettings.put("jakarta.persistence.jdbc.url", props.getProperty("DB_URL"));
            dbSettings.put("jakarta.persistence.jdbc.user", props.getProperty("DB_USER"));
            dbSettings.put("jakarta.persistence.jdbc.password", props.getProperty("DB_PASSWORD"));

            factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME, dbSettings);
            System.out.println(" Database connection initialized successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError(" Failed to create EntityManagerFactory!");
        }
    }

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }

    public static void closeFactory() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}