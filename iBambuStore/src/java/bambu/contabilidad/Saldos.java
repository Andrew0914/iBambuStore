package bambu.contabilidad;

import bambu.otros.Conexion;
import bambu.otros.Usuario;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

public class Saldos {

    private ResultSet content;
    public Usuario usuario;
    private Statement ejecutor;
    JasperReport reporte;
    JasperPrint jasperPrint;

    public Saldos(Usuario usuario) {
        this.usuario = usuario;
    }

    public JsonArray generarReporteVentas(String fecha1, String fecha2) {
        JsonArray array = new JsonArray();
        JsonObject json = new JsonObject();
        String query = "SELECT * FROM ventas WHERE fecha_venta BETWEEN '" + fecha1 + "' AND '" + fecha2 + "'";
        System.out.println(query);
        try {
            this.ejecutor = this.usuario.conexion.conectar().createStatement();
            this.content = this.ejecutor.executeQuery(query);
            while (this.content.next()) {
                json.addProperty("idVenta", this.content.getString("idVenta"));
                json.addProperty("fecha_venta", this.content.getString("fecha_venta"));
                json.addProperty("importe", this.content.getString("subtotal_venta"));
                json.addProperty("iva_venta", this.content.getString("iva_venta"));
                json.addProperty("total", this.content.getString("total"));
                array.add(json);
                json = new JsonObject();
            }

            //Generación de Pdf
            this.content = this.ejecutor.executeQuery(query);
            exportarReporte(1, content);

        } catch (JRException ex) {
            System.out.println("Formato no encontrado");

        } catch (SQLException sql) {
            System.out.println(sql);
        }
        return array;
    }

    public JsonArray generarReportCompras(String fecha1, String fecha2) {
        JsonArray array = new JsonArray();
        JsonObject json = new JsonObject();
        String query = "SELECT * FROM compras WHERE fecha_compra BETWEEN '" + fecha1 + "' AND '" + fecha2 + "'";
        System.out.println(query);
        try {
            this.ejecutor = this.usuario.conexion.conectar().createStatement();
            this.content = this.ejecutor.executeQuery(query);
            while (this.content.next()) {
                json.addProperty("id_compra", this.content.getString("id_compra"));
                json.addProperty("fecha_compra", this.content.getString("fecha_compra"));
                json.addProperty("importe", this.content.getString("subtotal_compra"));
                json.addProperty("iva_compra", this.content.getString("iva_compra"));
                json.addProperty("total", this.content.getString("total_compra"));
                json.addProperty("credito", this.content.getString("credito"));
                array.add(json);
                json = new JsonObject();
            }

            this.content = this.ejecutor.executeQuery(query);
            exportarReporte(2, content);
        } catch (JRException ex) {
            System.out.println("Formato no encontrado");
        } catch (SQLException sql) {
            System.out.println(sql);
        }
        return array;
    }

    public void exportarReporte(int tipo, ResultSet contenido) throws JRException {
        //Generación de Pdf
        String nombre;
        if (tipo == 1) {
            nombre = "ReporteVentas";
        } else {
            nombre = "ReporteCompras";
        }

        String location = "bambu\\contabilidad\\" + nombre + ".jasper";
        String logo = "bambu\\contabilidad\\logo.jpg";
        InputStream input = Thread.currentThread().getContextClassLoader().getResourceAsStream(location);
        String urlLogo = Thread.currentThread().getContextClassLoader().getResource(logo).getPath();
        this.reporte = (JasperReport) JRLoader.loadObject(input);
        Map<String, Object> parametros = new HashMap<String, Object>();
        parametros.put("realPath", urlLogo);
        jasperPrint = JasperFillManager.fillReport(reporte, parametros, new JRResultSetDataSource(content));
        JasperExportManager.exportReportToPdfFile(jasperPrint, nombre + ".pdf");
    }

}
