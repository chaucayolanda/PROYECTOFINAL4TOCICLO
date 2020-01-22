<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en" >

    <head>
        <meta charset="UTF-8">
        <title>Razzeto || San Jorge</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">
        <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
        <link rel="stylesheet" href="./css/main.css">
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="./css/fonts.css">
    </head>
    <body class="cover">
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
        <section class="full-box dashboard-contentPage mCustomScrollbar _mCS_1 mCS-autoHide mCS_no_scrollbar no-paddin-left">
            <nav class="full-box dashboard-Navbar">
                <li class="pull-left">
                    <a style="font-size: 16px; line-height: 35px;" href="Index.jsp" class="btn-menu-dashboard"><strong style="color: #ff5722;">Inicio</strong></a>
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
        </div>
    </section>
    <div class="slider-container">
        <ul class="slider-pagi"></ul>
        <div class="slider">
            <div class="slide slide-0 active">
                <div class="slide__bg"></div>
                <div class="slide__content">
                    <svg class="slide__overlay" viewBox="0 0 720 405" preserveAspectRatio="xMaxYMax slice">
                    <path class="slide__overlay-path" d="M0,0 150,0 500,405 0,405" />
                    </svg>
                    <div class="slide__text">
                        <h2 style="font-family: Roboto-Black" class="slide__text-heading">Embutidos Razzeto</h2>
                        <p style="font-family: Roboto-Regular" class="slide__text-desc">Somos una empresa lider en la elaboración y comercialización de embutidos y productos cárnicos de reconocida calidad en el mercado nacional e internacional</p>
                    </div>
                </div>
            </div>
            <div class="slide slide-1 ">
                <div class="slide__bg"></div>
                <div class="slide__content">
                    <svg class="slide__overlay" viewBox="0 0 720 405" preserveAspectRatio="xMaxYMax slice">
                    <path class="slide__overlay-path" d="M0,0 150,0 500,405 0,405" />
                    </svg>
                    <div class="slide__text">
                        <h2 style="font-family: Roboto-Black" class="slide__text-heading">Galletas San Jorge</h2>
                        <p style="font-family: Roboto-Regular" class="slide__text-desc">Somos una empresa orientada al consumidor, innovadora, rentable y líder en el mercado nacional de producción de galletas, panetones, fideos y mermeladas</p>
                    </div>
                </div>
            </div>    
        </div>
    </div>
    <script  src="./js/jquerymin.js"></script>
    <script  src="./js/index.js"></script>
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