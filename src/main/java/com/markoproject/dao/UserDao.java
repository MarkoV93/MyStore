/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao;

import com.markoproject.table.User;
import java.sql.SQLException;
import java.util.List;

// interface of dao class with work methods which work  with "User" objects
public interface UserDao {
      public boolean saveUser(User user) ;
    public void deleteUser(int id) ;
    public User getUser(int id);
    public User verifyUser(String login,String password);
    public List<User> getUsers(Integer page);
    public int getPagesOfNotAdminUsers();
 public User getUser(String login);
     
}
