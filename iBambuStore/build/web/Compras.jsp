<%-- 
    Document   : Compras
    Created on : 26/06/2015, 10:52:11 PM
    Author     : AndrewAlan
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="bambu.otros.Conexion"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="bambu.otros.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bambu Store :: Compras</title>
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

        <section id="general_compras">
            <h2>Compras</h2>
            <hr> 
            Proveedor: 
            <input type="text" id="search_proveedor" placeholder="Buscar ..." class="cajasPrincipales focusCaja">
            <select id="list_proveedores" class="focusCaja">
                <%
                   Usuario usr = (Usuario) (request.getSession().getAttribute("usuario"));
                    Statement ejecutor;
                    ResultSet resultado;
                    String opciones = "";
                    ejecutor = usr.conexion.conectar().createStatement();
                    resultado = ejecutor.executeQuery("SELECT id_proveedor,empresa from proveedores");
                    while (resultado.next()) {
                        opciones += "<option value=" + resultado.getString("id_proveedor") + ""
                                + ">" + resultado.getString("empresa") + "</option>";
                    }
                    out.print(opciones);
                %>
            </select>
            A cr&eacute;dito : <input type="checkbox" id="is_credio">
            <%
                Calendar fecha = Calendar.getInstance();
                DateFormat formato = DateFormat.getDateInstance();
                out.println(" Fecha : " + formato.format(fecha.getTime()));
            %>
            <br>
            SubTotal : $<input type="text" id="subtotal_compra" value="0" readonly class="cajasPrincipales">
            Iva Total : $<input type="text" id="ivatotal_compra" value="0" readonly class="cajasPrincipales">
            Total : $<input type="text" id="total_compra" value="0" readonly class="cajasPrincipales"> 

            <hr>
            Producto: <input type="text" placeholder="ingresar codigo" class="cajasPrincipales focusCaja" id="prod_compra">
            Cantidad: <input type="number" value="1" class="cajasPrincipales focusCaja soloNumeros" id="cantidad_compra">
            <button id="addProducto" class="btnCompras">Agregar <img src="imagen/addprod.png"></button>
            <button id="hacer_compra" class="btnCompras"><img src="imagen/aceptarcompra.png"></button>
            <button id="cancelar_compra" class="btnCompras"><img src="imagen/eliminar.png"></button>
            <hr>
            <table id="compra_detalles">

                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Sub Total</th>
                    <th>Iva</th>
                    <th>Total</th>
                    <th> &nbsp; - &nbsp;</th>

                </tr>

            </table>
        </section>
        <p id="ayuda">Ayuda <img src="imagen/help18.png"></p>
        <script type="text/javascript" src="javascript/jquery.js"></script>
        <script type="text/javascript" src="javascript/tootip.js"></script>
        <script type="text/javascript" src="javascript/Sesion.js"></script>
        <script type="text/javascript" src="javascript/Main.js"></script>
        <script type="text/javascript" src="javascript/compras.js"></script>
    </body>
</html>
