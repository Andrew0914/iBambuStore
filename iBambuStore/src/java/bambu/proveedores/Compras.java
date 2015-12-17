package bambu.proveedores;

import bambu.otros.Conexion;
import bambu.otros.Usuario;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

/**
 *
 * @author Andrew
 */
public class Compras {

    public static HashMap<String, Double> productos = new HashMap();
    public Usuario usuario;
    private Statement ejecutor;
    private ResultSet rs;
    private int id_ultimaCompra;
    private int hasCodigo;

    public Compras(Usuario usuario) {
        this.usuario = usuario;
        this.id_ultimaCompra = 0;
        this.hasCodigo = 0;
    }

    public boolean setCompra(double iva, double subtotal, double total, int credito, int proveedor) {
        boolean respuesta = false;
        String nuevaCompra = "INSERT INTO compras(fecha_compra,importe_compra,iva_compra,total_compra,is_credito,id_proveedor)"
                + "values(DATE_FORMAT(CURRENT_DATE,'%Y-%m-%d'),"
                + subtotal + ","
                + iva + ","
                + total + ","
                + credito + ","
                + proveedor + ")";
        try {
            this.ejecutor = this.usuario.conexion.conectar().createStatement();
            this.ejecutor.execute(nuevaCompra);
            respuesta = true;
        } catch (SQLException ex) {
            System.out.println("Compra general --> " + ex);
        }
        return respuesta;
    }

    public boolean setCompraDetalle() {
        boolean respuesta = false;
        String ultimaCompra = "Select MAX(id_compra) AS ultima_compra FROM compras ";
        try {
            ejecutor = this.usuario.conexion.conectar().createStatement();
            rs = ejecutor.executeQuery(ultimaCompra);
            if (rs.next()) {
                this.id_ultimaCompra = rs.getInt("ultima_compra");
            }
            double current_precio = 0;
            double current_total = 0;
            double current_subtotal = 0;
            double current_iva = 0;
            String query_detalle;
            for (String cod : productos.keySet()) {

                String obtenerPrecio = "SELECT precio_compra,hasCode FROM productos WHERE codigo_producto = '" + cod + "'";
                rs = ejecutor.executeQuery(obtenerPrecio);
                if (rs.next()) {
                    current_precio = rs.getDouble("precio_compra");
                    this.hasCodigo = rs.getInt("hasCode");
                }
                if (this.hasCodigo == 0) {
                    current_total = current_precio * productos.get(cod);
                    current_subtotal = current_total;
                    current_iva = 0;
                } else if (this.hasCodigo == 1) {
                    current_total = current_precio * productos.get(cod);
                    current_subtotal = current_total / 1.16;
                    current_iva = current_subtotal * 0.16;

                }

                query_detalle = new String("INSERT INTO `compra_detalle`(`codigo_producto`, `id_compra`, `cantidad_producto`, `importe_cdetalle`, `iva_cdetalle`, `total_cdetalle`) VALUES('"
                        + cod + "',"
                        + this.id_ultimaCompra + ","
                        + productos.get(cod) + ","
                        + current_subtotal + ","
                        + current_iva + ","
                        + current_total + ")");

                this.ejecutor = this.usuario.conexion.conectar().createStatement();

                this.ejecutor.execute(query_detalle);

            }
            respuesta = true;

        } catch (SQLException ex) {
            System.out.println("Detalle compra -->" + ex);
        }
        return respuesta;
    }
}
