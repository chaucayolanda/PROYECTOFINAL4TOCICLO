package Dao;

import Beans.BeanProveedor;
import Interfaces.IProveedor;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoProveedor implements IProveedor{
    
 private Connection cn;
    private PreparedStatement pstm;
    
    @Override
    public BeanProveedor Proveedor(BeanProveedor pr) {
        BeanProveedor obj = new BeanProveedor();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_INSERTAPROVEEDOR(?,?,?,?,?,?,?)}");
           
            
            pstm.setString(1, pr.getCompania());
            pstm.setString(2, pr.getContacto());
            pstm.setString(3, pr.getCargo());
            pstm.setString(4, pr.getDireccion());
            pstm.setString(5, pr.getDistrito());
            pstm.setString(6, pr.getTelefono());
            pstm.setString(7, pr.getWeb());
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    };
    
    
     public BeanProveedor EditTrabajador(BeanProveedor pr) {
        BeanProveedor obj = new BeanProveedor();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_EDITAPROVEEDOR(?,?,?,?,?,?,?,?)}");
            
            pstm.setInt(1, pr.getId());
            pstm.setString(2, pr.getCompania());
            pstm.setString(3, pr.getContacto());
            pstm.setString(4, pr.getCargo());
            pstm.setString(5, pr.getDireccion());
            pstm.setString(6, pr.getDistrito());
            pstm.setString(7, pr.getTelefono());
            pstm.setString(8, pr.getWeb());
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    };
    
    
     public BeanProveedor EliminaTrabajador(BeanProveedor pr) {
        BeanProveedor obj = new BeanProveedor();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_ELIMINAPROVEEDOR(?)}");
            pstm.setInt(1, pr.getId());
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
