/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.markoproject.dao;

import com.markoproject.table.Reserve;
import java.sql.SQLException;
import java.util.List;

// interface of dao class with work methods which work  with "Reserve" objects
public interface ReserveDao {
      public void saveReserve(Reserve reserve) ;
    public void deleteReserve(int id);
    public Reserve getReserve(int id) ;
    public List<Reserve> getReserves() ;
   public List<Reserve> getActiveReserves(Integer page);
   public int getPagesOfActiveReserves();
}
