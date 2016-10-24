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
import com.markoproject.dao.UserDao;
import com.markoproject.table.Product;
import com.markoproject.table.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.apache.log4j.LogManager;
import org.codehaus.jackson.map.ObjectMapper;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 *
 * this is a controller which has methods responsible for the operation with
 * objects entity "user"
 */
@Controller
public class UserController {

    private static final org.apache.log4j.Logger logger = LogManager.getLogger(CategoryDao.class);
    //this is the method for loading registration page

    @RequestMapping(value = "/registrationForm", method = RequestMethod.GET)
    public String registerForm(Map<String, Object> model) {
        User user = new User();
        user.setPhone("80");
        model.put("user", user);//set user into response for spring mvc validation
        return "registration";
    }

    @RequestMapping(value = "/user/{userLogin}", method = RequestMethod.GET)
    public String userProFile() throws BedPermissionExeption {
        CheckPermissions.chackUserPermissions();
        return "userPage";
    }

    //this is the method for registration new user
    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Map<String, Object> model) {
        if (result.hasErrors()) {//if validation is failed
            return "registration";
        } else {//else return  home page
            DaoFactory factory = DaoFactory.getInstance();
            UserDao userDao = factory.getUserDao();
            userDao.saveUser(user);
            return "redirect:products/all";
        }
    }
//method for logging out 

    @RequestMapping(value = "/logOut", method = RequestMethod.POST)
    public @ResponseBody
    String logOut(HttpSession session) {
        session.setAttribute("user", null);//setting empty user into session
        session.setAttribute("basket", null);//setting empty basket into session
        return "{\"msg\":\"you loaded out\"}";
    }
//method for logging 

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public @ResponseBody
    String login(@RequestBody String loginPassword, HttpSession session, Map<String, Object> model) {
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> map = null;
        try {
            map = mapper.readValue(loginPassword, Map.class);//getting map from json
        } catch (IOException ex) {
            logger.error("server can not parse jason" + ex.getMessage());
        }
        DaoFactory factory = DaoFactory.getInstance();
        UserDao userDao = factory.getUserDao();
        User user = userDao.verifyUser(map.get("login"), map.get("password"));//verify user
        if (user != null) {
            if (user.isActiveStatus()) {
                session.setAttribute("user", user);
                user.setPassword("");
                if (user.isAdminStatus()) {
                    return "{\"msg\":\"okAdmin\"}";
                } else {
                    return "{\"msg\":\"ok\"}";
                }
            } else {

                return "{\"msg\":\"you accaunt is banned< contact us please\"}";
            }
        } else {

            return "{\"msg\":\"password or login is uncorrect\"}";
        }

    }
//method for changing password

    @RequestMapping(value = "/user/changePassword", method = RequestMethod.PUT)
    public @ResponseBody
    String changePassword(@RequestBody String passwords, HttpSession session) throws BedPermissionExeption {
        CheckPermissions.chackUserPermissions();
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> map = null;
        try {
            map = mapper.readValue(passwords, Map.class);//read old and 
        } catch (IOException ex) {
            logger.error("server can not parse jason" + ex.getMessage());
        }
        User user = (User) session.getAttribute("user");
        UserDao userDao = DaoFactory.getInstance().getUserDao();
        User userForChange = userDao.verifyUser(user.getLogin(), map.get("oldPassword"));
        if (userForChange != null) {//if old password is correct
            userForChange.setPassword(map.get("newPassword"));//setting new password and save
            userDao.saveUser(userForChange);
            return "{\"msg\":\"ok\"}";
        } else {
            return "{\"msg\":\"not ok\"}";
        }
    }

    //method for changing phone
    @RequestMapping(value = "/user/changePhone", method = RequestMethod.PUT)
    public @ResponseBody
    String changePhone(@RequestBody String phone, HttpSession session) throws BedPermissionExeption {
        phone = phone.substring(1, phone.length() - 1);
        CheckPermissions.chackUserPermissions();
        User user = (User) session.getAttribute("user");
        UserDao userDao = DaoFactory.getInstance().getUserDao();
        User userForChange = userDao.getUser(user.getId());//getting this user from DB becouse user in session with out password
        userForChange.setPhone(phone);
        userDao.saveUser(userForChange);
        user.setPhone(phone);
        session.setAttribute("user", user);
        return "{\"msg\":\"number was changed\"}";

    }
   //method for changing email
    @RequestMapping(value = "/user/changeEmail", method = RequestMethod.PUT)
    public @ResponseBody
    String changeEmail(@RequestBody String email, HttpSession session) throws BedPermissionExeption {
        email = email.substring(1, email.length() - 1);
        CheckPermissions.chackUserPermissions();
        User user = (User) session.getAttribute("user");
        UserDao userDao = DaoFactory.getInstance().getUserDao();
        User userForChange = userDao.getUser(user.getId());//getting this user from DB becouse user in session with out password
        userForChange.setEmail(email);
        userDao.saveUser(userForChange);
        user.setEmail(email);
        session.setAttribute("user", userForChange);
        return "{\"msg\":\"@mail was changed\"}";

    }
   //method for changing user active status
    @RequestMapping(value = "/admin/bannedUser", method = RequestMethod.PUT)
    public @ResponseBody
    String bannedUser(@RequestBody User user) throws BedPermissionExeption {//user sending to controller by ajax
        CheckPermissions.chackAdminPermissions();
        DaoFactory.getInstance().getUserDao().saveUser(user);
        if (user.isActiveStatus()) {
            return "{\"msg\":\"user unbanned\"}";//return response to ajax about that updating is complete
        } else {
            return "{\"msg\":\"user banned\"}";//return response to ajax about that updating is complete

        }

    }
    //method for getting users by admin and returning "adminPage.jsp"
        @RequestMapping(value = "/admin/users", method = RequestMethod.GET)
    public String getUsers(Map<String, Object> model, @RequestParam(required = false) Integer page) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory daoFactory = DaoFactory.getInstance();
        UserDao userDao = daoFactory.getUserDao();
       List<User>  users = userDao.getUsers(page);
        int pages = userDao.getPagesOfNotAdminUsers();      
        model.put("pages", pages);
        model.put("notAdminUsers", users);
        return "adminPage";
    }
}
