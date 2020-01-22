<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <title>Home</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="./css/main.css">
        <link rel="stylesheet" type="text/css" href="./css/datatables.css">
        <link rel="stylesheet" href="./css/jquery-ui.css" />
        <link rel="stylesheet" href="./css/alertify.min.css">
        <link rel="stylesheet" href="./css/main.css">
        <link rel="stylesheet" href="./new.css">
        <script src="./js/jquery-1.10.2.min.js"></script>
        <script src="./js/jquery-ui.js"></script>
        <script src="./js/alertify.min.js"></script>    
        <script src="./js/sweetalert2.min.js"></script>
        <script src="./js/bootstrap.min.js"></script>
        <script src="./js/material.min.js"></script>
        <script src="./js/datatables.js"></script>        
        <script src="./js/ripples.min.js"></script>
        <script src="./js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="./js/main.js"></script>
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

            String usuario = (String) request.getSession().getAttribute("sUsuario");
            String cargo = (String) request.getSession().getAttribute("sCargo");
            String carguito = "Administrador";
            String usercodigo = (String) request.getSession().getAttribute("sCodigo");
            if (usuario == null) {
                response.sendRedirect("Login.jsp");
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
                        <img src="./assets/img/avatar.jpg" alt="UserIcon">
                        <figcaption class="text-center text-titles"><%=usuario%></figcaption>
                    </figure>
                    <ul class="full-box list-unstyled text-center">							
                        <li>
                            <a href="#!" class="btn-exit-system">
                                <i class="zmdi zmdi-power"></i>
                            </a>
                        </li>
                    </ul>
                </div>
                <ul class="list-unstyled full-box dashboard-sideBar-Menu">
                    <li>
                        <a href="Home.jsp">
                            <i class="zmdi zmdi-view-dashboard zmdi-hc-fw"></i> Inicio
                        </a>
                    </li>
                    <li>
                        <a href="#!" class="btn-sideBar-SubMenu">
                            <i class="zmdi zmdi-account-add zmdi-hc-fw"></i> Usuarios <i class="zmdi zmdi-caret-down pull-right"></i>
                        </a>
                        <ul class="list-unstyled full-box">
                            <li>
                                <a href="Trabajadores.jsp"><i class="zmdi zmdi-account zmdi-hc-fw"></i> Trabajadores</a>
                            </li>
                            <li>
                                <a href="ListaClientes.jsp"><i class="zmdi zmdi-male-female zmdi-hc-fw"></i> Clientes</a>
                            </li>
                            <li>
                                <a href="Proveedores.jsp"><i class="zmdi zmdi-accounts"></i> Proveedores</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" id="compras"><i class="zmdi zmdi-markunread-mailbox zmdi-hc-fw"></i> Compras</a>
                    </li>
                    <!--<li>
                        <a href="ventas.jsp">
                            <i class="zmdi zmdi-shopping-cart zmdi-hc-fw"></i> Ventas
                        </a>
                    </li>-->
                    <li>
                        <a href="Empresa.jsp"><i class="zmdi zmdi-shield-security zmdi-hc-fw"></i> Configurar Empresa</a>							
                    </li>
                </ul>
            </div>
        </section>

        <%            try {
                String sql = "SELECT MAX(COD_PROVEEDOR) FROM PROVEEDOR";
                rs = sta.executeQuery(sql);
                while (rs.next()) {
        %> 
        <input hidden id="total" value="<%= rs.getString(1)%>"/>
        <% }
            } catch (SQLException e) {
                out.println(e);
            };
        %>
        <section class="full-box dashboard-contentPage">
            <nav class="full-box dashboard-Navbar">
                <ul class="full-box list-unstyled text-right">
                    <li class="pull-left">
                        <a href="#!" class="btn-menu-dashboard"><i class="zmdi zmdi-more-vert"></i></a>
                    </li>
                    <%
                        if (carguito.equals(cargo)) {
                    %>
                    <center>
                        <li>
                            <a style="color:aqua" href="Usuarios.jsp">Cuentas de Usuario</a>
                        </li>
                    </center>
                    <%
                        }

                    %>
                </ul>
            </nav>
            <div class="container-fluid">
                <div class="page-header">
                    <h1 class="text-titles">Productos <small>Razzeto | San Jorge</small></h1>
                </div>
            </div>
            <div class="full-box text-center" style="padding: 30px 10px;">
                <a href="Trabajadores.jsp">
                    <article class="full-box tile">
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Administradores
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-account"></i>
                        </div>
                        <%                            try {
                                String sql = "SELECT COUNT(COD_TRABAJADOR) FROM TRABAJADORES WHERE COD_CARGO=1 AND ESTADO='A'";
                                rs = sta.executeQuery(sql);
                                while (rs.next()) {
                        %> 
                        <div class="full-box tile-number text-titles">
                            <p class="full-box"><%= rs.getString(1)%></p>
                            <% }
                                } catch (SQLException e) {
                                    out.println(e);
                                };
                            %>
                            <small>Registrados</small>
                        </div>
                    </article>
                </a>
                <a href="ListaClientes.jsp">
                    <article class="full-box tile">
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Clientes
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-male-female"></i>
                        </div>
                        <div class="full-box tile-number text-titles">
                            <%
                                try {
                                    String sql = "SELECT COUNT(COD_CLIENTE) FROM CLIENTES WHERE ESTADO='A'";
                                    rs = sta.executeQuery(sql);
                                    while (rs.next()) {
                            %> 
                            <p class="full-box"><%= rs.getString(1)%></p>
                            <% }
                                } catch (SQLException e) {
                                    out.println(e);
                                };
                            %>
                            <small>Registrados</small>
                        </div>
                    </article>
                </a>
                <a href="Trabajadores.jsp">
                    <article class="full-box tile">
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Secretarias
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-female"></i>
                        </div>
                        <div class="full-box tile-number text-titles">
                            <%
                                try {
                                    String sql = "SELECT COUNT(COD_TRABAJADOR) FROM TRABAJADORES WHERE COD_CARGO=2 AND ESTADO='A'";
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
                            <small>Registradas</small>
                        </div>
                    </article>
                </a>
                <a href="Trabajadores.jsp">
                    <article class="full-box tile">
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Camioneros
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-face"></i>
                        </div>
                        <div class="full-box tile-number text-titles">
                            <%
                                try {
                                    String sql = "SELECT COUNT(COD_TRABAJADOR) FROM TRABAJADORES WHERE COD_CARGO=3 AND ESTADO='A'";
                                    rs = sta.executeQuery(sql);
                                    while (rs.next()) {
                            %>
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
                <a href="Trabajadores.jsp">
                    <article class="full-box tile">
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Almacen
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-local-shipping"></i>
                        </div>
                        <div class="full-box tile-number text-titles">
                            <%
                                try {
                                    String sql = "SELECT COUNT(COD_TRABAJADOR) FROM TRABAJADORES WHERE COD_CARGO=4 AND ESTADO='A'";
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

                <a href="Productos.jsp">
                    <article onclick="iraproducto()" class="full-box tile">
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Productos
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-local-dining"></i>
                        </div>
                        <div class="full-box tile-number text-titles">
                            <%
                                try {
                                    String sql = "SELECT COUNT(COD_PRODUCTO) FROM PRODUCTO WHERE STOCK>0";
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
                <a href="Proveedores.jsp">
                    <article class="full-box tile">
                        <div class="full-box tile-title text-center text-titles text-uppercase">
                            Proveedores
                        </div>
                        <div class="full-box tile-icon text-center">
                            <i class="zmdi zmdi-accounts"></i>
                        </div>
                        <div class="full-box tile-number text-titles">
                            <%
                                try {
                                    String sql = "SELECT COUNT(COD_PROVEEDOR) FROM PROVEEDOR WHERE ESTADO='A'";
                                    rs = sta.executeQuery(sql);
                                    while (rs.next()) {
                            %>
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


        <div id="modalProveedor" style="display:none">
            <form action="Compras.jsp" method="post" name="frmProveedor"  style="margin-top:10px; margin-bottom:10px">
                <input hidden id="codigo" name="codigo" value="">
                <input hidden id="nombrep" name="nombrep" value="">
                <div class="table-responsive">
                    <table id="productos" class="table text-center">
                        <thead>
                            <tr>
                                <th class="text-center">Seleccionar</th>
                                <th class="text-center">Proveedor</th>
                            </tr>
                        </thead>
                        <%
                            try {
                                String sql = "SELECT COD_PROVEEDOR, NOMBRE_CONTACTO FROM PROVEEDOR WHERE ESTADO = 'A'";
                                rs = sta.executeQuery(sql);
                        %>
                        <tbody>
                            <%
                                while (rs.next()) {
                            %> 
                            <tr>
                                <td>
                                    <input name="radiecito" type="radio" id="user<%= rs.getString(1)%>"/>
                                    <label for="user<%= rs.getString(1)%>"><span></span></label>
                                </td>
                                <td>
                                    <input disabled style="border-width:0; background-color:white; color:black; width: 100%; text-align: center;" name="usuario<%= rs.getString(1)%>" id="usuario<%= rs.getString(1)%>" value="<%= rs.getString(2)%>"/>
                                    <input hidden type="text" id="userc<%= rs.getString(1)%>" value="<%= rs.getString(1)%>"/></td>
                            </tr>
                            <% }
                                    rs.close();
                                    sta.close();
                                    cnx.close();
                                } catch (SQLException e) {
                                    out.println(e);
                                };
                            %>
                        </tbody>
                    </table>
                    <center><button onclick="iracompras()" class="btn btn-success btn-raised btn-xs"> Seleccionar </button></center>
                </div>
            </form>
        </div>


        <script>

            $(function () {
                $("#modalProveedor").dialog({
                    autoOpen: false
                });
                $("#compras").click(function () {
                    $("#modalProveedor").dialog('open');
                    $("#modalProveedor").dialog({
                        title: "Proveedores",
                        resizable: false,
                        height: 450,
                        width: 600,
                        modal: true
                    });
                });
            });

            function iracompras() {
                var totalproveedor = $("#total").val();
                for (var i = 1; i <= totalproveedor; i++) {
                    if ($("#user" + i).is(':checked')) {
                        $("#codigo").val($("#userc" + i).val());
                        $("#nombrep").val($("#usuario" + i).val());
                    }
                    ;
                }
                window.frmProveedor.submit();
            }
            ;

            $.material.init();
        </script>
    </body>
</html>