package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import bambu.otros.Usuario;

public final class Bambu_005fLogin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>Login BambuStore</title>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/estilos.css\">\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <ul id=\"login\">\n");
      out.write("            <li>\n");
      out.write("                <img src=\"imagen/logo_bs.png\">\n");
      out.write("            </li>\n");
      out.write("            <li>\n");
      out.write("                <input type=\"text\" id=\"nombre\" placeholder=\"Usuario\">\n");
      out.write("            </li>\n");
      out.write("            <li>\n");
      out.write("                <input type=\"password\" id=\"contrasena\" placeholder=\"Password\">\n");
      out.write("            </li>\n");
      out.write("            <li>\n");
      out.write("                <button id=\"iniciar_sesion\">Iniciar sesi&oacute;n</button>\n");
      out.write("            </li>\n");
      out.write("            <li>\n");
      out.write("                <button id=\"nuevo_usuario\">Nuevo Usuario</button>\n");
      out.write("            </li>\n");
      out.write("        </ul>\n");
      out.write("        <div id=\"pop\">\n");
      out.write("            <span id=\"close\"> X </span>\n");
      out.write("            <ul>\n");
      out.write("\n");
      out.write("                <li> <img src=\"imagen/add199.png\"> </li> \n");
      out.write("                <li><h3>Nuevo usuario</h3></li>\n");
      out.write("                <li>\n");
      out.write("                    <input type=\"text\" id=\"nuevo_nombre\" placeholder=\"Usuario\">\n");
      out.write("                </li>\n");
      out.write("                <li>\n");
      out.write("                    <input type=\"password\" id=\"nueva_contrasena\" placeholder=\"Password\">\n");
      out.write("                </li>\n");
      out.write("                <li>\n");
      out.write("                    <input type=\"password\" id=\"x_contrasena\" placeholder=\"Repetir password...\">\n");
      out.write("                </li>\n");
      out.write("                ");

                    try{
                    
                    int puede = ((Usuario) request.getSession().getAttribute("usuario")).getPrivilegio();
                    if (puede == 1) {
                        out.println("<li>"
                                + "Administrador: <input type='radio' id='admin'>"
                                + "<br> <br>"
                                + "Tendero : <input type=´'radio' id='tendero'> "
                                + " <br> <br>"
                                + "</li>");
                    }
                    }catch(NullPointerException n){
                        //System.out.println("No hay sesion activa");
                    }
                    
                
      out.write("\n");
      out.write("                <li>\n");
      out.write("                    <button id=\"crear_usuario\"> Crear Usuario</button>\n");
      out.write("                </li>\n");
      out.write("\n");
      out.write("            </ul>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div id=\"capa\"></div>\n");
      out.write("\n");
      out.write("        <script type=\"text/javascript\" src=\"javascript/jquery.js\"></script>\n");
      out.write("        <script type=\"text/javascript\" src=\"javascript/Sesion.js\"></script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
