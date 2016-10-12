/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao.impl;

import com.markoproject.dao.CityDao;
import com.markoproject.dao.ProductDao;
import com.markoproject.table.City;
import com.markoproject.table.Product;
import com.markoproject.table.User;
import com.markoproject.util.HibernateUtil;
import java.sql.SQLException;
import java.util.List;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Marko
 */
public class CityDaoImpl extends AbstractDao implements CityDao {
 private static final Logger logger= LogManager.getLogger(CityDao.class);



    public boolean saveCity(City city)  {
       return super.saveOrUpdate(city);
    }


    public List<City> getCities()  {
        List<City> citys = super.getAll(City.class);
        return citys;

    }

    // @Override
    public City getCity(String cityCriteria) {
      
        return (City) super.getByName(City.class, cityCriteria);
    }
    

    public boolean deleteCity(int id )  {
     return  super.delete(City.class,id);
    }

    @Override
    public List<City> getActivCities()  {
       List<City> cities = super.getAllActive(City.class);
        return cities;
    }

}
