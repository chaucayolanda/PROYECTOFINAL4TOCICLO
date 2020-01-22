package Dao;

import Beans.BeanDetalleCompra;
import Interfaces.IDetalleCompra;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoDetalleCompra implements IDetalleCompra{
    
    private Connection cn;
    private PreparedStatement pstm;

    @Override
    public BeanDetalleCompra DetalleCompra(BeanDetalleCompra detalle) {
        BeanDetalleCompra obj = new BeanDetalleCompra();
        ResultSet rs = null;
        try {
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_INSERTA_DETALLE_COMPRA(?,?,?,?,?,?,?,?)}");
            
            pstm.setInt(1, detalle.getCOD_COMPRA());
            pstm.setInt(2, detalle.getCOD_PRODUCTO());
            pstm.setInt(3, detalle.getCANTIDAD());
            pstm.setString(4, detalle.getPRECIO_COMPRA());
            pstm.setString(5, detalle.getPRECIO_VENTA() );
            pstm.setString(6, detalle.getPRESENTACION());
            pstm.setString(7, detalle.getDESCRIPCION());
            pstm.setInt(8, detalle.getCOD_MARCA());
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
