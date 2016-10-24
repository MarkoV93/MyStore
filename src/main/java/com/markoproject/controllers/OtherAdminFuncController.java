/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.controllers;

import com.markoproject.checkPermissions.BedPermissionExeption;
import com.markoproject.checkPermissions.CheckPermissions;
import com.markoproject.dao.CategoryDao;
import com.markoproject.dao.DaoFactory;
import com.markoproject.dao.ProductDao;
import com.markoproject.dao.ReserveDao;
import com.markoproject.dao.UserDao;
import com.markoproject.table.Category;
import com.markoproject.table.City;
import com.markoproject.table.Product;
import com.markoproject.table.Reserve;
import com.markoproject.table.User;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * controller with methods for admin functionality wich did not include into rest contollers
 */
@Controller
@RequestMapping(value = "/admin")
public class OtherAdminFuncController {

    private static final org.apache.log4j.Logger logger = LogManager.getLogger(CategoryDao.class);


//method for returning all not accepted reserves
    @RequestMapping(value = "/reserves", method = RequestMethod.GET)
    public String getReserves(Map<String, Object> model, @RequestParam(required = false) Integer page) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        ReserveDao reserveDao = DaoFactory.getInstance().getReserveDao();
        List<Reserve> reserves = reserveDao.getActiveReserves(page);
        int pages = reserveDao.getPagesOfActiveReserves();      //get count of pages by 10 reserves on page  
        model.put("pages", pages);
        model.put("reserves", reserves);
        return "reserves";
    }

    //method for accepting reserves by admin
    @RequestMapping(value = "/acceptReserve/{reserveId}", method = RequestMethod.PUT)
    public @ResponseBody
    String bannedUser(@PathVariable("reserveId") int reserveId, @RequestBody Boolean activity) {
        ReserveDao reserveDao = DaoFactory.getInstance().getReserveDao();
        Reserve reserve = reserveDao.getReserve(reserveId);
        reserve.setAccepted(activity);
        reserveDao.saveReserve(reserve);
        if (reserve.isAccepted()) {
            return "{\"msg\":\"reserve  accepted\"}";//send json message about reserve accepted
        } else {
            return "{\"msg\":\"reserve did not accept\"}";
        }

    }
//method for returning page for creating new product
    @RequestMapping(value = "goToCreatingProduct", method = RequestMethod.GET)
    public String newProduct(Map<String, Object> model) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory daoFactory = DaoFactory.getInstance();
        List<City> cities = daoFactory.getCityDao().getActivCities();
        List<Category> categories = daoFactory.getCategoryDao().getActivCategories();
       // int newId=daoFactory.getProductDao().getNewId();//newId use for name image
       //  model.put("id", newId);
        model.put("cities", cities);
        model.put("categories", categories);
        return "newProduct";
    }

    //method for returning page for editing  product
    @RequestMapping(value = "goToEditingProduct{productId}", method = RequestMethod.GET)
    public String goToEditingProduct(@PathVariable("productId") int productId, Map<String, Object> model) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory daoFactory = DaoFactory.getInstance();
        Product product = daoFactory.getProductDao().getProduct(productId);
        List<City> cities = daoFactory.getCityDao().getActivCities();
        List<Category> categories = daoFactory.getCategoryDao().getActivCategories();
        model.put("cities", cities);
        model.put("categories", categories);
        model.put("product", product);
        return "editProduct";
    }

    
    //method for uploading image for product 
    @RequestMapping(value = "uploadImage", method = RequestMethod.POST)
    public String uploadImage(@RequestParam("productId") int productId, @RequestParam("file") MultipartFile file, Map<String, Object> model) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();      
        if (!file.isEmpty()) {
               DaoFactory daoFactory = DaoFactory.getInstance();
        ProductDao productDao = daoFactory.getProductDao();
        Product product = productDao.getProduct(productId);
            System.out.println(productId);
        product.setImage(productId + ".png");
        productDao.saveProduct(product);      
            BufferedImage src;
    
            try {
                src = ImageIO.read(new ByteArrayInputStream(file.getBytes()));
                File destination = new File("C:/Users/Marko/Documents/NetBeansProjects/MyStore/src/main/webapp/WEB-INF/resources/images/" + productId + ".png");// something like C:/Users/Marko/Desktop/SpringFileUpload/Id.png C:\Users\Marko\Desktop
                ImageIO.write(src, "png", destination);
            } catch (IOException ex) {
                logger.error("file doesn't upload" + ex.getCause());
            }
        }
        return "redirect:/admin/products";
    }
}
