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
import com.markoproject.table.Category;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Marko
 */
@Controller
public class CategoryRestController {

    @RequestMapping(value = "admin/changeCategory", method = RequestMethod.PUT)
    public @ResponseBody
    String bannedCategory(@RequestBody Category category) throws BedPermissionExeption  {
        CheckPermissions.chackAdminPermissions();
        DaoFactory.getInstance().getCategoryDao().saveCategory(category);
        return "{\"msg\":\"category changed\"}";
    }

    @RequestMapping(value = "admin/createCategory", method = RequestMethod.POST)
    public @ResponseBody
    String createCategory(@RequestBody Category category) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        boolean isCreated = DaoFactory.getInstance().getCategoryDao().saveCategory(category);
        if (isCreated) {
            return "{\"msg\":\"ok\"}";

        } else {
            return "{\"msg\":\" write current category name \"}";

        }
    }

    @RequestMapping(value = "admin/deleteCategory", method = RequestMethod.DELETE)
    public @ResponseBody
    String deleteFromCity(@RequestBody Integer id) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        boolean isDeleted = DaoFactory.getInstance().getCategoryDao().deleteCategory(id);
        if (isDeleted) {
            return "{\"id\":\"remove" + id + "\"}";
        } else {
            return "{\"msg\":\" Category is not empty \"}";
        }
    }

    @RequestMapping(value = "admin/categories", method = RequestMethod.GET)
    public String getCategories(Map<String, Object> model) throws  BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        CategoryDao categoryDao = DaoFactory.getInstance().getCategoryDao();
        List<Category> categories = categoryDao.getCategories();
        model.put("categories", categories);
        return "categories";
    }
}
