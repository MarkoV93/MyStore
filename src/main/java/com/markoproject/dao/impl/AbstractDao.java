/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao.impl;

import com.markoproject.dao.ProductDao;
import com.markoproject.table.Category;
import com.markoproject.table.Product;
import com.markoproject.util.HibernateUtil;
import java.sql.SQLException;
import java.util.List;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Marko
 */
public abstract class AbstractDao {

    protected Session session;
    protected Transaction tx;
    private static final Logger logger = LogManager.getLogger(AbstractDao.class);

    public AbstractDao() {

    }

    protected boolean saveOrUpdate(Object obj) {
        try {
            startOperation();
            session.saveOrUpdate(obj);
            tx.commit();
            return true;
        } catch (HibernateException e) {
            logger.warn("jbject doesn't created" + e.getCause());
            return false;

        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.error("connection doun't clouse" + e.getCause());
                }
            }
        }
    }

    protected boolean delete(Class clazz, int id) {
        try {
            startOperation();
            session.delete(session.load(clazz, id));
            tx.commit();
            return true;
        } catch (HibernateException e) {
            logger.warn("object doesn't deleted" + e.getCause());
            e.printStackTrace();
            return false;

        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection doun't clouse" + e.getCause());
                }
            }
        }
    }

    protected Object get(Class clazz, int id) {
        Object obj = null;
        try {
            startOperation();
            obj = session.get(clazz, id);
            tx.commit();
        } catch (HibernateException e) {
            logger.error("object not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection doun't clouse" + e.getCause());
                }
            }
        }
        return obj;
    }

    protected List getAllActive(Class clazz) {
        List objects = null;
        try {
            startOperation();
            Criteria objectCriteria = session.createCriteria(clazz);
            objectCriteria.add(Restrictions.eq("activeStatus", Boolean.TRUE));
            objects = objectCriteria.list();
            tx.commit();
        } catch (HibernateException e) {
            logger.error("object not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection doun't clouse" + e.getCause());
                }
            }
        }
        return objects;
    }

    protected List getAll(Class clazz) {
        List objects = null;
        try {
            startOperation();
            Query query = session.createQuery("from " + clazz.getName());
            objects = query.list();
            tx.commit();
        } catch (HibernateException e) {
            logger.error("object not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection doun't clouse" + e.getCause());
                }
            }
        }
        return objects;
    }

    protected List getAll(Class clazz, int page) throws SQLException {
        List objects = null;
        try {
            startOperation();
            Query query = session.createQuery("from " + clazz.getName());

            query.setFirstResult(page * 10);
            query.setMaxResults(10);
            objects = query.list();
            tx.commit();
        } catch (HibernateException e) {
            logger.error("object not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection doun't clouse" + e.getCause());
                }
            }
        }
        return objects;
    }

    protected Object getByName(Class clazz, String name) {
        Object result = null;
        try {
            startOperation();
            Criteria categoryCriteria = session.createCriteria(clazz);
            categoryCriteria.add(Restrictions.eq("name", name));
            result =  categoryCriteria.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            logger.error("category not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection doun't clouse" + e.getCause());
                }
            }
        }
        return result;
    }

    protected void startOperation() {
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
        } catch (HibernateException e) {
            logger.error("session didn't open or transaction didn't begin" + e.getCause());
        }
    }

}
