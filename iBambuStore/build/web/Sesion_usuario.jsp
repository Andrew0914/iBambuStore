<%-- 
    Document   : InicioSesion
    Created on : 5/06/2015, 09:20:08 PM
    Author     : Andrew
--%>

<%@page import="bambu.otros.Conexion"%>
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

    if (ID.equals("inicio_sesion")) {
        String nombre = request.getParameter("nombre");
        String contrasena = request.getParameter("contrasena");
        Conexion conexion = new Conexion(nombre, contrasena);
        conexion.conectar();
        sesion.setAttribute("usuario", conexion.user);
        JsonObject json = new JsonObject();
        json.addProperty("sesion", "in");
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
