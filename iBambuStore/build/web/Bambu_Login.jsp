<%-- 
    Document   : Bambu_Login
    Created on : 20/06/2015, 08:03:39 PM
    Author     : AndrewAlan
--%>

<%@page import="bambu.otros.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login BambuStore</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/estilos.css">
    </head>
    <body>
        <ul id="login">
            <li>
                <img src="imagen/logo_bs.png">
            </li>
            <li>
                <input type="text" id="nombre" placeholder="Usuario">
            </li>
            <li>
                <input type="password" id="contrasena" placeholder="Password">
            </li>
            <li>
                <button id="iniciar_sesion">Iniciar sesi&oacute;n</button>
            </li>
            <!--<li>
                <button id="nuevo_usuario">Nuevo Usuario</button>
            </li>->
        </ul>
        <!--<div id="pop">
            <span id="close"> X </span>
            <ul>

                <li> <img src="imagen/add199.png"> </li> 
                <li><h3>Nuevo usuario</h3></li>
                <li>
                    <input type="text" id="nuevo_nombre" placeholder="Usuario">
                </li>
                <li>
                    <input type="password" id="nueva_contrasena" placeholder="Password">
                </li>
                <li>
                    <input type="password" id="x_contrasena" placeholder="Repetir password...">
                </li>
                <%
                  /*  try{
                    
                    int puede = ((Usuario) request.getSession().getAttribute("usuario")).getPrivilegio();
                    if (puede == 1) {
                        out.println("<li>"
                                + "Administrador: <input type='radio' id='admin'>"
                                + "<br> <br>"
                                + "Tendero : <input type=´'radio' id='tendero'> "
                                + " <br> <br>"
                                + "</li>");
                    }
                    }catch(NullPointerException n){
                        //System.out.println("No hay sesion activa");
                    }*/
                    
                %>
                <li>
                    <button id="crear_usuario"> Crear Usuario</button>
                </li>

            </ul>
        </div>

        <div id="capa"></div>-->

        <script type="text/javascript" src="javascript/jquery.js"></script>
        <script type="text/javascript" src="javascript/Sesion.js"></script>
    </body>
</html>
