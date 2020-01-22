package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static String usuario = "sa";
    private static String password = "12345678";
    private static String url = "jdbc:sqlserver://localhost;databaseName=AVANZADO";

    static {
        try {
            Class.forName(driver);
        } catch (Exception ex) {
            System.out.print(ex.toString());
        }
    }

    public Connection getCn() {
        Connection cn = null;
        try {
            cn = DriverManager.getConnection(url, usuario, password);
        } catch (SQLException ex) {
            System.out.print(ex.toString());
        }
        return cn;
    }
}
