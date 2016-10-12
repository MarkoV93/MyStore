/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.maarkoproject.filters.checkPermissions;

/**
 *
 * @author Marko
 */
public class BedPermissionExeption extends Exception {

    String message;

    public  BedPermissionExeption(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

}
