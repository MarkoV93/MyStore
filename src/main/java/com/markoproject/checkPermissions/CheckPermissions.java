/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.checkPermissions;

import com.markoproject.dao.CategoryDao;
import com.markoproject.table.User;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 *
 * @author Marko
 */
@Service
public class CheckPermissions {

    @Autowired
    private HttpServletRequest request;
    private static final org.apache.log4j.Logger logger = LogManager.getLogger(CheckPermissions.class);

    static public void chackUserPermissions() throws BedPermissionExeption {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null||!user.isActiveStatus()) {
            request.setAttribute("message", "you doun't have permission to enter this page");
             logger.warn("user doesn't has premissions on this page");
            throw new BedPermissionExeption("user dousn't has permissions on this action");
        }
    }
     static public void chackAdminPermissions() throws BedPermissionExeption {
          HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user==null||!user.isAdminStatus()){
            request.setAttribute("message", "you doun't have permission to enter this page");
             logger.warn("user doesn't has premissions on this page");
            throw new BedPermissionExeption("user dousn't has permissions on this action");
            
        }
     }

}
