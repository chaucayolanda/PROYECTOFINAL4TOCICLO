package Dao;

import Beans.BeanLoginCliente;
import Interfaces.ILoginCliente;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoLoginCliente implements ILoginCliente{
    private Connection cn;
    private PreparedStatement pstm;

    @Override
    public BeanLoginCliente LogueoCliente(BeanLoginCliente cliente) {
        BeanLoginCliente obj = new BeanLoginCliente();
        ResultSet rs=null;
        try{
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_LOGINCLIENTES(?,?)}");
            
            pstm.setString(1, cliente.getDni());
            pstm.setString(2, cliente.getClave());
            rs = pstm.executeQuery();
            
            while (rs.next()){
                obj.setDni(rs.getString(1));
                obj.setCodigo(rs.getString(3));
            }
            return obj;
        }catch(SQLException ex){
            return null;
        }
    }
}
