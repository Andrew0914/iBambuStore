<%-- 
    Document   : Reportes
    Created on : 26/06/2015, 10:53:10 PM
    Author     : AndrewAlan
--%>

<%@page import="bambu.otros.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BambuStore :: Reportes</title>
        <link rel="stylesheet" href="css/estilos.css">
    </head>
    <body>
        <header>
            <div id="logo">
                <img src="imagen/logo_bs.png" alt="BambuStore">
            </div>
            <nav>
                <ul>
                    <li><a href="index.jsp">Ventas <img src='imagen/signal12.png'></a></li> 
                    <li><a href="Compras.jsp">Compras <img src='imagen/shop32.png'></a></li>
                            <%
                                int puede = ((Usuario) request.getSession().getAttribute("usuario")).getPrivilegio();
                                if (puede == 1) {
                                    out.println("<li><a href='Productos.jsp'>Productos <img src='imagen/product3.png'></a></li>"
                                            + "<li><a href='Proveedores.jsp'> Proveedor <img src='imagen/delivery36.png'></a></li>"
                                            + "<li><a href='Reportes.jsp'>Reportes <img src='imagen/report1.png'></a></li>"
                                            + "<li><a id='nuevoUsuario'><img src='imagen/adduser.png'></a></li>");
                                }
                            %>
                    <li id="logout"><img src="imagen/door9.png"></li>
                </ul>
            </nav>
        </header>
        <section id="reportes_general">
            <h2>Reportes</h2>
            <hr>
            VENTAS: <input type="radio" name="tiporeporte" id="reporte_venta" class="espacioinput">
            COMPRAS <input type="radio" name="tiporeporte" id="reporte_compra" class="espacioinput">
            Desde <input type="date" id="fecha1" class="rangos"> Hasta  <input type="date" id="fecha2" class="rangos espacioinput">
            <button id="obtener_reporte" class="btnCompras"><img src="imagen/money182.png"></button>
            <br><br>
            <hr>
            <table id="reportes_table">

            </table>
        </section>
        <script type="text/javascript" src="javascript/jquery.js"></script>
        <script type="text/javascript" src="javascript/tootip.js"></script>
        <script type="text/javascript" src="javascript/Sesion.js"></script>
        <script type="text/javascript" src="javascript/Main.js"></script>
    </body>
</html>
