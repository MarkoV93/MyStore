/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.controllers;

import com.markoproject.checkPermissions.BedPermissionExeption;
import com.markoproject.checkPermissions.CheckPermissions;
import com.markoproject.dao.CityDao;
import com.markoproject.dao.DaoFactory;
import com.markoproject.table.City;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * Rest controller for city
 * datas is sending by json from ajax function if file "cities.js"
 */
@RequestMapping(value = "/admin")
@Controller
public class CityRestController {

    @RequestMapping(value = "/changeCity", method = RequestMethod.PUT)
    public @ResponseBody
    String bannedCity(@RequestBody City city) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        DaoFactory.getInstance().getCityDao().saveCity(city);
        return "{\"msg\":\"city changed\"}";

    }

    @RequestMapping(value = "/createCity", method = RequestMethod.POST)
    public @ResponseBody
    String createCity(@RequestBody City city) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        boolean isCreated = DaoFactory.getInstance().getCityDao().saveCity(city);
        if (isCreated) {
            return "{\"msg\":\"ok\"}";
        } else {
            return "{\"msg\":\" write current category name \"}";

        }
    }

    @RequestMapping(value = "/deleteCity", method = RequestMethod.DELETE)
    public @ResponseBody
    String deleteCity(@RequestBody Integer id) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        boolean isDeleted = DaoFactory.getInstance().getCityDao().deleteCity(id);
        if (isDeleted) {
            return "{\"id\":\"remove" + id + "\"}";
        } else {
            return "{\"msg\":\" city is not empty \"}";
        }
    }

    @RequestMapping(value = "/cities", method = RequestMethod.GET)
    public String getCities(Map<String, Object> model) throws BedPermissionExeption {
        CheckPermissions.chackAdminPermissions();
        CityDao cityDao = DaoFactory.getInstance().getCityDao();
        List<City> cities = cityDao.getCities();
        model.put("cities", cities);
        return "cities";
    }
}
