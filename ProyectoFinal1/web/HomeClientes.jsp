<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <title>Clientes</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body> 
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
            String dni = request.getParameter("dni");
            CallableStatement csta = null;
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                cnx = DriverManager.getConnection(cadena);
            } catch (java.lang.ClassNotFoundException e) {
                out.println(e);
            } catch (SQLException e) {
                out.println(e);
            };
            String usuario =(String) request.getSession().getAttribute("sCliente");
            String usercodigo =(String) request.getSession().getAttribute("sCodigoCliente");
            if(usuario == null){
                response.sendRedirect("LoginClientes.jsp");
            }
        %>
        <section class="full-box cover dashboard-sideBar">
            <div class="full-box dashboard-sideBar-bg btn-menu-dashboard"></div>
            <div class="full-box dashboard-sideBar-ct">
                <div class="full-box text-uppercase text-center text-titles dashboard-sideBar-title">
                    SISTEMA DE PEDIDOS <i class="zmdi zmdi-close btn-menu-dashboard visible-xs"></i>
                </div>
                <div class="full-box dashboard-sideBar-UserInfo">
                    <figure class="full-box">
                        <img src="./assets/img/avatar1.jpg" alt="UserIcon">
                        <figcaption class="text-center text-titles"><%=usuario%></figcaption>
                    </figure>
                    <ul class="full-box list-unstyled text-center">							
                        <li>
                            <a href="#!" class="btn-exit-system">
                                <i class="zmdi zmdi-power"></i>
                            </a>
                        </li>
                        <li>
                            <a href="CuentaCliente.jsp">
                                <i class="zmdi zmdi-settings"></i>
                            </a>
                        </li>
                    </ul>
                </div>
                <ul class="list-unstyled full-box dashboard-sideBar-Menu">
                    <li>
                        <a href="HomeClientes.jsp">
                            <i class="zmdi zmdi-view-dashboard zmdi-hc-fw"></i> Inicio
                        </a>
                    </li>
                    <li>
                        <a href="carrito.jsp">
                            <i class="zmdi zmdi-shopping-cart zmdi-hc-fw"></i> Carrito
                        </a>
                    </li>
                </ul>
            </div>
        </section>
        <section class="full-box dashboard-contentPage">
            <nav class="full-box dashboard-Navbar">
                <ul class="full-box list-unstyled text-right">
                    <li class="pull-left">
                        <a href="#!" class="btn-menu-dashboard"><i class="zmdi zmdi-more-vert"></i></a>
                    </li>
                    <center>
                    </center>
                </ul>
            </nav>
            <div class="container-fluid">
                <div class="page-header">
                    <h1 class="text-titles">Productos <small>Razzeto | San Jorge</small></h1>
                </div>
            </div>
            <div class="full-box text-center" style="padding: 30px 10px;">
                <a href="carrito.jsp">
                    <article class="full-box tile">                        
                            <input name="codigo" value="<%=usercodigo%>"/>
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Compras
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-shopping-cart zmdi-hc-fw"></i>
                        </div>
                        <div class="full-box tile-number text-titles">
                            <%
                                try {
                                    String sql = "SELECT COUNT(COD_VENTA) FROM VENTA WHERE ESTADO = 'A' AND COD_CLIENTE = " + usercodigo;
                                    rs = sta.executeQuery(sql);
                                    while (rs.next()) {
                            %>
                            <span class="colorlib-counter js-counter" data-from="0" data-to="<%= rs.getString(1)%>" data-speed="2000" data-refresh-interval="50"></span>
                            <p class="full-box"><%=rs.getString(1)%></p>
                            <% }
                                } catch (SQLException e) {
                                    out.println(e);
                                };
                            %>
                            <small>Registrados</small>
                        </div>
                    </article>
                </a>
            </div>
        </section> 
        <script src="./js/jquery-1.10.2.min.js"></script>
        <script src="./js/jquery-ui.js"></script>
        <script src="./js/jquery-3.1.1.min.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/material.min.js"></script>
        <script src="./js/ripples.min.js"></script>
        <script src="./js/sweetalert2.min.js"></script>
        <script src="./js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="./js/main.js"></script>
        <script>
            $.material.init();
        </script>
    </body>
</html>