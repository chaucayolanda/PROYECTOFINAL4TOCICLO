package Dao;

import Beans.BeanLogin;
import Interfaces.ILogin;
import Utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoLogin implements ILogin{
    private Connection cn;
    private PreparedStatement pstm;

    @Override
    public BeanLogin Logueo(BeanLogin user) {
        BeanLogin obj = new BeanLogin();
        ResultSet rs=null;
        try{
            cn = new Conexion().getCn();
            pstm = cn.prepareStatement("{CALL SP_LOGIN(?,?)}");
            
            pstm.setString(1, user.getUsuario());
            pstm.setString(2, user.getClave());
            rs = pstm.executeQuery();
            
            while (rs.next()){
                obj.setUsuario(rs.getString(1));
                obj.setCargo(rs.getString(4));
                obj.setCodigo(rs.getString(5));
            }
            return obj;
        }catch(SQLException ex){
            return null;
        }
    }    
}