
package bambu.otros;

import java.io.Serializable;

/**
 *
 * @author Andrew
 */
public class Usuario  implements Serializable {
    
    private String usuario;
    private String contrasena;
    private int privilegio;

    public int getPrivilegio() {
        return privilegio;
    }

    public void setPrivilegio(int privilegio) {
        this.privilegio = privilegio;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }
/*Te amo <3*/
    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }  
}
