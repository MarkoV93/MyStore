/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao.impl;

import com.markoproject.dao.CategoryDao;
import com.markoproject.dao.ProductDao;
import com.markoproject.table.Category;
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
 * implementation of CategoryDao
 */
public class CategoryDaoImpl extends AbstractDao implements CategoryDao {

    private static final Logger logger = LogManager.getLogger(CategoryDao.class);

    @Override
    public boolean saveCategory(Category category) {
        return super.saveOrUpdate(category);
    }

    @Override
    public List<Category> getCategories() {
        List<Category> categories = super.getAll(Category.class);
        return categories;
    }

    @Override
    public Category getCategory(int id) {
        return (Category) super.get(Category.class, id);
    }

    @Override
    public boolean deleteCategory(int id) {
        return super.delete(Category.class, id);
    }

    @Override
    public Category getCategoryByName(String name) {

        return (Category) super.getByName(Category.class, name);
    }

    @Override
    public List<Category> getActivCategories() {
        List<Category> categories = super.getAllActive(Category.class);
              Category all = new Category();
        all.setName("All");
        categories.add(all);
        return categories;
    }
}
