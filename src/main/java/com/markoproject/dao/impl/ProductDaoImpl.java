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

public class ProductDaoImpl extends AbstractDao implements ProductDao {

    private static final Logger logger = LogManager.getLogger(ProductDao.class);

    @Override
    public boolean saveProduct(Product product) {
        return super.saveOrUpdate(product);
    }
//method for deleting products from table @param product.id

    @Override
    public boolean deleteProduct(int id) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Product product = (Product) session.load(Product.class, id);
            Transaction tranaction = session.beginTransaction();
            Criteria reserveCriteria = session.createCriteria(Reserve.class);
            reserveCriteria.add(Restrictions.eq("accepted", Boolean.FALSE));//Search not accepted orders 
            reserveCriteria.add((Restrictions.eq("product", product)));
            if (reserveCriteria.list().size() != 0) {//if in DB are not  accepted reserves return false
                return false;
            }
            reserveCriteria = session.createCriteria(Reserve.class);
            reserveCriteria.add(Restrictions.eq("accepted", Boolean.TRUE));
            reserveCriteria.add((Restrictions.eq("product", product)));
            List<Reserve> reserves = reserveCriteria.list();
            for (Reserve r : reserves) {
                session.delete(r);//deleting all accepted reserves

            }
            session.delete(product);//deleting product
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

    /*
    *method for returning products from table
     */
    @Override
    public List<Product> getProducts(Category category, Integer page, String priceCriteria, City city, Boolean onliActive) {
        double min = 0;
        double max = 0;
        if (page == null) {
            page = 0;
        }
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            min = Double.valueOf(values[0]);//initialize min and max value for price
            max = Double.valueOf(values[1]);

        }
        List<Product> result = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            productCriteria.setFirstResult(page * 12).setMaxResults(12);
            productCriteria.addOrder(Order.asc("name"));
            if (category != null) {//if assigned category is not null ,added it to criteria
                productCriteria.add(Restrictions.eq("category", category));
            }
            if (city != null) {//if assigned city is not null ,add it to criteria
                productCriteria.add(Restrictions.eq("city", city));
            }
            if (onliActive) {//if assigned onlyActive==true l ,added to criteria thad activeStatus must equeal true
                productCriteria.add(Restrictions.eq("activeStatus", Boolean.TRUE));
            }
            if (priceCriteria != null) {//if assigned price criteria not null ,add to criteria max and min values of product.price
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

    /*
    *method for returning count of  pages for 12 products with criterias
     */
    @Override
    public int getPagesOfProducts(Category category, String priceCriteria, City city, Boolean onliActive) {
        int count = 0;
        Session session = null;
        double min = 0;
        double max = 0;
        int pages = 0;
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            min = Double.valueOf(values[0]);//initializing max and min values of price if priceCriteria not null
            max = Double.valueOf(values[1]);

        }
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            if (category != null) {
                productCriteria.add(Restrictions.eq("category", category));//add category criteria if it not null
            }
            if (city != null) {
                productCriteria.add(Restrictions.eq("city", city));//add category city if it not null
            }
            if (onliActive) {
                productCriteria.add(Restrictions.eq("activeStatus", Boolean.TRUE));//if onliActive equal true add criteria that activeStatus must be true
            }
            if (priceCriteria != null) {
                productCriteria.add(Restrictions.between("price", min, max));//add price criteria if it not null
            }
            count = ((Number) productCriteria.setProjection(Projections.rowCount()).uniqueResult()).intValue();

            pages = count / 12;//calculate count of pages if on page there is 12 products
            if ((count % 12 == 0) && (count != 0)) {
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

    /*
    *method for returning 12 products from table by the pice of word with adding criteries 
     */
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
            String[] values = priceCriteria.split("\\|");//initializing max and min values of price if priceCriteria not null
            min = Double.valueOf(values[0]);
            max = Double.valueOf(values[1]);
        }
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            productCriteria.setFirstResult(page * 12).setMaxResults(12); //set criteria that it must return 12 products ,beginning from 12*page
            productCriteria.addOrder(Order.asc("name"));//sort bu name
            productCriteria.add(Restrictions.like("name", "%" + name + "%").ignoreCase());//add criteria that product name include search word
            if (priceCriteria != null) {
                productCriteria.add(Restrictions.between("price", min, max));//add criteria that products must be  with price between min and  max  pricees 
            }
            if (city != null) {
                productCriteria.add(Restrictions.eq("city", city));//get products with this city if city not null
            }
            productCriteria.add(Restrictions.eq("activeStatus", Boolean.TRUE));
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

    /*
    *method for returning count of  pages for 12 products finding by name  with criterias
     */
    @Override
    public int getPagesOfFound(String serch, String priceCriteria, City city) {
        int count = 0;
        double min = 0;
        double max = 0;
        int pages = 0;
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");//initializing max and min values of price if priceCriteria not null
            min = Double.valueOf(values[0]);
            max = Double.valueOf(values[1]);
        }
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            Criteria productCriteria = session.createCriteria(Product.class);
            productCriteria.add(Restrictions.like("name", "%" + serch + "%").ignoreCase());//added criteria that product name include search word
            if (priceCriteria != null) {
                productCriteria.add(Restrictions.between("price", min, max));//added criteria that products must be  with price between min and  max  price 
            }
            if (city != null) {
                productCriteria.add(Restrictions.eq("city", city));//add criteria that city of product must be equal city if it not null
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

    /*
    *method for returning value of last id+one
     */
    @Override
    public int getNewId() {
        Integer lastId = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            String hql = "select max(id) from Product";
            List list = session.createQuery(hql).list();
            if (list.get(0) == null) {//if table of products is empty
                lastId = 0;
            } else {
                lastId = ((Integer) list.get(0)).intValue();//get lust id if products table not empty
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
        return lastId;
    }
}
