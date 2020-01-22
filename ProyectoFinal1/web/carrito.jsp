<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Compras</title>
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
    <style>
        .no-close .ui-dialog-titlebar-close {
            display: none;
        }
    </style>
    <body>
        <%
            Connection cnx = null;
            ResultSet rs = null;
            Statement sta = null;
            CallableStatement csta = null;
            String usuario = (String) request.getSession().getAttribute("sCliente");
            String usercodigo = (String) request.getSession().getAttribute("sCodigoCliente");
            if (usuario == null) {
                response.sendRedirect("LoginClientes.jsp");
            }
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                cnx = DriverManager.getConnection("jdbc:sqlserver://localhost; databaseName=AVANZADO;user=sa; password=12345678;");
                sta = cnx.createStatement();
            } catch (java.lang.ClassNotFoundException e) {
                out.println(e);
            } catch (SQLException e) {
                out.println(e);
            };
            try {
                csta = cnx.prepareCall("{CALL SP_INSERTAVENTA(?)}");
                csta.setString(1, usercodigo);
                csta.executeUpdate();
            } catch (SQLException e) {
                out.println(e);
            };
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
                </ul>
            </nav>
            <div class="container-fluid">
                <div class="page-header">
                    <h1 class="text-titles"><i class="zmdi zmdi-markunread-mailbox zmdi-hc-fw"></i>Compras</h1>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                            <li><a href="#new" data-toggle="tab">Nueva</a></li>
                            <li><a href="#list" data-toggle="tab">Lista</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="new">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-md-10 col-md-offset-1">
                                            <form action="AddDetalleVenta" method="post">
                                                <%
                                                    try {
                                                        String sql = "SELECT MAX(COD_VENTA) FROM VENTA";
                                                        rs = sta.executeQuery(sql);
                                                        while (rs.next()) {
                                                %> 
                                                <input hidden id="codigocompraactual" name="codigoventaactual" value="<%= rs.getString(1)%>"/>
                                                <% }
                                                    } catch (SQLException e) {
                                                        out.println(e);
                                                    };
                                                %>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Cliente</label>
                                                    <input disabled class="form-control text-center" type="text" id="nombrecliente" value="<%=usuario%>"/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label" style="font-size: 16px;">Producto</label><br>
                                                    <div class="row">                                                       
                                                        <div class="col-lg">
                                                            <center><button type="button" id="productos" class="btn btn-success btn-xs"><strong><i class="zmdi zmdi-eye"></i></strong></button></center>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="adicionaproductos"></div>
                                                <%
                                                    try {
                                                        String sql = "SELECT MAX(COD_PRODUCTO) FROM PRODUCTO";
                                                        rs = sta.executeQuery(sql);
                                                        while (rs.next()) {
                                                %> 
                                                <input hidden id="cantprod" value="<%= rs.getString(1)%>"/>
                                                <% }
                                                    } catch (SQLException e) {
                                                        out.println(e);
                                                    };
                                                %>
                                                <p class="text-center">
                                                    <button type="submit" class="btn btn-info btn-raised btn-sm"><i class="zmdi zmdi-floppy"></i> Guardar</button>
                                                </p>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                                
                                                <div class="tab-pane fade" id="list">
                                <div class="table-responsive">
                                    <table id="clientes" class="table table-hover text-center">
                                        <thead>
                                            <tr>                                                
                                                <th class="text-center">Venta</th>
                                                <th class="text-center">Cliente</th>
                                                <th class="text-center">Fecha</th>
                                                <th class="text-center">Estado</th>
                                                <th hidden class="text-center">Ver</th>
                                            </tr>
                                        </thead>
                                        <%
                                            try {
                                                String codigo = usercodigo;
                                                String sql = "SELECT COD_VENTA, CONCAT(CLIENTES.NOMBRES, ' ', CLIENTES.APE_PATERNO, ' ', CLIENTES.APE_MATERNO), FECHA_VENTA FROM VENTA INNER JOIN CLIENTES ON VENTA.COD_CLIENTE = CLIENTES.COD_CLIENTE WHERE VENTA.ESTADO = 'A' AND CLIENTES.COD_CLIENTE = "+ codigo;
                                                rs = sta.executeQuery(sql);
                                        %>
                                        <tbody>
                                            <%
                                                while (rs.next()) {
                                            %> 
                                            <tr>                                                
                                                <td><%= rs.getString(1)%></td>
                                                <td><%= rs.getString(2)%></td>
                                                <td><%= rs.getString(3)%></td>
                                                <td>Activo</td>
                                                <td hidden><td>
                                            </tr>
                                            <% }
                                                } catch (SQLException e) {
                                                    out.println(e);
                                                };
                                            %>
                                        </tbody>
                                    </table>
                                    <input hidden id="numpro" value="1" />
                                </div>
                            </div>
                            <div id="modalProductos" style="display:none">
                                <form action="#" style="margin-top:10px; margin-bottom:10px">
                                    <div class="table-responsive">
                                        <table id="productos" class="table text-center">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Seleccionar</th>
                                                    <th hidden class="text-center"></th>
                                                    <th class="text-center">Producto</th>
                                                </tr>
                                            </thead>
                                            <%
                                                try {
                                                    String sql = "SELECT COD_PRODUCTO, DESCRIPCION, PRESENTACION, PRECIO_VENTA, NOMBRE FROM PRODUCTO INNER JOIN MARCA ON PRODUCTO.COD_MARCA = MARCA.COD_MARCA";
                                                    rs = sta.executeQuery(sql);
                                            %>
                                            <tbody>
                                                <%
                                                    while (rs.next()) {
                                                %> 
                                                <tr>
                                                    <td>
                                                        <input name="radiecito1" type="radio" id="producto<%= rs.getString(1)%>"/>
                                                        <label for="producto<%= rs.getString(1)%>"><span></span></label>
                                                    </td>
                                                    <td hidden><input id="productosU<%= rs.getString(1)%>" value="<%= rs.getString(1)%>"</td>
                                                    <td><input disabled style="border-width:0; background-color:white; color:black; text-align: center;" id="dato<%= rs.getString(1)%>" value="<%= rs.getString(2)%>"/></td>
                                                    <td hidden><input id="presentacionp<%= rs.getString(1)%>" value="<%= rs.getString(3)%>"</td>
                                                    <td hidden><input id="pventa<%= rs.getString(1)%>" value="<%= rs.getString(4)%>"</td>
                                                    <td hidden><input id="nmarca<%= rs.getString(1)%>" value="<%= rs.getString(5)%>"</td>
                                                </tr>
                                                <% }
                                                    } catch (SQLException e) {
                                                        out.println(e);
                                                    };
                                                %>
                                            </tbody>
                                        </table>
                                        <center><button type="button" onclick="addprod()" class="btn btn-info btn-raised btn-sm"> Añadir </button></center>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script>

            $.material.init();
       
            $(function () {
                $("#modalProductos").dialog({
                    autoOpen: false
                });

                $("#productos").click(function () {
                    $("#modalProductos").dialog('open');
                    $("#modalProductos").dialog({
                        title: "Productos",
                        resizable: false,
                        height: 450,
                        width: 500,
                        modal: true
                    });
                });
            });



            function addprod() {
                var totalproductos = $("#cantprod").val();
                var html = "";
                for (var i = 1; i <= totalproductos; i++) {
                    if ($("#producto" + i).is(':checked')) {
                        var codigoproducto = $("#productosU" + i).val();
                        var dato = $("#dato" + i).val();
                        var presentacion = $("#presentacionp" + i).val();
                        var preventa = $("#pventa" + i).val();
                        var marca = $("#nmarca" + i).val();
                        $("#adicionaproductos").empty();
                        html = html + ("<div class=\"row\">");
                        html = html + ("<div class=\"col-lg-1\"></div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input hidden type=\"text\" value=\"" + codigoproducto + "\" name=\"codigoproducto\" id=\"codigoproducto\" >");
                        html = html + ("<input readonly  class=\"form-control\" style=\"text-align: center\" type=\"text\" value=\"" + dato + "\" id=\"producto\" />");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input readonly  class=\"form-control\" style=\"text-align: center\" type=\"text\" value=\"" + presentacion + "\" id=\"presentacion\" >");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input class=\"form-control\" style=\"text-align: center\" type=\"text\" readonly  value=\"" + marca + "\" id=\"marca\" >");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-1\"></div>");
                        html = html + ("</div>");                        
                        html = html + ("<div class=\"row\">");
                        html = html + ("<div class=\"col-lg-3\"></div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input readonly  class=\"form-control\" style=\"text-align: center\" type=\"text\" value=\"" + preventa + "\" name=\"preventa\" id=\"preventa\" />");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input class=\"form-control\" style=\"text-align: center\" type=\"number\" placeholder=\"Cantidad\" name=\"stock\" id=\"stock\" required/>");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-3\"></div>");
                        html = html + ("</div>");
                        $("#adicionaproductos").append(html);
                    };
                };
            };

        </script>
    </body>
</html>