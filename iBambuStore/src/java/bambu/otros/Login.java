package bambu.otros;

import bambu.otros.Login;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Login extends Conexion{
    
    public Login(String usr, String pass) {
        super(usr, pass);
    }

    public boolean autenticacion(String usr, String pass) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try{
            String consulta = "select *from user where User = ? and Password = ?";
            pst = conectar().prepareStatement(consulta);
            pst.setString(1,usr);
            pst.setString(2,pass);
            rs = pst.executeQuery();
            
            if(rs.absolute(1)){
                return true;
            }
            
        } catch (Exception ex) {
            System.out.println("Error"+ ex);
        }
        
        return false;
    }
    
    public static void main(String[] args) {
        Login log = new Login("root","");
        System.out.println(log.autenticacion("root","" ));
        System.out.println("");
    }
}