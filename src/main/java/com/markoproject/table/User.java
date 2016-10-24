/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.table;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

/**
 *
 * @author Marko
 */
@Entity
@Table(name = "user")
public class User implements Serializable{
       @Id
    @Column(name="id")
    @GeneratedValue(strategy=GenerationType.AUTO)
    private int id;
    
         @NotEmpty(message = "Please enter your name.")
    @Column(name="name",columnDefinition = "varchar(25)")
    private String name;
    
          @NotEmpty(message = "Please enter your name.")
    @Column(name="surname",columnDefinition = "varchar(25)")
    private String surname;
         
     @NotEmpty(message = "Please enter your login.")
     @Column(name="login",columnDefinition = "varchar(30)" ,unique = true)
    private String login;
     
       @NotEmpty(message = "Please enter your password.")
      @Column(name="password",columnDefinition = "varchar(30)")
    private String password;

      @Pattern(regexp="(^$|[0-9]{11})",message = "Please current phone.")
      @NotEmpty(message = "Please enter your phone.")
      @Column(name="phone",columnDefinition = "varchar(12)")
    private String phone;
      
  @Email(message="Please provide a valid email address")
         @NotEmpty(message = "Please enter your @mail.")
      @Column(name="email",columnDefinition = "varchar(30)")
    private String email;
         

      @Column(name="active_status")
    private boolean activeStatus;
          

      @Column(name="admin_status")
    private boolean adminStatus;

    public int getId() {
        return id;
    }
  


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }

    public boolean isAdminStatus() {
        return adminStatus;
    }

    public void setAdminStatus(boolean adminStatus) {
        this.adminStatus = adminStatus;
    }
      
      
}

