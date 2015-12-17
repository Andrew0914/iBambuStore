<%-- 
    Document   : Proveedores
    Created on : 26/06/2015, 10:52:36 PM
    Author     : AndrewAlan
--%>

<%@page import="bambu.otros.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BambuStore::Proveedores</title>
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
                    <li><a href='Productos.jsp'>Productos <img src='imagen/product3.png'></a></li>
                    <li><a href='Proveedores.jsp'> Proveedor <img src='imagen/delivery36.png'></a></li>
                    <li><a href='Reportes.jsp'>Reportes <img src='imagen/report1.png'></a></li>
                    <!--<li><a id='nuevoUsuario'><img src='imagen/adduser.png'></a></li>-->
                    <li id="logout"><img src="imagen/door9.png"></li>
                </ul>
            </nav>

        </header>
        <section id="general_proveedores">
            <h3>Proveedores</h3>
            <hr>
            <input type="text" id="busq_proveedor" placeholder="Proveedor ... " class="espacioinput rangos">
            <button class="btnCompras" id="buscarProveedores"><img src="imagen/search100.png"></button>
            <button class="btnCompras" id="guardarProveedores"><img src="imagen/save.png"></button>
            <button class="btnCompras" id="cancelarProveedores"><img src="imagen/cancel.png"></button>
            <button class="btnCompras" id="agregarProveedor" title="Nuevo proveedor"><img src="imagen/agregar.png"></button>
            <br><br>
            <hr>
            <table id="resutlados_proveedores">
                <tr>
                    <th>ID</th>
                    <th>Empresa </th>
                    <th>Telefono</th>
                    <th>Distribuidor</th>
                    <th>Correo</th>
                    <th>-</th>
                    <th>-</th>
                </tr>
            </table>
        </section>
        <div id="popNuevoProveedor">
            <h3>Nuevo proveedor</h3>
            <ul>
                <li><input type="text" id="nombre_empresa" placeholder="Empresa" class="rangos"><br><br></li>
                <li><input type="text" id="telefonoprov" placeholder="Telefono" class="rangos soloNumeros"><br><br></li>
                <li><input type="text" id="distribuidorprov" placeholder="Nombre del distribuidor" class="rangos"><br><br></li>
                <li><input type="text" id="paternoprov" placeholder="Apellido Paterno"class="rangos"><br><br></li>
                <li><input type="text" id="maternoprov" placeholder="Apellido Materno"class="rangos"><br><br></li>
                <li>
                    <button id="addProveedor" class="btnCompras espacioinput"><img src="imagen/agregar.png"></button><br><br>
                    <button id="cancelarAddProv" class="btnCompras"><img src="imagen/cancel.png"> </button>
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
