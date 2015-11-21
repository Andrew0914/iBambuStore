package bambu.otros;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class Login {

    public Usuario usuario;

    public Login() {
        usuario = new Usuario();
    }

    public int nuevoUsuario(File file, String nombre, String contrasena, int privilegio) {

        int respuesta = 0;
        usuario.setUsuario(nombre);
        usuario.setContrasena(contrasena);
        usuario.setPrivilegio(privilegio);

        FileOutputStream usuarioSerial = null;
        ObjectOutputStream objUsuario = null;

        if (file.exists()) {
            respuesta = 3;
        } else {
            try {
                file.createNewFile();
                usuarioSerial = new FileOutputStream(file);
                objUsuario = new ObjectOutputStream(usuarioSerial);
                objUsuario.writeObject(usuario);
                respuesta = 1;
            } catch (IOException io) {
                System.err.println("Ocurrio un error al serializar el usuario" + io.getMessage());
                respuesta = 2;
            } finally {
                try {
                    usuarioSerial.close();
                    objUsuario.close();
                } catch (IOException io) {
                    System.err.println("Se intentaron cerrar los flujos ... " + io.getMessage());
                    respuesta = 2;
                }
            }
        }
        return respuesta;
    }

    public boolean iniciarSecion(File file, String nombre, String contrasena) {
        boolean validado = false;
        FileInputStream archUsuario = null;
        ObjectInputStream objUsuario = null;
        if (file.exists()) {

            try {

                archUsuario = new FileInputStream(file);
                objUsuario = new ObjectInputStream(archUsuario);

                usuario = (Usuario) objUsuario.readObject();

                validado = usuario.getUsuario().equals(nombre) && usuario.getContrasena().equals(contrasena);

            } catch (IOException io) {
                System.err.println("Error con los flujos  " + io);

            } catch (ClassNotFoundException cnot) {
                System.err.println("Error no se encontro la clase" + cnot.getMessage());
            } finally {
                try {
                    archUsuario.close();
                    objUsuario.close();
                } catch (IOException io) {
                    System.err.println("Error al cerrar los flujos usuario" + io.getMessage());
                }
            }

        } else {
            System.out.println("no existe el archivo");
        }
        return validado;
    }

}
