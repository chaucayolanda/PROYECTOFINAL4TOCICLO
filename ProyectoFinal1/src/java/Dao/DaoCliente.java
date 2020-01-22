package Dao;

import Beans.BeanCliente;
import Beans.BeanTrabajador;
import Interfaces.ICliente;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoCliente implements ICliente{

    private Connection cn;
    private PreparedStatement pstm;

    @Override
    public BeanCliente Cliente(BeanCliente cl) {
     BeanCliente obj = new BeanCliente();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_INSERTACLIENTES(?,?,?,?,?,?,?,?,?,?)}");
            
            pstm.setString(1, cl.getNombres());
            pstm.setString(2, cl.getPaterno());
            pstm.setString(3, cl.getMaterno());
            pstm.setString(4, cl.getSexo());
            pstm.setString(5, cl.getDireccion());
            pstm.setString(6, cl.getDistrito());
            pstm.setString(7, cl.getMail());
            pstm.setString(8, cl.getCelular());
            pstm.setString(9, cl.getDni());
            pstm.setString(10, cl.getClave());
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    };



    public BeanCliente EditCliente(BeanCliente cl) {
        BeanCliente obj = new BeanCliente();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{call SP_EDITACLIENTE(?,?,?,?,?,?,?,?,?,?)}");
            
            pstm.setInt(1, cl.getCodigo());
            pstm.setString(2, cl.getNombres());
            pstm.setString(3, cl.getPaterno());
            pstm.setString(4, cl.getMaterno());
            pstm.setString(5, cl.getDireccion());
            pstm.setString(6, cl.getDistrito());
            pstm.setString(7, cl.getMail());
            pstm.setString(8, cl.getCelular());
            pstm.setString(9, cl.getDni());
            pstm.setString(10, cl.getClave());
            rs = pstm.executeQuery();      
        
            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    };
    
    
     public BeanCliente EliminaTrabajador(BeanCliente cl) {
        BeanCliente obj = new BeanCliente();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_ELIMINACLIENTE(?)}");
            pstm.setInt(1, cl.getCodigo());
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