<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Ventas</title>
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
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                cnx = DriverManager.getConnection("jdbc:sqlserver://localhost; databaseName=AVANZADO;user=sa; password=12345678;");
                sta = cnx.createStatement();
            } catch (java.lang.ClassNotFoundException e) {
                out.println(e);
            } catch (SQLException e) {
                out.println(e);
            };
            String usuario = (String) request.getSession().getAttribute("sUsuario");
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
        <section class="full-box dashboard-contentPage">
            <nav class="full-box dashboard-Navbar">
                <ul class="full-box list-unstyled text-right">
                    <li class="pull-left">
                        <a href="#!" class="btn-menu-dashboard">
                            <i class="zmdi zmdi-more-vert"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="container-fluid">
                <div class="page-header">
                    <h1 class="text-titles">
                        <i class="zmdi zmdi-shopping-cart-add zmdi-hc-fw"></i> Ventas</h1>
                </div>
                <p class="lead">DESCRIPCION</p>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                            <li class="active">
                                <a href="#new" data-toggle="tab">Nueva</a>
                            </li>
                            <li>
                                <a href="#list" data-toggle="tab">Lista</a>
                            </li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="new">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-md-10 col-md-offset-1">
                                            <form action="">
                                                <table class="table" id="tablaproductos">
                                                    <thead>
                                                        <tr>
                                                            <th>Seleccionar</th>
                                                            <th>Stock</th>
                                                            <th>Producto</th>
                                                            <th>Presentación</th>
                                                            <th>Precio Unitario</th>
                                                            <th>Cantidad</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c1"/>
                                                                <label for="c1"><span></span></label>
                                                            </td>
                                                            <td>23</td>
                                                            <td>Aceite Primor</td>
                                                            <td>Botella 1lt.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 450" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c2"/>
                                                                <label for="c2"><span></span></label>
                                                            </td>
                                                            <td>14</td>
                                                            <td>Atun en trozos la florida</td>
                                                            <td>Lata</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 3.00" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c3"/>
                                                                <label for="c3"><span></span></label>
                                                            </td>
                                                            <td>149</td>
                                                            <td>Arroz Paisana</td>
                                                            <td>Bolsa 5kg.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 10.00" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c4"/>
                                                                <label for="c4"><span></span></label>
                                                            </td>
                                                            <td>22</td>
                                                            <td>Azucar de Caña</td>
                                                            <td>Bolsa 3kg.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 7.50" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c5"/>
                                                                <label for="c5"><span></span></label>
                                                            </td>
                                                            <td>00</td>
                                                            <td>Gaseosa Inca Kola</td>
                                                            <td>Botella 3lt.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 9.50" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c6"/>
                                                                <label for="c6"><span></span></label>
                                                            </td>
                                                            <td>23</td>
                                                            <td>Aceite Primor</td>
                                                            <td>Botella 1lt.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 450" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c7"/>
                                                                <label for="c7"><span></span></label>
                                                            </td>
                                                            <td>14</td>
                                                            <td>Atun en trozos la florida</td>
                                                            <td>Lata</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 3.00" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c8"/>
                                                                <label for="c8"><span></span></label>
                                                            </td>
                                                            <td>149</td>
                                                            <td>Arroz Paisana</td>
                                                            <td>Bolsa 5kg.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 10.00" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c9"/>
                                                                <label for="c9"><span></span></label>
                                                            </td>
                                                            <td>22</td>
                                                            <td>Azucar de Caña</td>
                                                            <td>Bolsa 3kg.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 7.50" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c10"/>
                                                                <label for="c10"><span></span></label>
                                                            </td>
                                                            <td>00</td>
                                                            <td>Gaseosa Inca Kola</td>
                                                            <td>Botella 3lt.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 9.50" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="checkbox" id="c11"/>
                                                                <label for="c11"><span></span></label>
                                                            </td>
                                                            <td>23</td>
                                                            <td>Aceite Primor</td>
                                                            <td>Botella 1lt.</td>
                                                            <td>
                                                                <input disabled style="color:black; background-color: white; border-width:0" value="S/ 450" />
                                                            </td>
                                                            <td>
                                                                <input type="number" style="border-width:0" value="" />
                                                            </td>
                                                        </tr>													
                                                    </tbody>
                                                </table>
                                                <p class="text-center">
                                                    <button href="#!" class="btn btn-info btn-raised btn-sm">
                                                        <i class="zmdi zmdi-floppy"></i> Guardar</button>
                                                </p>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="list">
                                <div class="table-responsive">
                                    <table class="table table-hover text-center" id="listaproductos">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Stock</th>
                                                <th>Producto</th>
                                                <th>Presentación</th>
                                                <th>Precio Unitario</th>
                                                <th>Cantidad</th>
                                                <th>Editar</th>
                                                <th>Eliminar</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>Carlos Alfaro</td>
                                                <td>$40</td>
                                                <td>$40</td>
                                                <td>$0</td>
                                                <td>01/01/2017</td>
                                                <td>
                                                    <a href="#!" class="btn btn-success btn-raised btn-xs">
                                                        <i class="zmdi zmdi-refresh"></i>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a href="#!" class="btn btn-danger btn-raised btn-xs">
                                                        <i class="zmdi zmdi-delete"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>2</td>
                                                <td>Claudia Rodriguez</td>
                                                <td>$40</td>
                                                <td>$40</td>
                                                <td>$0</td>
                                                <td>01/01/2017</td>
                                                <td>
                                                    <a href="#!" class="btn btn-success btn-raised btn-xs">
                                                        <i class="zmdi zmdi-refresh"></i>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a href="#!" class="btn btn-danger btn-raised btn-xs">
                                                        <i class="zmdi zmdi-delete"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Alicia Melendez</td>
                                                <td>$40</td>
                                                <td>$40</td>
                                                <td>$0</td>
                                                <td>01/01/2017</td>
                                                <td>
                                                    <a href="#!" class="btn btn-success btn-raised btn-xs">
                                                        <i class="zmdi zmdi-refresh"></i>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a href="#!" class="btn btn-danger btn-raised btn-xs">
                                                        <i class="zmdi zmdi-delete"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>1</td>
                                                <td>Sarai Mercado</td>
                                                <td>$40</td>
                                                <td>$40</td>
                                                <td>$0</td>
                                                <td>01/01/2017</td>
                                                <td>
                                                    <a href="#!" class="btn btn-success btn-raised btn-xs">
                                                        <i class="zmdi zmdi-refresh"></i>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a href="#!" class="btn btn-danger btn-raised btn-xs">
                                                        <i class="zmdi zmdi-delete"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
                    };
                }
                window.frmProveedor.submit();
            };


            $(document).ready(function () {
                $('#tablaproductos').DataTable();
                $('#listaproductos').DataTable();
            });

            $.material.init();
        </script>
    </body>

</html>