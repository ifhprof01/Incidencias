package controlador;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilidades.Utilidades;

/**
 *
 * @author usuario
 */
public class ServletEnvioEmail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Utilidades.enviarCorreo(request.getParameter("origen"), 
                                    request.getParameter("contrasena"), // Contraseña de la cuenta uno@gmail.com
                                    "true",
                                    "true",
                                    "smtp.gmail.com",
                                    "587",
                                    request.getParameter("destinatario"),
                                    request.getParameter("asunto"),
                                    request.getParameter("contenido"));
            request.setAttribute("mensajeUsuario", "Incidencia enviada correctamente");
            request.getRequestDispatcher("listaincidencias.jsp").forward(request, response);
        } catch (Exception ex) {
            Utilidades.mensajeErrorLog(-1, "El correo electrónico no ha podido ser enviado: " + ex,null);
            request.setAttribute("mensajeUsuario", "El alta no se ha podido realizar. Consulte con el administrador");
            request.setAttribute("listaErrores", new ArrayList());
            request.getRequestDispatcher("envioemail.jsp").forward(request, response);
        }
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet NewServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
//            out.println("<p>"+request.getParameter("origen")+"</p>");
//            out.println("<p>"+request.getParameter("contrasena")+"</p>");
//            out.println("<p>"+request.getParameter("destinatario")+"</p>");
//            out.println("<p>"+request.getParameter("asunto")+"</p>");
//            out.println("<p>"+request.getParameter("contenido")+"</p>");
//            out.println("</body>");
//            out.println("</html>");
//        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    }

