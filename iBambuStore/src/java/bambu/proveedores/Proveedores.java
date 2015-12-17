/*
 *BambuStore
 *Clase para gestionar los proveedores y reportar el dinero que salio en compra de mercancia
 */
package bambu.proveedores;

import bambu.otros.Conexion;
import bambu.otros.Usuario;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Andrew
 */
public class Proveedores {

    private String empresa;
    public Usuario usuario;
    private Statement ejecutor;
    private ResultSet rs;

    public Proveedores(String empresa,Usuario usuario) {
        this.empresa = empresa;
        this.usuario= usuario;
    }

    public Proveedores(Usuario usuario) {

        this.usuario = usuario;
    }

    public JsonArray getProveedor() {
        JsonObject json = new JsonObject();
        JsonArray arr = new JsonArray();
        String query = "SELECT * FROM proveedores WHERE empresa LIKE '%" + this.empresa + "%'";
        try {
            this.ejecutor = this.usuario.conexion.conectar().createStatement();
            this.rs = this.ejecutor.executeQuery(query);
            while (rs.next()) {
                json.addProperty("id_proveedor", rs.getString("id_proveedor"));
                json.addProperty("empresa", rs.getString("empresa"));
                json.addProperty("telefono", rs.getString("telefono"));
                json.addProperty("nombre_distribuidor", rs.getString("nombre_distribuidor"));
                json.addProperty("apaterno_distribuidor", rs.getString("apaterno_distribuidor"));
                json.addProperty("amaterno_distribuidor", rs.getString("amaterno_distribuidor"));
                arr.add(json);
                json = new JsonObject();
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return arr;
    }

    public boolean updateProveedor(String data) {
        boolean respuesta = false;
        String query = "";
        String[] rows = data.split(";");

        for (int i = 0; i < rows.length; i++) {
            String[] dato = rows[i].split(",");
            query += "UPDATE proveedores SET ";
            query += "empresa='" + dato[1] + "',";
            query += "telefono=" + dato[2] + ",";
            query += "nombre_distribuidor='" + dato[3] + "',";
            query += "apaterno_distribuidor='" + dato[4] + "',";
            query += "amaterno_distribuidor='" + dato[5] + "' ";
            query += " WHERE id_proveedor='" + dato[0] + "'";

            try {
                this.ejecutor = this.usuario.conexion.conectar().createStatement();
                System.out.println(query);
                this.ejecutor.execute(query);
                query = new String();
            } catch (SQLException ex) {
                System.out.println("No se actualizo proveedor " + ex);
            }
        }
        respuesta = true;
        return respuesta;
    }

    public boolean borrarUnProveedor(int id) {
        boolean resultado = false;
        String query = "DELETE FROM proveedores WHERE id_proveedor='" + id + "'";
        try {
            this.ejecutor = this.usuario.conexion.conectar().createStatement();
            this.ejecutor.execute(query);
            resultado = true;
        } catch (SQLException x) {
            System.out.println(x);
        }
        return resultado;

    }

    public boolean insertarProveedor(String empresa, String telefono, String distribuidor, String paterno,String materno) {
        boolean respuesta = false;
        String query = "INSERT INTO proveedores(empresa,telefono,nombre_distribuidor,apaterno_distribuidor,amaterno_distribuidor) values('"
                + empresa + "','"
                + telefono + "','"
                + distribuidor + "','"
                + paterno + "','"
                + materno + "')";
        try{
        this.ejecutor =this.usuario.conexion.conectar().createStatement();
        this.ejecutor.execute(query);
        }catch(SQLException ex){System.out.println(ex);}
        respuesta = true;
        return respuesta;
    }
}
