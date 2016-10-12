/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao.impl;

import com.markoproject.dao.ProductDao;
import com.markoproject.dao.ReserveDao;
import com.markoproject.table.Reserve;
import com.markoproject.util.HibernateUtil;
import java.sql.SQLException;
import java.util.List;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Marko
 */
public class ReserveDaoImpl extends AbstractDao implements ReserveDao{

     private static final Logger logger= LogManager.getLogger(ReserveDao.class);
    
    @Override
    public void saveReserve(Reserve reserve)  {
       super.saveOrUpdate(reserve);
    }

    @Override
    public void deleteReserve(int id)  {
       super.delete(Reserve.class, id);
    }

    @Override
    public Reserve getReserve(int id) {
     return  (Reserve)super.get(Reserve.class, id);
    }

    @Override
    public List<Reserve> getReserves()  {
       List<Reserve> reserves=super.getAll(Reserve.class);
       return reserves;
    }

    @Override
    public List<Reserve> getActiveReserves(Integer page) {
         if(page==null) page=0;
          List<Reserve> result = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
           Criteria reserveCriteria = session.createCriteria(Reserve.class);
           reserveCriteria.setFirstResult(page * 10).setMaxResults(10);
            reserveCriteria.add(Restrictions.eq("accepted",Boolean.FALSE));
           result = reserveCriteria.list();  
        } catch (HibernateException e) {
            logger.error("reserves not found"+e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
              try{
                session.close();
              }catch(HibernateException e){
                  logger.warn("connection doun't clouse"+e.getCause());
              }
            }
        }
        return result;
    }

    @Override
    public int getPagesOfActiveReserves() {
         int count=0;
         int pages=0;
          Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
           Criteria reserveCriteria = session.createCriteria(Reserve.class);
         
            reserveCriteria.add(Restrictions.eq("accepted", false));
 
           count =((Number)reserveCriteria.setProjection(Projections.rowCount()).uniqueResult()).intValue();
           if(count==0){
               count++;
           }
            pages = count / 10;
        if (count % 10 == 0) {
            pages--;
        }
        } catch (HibernateException e) {
            logger.error("count of reserves  not geted"+e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
              try{
                session.close();
              }catch(HibernateException e){
                  logger.warn("connection dount clouse"+e.getCause());
              }
            }
        }
         return pages;
    }
    }
    

