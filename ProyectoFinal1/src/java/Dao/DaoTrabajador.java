/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Beans.BeanTrabajador;
import Interfaces.ITrabajador;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoTrabajador implements ITrabajador {

    private Connection cn;
    private PreparedStatement pstm;

    @Override
    public BeanTrabajador Trabajador(BeanTrabajador tr) {
        BeanTrabajador obj = new BeanTrabajador();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_INSERTATRABAJADOR(?,?,?,?,?,?,?,?,?,?)}");
            pstm.setString(1, tr.getNombres());
            pstm.setString(2, tr.getPaterno());
            pstm.setString(3, tr.getMaterno());
            pstm.setString(4, tr.getSexo());
            pstm.setString(5, tr.getDireccion());
            pstm.setString(6, tr.getDistrito());
            pstm.setString(7, tr.getDni());
            pstm.setString(8, tr.getMail());
            pstm.setString(9, tr.getCelular());
            pstm.setInt(10, tr.getCargo());
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    };
    
    public BeanTrabajador EditTrabajador(BeanTrabajador tr) {
        BeanTrabajador obj = new BeanTrabajador();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{call SP_EDITAATRABAJADOR(?,?,?,?,?,?,?,?,?,?)}");
            
            pstm.setInt(1, tr.getCodigo());
            pstm.setString(2, tr.getNombres());
            pstm.setString(3, tr.getPaterno());
            pstm.setString(4, tr.getMaterno());
            pstm.setString(5, tr.getDireccion());
            pstm.setString(6, tr.getDistrito());
            pstm.setString(7, tr.getDni());
            pstm.setString(8, tr.getMail());
            pstm.setString(9, tr.getCelular());
            pstm.setInt(10, tr.getCargo());
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    };
    
    
     public BeanTrabajador EliminaTrabajador(BeanTrabajador tr) {
        BeanTrabajador obj = new BeanTrabajador();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_ELIMINATRABAJADOR(?)}");
            pstm.setInt(1, tr.getCodigo());
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    };
}