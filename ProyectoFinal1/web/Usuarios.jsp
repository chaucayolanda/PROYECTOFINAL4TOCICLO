<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Cuentas de Usuario</title>
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
            String cargo = (String) request.getSession().getAttribute("sCargo");
            String carguito = "Administrador";
            String usercodigo = (String) request.getSession().getAttribute("sCodigo");
            if (usuario == null) {
                response.sendRedirect("Login.jsp");
            }
            if (cargo.equalsIgnoreCase(carguito)) {
            } else {
        %>
        <script>

            swal({
                title: 'SOLO USUARIOS ADMINISTRADORES',
                text: "Lo sentimos, no tienes los permisos suficientes para visualizar esta página",
                type: 'error',
                confirmButtonColor: '#03A9F4',
                confirmButtonText: 'Aceptar',
            }).then(function () {
                window.location.href = "Home.jsp";
            });


        </script>
        <%
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
            if (carguito.equals(cargo)) {
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
                    <h1 class="text-titles"><i class="zmdi zmdi-assignment-account zmdi-hc-fw"></i>Cuentas de Usuario</h1>
                </div>
                <p class="lead">Estimado Usuario, en esta sección se realizan las consultas de las <strong>Cuentas de Usuario</strong> actualmente registrados en el sistema, con opción de añadir, editar y modificar datos.</p>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                            <li><a href="#new" data-toggle="tab">&nbsp; </a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="new">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-md-10 col-md-offset-1">
                                            <form name="agregarcuenta" action="AddUsuario" method="post">
                                                <div class="form-group label-floating">
                                                    <label class="control-label" style="font-size: 16px;">Trabajador</label>
                                                    <button type="button" class="btn btn-success btn-xs" id="usuario"><strong> . . .</strong></button>
                                                </div>
                                                <div id="divusuario"></div>
                                                <input hidden id="codigou" name="codigou" value="">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Usuario</label>
                                                    <input class="form-control" type="text" maxlength="15" name="user" id="user" required>
                                                </div>
                                                <%
                                                    try {
                                                        String sql = "SELECT MAX(T.COD_TRABAJADOR) FROM TRABAJADORES T INNER JOIN USUARIOS U ON T.COD_TRABAJADOR != U.COD_TRABAJADOR WHERE T.ESTADO = 'A'";
                                                        rs = sta.executeQuery(sql);
                                                        while (rs.next()) {
                                                %> 
                                                <input hidden id="cantuser" value="<%= rs.getString(1)%>"/>
                                                <% }
                                                    } catch (SQLException e) {
                                                        out.println(e);
                                                    };
                                                %>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Clave</label>
                                                    <input class="form-control" type="password" maxlength="15" name="password" id="password" required>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Repetir Clave</label>
                                                    <input class="form-control" type="password" maxlength="15" name="repetpassword" id="repetpassword" required>
                                                </div>
                                                <p class="text-center">
                                                    <button type="button" onclick="pwd()" class="btn btn-info btn-raised btn-sm"><i class="zmdi zmdi-floppy"></i> Guardar</button>
                                                </p>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!--lista de usuarios-->
                                <div class="table-responsive">
                                    <table id="clientes" class="table table-hover text-center">
                                        <thead>
                                            <tr>                                                
                                                <th class="text-center">Trabajador</th>
                                                <th class="text-center">Modificar</th>
                                            </tr>
                                        </thead>
                                        <%
                                            try {
                                                String sql = "SELECT T.COD_TRABAJADOR, CONCAT(T.NOMBRES, ' ', T.APE_PATERNO, ' ', T.APE_MATERNO), USUARIO FROM TRABAJADORES T INNER JOIN USUARIOS U ON T.COD_TRABAJADOR = U.COD_TRABAJADOR WHERE T.ESTADO = 'A'";
                                                rs = sta.executeQuery(sql);
                                        %>
                                        <tbody>
                                            <%
                                                while (rs.next()) {
                                            %> 
                                            <tr>                                                
                                                <td><%= rs.getString(2)%></td>
                                                <td><button id="editar<%=rs.getString(1)%>" onclick="pintar('<%=rs.getString(1)%>', '<%=rs.getString(2)%>', '<%=rs.getString(3)%>')" class="btn btn-success btn-raised btn-xs"><i class="zmdi zmdi-refresh"></i></button></td>
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
                            <div id="modalUsuarios" style="display:none">
                                <form id="frmUsuario" action="#" style="margin-top:10px; margin-bottom:10px">
                                    <div class="table-responsive">
                                        <table id="productos" class="table text-center">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Seleccionar</th>
                                                    <th class="text-center">Trabajador</th>
                                                </tr>
                                            </thead>
                                            <%
                                                try {
                                                    String sql = "SELECT COD_TRABAJADOR, CONCAT(NOMBRES, ' ', APE_PATERNO, ' ', APE_MATERNO) FROM TRABAJADORES WHERE ESTADO = 'A' AND NOT COD_TRABAJADOR IN (SELECT COD_TRABAJADOR FROM USUARIOS)";
                                                    rs = sta.executeQuery(sql);
                                            %>
                                            <tbody>
                                                <%
                                                    while (rs.next()) {
                                                %> 
                                                <tr>
                                                    <td>
                                                        <input name="radiecitotrabajador" type="radio" id="usert<%= rs.getString(1)%>"/>
                                                        <label for="usert<%= rs.getString(1)%>"><span></span></label>
                                                    </td>
                                                    <td>
                                                        <input disabled style="border-width:0; background-color:white; color:black; width: 100%; text-align: center;" name="usuariot<%= rs.getString(1)%>" id="usuariot<%= rs.getString(1)%>" value="<%= rs.getString(2)%>"/>
                                                        <input hidden type="text" id="userct<%= rs.getString(1)%>" value="<%= rs.getString(1)%>"/></td>
                                                </tr>
                                                <% }
                                                    } catch (SQLException e) {
                                                        out.println(e);
                                                    };
                                                %>
                                            </tbody>
                                        </table>
                                        <center><button type="button" onclick="addusr()" class="btn btn-success btn-raised btn-xs"> Añadir </button></center>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%}%>
        <div id="modalEditar" style="display:none">
            <form action="EditUsuario" name="frmmodalEditar" method="post">
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Nombre</label>
                    <div class="col-sm-8">
                        <input type="text" disabled class="form-control" id="nombreeditar" name="nombreeditar" required>                       
                    </div>
                </div>
                <input hidden id="codigoeditar" name="codigoeditar"/>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Usuario</label>
                    <div class="col-sm-8">
                        <input type="text" disabled class="form-control" id="usuarioeditar"  name="usuarioeditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Clave</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="claveeditar"  name="claveeditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Repetir</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" id="repetclaveeditar"  name="repetclaveeditar" required>
                    </div>
                </div>
                <div class="form-inline">
                    <center>
                        <button type="button" class="btn" style="background: #4caf50; border-radius: 4px" id="btnRegistrar">Editar</button>
                        <button type="button" class="btn" style="background: #f44336; border-radius: 4px" id="btnCerrar">Cerrar</button>
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
                    }
                    ;
                }
                window.frmProveedor.submit();
            }
            ;

            $(function () {
                $("#modalEditar").dialog({
                    autoOpen: false
                });
                var cantidad = $("#cantuser").val();
                for (var i = 1; i <= cantidad; i++) {
                    $("#editar" + i).click(function () {
                        $("#modalEditar").dialog('open');
                        $("#claveeditar").val("");
                        $("#repetclaveeditar").val("");
                        $("#modalEditar").dialog({
                            dialogClass: "no-close",
                            title: "Editar Usario",
                            resizable: false,
                            height: "auto",
                            width: 400,
                            modal: true
                        });
                    });
                }
                ;


                $("#btnCerrar").click(function () {
                    $("#modalEditar").dialog('close');
                });
            });



            $("#btnRegistrar").click(function () {
                var clave = $("#claveeditar").val();
                var repet = $("#repetclaveeditar").val();
                if (clave !== "" && repet !== "") {
                    if (clave === repet) {
                        document.frmmodalEditar.submit();
                    } else {
                        swal({
                            title: "ERROR!",
                            text: "Las claves ingresadas no coinciden!"
                        });
                    }
                } else {
                    swal({
                        title: "ERROR!",
                        text: "Faltan datos"
                    });
                }
            });

            function pintar(codigo, nombres, usuario) {
                var _codigo = codigo;
                var _nombres = nombres;
                var _usuario = usuario;
                $("#codigoeditar").val(_codigo);
                $("#nombreeditar").val(_nombres);
                $("#usuarioeditar").val(_usuario);
            }

            function pwd() {
                var codigo = $("#codigou").val();
                var usuario = $("#user").val();
                var clave = $("#password").val();
                var repet = $("#repetpassword").val();
                if (codigo !== "" && usuario !== "" && clave !== "" && repet !== "") {
                    if (clave === repet) {
                        document.agregarcuenta.submit();
                    } else {
                        swal({
                            title: "ERROR!",
                            text: "Las claves ingresadas no coinciden!"
                        });
                    }
                } else {
                    swal({
                        title: "ERROR!",
                        text: "Faltan datos"
                    });
                }
            }
            ;

            $(function () {
                $("#modalUsuarios").dialog({
                    autoOpen: false
                });
                $("#usuario").click(function () {
                    $("#modalUsuarios").dialog('open');
                    $("#modalUsuarios").dialog({
                        title: "Proveedores",
                        resizable: false,
                        height: 450,
                        width: 600,
                        modal: true
                    });
                });
            });
            function addusr() {
                var totalusuarios = $("#cantuser").val();
                var html = "";
                for (var i = 1; i <= totalusuarios; i++) {
                    if ($("#usert" + i).is(':checked')) {
                        $("#codigou").val($("#userct" + i).val());
                        var usuario = $("#usuariot" + i).val();
                        $("#divusuario").empty();
                        html = html + ("<div class=\"row\">");
                        html = html + ("<div class=\"col-lg\"></div>");
                        html = html + ("<div class=\"col-lg\">");
                        html = html + ("<input disabled class=\"form-control\" style=\"text-align: center\" type=\"text\" value=\"" + usuario + "\" name=\"usuario" + i + "\" id=\"usuario" + i + "\" />");
                        html = html + ("</div>");
                        html = html + ("<div class=\"col-lg\"></div>");
                        html = html + ("</div>");
                        $("#divusuario").append(html);
                    }
                    ;
                }
                ;
            }
            ;

            $.material.init();
        </script>
    </body>
</html>