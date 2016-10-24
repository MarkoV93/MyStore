/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao.impl;

import com.markoproject.dao.ProductDao;
import com.markoproject.dao.UserDao;
import com.markoproject.table.User;
import com.markoproject.util.HibernateUtil;
import java.sql.SQLException;
import java.util.List;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * implementation of ReserveDao
 */
public class UserDaoImpl extends AbstractDao implements UserDao {

    private static final Logger logger = LogManager.getLogger(UserDao.class);

    @Override
    public boolean saveUser(User user) {
        return super.saveOrUpdate(user);
    }

    @Override
    public void deleteUser(int id) {
        super.delete(User.class, id);
    }

    @Override
    public User getUser(int id) {
        return (User) super.get(User.class, id);
    }
//method for verify is there in db user with this password and login
    @Override
    public User verifyUser(String login, String password) {
        User result = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria userCriteria = session.createCriteria(User.class);
            userCriteria.add(Restrictions.eq("login", login));
            userCriteria.add(Restrictions.eq("password", password));
            result = (User) userCriteria.uniqueResult();
        } catch (HibernateException e) {
            logger.error("reserves not verifyed" + e.getCause());
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
//method for returning 10 users with not admin status by pages 
    @Override
    public List<User> getUsers(Integer page) {
        if (page == null) {
            page = 0;
        }
        List<User> result = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria userCriteria = session.createCriteria(User.class);
            userCriteria.setFirstResult(page * 10).setMaxResults(10);//add criteria for returning 10 users begin from 10*page user
            userCriteria.add(Restrictions.eq("adminStatus", Boolean.FALSE));
            result = userCriteria.list();
        } catch (HibernateException e) {
            logger.error("users not found" + e.getCause());
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

    //method for rutorning count of  pages of users with not admin status
    @Override
    public int getPagesOfNotAdminUsers() {
        int count = 0;
        int pages = 0;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria userCriteria = session.createCriteria(User.class);
            userCriteria.add(Restrictions.eq("adminStatus", false));
            count = ((Number) userCriteria.setProjection(Projections.rowCount()).uniqueResult()).intValue();
            pages = count / 10;
            if ((count % 10 == 0)&&(count!=0)) {
                pages--;
            }
        } catch (HibernateException e) {
            logger.error("users not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection doun't clouse" + e.getCause());
                }
            }
        }
        return pages;
    }
//method for returning user by login
    @Override
    public User getUser(String login) {
        User result = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria userCriteria = session.createCriteria(User.class);
            userCriteria.add(Restrictions.eq("login", login));
            result = (User) userCriteria.uniqueResult();
        } catch (HibernateException e) {
            logger.error("user not found" + e.getCause());
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

}
