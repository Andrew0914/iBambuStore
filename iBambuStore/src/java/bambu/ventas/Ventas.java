package bambu.ventas;

import bambu.otros.Conexion;
import bambu.otros.Usuario;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Desktop;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.HashMap;

public class Ventas {

    public static HashMap<String, Double> detalles = new HashMap();
    private Statement ejecutor;
    private ResultSet rs;
    private int id_ultimaVenta;
    private int hasCodigo;
    private ResultSet venta_general;
    private ResultSet detallesVenta;
    private Usuario usuario;
    public Ventas(Usuario usuario) {
        this.usuario = usuario;
        this.id_ultimaVenta = 0;
        this.hasCodigo = 0;
    }

    public boolean setVenta(double total) {
        boolean respuesta = false;
        double subtotal = total / 1.16;
        double iva_venta = subtotal * 0.16;
        String nuevaVenta = "INSERT INTO ventas(fecha_venta,importe_venta,iva_venta,total_venta) values("
                + "DATE_FORMAT(CURRENT_DATE,'%Y-%m-%d'),'"
                + subtotal + "','"
                + iva_venta + "','"
                + total + "'"
                + ")";
        try {
            ejecutor = this.usuario.conexion.conectar().createStatement();
            ejecutor.execute(nuevaVenta);
            respuesta = true;
        } catch (SQLException ex) {
            System.out.println("Venta --> " + ex);
        }
        return respuesta;
    }

    public boolean setVentaDetalle() {
        boolean respuesta = false;
        String ultimaVenta = "Select MAX(id_venta) AS ultima_venta FROM ventas ";
        try {
            ejecutor = this.usuario.conexion.conectar().createStatement();
            rs = ejecutor.executeQuery(ultimaVenta);
            if (rs.next()) {
                this.id_ultimaVenta = rs.getInt("ultima_venta");
            }
            double current_precio = 0;
            double current_total = 0;
            double current_subtotal = 0;
            double current_iva = 0;
            String query_detalle;
            for (String cod : detalles.keySet()) {

                String obtenerPrecio = "SELECT precio_venta,hasCode FROM productos WHERE codigo_producto = '" + cod + "'";
                rs = ejecutor.executeQuery(obtenerPrecio);
                if (rs.next()) {
                    current_precio = rs.getDouble("precio_venta");
                    this.hasCodigo = rs.getInt("hasCode");
                }
                if (this.hasCodigo == 0) {
                    current_total = current_precio * detalles.get(cod);
                    current_subtotal = current_total;
                    current_iva = 0;
                } else if (this.hasCodigo == 1) {
                    current_total = current_precio * detalles.get(cod);
                    current_subtotal = current_total / 1.16;
                    current_iva = current_subtotal * 0.16;
                }
                query_detalle = new String("INSERT INTO `venta_detalle`(`codigo_producto`, `id_venta`, `cantidad_producto`, `importe_vdetalle`, `iva_vdetalle`, `total_vdetalle`) VALUES('"
                        + cod + "',"
                        + this.id_ultimaVenta + ","
                        + detalles.get(cod) + ","
                        + current_subtotal + ","
                        + current_iva + ","
                        + current_total + ")");

                this.ejecutor = this.usuario.conexion.conectar().createStatement();

                this.ejecutor.execute(query_detalle);

            }
            respuesta = true;

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        detalles.clear();
        return respuesta;
    }

    public void imprimirTickect() {
        DecimalFormat formato = new DecimalFormat("#.##");
        String ultimaVenta = "Select MAX(id_venta) AS ultima_venta FROM ventas ";
        int venta_ticket = 0;
        try {
            ejecutor = this.usuario.conexion.conectar().createStatement();
            rs = ejecutor.executeQuery(ultimaVenta);
            if (rs.next()) {
                venta_ticket = rs.getInt("ultima_venta");
                String datos_venta = "SELECT * FROM ventas where id_venta=" + venta_ticket;
                String datos_detalles = "SELECT  * FROM venta_detalle WHERE id_venta=" + venta_ticket;
                this.ejecutor = this.usuario.conexion.conectar().createStatement();
                this.venta_general = this.ejecutor.executeQuery(datos_venta);
                this.detallesVenta = this.ejecutor.executeQuery(datos_detalles);
            }
            File archivo = new File("ticket" + venta_ticket + ".pdf");
            archivo.createNewFile();
            Document ticket = new Document();
            FileOutputStream ticket_fisico = new FileOutputStream(archivo);

            PdfWriter.getInstance(ticket, ticket_fisico).setInitialLeading(20);
            ticket.open();
            Paragraph encabezado = new Paragraph(
                    "Venta " + venta_ticket + ""
                    + "            Fecha" + new java.util.Date() + "\n"
            );
            encabezado.setAlignment(Chunk.ALIGN_CENTER);
            ticket.add(encabezado);
            Paragraph espacio = new Paragraph("\n\n");
            ticket.add(espacio);
            Image foto = Image.getInstance("E:\\iBambuStore\\web\\imagen\\logo_bs.png");
            foto.setAlignment(Chunk.ALIGN_CENTER);
            foto.scaleToFit(100, 100);
            ticket.add(foto);
            ticket.add(espacio);
            PdfPTable detalles = new PdfPTable(5);
            detalles.addCell("Producto");
            detalles.addCell("Cantidad");
            detalles.addCell("Sub Total");
            detalles.addCell("IVA ");
            detalles.addCell("Total");
            double totalpdf=0.0, subtotalpdf=0.0,ivapdf=0.0;
            while (this.detallesVenta.next()) {
                totalpdf += this.detallesVenta.getDouble("total_vdeta");
                subtotalpdf += this.detallesVenta.getDouble("subtotal_vdeta");
                ivapdf +=  this.detallesVenta.getDouble("iva_dveta");
                detalles.addCell(this.detallesVenta.getString("id_producto"));
                detalles.addCell(formato.format(this.detallesVenta.getDouble("cantidad_productos")));
                detalles.addCell(formato.format(this.detallesVenta.getDouble("subtotal_vdeta")));
                detalles.addCell(formato.format(this.detallesVenta.getDouble("iva_dveta")));
                detalles.addCell(formato.format(this.detallesVenta.getDouble("total_vdeta")));
            }
            ticket.add(detalles);
            Paragraph totales = new Paragraph(
            "TOTALES : \n"
                    + "Sub Total : $" + formato.format(subtotalpdf) + "\n"
                    + "IVA venta : $" + formato.format(ivapdf) + "\n"
                    + "TOTAL venta: $" + formato.format(totalpdf)
            );
            ticket.add(espacio);
            ticket.add(totales);
            ticket.close();
            Desktop.getDesktop().open(archivo);
        } catch (SQLException ex) {
            System.out.println(ex.fillInStackTrace());
        } catch (DocumentException dx) {
            System.out.println(dx);
        } catch (FileNotFoundException fx) {
            System.out.println(fx);
        } catch (IOException iox) {
            System.out.println(iox);
        }

    }
}
