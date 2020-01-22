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
            String usuario = (String) request.getSession().getAttribute("sUsuario");
            String usercodigo = (String) request.getSession().getAttribute("sCodigo");
            String codproveedor = request.getParameter("codigo");
            String nombrep = request.getParameter("nombrep");
            if (usuario == null) {
                response.sendRedirect("Login.jsp");
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
                csta = cnx.prepareCall("{CALL SP_INSERTACOMPRA(?,?)}");
                csta.setString(1, codproveedor);
                csta.setString(2, usercodigo);
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

        <%
            try {
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
                </ul>
            </nav>
            <div class="container-fluid">
                <div class="page-header">
                    <h1 class="text-titles"><i class="zmdi zmdi-markunread-mailbox zmdi-hc-fw"></i>Compras</h1>
                </div>
                <p class="lead">Estimado Usuario, en esta sección se realizan las consultas de las <strong>Compras</strong> actualmente registrados en el sistema, con opción de añadir, verificar datos.</p>
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
                                            <form action="AddDetalleCompra" method="post">
                                                <%
                                                    try {
                                                        String sql = "SELECT MAX(COD_COMPRA) FROM COMPRA";
                                                        rs = sta.executeQuery(sql);
                                                        while (rs.next()) {
                                                %> 
                                                <input hidden id="codigocompraactual" name="codigocompraactual" value="<%= rs.getString(1)%>"/>
                                                <% }
                                                    } catch (SQLException e) {
                                                        out.println(e);
                                                    };
                                                %>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Proveedor</label>
                                                    <input disabled class="form-control text-center" type="text" maxlength="50" name="nombreproveedor" id="nombreproveedor" value="<%=nombrep%>"/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label" style="font-size: 16px;">Producto</label><br>
                                                    <div class="row">
                                                        <div class="col-lg-2"></div>
                                                        <div class="col-lg-4">                                                            
                                                            <label>Nuevo</label>
                                                            <input type="checkbox" id="nuevop"/>
                                                            <label onclick="newprod()" for="nuevop"><span></span></label>
                                                        </div>
                                                        <div class="col-lg-4">
                                                            <label>Existente</label>
                                                            <button id="productos" class="btn btn-success btn-xs"><strong> . . .</strong></button>
                                                        </div>
                                                        <div class="col-lg-2"></div>
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
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Precio Compra</label>
                                                    <input class="form-control" type="text" maxlength="8" name="pcompra" id="pcompra" required>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Precio Venta</label>
                                                    <input class="form-control" type="text" maxlength="9" name="pventa" id="pventa" required>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Presentación</label>
                                                    <input class="form-control" type="text" name="presentacion" id="presentacion" required>
                                                </div>
                                                <p class="text-center">
                                                    <button type="submit" class="btn btn-info btn-raised btn-sm"><i class="zmdi zmdi-floppy"></i> Guardar</button>
                                                </p>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="modalProductos" style="display:none">
                                <form action="#" style="margin-top:10px; margin-bottom:10px">
                                    <div class="table-responsive">
                                        <table id="productos" class="table text-center">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Seleccionar</th>
                                                    <th class="text-center">Producto</th>
                                                    <th class="text-center">Marca</th>
                                                </tr>
                                            </thead>
                                            <%
                                                try {
                                                    String sql = "SELECT P.COD_PRODUCTO, P.DESCRIPCION, M.COD_MARCA, M.NOMBRE FROM PRODUCTO P INNER JOIN MARCA M ON P.COD_MARCA = M.COD_MARCA";
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
                                                    <td><input hidden id="productosU<%= rs.getString(1)%>" value="<%= rs.getString(1)%>"</td>
                                                    <td><input disabled style="border-width:0; background-color:white; color:black; text-align: center;" id="dato<%= rs.getString(1)%>" value="<%= rs.getString(2)%>"/></td>
                                                    <td><input disabled style="border-width:0; background-color:white; color:black; text-align: center;" id="marca<%= rs.getString(1)%>" value="<%= rs.getString(4)%>"/></td>
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
                            <div class="tab-pane fade" id="list">
                                <div class="table-responsive">
                                    <table id="clientes" class="table table-hover text-center">
                                        <thead>
                                            <tr>                                                
                                                <th class="text-center">Proveedor</th>
                                                <th class="text-center">Trabajador</th>
                                                <th class="text-center">Fecha Compra</th>
                                                <th hidden class="text-center">Ver</th>
                                            </tr>
                                        </thead>
                                        <%
                                            try {
                                                String codigo = codproveedor;
                                                String sql = "SELECT C.COD_COMPRA, C.COD_PROVEEDOR, P.NOMBRE_CONTACTO, C.COD_TRABAJADOR, CONCAT(T.NOMBRES, ' ', T.APE_PATERNO, ' ', T.APE_MATERNO) , C.FECHA_COMPRA FROM COMPRA C INNER JOIN PROVEEDOR P ON C.COD_PROVEEDOR = P.COD_PROVEEDOR INNER JOIN TRABAJADORES T ON C.COD_TRABAJADOR = T.COD_TRABAJADOR WHERE C.ESTADO = 'A' AND C.COD_PROVEEDOR = " + codigo;
                                                rs = sta.executeQuery(sql);
                                        %>
                                        <tbody>
                                            <%
                                                while (rs.next()) {
                                            %> 
                                            <tr>                                                
                                                <td><%= rs.getString(3)%></td>
                                                <td><%= rs.getString(5)%></td>
                                                <td><%= rs.getString(6)%></td>
                                                <td hidden><i id="dc<%=rs.getString(1)%>" onclick="DetalleVenta('<%=rs.getString(1)%>')" class="zmdi zmdi-eye zmdi-hc-fw"></i><td>
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
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div id="modalProveedor" style="display:none">
            <form method="post" style="margin-top:10px; margin-bottom:10px">
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
                                    <input hidden type="text" id="userc<%= rs.getString(1)%>" value="<%= rs.getString(1)%>"/>
                                </td>
                            </tr>
                            <% }

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

        <div id="modalDC" style="display:none">
            <form method="post" style="margin-top:10px; margin-bottom:10px">        
                <div class="table-responsive">
                    <table class="table text-center">
                        <thead>
                            <tr>
                                <th class="text-center">Producto</th>
                                <th class="text-center">Cantidad</th>
                                <th class="text-center">P. Compra</th>
                                <th class="text-center">P. Venta</th>
                                <th class="text-center">Total</th>
                            </tr>
                        </thead>
                        <%
                            try {
                                String codigo= "29";
                                String sql = "SELECT P.DESCRIPCION, DC.CANTIDAD, DC.PRECIO_COMPRA, DC.PRECIO_VENTA, DC.TOTAL FROM DETALLE_COMPRA DC INNER JOIN PRODUCTO P ON DC.COD_PRODUCTO = P.COD_PRODUCTO WHERE DC.COD_COMPRA="+codigo;
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
                                <td><%= rs.getString(4)%></td>
                                <td><%= rs.getString(5)%></td>
                            </tr>
                            <% }

                                } catch (SQLException e) {
                                    out.println(e);
                                };
                            %>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>

        <script>
            function DetalleVenta(codigo) {
                $("#modalDC").dialog({
                    autoOpen: false
                });
                $("#dc" + codigo).click(function () {

                    $("#modalDC").dialog('open');
                    $("#modalDC").dialog({
                        title: "Detalle de compra: " + codigo,
                        resizable: false,
                        height: 450,
                        width: 653,
                        modal: true
                    });
                });

            }
        </script>

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
                        //$("#nombreproveedor").val($("#usuario" + i).val());
                        //$("#codigoproveedor").val($("#userc" + i).val());
                    }
                    ;
                }
                window.frmProveedor.submit();
            }
            ;

            $.material.init();
        </script>

        <script>
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
                        width: 672,
                        modal: true
                    });
                });
            });


            function newprod() {
                var i = parseInt($("#numpro").val());
                $("#numpro").val(i + 1);
                var html = "";
                var totalproductos = $("#cantprod").val();
                if ($("#nuevop").is(':checked')) {
                    $("#productos").prop("disabled", false);
                    $("#adicionaproductos").empty();
                    $("#numpro").val("1");
                } else {
                    for (var j = 1; j <= totalproductos; j++) {
                        $("#producto" + j).prop('checked', false);
                    }
                    ;
                    $("#productos").prop("disabled", true);
                    for (i; i <= 1; i++) {
                        $("#adicionaproductos").empty();
                        html = html + ("<div class=\"row\">");
                        html = html + ("<div class=\"col-lg-1\"></div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input hidden type=\"text\" value=\"0\" name=\"codigoproducto\" id=\"codigoproducto\" >");
                        html = html + ("<input class=\"form-control\" style=\"text-align: center\" type=\"text\" placeholder=\"Nombre del producto\" name=\"producto\" id=\"producto\" required/>");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-2\">");
                        html = html + ("<input class=\"form-control\" style=\"text-align: center\" type=\"number\" name=\"stock\" placeholder=\"Stock\" id=\"stock\" required/>");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<select class=\"form-control\" id=\"marca\" name=\"marca\"><%try {
                                String selec = ("SELECT * FROM MARCA");
                                rs = sta.executeQuery(selec);
                                while (rs.next()) {%><option value=\"<%=rs.getString(1)%>\"><%=rs.getString(2)%></option><% }
                                    } catch (SQLException e) {
                                        out.println(e);
                                    };%></select>");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-2\">");
                        html = html + ("<button class=\"btn btn-success hidden\" id=\"btn" + i + "\" onclick=\"validar()\"><i class=\"zmdi zmdi-shopping-cart-add\"></i></button>");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-1\"></div>");
                        html = html + ("</div>");
                        $("#adicionaproductos").append(html);
                    }
                }
                ;
            }
            ;


            function validar() {
                var i = parseInt($("#numpro").val());
                $("#numpro").val(i + 1);
                if ($("#producto" + i).val() === "") {
                    alert("Ingrese Nombre del Producto");
                    $("#producto" + i).focus();
                } else if ($("#stock" + i).val() === "") {
                    alert("Ingrese Stock del Producto");
                    $("#stock" + i).focus();
                } else {
                    addinput();
                }
                ;
            }

            function addinput() {
                var j = parseInt($("#numpro").val());
                $("#numpro").val(j + 1);
                var html = "";
                for (i = 1; i <= 1; i++) {
                    $("#btn1").remove();
                    html = html + ("<div class=\"row\">");
                    html = html + ("<div class=\"col-lg-1\"></div>");
                    html = html + ("<div class=\"col-lg-3\">");
                    html = html + ("<input class=\"form-control\" style=\"text-align: center\" type=\"text\" placeholder=\"Nombre del producto\" name=\"producto\" id=\"producto\"/>");
                    html = html + ("</div>");
                    html = html + ("<div class=\"col-lg-2\">");
                    html = html + ("<input class=\"form-control\" style=\"text-align: center\" type=\"number\" name=\"stock\" placeholder=\"Stock\" id=\"stock\"/>");
                    html = html + ("</div>");
                    html = html + ("<div class=\"col-lg-3\">");
                    html = html + ("<select class=\"form-control\" id=\"marca\" name=\"marca\"><%try {
                            String selec = ("SELECT * FROM MARCA");
                            rs = sta.executeQuery(selec);
                            while (rs.next()) {%><option value=\"<%=rs.getString(1)%>\"><%=rs.getString(2)%></option><% }
                                } catch (SQLException e) {
                                    out.println(e);
                                };%></select>");
                    html = html + ("</div>");
                    html = html + ("<div class=\"col-lg-2\">");
                    html = html + ("<button class=\"btn btn-success hidden\" id=\"btn" + i + "\" onclick=\"validar()\"><i class=\"zmdi zmdi-shopping-cart-add\"></i></button>");
                    html = html + ("</div>");
                    html = html + ("<div class=\"col-lg-1\"></div>");
                    html = html + ("</div>");
                    $("#adicionaproductos").append(html);
                }
                ;
            }


            function addprod() {
                var totalproductos = $("#cantprod").val();
                var html = "";
                for (var i = 1; i <= totalproductos; i++) {
                    if ($("#producto" + i).is(':checked')) {
                        var codigoproducto = $("#productosU" + i).val();
                        var dato = $("#dato" + i).val();
                        var marca = $("#marca" + i).val();
                        $("#adicionaproductos").empty();
                        html = html + ("<div class=\"row\">");
                        html = html + ("<div class=\"col-lg-1\"></div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input hidden type=\"text\" value=\"" + codigoproducto + "\" name=\"codigoproducto\" id=\"codigoproducto\" >");
                        html = html + ("<input disabled class=\"form-control\" style=\"text-align: center\" type=\"text\" value=\"" + dato + "\" name=\"producto\" id=\"producto\" />");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<input class=\"form-control\" style=\"text-align: center\" type=\"number\" name=\"stock\" id=\"stock\" required/>");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-3\">");
                        html = html + ("<select class=\"form-control\" id=\"marca\" name=\"marca\"><%try {
                                String selec = ("SELECT * FROM MARCA");
                                rs = sta.executeQuery(selec);
                                while (rs.next()) {%><option value=\"<%=rs.getString(1)%>\"><%=rs.getString(2)%></option><% }
                                    } catch (SQLException e) {
                                        out.println(e);
                                    };%></select>");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg-1\"></div>");
                        html = html + ("</div>");
                        $("#adicionaproductos").append(html);
                    }
                    ;
                }
                ;
            }
            ;

        </script>
    </body>
</html>