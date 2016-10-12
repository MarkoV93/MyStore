/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.controllers;

import com.markoproject.dao.DaoFactory;
import com.markoproject.dao.ProductDao;
import com.markoproject.table.Category;
import com.markoproject.table.City;
import com.markoproject.table.Product;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 *
 * @author Marko
 */
@Controller
@SessionAttributes({"categories", "cityes", "defaultCity", "minFilter", "maxFilter"})
@RequestMapping(value = "/products")
public class ProductController {

    @RequestMapping(value = "/{category}", method = RequestMethod.GET)
    public String getProductsByCategory(@PathVariable("category") String name, Map<String, Object> model, @RequestParam(required = false) String cityCriteria, @RequestParam(required = false) String priceCriteria, @RequestParam(required = false) Integer page) {
        DaoFactory daoFactory = DaoFactory.getInstance();
        model.put("defaultCity", cityCriteria);
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            model.put("minFilter", Integer.valueOf(values[0]));
            model.put("maxFilter", Integer.valueOf(values[1]));
        }
        City city = daoFactory.getCityDao().getCity(cityCriteria);
        Category category = daoFactory.getCategoryDao().getCategoryByName(name);
        List<Product> products = daoFactory.getProductDao().getProducts(category, page, priceCriteria, city, true);
        model.put("products", products);
        model.put("path", name);
        model.put("page", page);
        int pages = daoFactory.getProductDao().getPagesOfProducts(category, priceCriteria, city, true);
        model.put("pages", pages);
        return "store";
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public String getAllProducts(Map<String, Object> model, @RequestParam(required = false) String message, @RequestParam(required = false) String priceCriteria, @RequestParam(required = false) Integer page) {
        DaoFactory daoFactory = DaoFactory.getInstance();
        List<Category> categories = daoFactory.getCategoryDao().getActivCategories();
        List<City> cityes = daoFactory.getCityDao().getActivCities();
        Category all = new Category();
        all.setName("All");
        categories.add(all);
        System.out.println(categories);
        List<Product> products = daoFactory.getProductDao().getProducts(null, page, priceCriteria, null, true);
        model.put("categories", categories);
        model.put("cityes", cityes);
        model.put("products", products);
        model.put("path", "All");
        model.put("message", message);
        model.put("defaultCity", "all");
        model.put("minFilter", "0");
        model.put("maxFilter", "3000");
        int pages = daoFactory.getProductDao().getPagesOfProducts(null, priceCriteria, null, true);    
        model.put("page", page);
        model.put("pages", pages);
        return "store";
    }

    @RequestMapping(value = "/showProduct/{productId}", method = RequestMethod.GET)
    public String showProduct(@PathVariable("productId") int productId, Map<String, Object> model) {
        DaoFactory daoFactory = DaoFactory.getInstance();
        Product product = daoFactory.getProductDao().getProduct(productId);
        model.put("product", product);
        return "product";
    }

    @RequestMapping(value = "/serch", method = RequestMethod.GET)
    public String serchProduct(@RequestParam(required = false) Integer page, @RequestParam(required = false) String priceCriteria, @RequestParam(required = false) String cityCriteria, @RequestParam(required = false) String serch, Map<String, Object> model)  {
        model.put("defaultCity", cityCriteria);
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");
            model.put("minFilter", Integer.valueOf(values[0]));
            model.put("maxFilter", Integer.valueOf(values[1]));
        }
        DaoFactory daoFactory = DaoFactory.getInstance();
        City city = daoFactory.getCityDao().getCity(cityCriteria);
        ProductDao productDao = daoFactory.getProductDao();
        List<Product> products = productDao.findProduct(serch, page, priceCriteria, city);
        model.put("products", products);
        model.put("serch", serch);
        model.put("path", "serch");
        int pages = daoFactory.getProductDao().getPagesOfFound(serch, priceCriteria, city);
        model.put("pages", pages);
        System.out.println(pages + "xxx");
        return "serch";
    }
}
