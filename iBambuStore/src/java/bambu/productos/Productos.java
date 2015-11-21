package bambu.productos;

import bambu.otros.Conexion;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Productos {

    private String codigo_producto;
    private String unidad;
    private double precio1;
    private double precio2;
    private int hasCode;
    private Connection conn;
    private Statement ejecutor;
    private ResultSet content;

    public Productos() {
        this.conn = new Conexion().conectar();
    }

    public Productos(String codigo_producto) {
        this.codigo_producto = codigo_producto;
        this.conn = new Conexion().conectar();
    }

    public Productos(String codigo_producto, double precio1, double precio2) {
        this.codigo_producto = codigo_producto;
        this.precio1 = precio1;
        this.precio2 = precio2;
        this.conn = new Conexion().conectar();
    }

    public JsonObject getProducto() {
        String query = "SELECT  * From productos WHERE codigo_producto= '" + this.codigo_producto + "'";
        JsonObject json = new JsonObject();
        try {

            this.ejecutor = this.conn.createStatement();
            this.content = this.ejecutor.executeQuery(query);

            while (this.content.next()) {
                json.addProperty("codigo_producto", this.content.getString("codigo_producto"));
                json.addProperty("nombre", this.content.getString("nombre"));
                json.addProperty("medida", this.content.getString("medida"));
                json.addProperty("unidad", this.content.getString("unidades"));
                json.addProperty("precio_venta", this.content.getString("precio_venta"));
                json.addProperty("precio_compra", this.content.getString("precio_compra"));
                json.addProperty("hasCode", this.content.getString("hasCode"));
            }

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        this.ejecutor = null;
        this.content = null;
        System.out.println(json);
        return json;
    }

    public JsonArray busquedaProductos(String ordenamiento, int todos) {
        JsonArray array = new JsonArray();
        JsonObject json = new JsonObject();
        String query = "SELECT * FROM productos WHERE";
        if (todos == 1) {
            query = "SELECT * FROM productos " + ordenamiento;
        } else if (todos == 0) {
            if (!this.codigo_producto.equals("no_codigo")) {
                query += " (codigo_producto='" + this.codigo_producto + "' OR nombre='" + this.codigo_producto + "')";
                if (this.precio1 > 0 || this.precio2 > 0) {
                    query += "  AND precio_venta BETWEEN " + this.precio1 + " AND " + this.precio2;
                }
            } else {
                if (this.precio1 > 0 || this.precio2 > 0) {
                    query += " precio_venta BETWEEN " + this.precio1 + " AND " + this.precio2;
                }
            }

            query += " " + ordenamiento;
        }
        try {

            this.ejecutor = this.conn.createStatement();
            this.content = this.ejecutor.executeQuery(query);
            while (this.content.next()) {
                json.addProperty("codigo_producto", this.content.getString("codigo_producto"));
                json.addProperty("nombre", this.content.getString("nombre"));
                json.addProperty("medida", this.content.getString("medida"));
                json.addProperty("unidad", this.content.getString("unidades"));
                json.addProperty("precio_venta", this.content.getString("precio_venta"));
                json.addProperty("precio_compra", this.content.getString("precio_compra"));
                json.addProperty("hasCode", this.content.getString("hasCode"));
                array.add(json);
                json = new JsonObject();
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        catch(Exception exx){
            System.out.println(exx);
        }
        System.out.println(array);
        return array;
    }

    public boolean updateProducto(String data) {
        boolean respuesta = false;
        String query = "";
        String[] rows = data.split(";");

        for (int i = 0; i < rows.length; i++) {
            String[] dato = rows[i].split(",");
            query += "UPDATE productos SET ";
            query += "nombre='" + dato[1] + "',";
            query += "medida='" + dato[2] + "',";
            query += "unidades='" + dato[3] + "',";
            query += "precio_venta=" + dato[4] + ",";
            query += "precio_compra=" + dato[5] + " ";
            query += " WHERE codigo_producto='" + dato[0] + "'";

            try {
                this.ejecutor = this.conn.createStatement();
                System.out.println(query);
                this.ejecutor.execute(query);
                query = new String();
            } catch (SQLException ex) {
                System.out.println("No se actualizo prod" + ex);
            }
        }
        respuesta = true;
        return respuesta;
    }

    public boolean borrarUnProducto() {
        boolean resultado = false;
        String query = "DELETE FROM productos WHERE codigo_producto='" + this.codigo_producto + "'";
        try {
            this.ejecutor = this.conn.createStatement();
            this.ejecutor.execute(query);
            resultado = true;
        } catch (SQLException x) {
            System.out.println(x);
        }
        return resultado;

    }

    public boolean insertarProducto(String codigo, String nombre, String medida, String unidad, double precioventa,int barras,double preciocompra) {
        boolean respuesta = false;
        String query = "INSERT INTO productos(codigo_producto,nombre,medida,unidades,precio_venta,precio_compra,hasCode) values('"
                + codigo + "','"
                + nombre + "','"
                + medida + "','"
                + unidad + "','"
                + precioventa + "','"
                + preciocompra+ "','"
                + barras+"')";
        try {
            this.ejecutor = this.conn.createStatement();
            this.ejecutor.execute(query);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        catch(Exception x){
            System.out.println(x);
        }
        respuesta = true;
        return respuesta;
    }
}
