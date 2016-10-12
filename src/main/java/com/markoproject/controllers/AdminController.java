/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.controllers;

import com.maarkoproject.filters.checkPermissions.BedPermissionExeption;
import com.maarkoproject.filters.checkPermissions.CheckPermissions;
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
 * @author Marko
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    private static final org.apache.log4j.Logger logger = LogManager.getLogger(CategoryDao.class);

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public String getUsers(Map<String, Object> model, @RequestParam(required = false) Integer page) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        List<User> users = null;
        DaoFactory daoFactory = DaoFactory.getInstance();
        UserDao userDao = daoFactory.getUserDao();
        users = userDao.getUsers(page);
        int pages = userDao.getPagesOfNotAdminUsers();
      
        model.put("pages", pages);
        model.put("notAdminUsers", users);
        model.put("path", "users");
        return "adminPage";
    }

    @RequestMapping(value = "/reserves", method = RequestMethod.GET)
    public String getReserves(Map<String, Object> model, @RequestParam(required = false) Integer page) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory daoFactory = DaoFactory.getInstance();
        ReserveDao reserveDao = daoFactory.getReserveDao();
        List<Reserve> reserves = reserveDao.getActiveReserves(page);
        int pages = reserveDao.getPagesOfActiveReserves();        
        model.put("pages", pages);
        model.put("reserves", reserves);
        model.put("path", "reserves");
        return "reserves";
    }

    @RequestMapping(value = "/acceptReserve/{reserveId}", method = RequestMethod.PUT)
    public @ResponseBody
    String bannedUser(@PathVariable("reserveId") int reserveId, @RequestBody Boolean activity) {
        ReserveDao reserveDao = DaoFactory.getInstance().getReserveDao();
        Reserve reserve = reserveDao.getReserve(reserveId);

        reserve.setAccepted(activity);
        reserveDao.saveReserve(reserve);
        if (reserve.isAccepted()) {
            return "{\"msg\":\"reserve  accepted\"}";
        } else {
            return "{\"msg\":\"reserve did not accept\"}";
        }

    }

    @RequestMapping(value = "newProduct", method = RequestMethod.GET)
    public String newProduct(Map<String, Object> model) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory daoFactory = DaoFactory.getInstance();
        List<City> cities = daoFactory.getCityDao().getActivCities();
        List<Category> categories = daoFactory.getCategoryDao().getActivCategories();
        int newId=daoFactory.getProductDao().getNewId();
        System.out.println(newId+" sssss");
         model.put("id", newId);
        model.put("cities", cities);
        model.put("categories", categories);
        return "newProduct";
    }

    @RequestMapping(value = "editProduct{productId}", method = RequestMethod.GET)
    public String editProduct(@PathVariable("productId") int productId, Map<String, Object> model) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory daoFactory = DaoFactory.getInstance();
        Product product = daoFactory.getProductDao().getProduct(productId);
        System.out.println("this is controller");
        List<City> cities = daoFactory.getCityDao().getActivCities();
        List<Category> categories = daoFactory.getCategoryDao().getActivCategories();
        model.put("cities", cities);
        model.put("categories", categories);
        model.put("product", product);
        return "editProduct";
    }

    @RequestMapping(value = "uploadImage{productId}", method = RequestMethod.POST)
    public String uploadImage(@PathVariable("productId") int productId, @RequestParam("file") MultipartFile file, Map<String, Object> model) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory daoFactory = DaoFactory.getInstance();
        ProductDao productDao = daoFactory.getProductDao();
        Product product = productDao.getProduct(productId);
        product.setImage(productId + ".png");
        productDao.saveProduct(product);
        System.out.println(productId);
        if (!file.isEmpty()) {
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
