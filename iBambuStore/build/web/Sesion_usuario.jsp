<%-- 
    Document   : InicioSesion
    Created on : 5/06/2015, 09:20:08 PM
    Author     : Andrew
--%>

<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="bambu.otros.Usuario"%>
<%@page import="bambu.otros.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ID = request.getParameter("ID");
    HttpSession sesion = request.getSession(true);

    if (ID.equals("nuevo_usuario")) {
        JsonObject objson = new JsonObject();
        Login nuevo = new Login();
        String nombre = request.getParameter("nombre");
        File ruta = new File("usuarios");
        File file = new File(ruta, nombre + ".user");

        String contrasena = request.getParameter("contrasena");
        int privilegio_activo;
        if (request.getSession().getAttribute("usuario") == null) {
            privilegio_activo = 0;

        } else {
            privilegio_activo = ((Usuario) request.getSession().getAttribute("usuario")).getPrivilegio();

        }

        if (privilegio_activo == 0) {
            int hacer = nuevo.nuevoUsuario(file, nombre, contrasena, 0);
            if (hacer == 1) {
                File archivo = new File("usuarios\\" + nombre + ".user");
                sesion.setAttribute("usuario", nuevo.usuario);
                if (nuevo.iniciarSecion(archivo, nombre, contrasena)) {
                    objson.addProperty("estado", "creado");
                }
            } else if (hacer == 2) {
                objson.addProperty("estado", "no_creado");
            } else if (hacer == 3) {
                objson.addProperty("estado", "existente");
            }
        } else if (privilegio_activo == 1) {
            int privilegio = Integer.parseInt(request.getParameter("privilegio"));
            int hacer = nuevo.nuevoUsuario(file, nombre, contrasena, privilegio);
            if (hacer == 1) {
                objson.addProperty("estado", "creado");

            } else if (hacer == 2) {
                objson.addProperty("estado", "no_creado");

            } else if (hacer == 3) {
                objson.addProperty("estado", "existente");
            }
        }

        out.clearBuffer();
        out.println(objson);
    }
    if (ID.equals("inicio_sesion")) {
        JsonObject json = new JsonObject();
        Login login = new Login();
        String persona = request.getParameter("nombre");
        File archivo = new File("usuarios\\" + persona + ".user");
        String contrasena = request.getParameter("contrasena");
        if (login.iniciarSecion(archivo, persona, contrasena)) {
            sesion.setAttribute("usuario", login.usuario);
            json.addProperty("inicio", "ok");
        } else {
            json.addProperty("inicio", "no");
        }

        out.clearBuffer();
        out.println(json);
    }

    if (ID.equals("logout")) {
        JsonObject json = new JsonObject();
        sesion.invalidate();
        json.addProperty("sesion", "out");
        out.clearBuffer();
        out.println(json);
    }

%>
