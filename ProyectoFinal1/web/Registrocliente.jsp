<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Registro | Clientes</title>
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
        %>

        <%
            try {
                String sql = "SELECT MAX(COD_CLIENTE) FROM CLIENTES";
                rs = sta.executeQuery(sql);
                while (rs.next()) {
        %> 
        <input hidden id="total" value="<%= rs.getString(1)%>"/>
        <% }
            } catch (SQLException e) {
                out.println(e);
            };
        %>

        <section class="full-box dashboard-contentPage mCustomScrollbar _mCS_1 mCS-autoHide no-paddin-left">
            <nav class="full-box dashboard-Navbar">
                <ul class="full-box list-unstyled text-right">
                    <center>
                        <li>
                            <a style="color:aqua" href="LoginClientes.jsp">Cancelar</a>
                        </li>
                    </center>
                </ul>
            </nav>
            <div class="container-fluid">
                <div class="page-header">
                    <h1 class="text-titles"><i class="zmdi zmdi-male-female zmdi-hc-fw"></i> Registro Clientes</h1>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12">
                        <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                            <li><a href="#new" data-toggle="tab">&nbsp;</a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="new">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-md-10 col-md-offset-1">
                                            <form action="AddCliente" name="formcliente" id="formcliente" method="post">
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
                                                    <label class="control-label">Email</label>
                                                    <input class="form-control" type="email" maxlength="50" name="email" id="email" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Celular</label>
                                                    <input class="form-control" type="text" maxlength="9" name="celular" id="celular" required>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Dni</label>
                                                    <input class="form-control" type="text" maxlength="8" name="dni" id="dni" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Clave</label>
                                                    <input class="form-control" type="password" maxlength="15" name="clave" id="clave" required/>
                                                </div>
                                                <div class="form-group label-floating">
                                                    <label class="control-label">Repetir Clave</label>
                                                    <input class="form-control" type="password" maxlength="15" id="rclave" required/>
                                                </div>
                                                    <div id="mensajeConfirmaNuevaClave" style="text-align:center; display: none; margin-top: 5px; margin-bottom: -14px; color: #d4393d"></div>
                                                <div class="text-center">
                                                    <button type="button" id="btnRegistrar" class="btn btn-info btn-raised btn-sm"><i class="zmdi zmdi-floppy"></i> Guardar</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
                                                    
      <script type="text/javascript">
          
        $("#btnRegistrar").click(function () {
            if (($("#nombre").val()==="")||($("#apepaterno").val()==="")||($("#apematerno").val()==="")||($("#direccion").val()==="")||($("#email").val()==="")||($("#celular").val()==="")||($("#dni").val()==="")||($("#clave").val()==="")){
                swal({
                        title: "ERROR!",
                        text: "Faltan datos",
                        icon: "error",
                        dangerMode: true
                    });
            }else{
            var valorClave = document.getElementById("clave").value;
            var valorNuevaClave = document.getElementById("rclave").value;
            var letrasMayusculas = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
            var cantNumeros = 0;
            var cantLetras = 0;
            var cantLetrasMayus = 0;
            
            
            for (var i = 0; i < valorNuevaClave.length; i++) {
                if (!isNaN(valorNuevaClave.charAt(i))) {
                    cantNumeros++;
                }

                if (isNaN(valorNuevaClave.charAt(i))) {
                    cantLetras++;
                }

                if (letrasMayusculas.indexOf(valorNuevaClave.charAt(i), 0) !== -1) {
                    cantLetrasMayus++;
                }
            }

            if (valorClave === null || valorClave.length === 0 || /^\s+$/.test(valorClave)) {
                $("p").remove();
                $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Ingrese su clave.</p>");
                $("#mensajeConfirmaNuevaClave").show();
                return false;
            }
            else if (valorNuevaClave === null || valorNuevaClave.length === 0 || /^\s+$/.test(valorNuevaClave)) {
                $("p").remove();
                $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Ingrese la confirmación de la clave.</p>");
                $("#mensajeConfirmaNuevaClave").show();
                return false;
            }
            else if (valorNuevaClave === valorClave) {
                if (cantNumeros < 1) {
                    $("p").remove();
                    $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo un número</p>");
                    $("#mensajeConfirmaNuevaClave").show();
                }
                else if (cantLetras < 1) {
                    $("p").remove();
                    $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo una letra minúscula o signo o símbolo</p>");
                    $("#mensajeConfirmaNuevaClave").show();
                }
                else if (cantLetrasMayus < 1) {
                    $("p").remove();
                    $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo una letra mayúscula</p>");
                    $("#mensajeConfirmaNuevaClave").show();
                }
                else if (valorNuevaClave.length < 8) {
                    $("p").remove();
                    $("#mensajeConfirmaNuevaClave").append("<p><strong>Aviso!</strong> Ingrese mínimo 8 caracteres</p>");
                    $("#mensajeConfirmaNuevaClave").show();
                }
                else {
                    $("p").remove();
                    swal({
                            title: "BIENVENIDO!",
                            text: "Nuevo cliente registrado!",
                            icon: "Success",
                            dangerMode: true
                        }).then(function () {
                    window.formcliente.submit();
		}); 		
                }
            }
        }
    });
    </script>
    
    
    
        <script>
            $.material.init();
        </script>
    </body>
</html>