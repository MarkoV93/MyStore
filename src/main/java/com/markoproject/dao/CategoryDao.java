/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao;

import com.markoproject.table.Category;
import com.markoproject.table.Product;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Marko
 */
public interface CategoryDao {
    public boolean saveCategory(Category category) ;
      public List<Category> getCategories() ;
      public Category getCategory(int id) ;
      public boolean deleteCategory(int id) ;
      public Category getCategoryByName(String name);
       public List<Category> getActivCategories() ;
  
}
