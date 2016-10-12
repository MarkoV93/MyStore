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
 * @author Marko
 */
@Controller
@SessionAttributes({"basket"})
public class BasketController {

    @RequestMapping(value = "/showBasket", method = RequestMethod.GET)
    public String showBasket(Map<String, Object> model) {
        return "basket";
    }

    @RequestMapping(value = "/deleteFromBasket", method = RequestMethod.DELETE)
    public @ResponseBody
    String deleteFromBasket(@RequestBody Integer id, HttpSession session) {
        List<Product> products = (List<Product>) session.getAttribute("basket");
        for (Product product : products) {
            if (product.getId() == id) {
                products.remove(product);
                return "{\"msg\":\"product  deleted\"}";
            }
        }
        return "{\"msg\":\"error\"}";
    }

    @RequestMapping(value = "/products/addToBasket/{productId}", method = RequestMethod.POST)
    public @ResponseBody
    Product addToBasket(@PathVariable("productId") int productId, Map<String, Object> model, HttpSession session)  {
        DaoFactory daoFactory = DaoFactory.getInstance();
        int id = 0;
        List<Product> basket = null;
        if (session.getAttribute("basket") == null) {
            basket = new ArrayList();
        } else {
            basket = (List) session.getAttribute("basket");
        }

        Product product = daoFactory.getProductDao().getProduct(productId);
        basket.add(product);
        System.out.println(product.getName());
        model.put("basket", basket);
        return product;
    }

        
         @RequestMapping(value = "/operationComplite", method = RequestMethod.GET)
    public String operationComplite(Map<String, Object> model) {
        model.put("message", "thank you for reserve, our operator call you for a few minuts");
         return "redirect:products/all";
    }
        
   @RequestMapping(value = "/buy", method = RequestMethod.POST)
    public @ResponseBody
    String buy(Map<String, Object> model, HttpSession session)  {
        List<Product> products = (List<Product>) session.getAttribute("basket");
        User user = (User) session.getAttribute("user");
        if (user == null) {
             return "{\"msg\":\"not ok\"}";
        } else {
            UserDao userDao = DaoFactory.getInstance().getUserDao();
            ReserveDao reserveDao = DaoFactory.getInstance().getReserveDao();
            User u = userDao.getUser(user.getId());
            for (Product product : products) {
                Reserve reserve = new Reserve();
                reserve.setProduct(product);
                reserve.setUser(u);
                reserveDao.saveReserve(reserve);
            }
            products = new ArrayList<Product>();
            model.put("basket", products);
            model.put("message", "we call you");
            return "{\"msg\":\"ok\"}";
        }
    }

}
