package bambu.otros;

import java.io.Serializable;

/**
 *
 * @author Andrew
 */
public class Usuario {

    public Conexion conexion;
    public boolean activo;
    public Usuario(Conexion conexion,boolean activo) {
        this.conexion = conexion;
        this.activo = activo;

    }
}
