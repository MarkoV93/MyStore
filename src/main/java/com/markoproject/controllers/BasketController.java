/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.controllers;

import com.markoproject.dao.DaoFactory;
import com.markoproject.dao.ReserveDao;
import com.markoproject.dao.UserDao;
import com.markoproject.table.Product;
import com.markoproject.table.Reserve;
import com.markoproject.table.User;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 *
 * controller for user's work with basket
 */
@Controller
@SessionAttributes({"basket"})
public class BasketController {

    
    //method for returning basket page
    @RequestMapping(value = "/showBasket", method = RequestMethod.GET)
    public String showBasket() {
        return "basket";
    }


    //method for deleting reserve from basket
    @RequestMapping(value = "/deleteFromBasket", method = RequestMethod.DELETE)
    public @ResponseBody
    String deleteFromBasket(@RequestBody Integer id, HttpSession session) {//get from ajax id of reserve for deleting
        List<Product> products = (List<Product>) session.getAttribute("basket");
        for (Product product : products) {
            if (product.getId() == id) {
                products.remove(product);//delete from basket product with this id
                return "{\"msg\":\"product  deleted\"}";//return response to ajax about that deleting is complete
            }
        }
        return "{\"msg\":\"error\"}";
    }

    //method for adding  reserve to basket
    @RequestMapping(value = "/products/addToBasket/{productId}", method = RequestMethod.POST)
    public @ResponseBody
    Product addToBasket(@PathVariable("productId") int productId, Map<String, Object> model, HttpSession session) {
        DaoFactory daoFactory = DaoFactory.getInstance();
         List<Product>   basket = (List) session.getAttribute("basket");//get basket fro session
                 if (session.getAttribute("basket") == null) {//if there is not in session basket
            basket = new ArrayList();
        } else {
            basket = (List) session.getAttribute("basket");
        }
        Product product = daoFactory.getProductDao().getProduct(productId);
        basket.add(product);//add product to basket 
        model.put("basket", basket);//set basget into session
        return product;
    }
//method for returning on home page and setting message about complete of buying
    @RequestMapping(value = "/operationComplite", method = RequestMethod.GET)
    public String operationComplite(Map<String, Object> model) {
        model.put("message", "thank you for reserve, our operator call you for a few minuts");
        return "redirect:products/all";
    }

    @RequestMapping(value = "/buy", method = RequestMethod.POST)
    public @ResponseBody
    String buy(Map<String, Object> model, HttpSession session) {
        List<Product> products = (List<Product>) session.getAttribute("basket");//get basket from session
        User user = (User) session.getAttribute("user");//get user from session
        if (user == null) {//if user is null , returning message in ajax that user is null
            return "{\"msg\":\"not ok\"}";
        } else {
            UserDao userDao = DaoFactory.getInstance().getUserDao();
            ReserveDao reserveDao = DaoFactory.getInstance().getReserveDao();
            User u = userDao.getUser(user.getId());
            for (Product product : products) {//creating reserves with all products in basket
                Reserve reserve = new Reserve();
                reserve.setProduct(product);
                reserve.setUser(u);
                reserveDao.saveReserve(reserve);
            }
            model.put("basket", null);
            return "{\"msg\":\"ok\"}";
        }
    }

}
