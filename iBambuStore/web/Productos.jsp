<%-- 
    Document   : Productos
    Created on : 26/06/2015, 10:52:19 PM
    Author     : AndrewAlan
--%>

<%@page import="bambu.otros.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BambuStore::Productos</title>
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
        <section id="productos_general">
            <h3>Productos</h3>
            <hr>
            Producto : <input type="text" id="nombre_codigo_prod" placeholder="Nombre o Codigo del producto" class="rangos espacioinput">
            Rango de precio: 
            <input class="rangos soloNumeros" type="text" id="precio1" placeholder="Prercio 1"> ---
            <input class="rangos espacioinput soloNumeros" type="text" id="precio2" placeholder="Prercio 2">
            Todos los productos <input type="checkbox" id="todos" >
            <br> <br>
            Ordenar por : <select class="rangos espacioinput"  id="ordenamiento_prod">
                <option value="ORDER BY precio_venta DESC">+Precio a -Precio</option>
                <option value="ORDER BY precio_venta ASC">-Precio a +Precio</option>
            </select>
            <button id="buscar_prod" class="btnCompras" title="Buscar productos"><img src="imagen/search100.png"></button>
            <button class="btnCompras" id="guardarCambiosProducto" title="Guardar cambios"><img src="imagen/save.png"></button>
            <button class="btnCompras" id="cancelarCambiosProducto" title="Cancelar cambios"><img src="imagen/cancel.png"></button>
            <button class="btnCompras" id="agregarProducto" title="Nuevo producto"><img src="imagen/agregar.png"></button>
            <br> <br>
            <hr>


            <table id="resultado_productos">
                <tr>
                    <th>Codigo</th>
                    <th>Nombre</th>
                    <th>Media</th>
                    <th>Unidad</th>
                    <th>Precio</th>
                    <th>-</th>
                    <th>-</th>
                </tr>
            </table>

        </section>   
        <div id="popNuevoProducto">
            <h3>Nuevo Producto</h3>
            <ul>
                <li><input type="text" id="codigoprod" placeholder="Codigo o clave" class="rangos"><br><br></li>
                <li>Codigo?:<input type="radio" id="barras"><br><br></li>
                <li><input type="text" id="nombre_producto" placeholder="Nombre" class="rangos"><br><br></li>
                <li><input type="text" id="medidaprod" placeholder="Medida" class="rangos soloNumeros"><br><br></li>
                <li><select id="unidadprod"  class="rangos">
                        <option value="ml">Mililitros</option>
                        <option value="l">Litros</option>
                        <option value="g">Gramos</option>
                        <option value="Kg">Kilogramos</option>
                    </select>
                    <br><br></li>
                <li><input type="text" id="precioventa" placeholder="Precio de venta" class="rangos soloNumeros"><br><br></li>
                <li><input type="text" id="preciocompra" placeholder="Precio de compra" class="rangos soloNumeros"><br><br></li>
                <li>
                    <button id="addProductox" class="btnCompras espacioinput"><img src="imagen/agregar.png"></button><br><br>
                    <button id="cancelarAddProd" class="btnCompras"><img src="imagen/cancel.png"> </button>
                </li>
            </ul>
        </div>
        <div id="capa"></div>
        <script type="text/javascript" src="javascript/jquery.js"></script>
        <script type="text/javascript" src="javascript/tootip.js"></script>
        <script type="text/javascript" src="javascript/Sesion.js"></script>
        <script type="text/javascript" src="javascript/Main.js"></script>
    </body>
</html>
