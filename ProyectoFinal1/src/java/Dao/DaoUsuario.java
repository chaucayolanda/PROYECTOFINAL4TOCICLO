/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Beans.BeanUsuario;
import Interfaces.IUsuario;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author gfernandez
 */
public class DaoUsuario implements IUsuario {

    private Connection cn;
    private PreparedStatement pstm;

    @Override
    public BeanUsuario User(BeanUsuario usuario) {
        BeanUsuario obj = new BeanUsuario();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_INSERTAUSUARIO(?,?,?)}");

            pstm.setString(1, usuario.getCodigo());
            pstm.setString(2, usuario.getUsuario());
            pstm.setString(3, usuario.getClave());
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
            return obj;
        } catch (SQLException ex) {
            return null;
        }
    }

    ;
    
    public BeanUsuario EditTrabajador(BeanUsuario usuario) {
        BeanUsuario obj = new BeanUsuario();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_EDITAUSUARIO(?,?)}");
            pstm.setString(1, usuario.getCodigo());
            pstm.setString(2, usuario.getClave());
            rs = pstm.executeQuery();

            while (rs.next()) {
            //obj.setUsuario(rs.getString(1));
            }
            return obj;
        } catch (SQLException ex) {
            return null;
        }
    };
    
}