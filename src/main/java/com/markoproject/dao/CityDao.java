/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao;

import com.markoproject.table.City;
import com.markoproject.table.Product;
import java.sql.SQLException;
import java.util.List;

// interface of dao class with work methods which work  with "City" objects
public interface CityDao {
     public boolean saveCity(City city) ;
      public List<City> getCities() ;
      public City getCity(String name) ;
       public boolean deleteCity(int id );
       public List<City> getActivCities() ;
}
