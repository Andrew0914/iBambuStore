/*
 *Clase para la conexion al a base de datos
solo agregue este comentario para probar un commit en github
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
    private Connection con;
    

    public Conexion(String usr, String pass) {
        this.bd = "mysql";
        this.server = "localhost";
        this.usuario = usr;
        this.password = pass;
    }

    public Connection conectar() {
        Connection conn=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn =DriverManager.getConnection("jdbc:mysql://" + this.server + "/" + this.bd , this.usuario,this.password);
            System.out.println("Conexion exitosa!");
        } catch (SQLException ex) {
        }
        catch(ClassNotFoundException clase){
            System.err.println("No se encotnro el driver" + clase.getMessage());
        }
        return conn;
    }
    
    public static void main(String[] args) {
        
        Conexion conexion1 =new Conexion("andy","1234");
        Connection prueba = conexion1.conectar();
        System.out.println(prueba);
    }
}
