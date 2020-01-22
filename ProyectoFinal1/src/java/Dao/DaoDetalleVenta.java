package Dao;

import Beans.BeanDetalleVenta;
import Interfaces.IDetalleVenta;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DaoDetalleVenta implements IDetalleVenta{
    
    private Connection cn;
    private PreparedStatement pstm;

    @Override
    public BeanDetalleVenta DetalleCompra(BeanDetalleVenta detalle) {
        BeanDetalleVenta obj = new BeanDetalleVenta();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_INSERTA_DETALLE_VENTA(?,?,?,?)}");
            
            pstm.setInt(1, detalle.getCodVenta());
            pstm.setInt(2, detalle.getCodProducto());
            pstm.setInt(3, detalle.getCantidad());
            pstm.setString(4, detalle.getPVenta());
            
            rs = pstm.executeQuery();

            while (rs.next()) {
//                obj.setUsuario(rs.getString(1));
            }
           return obj;
        }catch(SQLException ex){
            return null;
        }
    }
    
    
}
