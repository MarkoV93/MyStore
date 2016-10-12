/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao.impl;

import com.markoproject.dao.ProductDao;
import com.markoproject.table.Category;
import com.markoproject.table.City;
import com.markoproject.table.Product;
import com.markoproject.table.Reserve;
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
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Marko
 */
public class ProductDaoImpl extends AbstractDao implements ProductDao {

    private static final Logger logger = LogManager.getLogger(ProductDao.class);

    @Override
    public boolean saveProduct(Product product) {
        return super.saveOrUpdate(product);
    }

    @Override
    public boolean deleteProduct(int id) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Product product = (Product) session.load(Product.class, id);
            Transaction tranaction = session.beginTransaction();
            Criteria reserveCriteria = session.createCriteria(Reserve.class);
            reserveCriteria.add(Restrictions.eq("accepted", Boolean.FALSE));
            reserveCriteria.add((Restrictions.eq("product", product)));
            System.out.println(reserveCriteria.list());
            if (reserveCriteria.list().size() != 0) {
                return false;
            }
            reserveCriteria = session.createCriteria(Reserve.class);
            reserveCriteria.add(Restrictions.eq("accepted", Boolean.TRUE));
            reserveCriteria.add((Restrictions.eq("product", product)));
            List<Reserve> reserves = reserveCriteria.list();
            System.out.println(reserves);
            for (Reserve r : reserves) {
                session.delete(r);

            }
            session.delete(product);
            tranaction.commit();
            return true;
        } catch (HibernateException e) {
            e.printStackTrace();
            logger.error("product doesn't not dalete" + e.getCause());
            return false;
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.error("connection dount clouse" + e.getCause());
                }
            }
        }
    }

    @Override
    public Product getProduct(int id) {
        return (Product) super.get(Product.class, id);
    }

    @Override
    public List<Product> getProducts(Category category, Integer page, String priceCriteria, City city, Boolean onliActive) {
        double min = 0;
        double max = 0;
        if (page == null) {
            page = 0;
        }
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            min = Double.valueOf(values[0]);
            max = Double.valueOf(values[1]);
           
        }
        List<Product> result = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            productCriteria.setFirstResult(page * 12).setMaxResults(12);
            productCriteria.addOrder(Order.asc("name"));
            if (category != null) {
                productCriteria.add(Restrictions.eq("category", category));
            }
            if (city != null) {
                productCriteria.add(Restrictions.eq("city", city));
            }
            if (onliActive) {
                productCriteria.add(Restrictions.eq("activeStatus", Boolean.TRUE));
            }
            if (priceCriteria != null) {
                productCriteria.add(Restrictions.between("price", min, max));
            }
            result = productCriteria.list();
        } catch (HibernateException e) {
            logger.error("products not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection dount clouse" + e.getCause());
                }
            }
        }
        return result;

    }

    @Override
    public int getPagesOfProducts(Category category, String priceCriteria, City city, Boolean onliActive) {
        int count = 0;
        Session session = null;
        double min = 0;
        double max = 0;
        int pages = 0;
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            min = Double.valueOf(values[0]);
            max = Double.valueOf(values[1]);
            
        }
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            if (category != null) {
                productCriteria.add(Restrictions.eq("category", category));
            }
            if (city != null) {
                productCriteria.add(Restrictions.eq("city", city));
            }
            if (onliActive) {
                productCriteria.add(Restrictions.eq("activeStatus", Boolean.TRUE));
            }
            if (priceCriteria != null) {
                productCriteria.add(Restrictions.between("price", min, max));
            }
            count = ((Number) productCriteria.setProjection(Projections.rowCount()).uniqueResult()).intValue();
            if (count == 0) {
                count = 1;
            }
            pages = count / 12;
            if (count % 12 == 0) {
                pages--;
            }
        } catch (HibernateException e) {
            logger.error("products not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection dount clouse" + e.getCause());
                }
            }
        }
        return pages;
    }

    @Override
    public List<Product> findProduct(String name, Integer page, String priceCriteria, City city) {
        if (page == null) {
            page = 0;
        }
        List<Product> result = null;
        Session session = null;
        double min = 0;
        double max = 0;
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            min = Double.valueOf(values[0]);
            max = Double.valueOf(values[1]);
        }
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            productCriteria.setFirstResult(page * 12).setMaxResults(12);
            productCriteria.addOrder(Order.asc("name"));
            productCriteria.add(Restrictions.like("name", "%" + name + "%").ignoreCase());
            if (priceCriteria != null) {
                productCriteria.add(Restrictions.between("price", min, max));
            }
            if (city != null) {
                productCriteria.add(Restrictions.eq("city", city));
            }
            result = productCriteria.list();
            System.out.println(result);
        } catch (HibernateException e) {
            logger.error("products not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection dount clouse" + e.getCause());
                }
            }
        }
        return result;
    }

    @Override
    public int getPagesOfFound(String serch, String priceCriteria, City city) {
        int count = 0;
        double min = 0;
        double max = 0;
        int pages = 0;
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            min = Double.valueOf(values[0]);
            max = Double.valueOf(values[1]);
        }
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            productCriteria.add(Restrictions.like("name", "%" + serch + "%").ignoreCase());
            if (priceCriteria != null) {
                productCriteria.add(Restrictions.between("price", min, max));
            }
            if (city != null) {
                productCriteria.add(Restrictions.eq("city", city));
            }
            count = ((Number) productCriteria.setProjection(Projections.rowCount()).uniqueResult()).intValue();
            if (count == 0) {
                count = 1;
            }
            pages = count / 12;
            if (count % 12 == 0) {
                pages--;
            }
        } catch (HibernateException e) {
            logger.error("products not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection dount clouse" + e.getCause());
                }
            }
        }
        return pages;
    }

    @Override
    public int getNewId() {
        Integer lastId = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            String hql = "select max(id) from Product";
            List list = session.createQuery(hql).list();
            System.out.println(list.size());
            System.out.println(list.get(0)==null);
             if (list.get(0)==null) {
                lastId = 0;
            }else{
            lastId = ((Integer) list.get(0)).intValue();
             }
        } catch (HibernateException e) {
            logger.error("products not found" + e.getCause());
        } finally {
            if ((session != null) && (session.isOpen())) {
                try {
                    session.close();
                } catch (HibernateException e) {
                    logger.warn("connection dount clouse" + e.getCause());
                }
            }
        }
        return lastId + 1;
    }
}
