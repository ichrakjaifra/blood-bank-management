package com.bloodbank.test;

import jakarta.persistence.EntityManager;
import com.bloodbank.util.JPAUtil;

public class TestDBConnection {
    public static void main(String[] args) {
        try {
            EntityManager em = JPAUtil.getEntityManager();
            System.out.println("Database connection successful!");
            em.close();
        } catch (Exception e) {
            System.out.println("Database connection failed!");
            e.printStackTrace();
        }
    }
}