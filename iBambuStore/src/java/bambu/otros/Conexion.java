/*
 *Clase para la conexion al a base de datos
 */
package bambu.otros;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 * @author Andrew
 */
public class Conexion {

    private String usuario;
    private String password;
    private String bd;
    private String server;

    public Conexion() {
        this.bd = "bambu_store";
        this.server = "192.168.0.5";
        this.usuario = "Daniel_normal";
        this.password = "pestanias001";
    }

    public Connection conectar() {
        Connection conn=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn =DriverManager.getConnection("jdbc:mysql://" + this.server + "/" + this.bd , this.usuario,this.password);
            System.out.println("Conexion exitosa!");
        } catch (SQLException ex) {
            System.err.println("No se conecto, probando con otra configuracion ... ");
            this.password = "";
            try{
            conn =DriverManager.getConnection("jdbc:mysql://" + this.server + "/" + this.bd , this.usuario,this.password);
                System.out.println("Conexion exitosa!");
            }catch(SQLException sql){
                System.err.println("Oops! ocurrió algun problema con la BD" + sql.getMessage());
            }
        }
        catch(ClassNotFoundException clase){
            System.err.println("No se encotnro el driver" + clase.getMessage());
        }
        return conn;
    }
    
    public static void main(String[] args) {
        Conexion conexion1 =new Conexion();
        Connection test = conexion1.conectar();
        System.out.println(test);
    }
}
