<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Usuarios | Administradores</title>
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
                        <button hidden value="<%=usercodigo%>" id="coduser"></button>
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
                String sql = "SELECT MAX(COD_TRABAJADOR) FROM TRABAJADORES";
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
                    <h1 class="text-titles"><i class="zmdi zmdi-account zmdi-hc-fw"></i> Usuarios <small>Administradores</small></h1>
                </div>
                <p class="lead">Estimado Usuario, en esta sección se realizan las consultas de los usuarios <strong>Administradores </strong> actualmente registrados en el sistema, con opción de añadir, editar y modificar datos.</p>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                            <%
                                if (carguito.equals(cargo)) {
                            %>
                            <li><a href="#new" data-toggle="tab">Nuevo</a></li>
                                <%
                                    }
                                %>
                            <li><a href="#list" data-toggle="tab">Lista</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <%if (carguito.equals(cargo)) {
                            %>
                            <div class="tab-pane fade active in" id="new">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-md-10 col-md-offset-1">
                                            <form action="Addtrabajador" method="post">
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Nombre</label>
                                                    <input class="form-control" type="text" maxlength="50" name="nombre" id="nombre" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Apellido Paterno</label>
                                                    <input class="form-control" type="text" maxlength="50" name="apepaterno" id="apepaterno" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Apellido Materno</label>
                                                    <input class="form-control" type="text" maxlength="50" name="apematerno" id="apematerno" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Sexo</label>
                                                    <select class="form-control" name="sexo" id="sexo">
                                                        <option value="M">Masculino</option> 
                                                        <option value="F">Femenino</option> 
                                                    </select>
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
                                                    <label class="control-label">Dni</label>
                                                    <input class="form-control" type="text" maxlength="8" name="dni" id="dni" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Email</label>
                                                    <input class="form-control" type="email" maxlength="50" name="email" id="email" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Celular</label>
                                                    <input class="form-control" type="text" maxlength="9" name="celular" id="celular" required>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Cargo</label>
                                                    <select class="form-control" name="cargo" id="cargo">
                                                        <%
                                                            try {
                                                                String selec = ("SELECT * FROM CARGO");
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
                                                <p class="text-center">
                                                    <button type="submit" class="btn btn-info btn-raised btn-sm"><i class="zmdi zmdi-floppy"></i> Guardar</button>
                                                </p>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <%
                                if(carguito.equalsIgnoreCase(cargo)){
                            %>
                            <div class="tab-pane fade" active in id="list">
                                <%}%>
                                <div class="table-responsive">
                                    <table id="admin" class="table table-hover text-center">
                                        <thead>
                                            <tr>                                                
                                                <th class="text-center">Nombres</th>
                                                <th class="text-center">Direccion</th>
                                                <th class="text-center">Distrito</th>
                                                <th class="text-center">DNI</th>
                                                <th class="text-center">E-mail</th>
                                                <th class="text-center">Celular</th> 
                                                <th class="text-center">Cargo</th>
                                                    <%                                                        if (carguito.equals(cargo)) {
                                                    %>
                                                <th class="text-center">Modificar</th>
                                                <th class="text-center">Eliminar</th>
                                                    <%
                                                        }

                                                    %>
                                            </tr>
                                        </thead>
                                        <%                                            try {
                                                String sql = "SELECT T.COD_TRABAJADOR, CONCAT(T.NOMBRES, ' ', T.APE_PATERNO, ' ', T.APE_MATERNO) AS NOMBRES, T.DIRECCION, D.DISTRITO, T.DNI, T.E_MAIL, T.CELULAR, C.DESCRIPCION, T.NOMBRES, T.APE_PATERNO, T.APE_MATERNO, C.COD_CARGO, D.COD_DISTRITO FROM TRABAJADORES T INNER JOIN CARGO C ON C.COD_CARGO = T.COD_CARGO INNER JOIN DISTRITO D ON D.COD_DISTRITO = T.COD_DISTRITO WHERE ESTADO='A'";
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
                                                <%
                                                    if (carguito.equals(cargo)) {
                                                %>
                                                <td><button id="editar<%=rs.getString(1)%>" onclick="pintar('<%= rs.getString(1)%>', '<%= rs.getString(9)%>', '<%= rs.getString(10)%>', '<%= rs.getString(11)%>', '<%= rs.getString(3)%>', '<%= rs.getString(13)%>', '<%= rs.getString(5)%>', '<%= rs.getString(6)%>', '<%= rs.getString(7)%>', '<%= rs.getString(12)%>')" class="btn btn-success btn-raised btn-xs"><i class="zmdi zmdi-refresh"></i></button></td>
                                                <td><a onclick="elimina('<%=rs.getString(1)%>')" class="btn btn-danger btn-raised btn-xs"><i class="zmdi zmdi-delete"></i></a></td>
                                                        <%
                                                            }

                                                        %>
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
            <form action="EditTrabajador" method="Post">
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Nombre</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="nombreeditar" name="nombreeditar" required>                       
                    </div>
                </div>
                <input hidden id="codigoeditar" name="codigoeditar"/>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Apellido Paterno</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="paternoeditar"  name="paternoeditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Apellido Materno</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="maternoeditar"  name="maternoeditar" required>
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
                    <label class="col-form-control col-sm-4">DNI</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="dnieditar" name="dnieditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">E-mail</label>
                    <div class="col-sm-8">
                        <input type="email" class="form-control" id="emaileditar" name="emaileditar" required>                       
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Celular</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="celulareditar" name="celulareditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Cargo</label>
                    <div class="col-sm-8">
                        <select class="form-control" name="cargoeditar" id="cargoeditar">
                            <%
                                try {
                                    String selec = ("SELECT COD_CARGO, DESCRIPCION FROM CARGO");
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
                    }
                    ;
                }
                window.frmProveedor.submit();
            }
            ;


            function elimina(codigo) {
                var cod = $("#coduser").val();
                if (codigo !== cod) {
                    swal({
                        title: 'Eliminar trabajador?',
                        text: "Está seguro que desea dar de baja el trabajador actual",
                        type: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#03A9F4',
                        cancelButtonColor: '#F44336',
                        confirmButtonText: 'Si, Eliminar',
                        cancelButtonText: 'No, Cancelar!'
                    }).then(function () {
                        window.location.href = "DeleteTrabajador?cod=" + codigo + "";
                    });
                } else {
                    swal({
                        title: 'Eliminar trabajador?',
                        text: "No puedes eliminar tu propio usuario",
                        type: 'error',
                        confirmButtonColor: '#03A9F4',
                        confirmButtonText: 'Aceptar'
                    });
                }
            }
            ;



            $(document).ready(function () {
                $('#admin').DataTable();
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
                            title: "Editar Trabajador",
                            resizable: false,
                            height: "auto",
                            width: 491,
                            modal: true
                        });
                    });
                }
                ;
            });


            $("#btnCerrar").click(function () {
                $("#modalEditar").dialog('close');
            });



            function pintar(codigo, nombres, paterno, materno, direccion, distrito, dni, mail, celular, cargo) {
                var _codigo = codigo;
                var _nombres = nombres;
                var _paterno = paterno;
                var _materno = materno;
                var _direccion = direccion;
                var _distrito = distrito;
                var _dni = dni;
                var _mail = mail;
                var _celular = celular;
                var _cargo = cargo;
                $("#codigoeditar").val(_codigo);
                $("#nombreeditar").val(_nombres);
                $("#paternoeditar").val(_paterno);
                $("#maternoeditar").val(_materno);
                $("#direccioneditar").val(_direccion);
                $("#distritoeditar").val(_distrito);
                $("#dnieditar").val(_dni);
                $("#emaileditar").val(_mail);
                $("#celulareditar").val(_celular);
                $("#cargoeditar").val(_cargo);
            }
            ;
        </script>

        <script>
            $.material.init();
        </script>
    </body>
</html>