<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Proveedores</title>
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
                    <h1 class="text-titles"><i class="zmdi zmdi-account zmdi-hc-fw"></i> Proveedores</h1>
                </div>
                <p class="lead">Estimado Usuario, en esta sección se realizan las consultas de los <strong>Proveedores</strong> actualmente registrados en el sistema, con opción de añadir, editar y modificar datos.</p>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                            <li><a href="#new" data-toggle="tab">Nuevo</a></li>
                            <li><a href="#list" data-toggle="tab">Lista</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="new">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-md-10 col-md-offset-1">
                                            <form action="AddProveedor" method="post">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Compañia</label>
                                                    <select class="form-control" name="compania" id="compania">
                                                        <%
                                                            try {
                                                                String selec = ("SELECT * FROM MARCA");
                                                                rs = sta.executeQuery(selec);
                                                                while (rs.next()) {
                                                        %>
                                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
                                                        <% }
                                                            } catch (SQLException e) {
                                                                out.println(e);
                                                            };
                                                        %>
                                                    </select>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Contacto</label>
                                                    <input class="form-control" type="text" maxlength="50" name="contacto" id="contacto" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Cargo</label>
                                                    <input class="form-control" type="text" maxlength="50" name="cargo" id="cargo"/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Direccion</label>
                                                    <input class="form-control" type="text" maxlength="50" name="direccion" id="direccion" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Distrito</label>
                                                    <select class="form-control" name="distrito" id="distrito">
                                                        <%
                                                            try {
                                                                String selec = ("SELECT * FROM DISTRITO WHERE COD_PROVINCIA='140100' ORDER BY DISTRITO");
                                                                rs = sta.executeQuery(selec);
                                                                while (rs.next()) {
                                                        %>
                                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
                                                        <% }
                                                            } catch (SQLException e) {
                                                                out.println(e);
                                                            };
                                                        %>
                                                    </select>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Telefono</label>
                                                    <input class="form-control" type="phone" maxlength="9" name="telefono" id="telefono" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Web</label>
                                                    <input class="form-control" type="text" maxlength="50" name="web" id="web" required/>
                                                </div>
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
                                    <table id="proveedores" class="table table-hover text-center">
                                        <thead>
                                            <tr>                                                
                                                <th class="text-center">Compañía</th>
                                                <th class="text-center">Contacto</th>
                                                <th class="text-center">Cargo</th>
                                                <th class="text-center">Direccion</th>
                                                <th class="text-center">Distrito</th>
                                                <th class="text-center">Telefono</th> 
                                                <th class="text-center">Web</th>
                                                <th class="text-center">Modificar</th>
                                                <th class="text-center">Eliminar</th>
                                            </tr>
                                        </thead>
                                        <%
                                            try {
                                                String sql = "SELECT P.COD_PROVEEDOR, M.NOMBRE, P.NOMBRE_CONTACTO, P.CARGO_CONTACTO, P.DIRECCION, D.DISTRITO, P.TELEFONO, P.WEB, D.COD_DISTRITO FROM PROVEEDOR P INNER JOIN DISTRITO D ON D.COD_DISTRITO = P.COD_DISTRITO INNER JOIN MARCA M ON M.COD_MARCA = P.NOMBRE_COMPANIA WHERE P.ESTADO='A'";
                                                rs = sta.executeQuery(sql);
                                        %>
                                        <tbody>
                                            <%
                                                while (rs.next()) {
                                            %> 
                                            <tr>                                                
                                                <td><%= rs.getString(2)%></td>
                                                <td><%= rs.getString(3)%></td>
                                                <td><%= rs.getString(4)%></td>
                                                <td><%= rs.getString(5)%></td>
                                                <td><%= rs.getString(6)%></td>
                                                <td><%= rs.getString(7)%></td>
                                                <td><%= rs.getString(8)%></td> 
                                                <td><button id="editar<%=rs.getString(1)%>" onclick="pintar('<%= rs.getString(1)%>', '<%= rs.getString(2)%>', '<%= rs.getString(3)%>', '<%= rs.getString(4)%>', '<%= rs.getString(5)%>', '<%= rs.getString(9)%>', '<%= rs.getString(7)%>', '<%= rs.getString(8)%>')" class="btn btn-success btn-raised btn-xs"><i class="zmdi zmdi-refresh"></i></button></td>
                                                <td><a onclick="elimina('<%=rs.getString(1)%>')" class="btn btn-danger btn-raised btn-xs"><i class="zmdi zmdi-delete"></i></a></td>
                                            </tr>
                                            <% }
                                                } catch (SQLException e) {
                                                    out.println(e);
                                                };
                                            %>
                                        </tbody>
                                    </table>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div id="modalEditar" style="display:none">
            <form action="EditProveedor" method="post">
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Compañia</label>
                    <div class="col-sm-8">
                     <select class="form-control" name="companiaeditar" id="companiaeditar">
                            <%
                                try {
                                    String selec = ("SELECT * FROM MARCA");
                                    rs = sta.executeQuery(selec);
                                    while (rs.next()) {
                            %>
                            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
                            <% }
                                } catch (SQLException e) {
                                    out.println(e);
                                };
                            %>
                        </select>                   
                </div>
                         </div>
                <input hidden id="codigoeditar" name="codigoeditar"/>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Contacto</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="contactoeditar"  name="contactoeditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Cargo</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cargoeditar"  name="cargoeditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Dirección</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="direccioneditar" name="direccioneditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Distrito</label>
                    <div class="col-sm-8">
                        <select class="form-control" name="distritoeditar" id="distritoeditar">
                            <%
                                try {
                                    String selec = ("SELECT * FROM DISTRITO WHERE COD_PROVINCIA='140100' ORDER BY DISTRITO");
                                    rs = sta.executeQuery(selec);
                                    while (rs.next()) {
                            %>
                            <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
                            <% }
                                } catch (SQLException e) {
                                    out.println(e);
                                };
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Telefono</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="telefonoeditar" name="telefonoeditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Web</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="webeditar" name="webeditar" required>                       
                    </div>
                </div>
                <div class="form-inline">
                    <center>
                        <button type="submit" class="btn btn-default" style="background: #4caf50; border-radius: 4px" id="btnRegistrar">Editar</button>
                        <button type="button" class="btn btn-default" style="background: #f44336; border-radius: 4px" id="btnCerrar">Cerrar</button>
                    </center>
                </div>
            </form>
        </div>

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

            $.material.init();


            function elimina(codigo) {
                swal({
                    title: 'Eliminar proveedor?',
                    text: "Está seguro que desea dar de baja el proveedor actual",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#03A9F4',
                    cancelButtonColor: '#F44336',
                    confirmButtonText: 'Si, Eliminar',
                    cancelButtonText: 'No, Cancelar!'
                }).then(function () {
                    window.location.href = "DeleteProveedor?cod=" + codigo + "";
                });
            }
            ;



            $(document).ready(function () {
                $('#proveedores').DataTable();
            });

            $(function () {
                $("#modalEditar").dialog({
                    autoOpen: false
                });
                var cantidad = $("#total").val();
                for (var i = 1; i <= cantidad; i++) {
                    $("#editar" + i).click(function () {
                        $("#modalEditar").dialog('open');
                        $("#modalEditar").dialog({
                            dialogClass: "no-close",
                            title: "Editar Proveedor",
                            resizable: false,
                            height: "auto",
                            width: 491,
                            modal: true
                        });
                    });
                }
                ;


                $("#btnCerrar").click(function () {
                    $("#modalEditar").dialog('close');
                });
            });


            function pintar(codigo, compania, contacto, cargo, direccion, distrito, telefono, web) {
                var _codigo = codigo;
                var _compañia = compania;
                var _contacto = contacto;
                var _cargo = cargo;
                var _direccion = direccion;
                var _distrito = distrito;
                var _telefono = telefono;
                var _web = web;
                $("#codigoeditar").val(_codigo);
                $("#compañiaeditar").val(_compañia);
                $("#contactoeditar").val(_contacto);
                $("#cargoeditar").val(_cargo);
                $("#direccioneditar").val(_direccion);
                $("#distritoeditar").val(_distrito);
                $("#telefonoeditar").val(_telefono);
                $("#webeditar").val(_web);
            }
            ;
        </script>

    </body>
</html>