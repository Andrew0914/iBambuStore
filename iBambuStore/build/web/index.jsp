<%-- 
    Document   : index
    Created on : 5/06/2015, 08:36:18 PM
    Author     : Andrew
--%>

<%@page import="java.io.File"%>
<%@page import="bambu.test.TestClass"%>
<%@page import="bambu.otros.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bambu Store :: Ventas</title>
        <link rel="stylesheet" href="css/estilos.css">
    </head>
    <header>
        <div id="logo">
            <img src="imagen/logo_bs.png" alt="BambuStore">
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Ventas <img src='imagen/signal12.png'></a></li> 
                <li><a href="Compras.jsp">Compras <img src='imagen/shop32.png'></a></li>
                <li><a href='Productos.jsp'>Productos <img src='imagen/product3.png'></a></li>
                <li><a href='Proveedores.jsp'> Proveedor <img src='imagen/delivery36.png'></a></li>
                <li><a href='Reportes.jsp'>Reportes <img src='imagen/report1.png'></a></li>
                <!--<li><a id='nuevoUsuario'><img src='imagen/adduser.png'></a></li>-->
                <li id="logout"><img src="imagen/door9.png"></li>
            </ul>
        </nav>

    </header>
    <div class="titulares">
        Ventas
        <hr>
    </div>
    <section id="contenido_ventas">

        <ul class="ul_ventas">
            <li id="proceso_venta">

                <b>Introduzca el c&oacute;digo producto...</b> 
                <br>
                <br>
                <input type="text" name="codigo_producto" id="codigo_producto" placeholder="Codigo Producto ..." class="focusCaja">
                <div class ="contenedor_tabla">
                    <table id="productos_venta">
                        <tr>
                            <th>C&oacute;digo</th>
                            <th>Nombre</th>
                            <th>Cantidad</th>
                            <th>Unidad</th>
                            <th>Precio</th>
                            <th>&nbsp; - &nbsp;</th>
                        </tr>
                    </table>
                </div>
            </li>
            <li id="totales">
                <h3>Total $</h3>
                <input type="text" name="total_venta" id="total_venta" value="0" readonly> 
                <h3>Pago $ </h3> 
                <input type="text" name="pago_venta" id="pago_venta" value="0" class="focusCaja soloNumeros"> <img src="imagen/info.png" title="Introducir la cantidad con la que paga el cliente" class="hastip">
                <h3>Cambio $</h3>
                <input type="text" name="cambio_venta" id="cambio_venta" value="0" readonly> 
                <button id="hacer_venta" title="Realizar Venta"><img src="imagen/aceptar.png"></button>
                <button id="cancelar_venta" title="Cancelar venta"><img src="imagen/eliminar.png"></button>
            </li>
        </ul>
    </section>

   <!-- <div id="pop">
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
                /*if (puede == 1) {
                    out.println("<li>"
                            + "Administrador: <input name='tipo_user' type='radio' id='admin'>"
                            + "<br> <br>"
                            + "Tendero : <input type='radio' name='tipo_user' id='tendero'> "
                            + " <br> <br>"
                            + "</li>");
                }*/
            %>





            <li>
                <button onclick="nuevoUsuario_admin()"> Crear Usuario</button>
            </li>
        </ul>
    </div> -->
    <div id="pop_producto_und">
        <h4> Cantidad comprada en: </h4> <br><br>               
        Kilogramos (Kg)<input type="radio" name="medidas" id="kilos"> <br> <br>
        Gramos (g)<input type="radio" name="medidas" id="gramos" checked="true"> <br> <br>
        Pesos ($)<input type="radio" name="medidas" id="pesos"> <br> <br>
        <input type="text" id="unidades_compradas" value="0" class="soloNumeros">
        <button id="btn_unidades">OK</button>
    </div>
    <div id="capa"></div>
    <p id="ayuda">Ayuda <img src="imagen/help18.png"></p>
    <script type="text/javascript" src="javascript/jquery.js"></script>
    <script type="text/javascript" src="javascript/tootip.js"></script>
    <script type="text/javascript" src="javascript/Sesion.js"></script>
    <script type="text/javascript" src="javascript/Main.js"></script>
</body>


</html>
