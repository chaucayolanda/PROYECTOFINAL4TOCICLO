<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>LogIn</title>
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="./css/main.css">
    </head>
    <body class="cover" style="background-image: url(./assets/img/login.jpg);">
        <nav class="full-box dashboard-Navbar">
            <li class="pull-left">
                <a href="Index.jsp" class="btn-menu-dashboard"><strong style="color: #ff5722;">Inicio</strong></a>
            </li>
            <ul class="full-box list-unstyled text-right">                    
                <li>
                    <a href="#!" class="btn-Notifications-area">
                        <i class="zmdi zmdi-check-all"></i>
                        <span class="badge">Acceder</span>
                    </a>
                </li>
            </ul>
        </nav>
        <form action="sLoginCliente" method="post" class="full-box logInForm">
            <p class="text-center text-muted">
                <i class="zmdi zmdi-account-circle zmdi-hc-5x"></i>
            </p>
            <p class="text-center text-muted text-uppercase">Inicia sesión</p>
            <div class="form-group label-floating">
                <label class="control-label" for="dni">DNI</label>
                <input style="color:white" class="form-control" id="dni" name="dni" type="text" required>
                <p class="help-block">Escribe tu dni</p>
            </div>
            <div class="form-group label-floating">
                <label class="control-label" for="UserPass">Contraseña</label>
                <input style="color:white" class="form-control" id="UserPass" name="UserPass" type="password" required>
                <p class="help-block">Escribe tu contraseña</p>
            </div>
            <div class="form-group text-center">
                <input type="submit" id="iniciarsesion" value="Iniciar sesión" class="btn btn-raised btn-danger">
            </div>          
            <center><a style="color:aqua" href="Registrocliente.jsp">Registrar</a></center>
            <center><a style="color:aqua" href="/ProyectoFinal/assets/pdf/MANUAL.pdf" download="Manual del usuario" >Manual del usuario</a></center>
        </form>
        <section class="full-box Notifications-area">
            <div class="full-box Notifications-bg btn-Notifications-area"></div>
            <div class="full-box Notifications-body">
                <div class="Notifications-body-title text-titles text-center">
                    Acceder <i class="zmdi zmdi-close btn-Notifications-area"></i>
                </div>
                <div class="list-group">
                    <div class="list-group-item">
                        <div class="row-content"><br>                        
                            <a href="Login.jsp"><h4 class="list-group-item-heading">Usuarios</h4></a>
                            <a href="LoginClientes.jsp"><h4 class="list-group-item-heading">Clientes</h4></a>

                        </div>
                    </div>
                </div>
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