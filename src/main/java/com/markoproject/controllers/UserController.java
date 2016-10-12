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
import com.markoproject.dao.UserDao;
import com.markoproject.table.Product;
import com.markoproject.table.User;
import java.io.IOException;
import java.sql.SQLException;
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
 * @author Marko
 */
@Controller
public class UserController {

    private static final org.apache.log4j.Logger logger = LogManager.getLogger(CategoryDao.class);

    @RequestMapping(value = "/registrationForm", method = RequestMethod.GET)
    public String registerForm(Map<String, Object> model) {
        User user = new User();
        model.put("user", user);
        return "registration";
    }

    @RequestMapping(value = "/user/{userLogin}", method = RequestMethod.GET)
    public String userProFile() throws BedPermissionExeption {
        CheckPermissions.chackUserPermissions();
        return "userPage";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Map<String, Object> model) {
        if (result.hasErrors()) {
            return "registration";
        } else {
            DaoFactory factory = DaoFactory.getInstance();
            UserDao userDao = factory.getUserDao();
            user.setActiveStatus(true);
            user.setAdminStatus(false);
            userDao.saveUser(user);
            return "redirect:products/all";
        }
    }

    @RequestMapping(value = "/logOut", method = RequestMethod.POST)
    public @ResponseBody
    String logOut(HttpSession session) {
        session.setAttribute("user", null);
        session.setAttribute("basket", null);
        return "{\"msg\":\"you loaded out\"}";
    }

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public @ResponseBody
    String changePassword(@RequestBody String loginPassword, HttpSession session, Map<String, Object> model) {
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> map = null;
        try {
            map = mapper.readValue(loginPassword, Map.class);
        } catch (IOException ex) {
            logger.error("server can not parse jason" + ex.getMessage());
        }
        System.out.println(map.get("login") + map.get("password"));
        DaoFactory factory = DaoFactory.getInstance();
        UserDao userDao = factory.getUserDao();
        if (userDao.verifyUser(map.get("login"), map.get("password"))) {
            User u = userDao.getUser(map.get("login"));
            System.out.println(u.getName());
            if (u.isActiveStatus()) {
                session.setAttribute("user", u);
                u.setPassword("");
                if (u.isAdminStatus()) {
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

    @RequestMapping(value = "/user/changePassword", method = RequestMethod.PUT)
    public @ResponseBody
    String changePassword(@RequestBody String passwords, HttpSession session) throws BedPermissionExeption {

        CheckPermissions.chackUserPermissions();

        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> map = null;
        try {
            map = mapper.readValue(passwords, Map.class);
        } catch (IOException ex) {
            logger.error("server can not parse jason" + ex.getMessage());
        }
        User user = (User) session.getAttribute("user");
        UserDao userDao = DaoFactory.getInstance().getUserDao();
        User userForChange = userDao.getUser(user.getId());
        if (userForChange.getPassword().equals(map.get("oldPassword"))) {
            userForChange.setPassword(map.get("newPassword"));
            userDao.saveUser(userForChange);
            session.setAttribute("user", userForChange);

             return "{\"msg\":\"ok\"}";
        } else {

            return "{\"msg\":\"not ok\"}";
        }
    }

    @RequestMapping(value = "/user/changePhone", method = RequestMethod.PUT)
    public @ResponseBody
    String changePhone(@RequestBody String phone, HttpSession session) throws BedPermissionExeption {
        CheckPermissions.chackUserPermissions();
        ObjectMapper mapper = new ObjectMapper();
        User userForChange = null;
        Map<String, String> map = null;
        try {
            map = mapper.readValue(phone, Map.class);
        } catch (IOException ex) {
            logger.error("server can not parse jason" + ex.getMessage());
        }
        User user = (User) session.getAttribute("user");
        UserDao userDao = DaoFactory.getInstance().getUserDao();
        userForChange = userDao.getUser(user.getId());
        userForChange.setPhone(map.get("phone"));
        userDao.saveUser(userForChange);

        return "{\"msg\":\"number was changed\"}";

    }

    @RequestMapping(value = "/user/changeEmail", method = RequestMethod.PUT)
    public @ResponseBody
    String changeEmail(@RequestBody String email, HttpSession session) throws BedPermissionExeption {
        CheckPermissions.chackUserPermissions();
        ObjectMapper mapper = new ObjectMapper();
        User userForChange = null;
        Map<String, String> map = null;
        try {
            map = mapper.readValue(email, Map.class);
        } catch (IOException ex) {
            logger.error("server can not parse jason" + ex.getMessage());
        }
        User user = (User) session.getAttribute("user");

        UserDao userDao = DaoFactory.getInstance().getUserDao();
        System.out.println(map.get("email"));
        userForChange = userDao.getUser(user.getId());
        userForChange.setEmail(map.get("email"));
        userDao.saveUser(userForChange);

        session.setAttribute("user", userForChange);
        return "{\"msg\":\"@mail was changed\"}";

    }

    @RequestMapping(value = "/admin/bannedUser/{userId}", method = RequestMethod.PUT)
    public @ResponseBody
    String bannedUser(@PathVariable("userId") int userId, @RequestBody Boolean activity) {
        DaoFactory daoFactory = DaoFactory.getInstance();
        UserDao userDao = daoFactory.getUserDao();
        User user = userDao.getUser(userId);
        user.setActiveStatus(activity);
        userDao.saveUser(user);
        if (user.isActiveStatus()) {
            return "{\"msg\":\"user unbanned\"}";
        } else {
            return "{\"msg\":\"user banned\"}";

        }

    }
}
