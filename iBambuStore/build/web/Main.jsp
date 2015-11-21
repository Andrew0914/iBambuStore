<%-- 
    Document   : Ventas
    Created on : 22/06/2015, 05:06:39 PM
    Author     : Andrew
--%>

<%@page import="bambu.contabilidad.Saldos"%>
<%@page import="bambu.proveedores.Proveedores"%>
<%@page import="bambu.proveedores.Compras"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="bambu.ventas.Ventas"%>
<%@page import="bambu.productos.Productos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ID = request.getParameter("ID");
    if (ID.equals("obtener_producto")) {
        String codigo = request.getParameter("codigo_producto");
        Productos producto = new Productos(codigo);
        if (producto.getProducto().get("hasCode").getAsInt() == 1) {

            String cod_producto = producto.getProducto().get("codigo_producto").getAsString();
            if (Ventas.detalles.containsKey(cod_producto)) {
                Ventas.detalles.put(cod_producto, Ventas.detalles.get(cod_producto) + 1);
            } else {
                Ventas.detalles.put(cod_producto, 1.0);
            }
        }
        out.clearBuffer();
        out.println(producto.getProducto());

    }

    if (ID.equals("cantidad_especial")) {
        String codigo = request.getParameter("codigo_producto");
        double cantidad_gramaje = Double.parseDouble(request.getParameter("cantidad_gramaje"));
        if (Ventas.detalles.containsKey(codigo)) {
            Ventas.detalles.put(codigo, Ventas.detalles.get(codigo) + cantidad_gramaje);
        } else {
            Ventas.detalles.put(codigo, cantidad_gramaje);
        }
        JsonObject json = new JsonObject();
        json.addProperty("estado", "ok");
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("hacer_venta")) {
        Ventas venta = new Ventas();
        JsonObject json = new JsonObject();
        double total_venta = Double.parseDouble(request.getParameter("total_venta"));
        if (venta.setVenta(total_venta)) {
            if (venta.setVentaDetalle()) {
                json.addProperty("venta", "ok");
                Ventas.detalles.clear();
            } else {
                json.addProperty("venta", "nodetalle");
                Ventas.detalles.clear();
            }
        } else {
            json.addProperty("venta", "noventa");
            Ventas.detalles.clear();
        }
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("cancelar_venta")) {
        JsonObject json = new JsonObject();
        Ventas.detalles.clear();
        json.addProperty("estado", "ok");
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("remover_producto_venta")) {
        String codigo = request.getParameter("codigo");
        double cantidad = Double.parseDouble(request.getParameter("cantidad"));
        int hasCode = Integer.parseInt(request.getParameter("hascodigo"));

        double old_cantidad = Ventas.detalles.get(codigo);

        if (hasCode == 1) {
            if (old_cantidad > 1) {
                Ventas.detalles.put(codigo, (old_cantidad - cantidad));
            } else if (old_cantidad == 1) {
                Ventas.detalles.remove(codigo);
            }
        } else if (hasCode == 0) {
            Ventas.detalles.put(codigo, old_cantidad - cantidad);
            if (Ventas.detalles.get(codigo) == 0) {
                Ventas.detalles.remove(codigo);
            }
        }

        JsonObject json = new JsonObject();
        json.addProperty("estado", "ok");
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("compra_detalle")) {
        String codigo = request.getParameter("codigo_producto");
        double cantidad = Double.parseDouble(request.getParameter("cantidad"));
        Productos producto = new Productos(codigo);
        JsonObject json = new JsonObject();
        json = producto.getProducto();

        if (Compras.productos.containsKey(codigo)) {
            double old_cantidad = Compras.productos.get(codigo);
            Compras.productos.put(codigo, old_cantidad + cantidad);
        } else {
            Compras.productos.put(codigo, cantidad);
        }

        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("remover_prod_compra")) {
        String codigo = request.getParameter("codigo");
        double cantidad = Double.parseDouble(request.getParameter("cantidad"));
        double old_cantidad = Compras.productos.get(codigo);
        Compras.productos.put(codigo, (old_cantidad - cantidad));
        if (Compras.productos.get(codigo) == 0) {
            Compras.productos.remove(codigo);
        }
        JsonObject json = new JsonObject();
        json.addProperty("estado", "ok");
        out.clearBuffer();
        out.println(json);

    }

    if (ID.equals("obtener_proveedor")) {
        String proveedor = request.getParameter("proveedor");
        Proveedores prov = new Proveedores(proveedor);
        out.clearBuffer();
        out.println(prov.getProveedor());
    }

    if (ID.equals("hacer_compra")) {
        Compras compra = new Compras();
        JsonObject json = new JsonObject();
        double total_compra = Double.parseDouble(request.getParameter("total_venta"));
        double iva_total = Double.parseDouble(request.getParameter("iva_total"));
        double subtotal = Double.parseDouble(request.getParameter("subtotal"));
        int credito = Integer.parseInt(request.getParameter("credito"));
        int proveedor = Integer.parseInt(request.getParameter("proveedor"));
        if (compra.setCompra(iva_total, subtotal, total_compra, credito, proveedor)) {
            if (compra.setCompraDetalle()) {
                json.addProperty("compra", "ok");
                Compras.productos.clear();
            } else {
                json.addProperty("compra", "nodetalle");
                Compras.productos.clear();
            }
        } else {
            json.addProperty("compra", "nocompra");
            Compras.productos.clear();
        }
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("cancelar_compra")) {
        JsonObject json = new JsonObject();
        Compras.productos.clear();
        json.addProperty("estado", "ok");
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("busquedaProducto")) {
        String cod_producto = request.getParameter("producto");
        double precio1 = Double.parseDouble(request.getParameter("precio1"));
        double precio2 = Double.parseDouble(request.getParameter("precio2"));
        int todos = Integer.parseInt(request.getParameter("todos"));
        String ordenamiento = request.getParameter("ordenamiento");
        Productos producto = new Productos(cod_producto, precio1, precio2);
        out.clearBuffer();
        out.println(producto.busquedaProductos(ordenamiento, todos));
    }

    if (ID.equals("update_producto")) {
        JsonObject json = new JsonObject();
        Productos producto = new Productos();
        String data = request.getParameter("datos");
        if (producto.updateProducto(data)) {
            json.addProperty("update", "ok");
        } else {
            json.addProperty("update", "no");
        }
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("delete_producto")) {
        JsonObject json = new JsonObject();
        String codigo = request.getParameter("producto");
        Productos producto = new Productos(codigo);
        if (producto.borrarUnProducto()) {
            json.addProperty("update", "ok");
        } else {
            json.addProperty("update", "no");
        }
        out.clearBuffer();
        out.println(json);
    }
    if (ID.equals("update_proveedor")) {
        JsonObject json = new JsonObject();
        Proveedores proveedor = new Proveedores();
        String data = request.getParameter("datos");
        if (proveedor.updateProveedor(data)) {
            json.addProperty("update", "ok");
        } else {
            json.addProperty("update", "no");
        }
        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("delete_proveedor")) {
        JsonObject json = new JsonObject();
        int id_proveedor = Integer.parseInt(request.getParameter("proveedor"));
        Proveedores proveedor = new Proveedores();
        if (proveedor.borrarUnProveedor(id_proveedor)) {
            json.addProperty("update", "ok");
        } else {
            json.addProperty("update", "no");
        }
        out.clearBuffer(); 
        out.println(json);
    }

    if (ID.equals("insert_proveedor")) {
        JsonObject json = new JsonObject();
        String empresa = request.getParameter("empresa");
        String telefono = request.getParameter("telefono");
        String distribuidor = request.getParameter("distribuidor");
        String paterno = request.getParameter("paterno");
        String materno = request.getParameter("materno");
        Proveedores proveedor = new Proveedores();
        if (proveedor.insertarProveedor(empresa, telefono, distribuidor, paterno,materno)) {
            json.addProperty("update", "ok");
        } else {
            json.addProperty("update", "no");
        }
        out.clearBuffer();
        out.println(json);
    }
    if (ID.equals("insert_producto")) {
        JsonObject json = new JsonObject();
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        String medida = request.getParameter("medida");
        String unidad = request.getParameter("unidad");
        double precioventa = Double.parseDouble(request.getParameter("precioventa"));
        double preciocompra = Double.parseDouble(request.getParameter("preciocompra"));
        int tienebarra = Integer.parseInt(request.getParameter("barras"));
        Productos producto = new Productos();
        if (producto.insertarProducto(codigo, nombre, medida, unidad, precioventa,tienebarra,preciocompra)) {
            json.addProperty("update", "ok");
        } else {
            json.addProperty("update", "no");
        }
        out.clearBuffer();
        out.println(json);
    }
    if (ID.equals("imprimir_ticket")) {
        JsonObject json = new JsonObject();
        json.addProperty("imprimir", "ok");
        Ventas ticket = new Ventas();
        ticket.imprimirTickect();
        out.clearBuffer();
        out.println(json);
    }
    
    if(ID.equals("reporte_venta")){
      String fecha1 = request.getParameter("fecha1");
      String fecha2 = request.getParameter("fecha2");
      Saldos ventas = new Saldos();
      out.clearBuffer();
      out.println(ventas.generarReporteVentas(fecha1, fecha2));
    }
    if(ID.equals("reporte_compra")){
      String fecha1 = request.getParameter("fecha1");
      String fecha2 = request.getParameter("fecha2");
      Saldos compras = new Saldos();
      out.clearBuffer();
      out.println(compras.generarReportCompras(fecha1, fecha2));  
    }

%>