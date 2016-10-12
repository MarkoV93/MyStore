/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao;

import com.markoproject.table.Category;
import com.markoproject.table.City;
import com.markoproject.table.Product;
import java.sql.SQLException;
import java.util.List;
import org.hibernate.Criteria;

/**
 *
 * @author Marko
 */
public interface ProductDao {

    public boolean saveProduct(Product product);

    public boolean deleteProduct(int id) ;

    public Product getProduct(int id) ;

     public List<Product> getProducts(Category category,Integer page,String priceCriteria,City city,Boolean onliActive)  ;

//    public List<Product> getByCategory(Category category, Integer page) throws SQLException;

    public int getPagesOfProducts(Category category,String priceCriteria,City city,Boolean onliActive) ;

    public List<Product> findProduct(String name, Integer page,String priceCriteria,City city) ;

    public int getPagesOfFound(String serch,String priceCriteria,City city) ;
    public int getNewId() ;
}
