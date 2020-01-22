<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="validar()">
        <%
            Connection cnx = null;
            ResultSet rs = null;
            Statement sta = null;
            String cadena = "jdbc:sqlserver://localhost; databaseName=AVANZADO;user=sa; password=12345678;";
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                cnx = DriverManager.getConnection(cadena);
                sta = cnx.createStatement();
            } catch (java.lang.ClassNotFoundException e) {
                out.println(e);
            } catch (SQLException e) {
                out.println(e);
            };
            if (request.getParameter("dni") != null) {
                if (request.getParameter("UserPass") != null) {
                    String dni = request.getParameter("dni");
                    String pass = request.getParameter("UserPass");
                    CallableStatement csta = null;
                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        cnx = DriverManager.getConnection(cadena);
                    } catch (java.lang.ClassNotFoundException e) {
                        out.println(e);
                    } catch (SQLException e) {
                        out.println(e);
                    };
                    try {
                        csta = cnx.prepareCall("{call SP_LOGINCLIENTES(?,?)}");
                        csta.setString(1, dni);
                        csta.setString(2, pass);
                        rs = csta.executeQuery();
                        while (rs.next()) {
        }
                        rs.close();
                        cnx.close();
                    } catch (SQLException e) {
                        out.println(e);
                    };
                }
            }
        %>
        <script>
            function validar() {               
                    swal({
                        title: "Dni o clave incorrecta",
                        icon: "error",
                        dangerMode: true
                    })
                            .then((willDelete) => {
                                if (willDelete) {
                                    location.href = "LoginClientes.jsp";
                                }
                            });
                };
        </script>

        <script src="./js/jquery-1.10.2.min.js"></script>
        <script src="./js/jquery-ui.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </body>
</html>
