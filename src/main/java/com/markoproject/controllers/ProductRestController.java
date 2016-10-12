/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.controllers;

import com.maarkoproject.filters.checkPermissions.BedPermissionExeption;
import com.maarkoproject.filters.checkPermissions.CheckPermissions;
import com.markoproject.dao.CityDao;
import com.markoproject.dao.DaoFactory;
import com.markoproject.dao.ProductDao;
import com.markoproject.table.Category;
import com.markoproject.table.City;
import com.markoproject.table.Product;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Marko
 */
@Controller
public class ProductRestController {

    @RequestMapping(value = "admin/products", method = RequestMethod.GET)
    public String getProducts(Map<String, Object> model, @RequestParam(required = false) Integer page) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        ProductDao productDao = DaoFactory.getInstance().getProductDao();
        List<Product> products = productDao.getProducts(null, page, null, null, false);
        int pages = productDao.getPagesOfProducts(null, null, null, false);
        model.put("pages", pages);
        model.put("products", products);
        model.put("path", "products");
        return "products";
    }

    @RequestMapping(value = "admin/changeProduct", method = RequestMethod.PUT)
    public @ResponseBody
    String changeCity(@RequestBody Product product) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory.getInstance().getProductDao().saveProduct(product);
        return "{\"msg\":\"Product changed \"}";

    }

    @RequestMapping(value = "admin/createProduct", method = RequestMethod.POST)
    public @ResponseBody
    String createProduct(@RequestBody Product product) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory.getInstance().getProductDao().saveProduct(product);
        return "{\"msg\":\"Product created \"}";
    }

    @RequestMapping(value = "admin/deleteProduct", method = RequestMethod.DELETE)
    public @ResponseBody
    String deleteProduct(@RequestBody Integer id) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        boolean isDeleted = DaoFactory.getInstance().getProductDao().deleteProduct(id);
        if (isDeleted) {
            return "{\"id\":\"remove" + id + "\"}";
        } else {
            return "{\"msg\":\" please accept all reserves with this product \"}";
        }

    }
}
