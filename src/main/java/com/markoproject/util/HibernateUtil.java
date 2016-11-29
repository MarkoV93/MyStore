/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.util;

import java.io.File;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *class for connecting to hibernate config file and 
 * returning static initialize SessionFactory 
 * this is realized of singltone pattern
 */
public class HibernateUtil {
  
    private static SessionFactory session;

    static {
        try {
            session = new Configuration().configure().buildSessionFactory();
        } catch (Throwable e) {
           e.printStackTrace();
        }
    }

    public static SessionFactory getSessionFactory() {
        return session;
    }
}
