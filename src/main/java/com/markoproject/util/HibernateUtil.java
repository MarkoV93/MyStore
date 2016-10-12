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
 *
 * @author Marko
 */
public class HibernateUtil {

    private static SessionFactory session;

    static {
        try {
            File f = new File("C:\\Users\\Marko\\Documents\\NetBeansProjects\\MyStore\\src\\main\\java\\hibernate.cfg.xml");
            session = new Configuration().configure(f).buildSessionFactory();
        } catch (Throwable e) {
           e.printStackTrace();
        }
    }

    public static SessionFactory getSessionFactory() {
        return session;
    }
}
