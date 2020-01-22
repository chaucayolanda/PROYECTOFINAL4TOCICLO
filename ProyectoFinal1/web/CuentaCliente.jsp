<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Clientes</title>
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
            String usuario = (String) request.getSession().getAttribute("sCliente");
            String usercodigo = (String) request.getSession().getAttribute("sCodigoCliente");
            if (usuario == null) {
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
                </ul>
            </nav>
            <div class="container-fluid">
                <div class="page-header">
                    <h1 class="text-titles"><i class="zmdi zmdi-account zmdi-hc-fw"></i> Clientes</h1>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                            <li><a href="#list" data-toggle="tab">&nbsp;</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="list">
                                <div class="table-responsive">
                                    <table id="admin" class="table table-hover text-center">
                                        <thead>
                                            <tr>                                                
                                                <th class="text-center">Nombres</th>
                                                <th class="text-center">Direccion</th>
                                                <th class="text-center">Distrito</th>
                                                <th class="text-center">E-mail</th>
                                                <th class="text-center">Celular</th> 
                                                <th class="text-center">DNI</th>
                                                <th class="text-center">Modificar</th>
                                                <th class="text-center">Eliminar</th>
                                            </tr>
                                        </thead>
                                        <%
                                            try {
                                                String sql = "SELECT COD_CLIENTE, CONCAT(NOMBRES, ' ', APE_PATERNO, ' ', APE_MATERNO), DIRECCION, CLIENTES.COD_DISTRITO, DISTRITO, E_MAIL, CELULAR, DNI, CLAVE, NOMBRES, APE_PATERNO, APE_MATERNO FROM CLIENTES INNER JOIN DISTRITO ON CLIENTES.COD_DISTRITO = DISTRITO.COD_DISTRITO WHERE COD_CLIENTE = " + usercodigo;
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
                                                <td><button id="editar" onclick="pintar('<%=rs.getString(1)%>', '<%=rs.getString(10)%>', '<%=rs.getString(11)%>', '<%=rs.getString(12)%>', '<%=rs.getString(3)%>', '<%=rs.getString(4)%>', '<%=rs.getString(6)%>', '<%=rs.getString(7)%>', '<%=rs.getString(8)%>', '<%=rs.getString(9)%>')" class="btn btn-success btn-raised btn-xs"><i class="zmdi zmdi-refresh"></i></button></td>
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
        <%
            try {
                String sql = "SELECT COUNT(COD_VENTA) FROM VENTA WHERE ESTADO = 'A' AND COD_CLIENTE = " + usercodigo;
                rs = sta.executeQuery(sql);
                while (rs.next()) {
        %> 
        <input id="countVentas" value="<%= rs.getString(1)%>">
        <% }
            } catch (SQLException e) {
                out.println(e);
            };
        %>

        <div id="modalEditar" style="display:none">
            <form action="EditCliente" id="EditCliente" name="EditCliente" method="post">
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
                        <input style="display: none"  maxlength="15" class="form-control" id="antigua" required>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Clave Anterior</label>
                    <div class="col-sm-8">
                        <input type="password"  maxlength="15" class="form-control" id="claveeditara" required>
                    </div>
                </div>
                 <div id="mensajeNuevaClave" style="text-align:center; display: none; margin-top: 5px; margin-bottom: -14px; color: #d4393d"></div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Nueva Clave</label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="15" class="form-control" id="claveeditar" name="claveeditar" required>
                    </div>
                </div>
                <div class="form-group label-floating">
                    <label class="col-form-control col-sm-4">Repetir Clave</label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="15" class="form-control" id="rclave" required>
                    </div>
                </div>
                 <div id="mensajeConfirmaNuevaClave" style="text-align:center; display: none; margin-top: 5px; margin-bottom: -14px; color: #d4393d"></div>
                <div class="form-inline">
                    <center>
                        <button type="button" class="btn btn-default" style="background: #4caf50; border-radius: 4px" id="btnRegistrar">Editar</button>
                        <button type="button" class="btn btn-default" style="background: #f44336; border-radius: 4px" id="btnCerrar">Cerrar</button>
                    </center>
                </div>
            </form>
        </div>


<script type="text/javascript">
        $("#btnRegistrar").click(function () {
            var valorClaveAnterior = document.getElementById("antigua").value;
            var valorClaveActual = document.getElementById("claveeditara").value;
            var valorNuevaClave = document.getElementById("claveeditar").value;
            var valorConfirmaNuevaClave = document.getElementById("rclave").value;
            var letrasMayusculas = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
            var cantNumeros = 0;
            var cantLetras = 0;
            var cantLetrasMayus = 0;
            
            if(valorClaveAnterior != valorClaveActual){
                $("p").remove();
                $("#mensajeNuevaClave").append("<p><strong>Aviso!</strong> Clave anterior incorrecta.</p>");
                $("#mensajeNuevaClave").show();
                return false;
            }
            for (var i = 0; i < valorNuevaClave.length; i++) {
                if (!isNaN(valorNuevaClave.charAt(i))) {
                    cantNumeros++;
                }

                if (isNaN(valorNuevaClave.charAt(i))) {
                    cantLetras++;
                }

                if (letrasMayusculas.indexOf(valorNuevaClave.charAt(i), 0) != -1) {
                    cantLetrasMayus++;
                }
            }

            if (valorClaveActual == null || valorClaveActual.length == 0 || /^\s+$/.test(valorClaveActual)) {
                $("p").remove();
                $("#mensajeClaveActual").append("<p><strong>Aviso!</strong> Ingrese su clave actual.</p>");
                $("#mensajeClaveActual").show();
                return false;
            }
            else if (valorNuevaClave == null || valorNuevaClave.length == 0 || /^\s+$/.test(valorNuevaClave)) {
                $("p").remove();
                $("#mensajeNuevaClave").append("<p><strong>Aviso!</strong> Ingrese su nueva clave.</p>");
                $("#mensajeNuevaClave").show();
                return false;
            }
            else if (valorConfirmaNuevaClave == null || valorConfirmaNuevaClave.length == 0 || /^\s+$/.test(valorConfirmaNuevaClave)) {
                $("p").remove();
                $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Ingrese la confirmación de la nueva clave.</p>");
                $("#mensajeConfirmaNuevaClave").show();
                return false;
            }
            else if (valorNuevaClave == valorConfirmaNuevaClave) {
                if (cantNumeros < 1) {
                    $("p").remove();
                    $("#mensajeNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo un número</p>");
                    $("#mensajeNuevaClave").show();
                }
                else if (cantLetras < 1) {
                    $("p").remove();
                    $("#mensajeNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo una letra minúscula o signo o símbolo</p>");
                    $("#mensajeNuevaClave").show();
                }
                else if (cantLetrasMayus < 1) {
                    $("p").remove();
                    $("#mensajeNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo una letra mayúscula</p>");
                    $("#mensajeNuevaClave").show();
                }
                else if (valorNuevaClave.length < 8) {
                    $("p").remove();
                    $("#mensajeNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo 8 caracteres</p>");
                    $("#mensajeNuevaClave").show();
                }
                else {
                    swal({
		  	title: 'Cambiar Contraseña?',
		  	text: "Está seguro que desea cambiar su contraseña",
		  	type: 'warning',
		  	showCancelButton: true,
		  	confirmButtonColor: '#03A9F4',
		  	cancelButtonColor: '#F44336',
		  	confirmButtonText: '<i class="zmdi zmdi-run"></i> Si, Cambiar!',
		  	cancelButtonText: '<i class="zmdi zmdi-close-circle"></i> No, Cancelar!'
		}).then(function () {
                    window.EditCliente.submit();
		}); 
                }
            }
            else {
                $("p").remove();
                $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Clave nueva no coincide con la confirmación.</p>");
                $("#mensajeConfirmaNuevaClave").show();
                return false;
            }
        });
    </script>
    
        <script>

            function elimina(codigo) {
                var ventas = $("#countVentas").val();
                if (ventas < 1) {
                    swal({
                        title: 'Eliminar Cuenta?',
                        text: "Está seguro que desea darse de baja,",
                        type: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#03A9F4',
                        cancelButtonColor: '#F44336',
                        confirmButtonText: 'Si, Eliminar',
                        cancelButtonText: 'No, Cancelar!'
                    }).then(function () {
                        window.location.href = "DeleteCliente?cod=" + codigo + "";
                    });
                } else {
                    swal({
                        title: 'Eliminar Cuenta?',
                        text: "Actualmente tiene un pedido en camino, cancelelo antes de eliminar su cuenta",
                        type: 'error',
                        confirmButtonColor: '#03A9F4',
                        confirmButtonText: 'Aceptar'
                    });
                }
            }
            ;



            $(function () {
                $("#modalEditar").dialog({
                    autoOpen: false
                });
                $("#editar").click(function () {

                    $("#modalEditar").dialog('open');
                    $("#modalEditar").dialog({
                        dialogClass: "no-close",
                        title: "Editar Datos",
                        resizable: false,
                        height: "auto",
                        width: 491,
                        modal: true
                    });
                });

                ;
            });


            $("#btnCerrar").click(function () {
                $("#modalEditar").dialog('close');
            });


            function pintar(codigo, nombres, paterno, materno, direccion, distrito, mail, celular, dni, clave) {
                var _codigo = codigo;
                var _nombres = nombres;
                var _paterno = paterno;
                var _materno = materno;
                var _direccion = direccion;
                var _distrito = distrito;
                var _mail = mail;
                var _celular = celular;
                var _clave = clave;
                var _dni = dni;
                $("#codigoeditar").val(_codigo);
                $("#nombreeditar").val(_nombres);
                $("#paternoeditar").val(_paterno);
                $("#maternoeditar").val(_materno);
                $("#direccioneditar").val(_direccion);
                $("#distritoeditar").val(_distrito);
                $("#dnieditar").val(_dni);
                $("#emaileditar").val(_mail);
                $("#celulareditar").val(_celular);
                $("#antigua").val(_clave);
            }
            ;
        </script>

        <script>
            $.material.init();
        </script>
    </body>
</html>