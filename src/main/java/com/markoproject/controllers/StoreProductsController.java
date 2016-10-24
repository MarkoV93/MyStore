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
 * This is controller with methods for showing, searching and adding to basket products
 */
@Controller
@SessionAttributes({"categories", "cityes", "defaultCity", "minFilter", "maxFilter"})
@RequestMapping(value = "/products")
public class StoreProductsController {

    //this method for loading home page with products by pages, with cities and categories
      @RequestMapping(value = "/all", method = RequestMethod.GET)
    public String getAllProducts(Map<String, Object> model, @RequestParam(required = false) String message, @RequestParam(required = false) String priceCriteria, @RequestParam(required = false) Integer page) {
        DaoFactory daoFactory = DaoFactory.getInstance();
        List<Category> categories = daoFactory.getCategoryDao().getActivCategories();
        List<City> cityes = daoFactory.getCityDao().getActivCities();
        List<Product> products = daoFactory.getProductDao().getProducts(null, page, priceCriteria, null, true);
        model.put("categories", categories);//put in session categories
        model.put("cityes", cityes);//put in session cities
        model.put("products", products);//put in response products
        model.put("path", "All");//put in response puch all for pagging buttons.When user click on pagging button , than  invoke mthod  "getProductsByCategory" with category "All"
        model.put("message", message);//message if another  method redirect on home page and set message into reguest
        model.put("defaultCity", "all");//set defult velues if filter
        model.put("minFilter", "0");
        model.put("maxFilter", "3000");
        int pages = daoFactory.getProductDao().getPagesOfProducts(null, priceCriteria, null, true);    
    //    model.put("page", page);
        model.put("pages", pages);
        return "store";
    }
     //this method for loading home page with products are one of the categories on pages with filtering by cities and price
    @RequestMapping(value = "/{category}", method = RequestMethod.GET)
    public String getProductsByCategory(@PathVariable("category") String name, Map<String, Object> model, @RequestParam(required = false) String cityCriteria, @RequestParam(required = false) String priceCriteria, @RequestParam(required = false) Integer page) {
        DaoFactory daoFactory = DaoFactory.getInstance();
        model.put("defaultCity", cityCriteria);//set city in request in which the filtered result
        if (priceCriteria != null) {//set price if it not null in request in which the filtered result
            String[] values = priceCriteria.split("\\|");
            model.put("minFilter", Integer.valueOf(values[0]));
            model.put("maxFilter", Integer.valueOf(values[1]));
        }
        City city = daoFactory.getCityDao().getCity(cityCriteria);
        Category category = daoFactory.getCategoryDao().getCategoryByName(name);
        List<Product> products = daoFactory.getProductDao().getProducts(category, page, priceCriteria, city, true);//get active products with criterias
        model.put("products", products);
        model.put("path", name);//set puth for pagging muttons
        model.put("page", page);//set page for filter form
        int pages = daoFactory.getProductDao().getPagesOfProducts(category, priceCriteria, city, true);
        model.put("pages", pages);
        return "store";
    }

  
//method for loading product page
    @RequestMapping(value = "/showProduct/{productId}", method = RequestMethod.GET)
    public String showProduct(@PathVariable("productId") int productId, Map<String, Object> model) {
        DaoFactory daoFactory = DaoFactory.getInstance();
        Product product = daoFactory.getProductDao().getProduct(productId);
        model.put("product", product);
        return "product";
    }

    //method for finding products by  name and loading search page
    @RequestMapping(value = "/serch", method = RequestMethod.GET)
    public String serchProduct(@RequestParam(required = false) Integer page, @RequestParam(required = false) String priceCriteria, @RequestParam(required = false) String cityCriteria, @RequestParam(required = false) String serch, Map<String, Object> model)  {
        model.put("defaultCity", cityCriteria);
        if (priceCriteria != null) {
            String[] values = priceCriteria.split("\\|");//set price if it not null in request in which the filtered result
            model.put("minFilter", Integer.valueOf(values[0]));
            model.put("maxFilter", Integer.valueOf(values[1]));
        }
        DaoFactory daoFactory = DaoFactory.getInstance();
        City city = daoFactory.getCityDao().getCity(cityCriteria);
        ProductDao productDao = daoFactory.getProductDao();
        List<Product> products = productDao.findProduct(serch, page, priceCriteria, city);
        model.put("products", products);
        model.put("serch", serch);
         model.put("page", page);
        model.put("path", "serch");//set puth for pagging muttods
        int pages = daoFactory.getProductDao().getPagesOfFound(serch, priceCriteria, city);
        model.put("pages", pages);
        return "serch";
    }
}
