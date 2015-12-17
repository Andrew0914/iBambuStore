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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <title>Login BambuStore</title>\r\n");
      out.write("        <meta charset=\"UTF-8\">\r\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/estilos.css\">\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("        <ul id=\"login\">\r\n");
      out.write("            <li>\r\n");
      out.write("                <img src=\"imagen/logo_bs.png\">\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"text\" id=\"nombre\" placeholder=\"Usuario\">\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <input type=\"password\" id=\"contrasena\" placeholder=\"Password\">\r\n");
      out.write("            </li>\r\n");
      out.write("            <li>\r\n");
      out.write("                <button id=\"iniciar_sesion\">Iniciar sesi&oacute;n</button>\r\n");
      out.write("            </li>\r\n");
      out.write("            <!--<li>\r\n");
      out.write("                <button id=\"nuevo_usuario\">Nuevo Usuario</button>\r\n");
      out.write("            </li>->\r\n");
      out.write("        </ul>\r\n");
      out.write("        <!--<div id=\"pop\">\r\n");
      out.write("            <span id=\"close\"> X </span>\r\n");
      out.write("            <ul>\r\n");
      out.write("\r\n");
      out.write("                <li> <img src=\"imagen/add199.png\"> </li> \r\n");
      out.write("                <li><h3>Nuevo usuario</h3></li>\r\n");
      out.write("                <li>\r\n");
      out.write("                    <input type=\"text\" id=\"nuevo_nombre\" placeholder=\"Usuario\">\r\n");
      out.write("                </li>\r\n");
      out.write("                <li>\r\n");
      out.write("                    <input type=\"password\" id=\"nueva_contrasena\" placeholder=\"Password\">\r\n");
      out.write("                </li>\r\n");
      out.write("                <li>\r\n");
      out.write("                    <input type=\"password\" id=\"x_contrasena\" placeholder=\"Repetir password...\">\r\n");
      out.write("                </li>\r\n");
      out.write("                ");

                  /*  try{
                    
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
                    }*/
                    
                
      out.write("\r\n");
      out.write("                <li>\r\n");
      out.write("                    <button id=\"crear_usuario\"> Crear Usuario</button>\r\n");
      out.write("                </li>\r\n");
      out.write("\r\n");
      out.write("            </ul>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <div id=\"capa\"></div>-->\r\n");
      out.write("\r\n");
      out.write("        <script type=\"text/javascript\" src=\"javascript/jquery.js\"></script>\r\n");
      out.write("        <script type=\"text/javascript\" src=\"javascript/Sesion.js\"></script>\r\n");
      out.write("    </body>\r\n");
      out.write("</html>\r\n");
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
