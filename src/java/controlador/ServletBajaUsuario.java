/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import incidenciascad.Configuracion;
import incidenciascad.Estado;
import incidenciascad.ExcepcionIncidenciasCAD;
import incidenciascad.Historial;
import incidenciascad.Incidencia;
import incidenciascad.IncidenciasCAD;
import incidenciascad.Usuario;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilidades.ExcepcionIncidencias;
import utilidades.Utilidades;

/**
 *
 * @author ifontecha
 */
public class ServletBajaUsuario extends HttpServlet {

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
            Utilidades.verificarAdministrador(request);
            IncidenciasCAD iCAD = new IncidenciasCAD();
            iCAD.eliminarUsuario(Integer.parseInt(request.getParameter("usuarioId")));
            request.setAttribute("mensajeUsuario", "Usuario eliminado correctamente");
            request.getRequestDispatcher("listausuarios.jsp").forward(request, response);
        } catch (ExcepcionIncidenciasCAD ex) {
            Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(),ex.getSentenciaSQL());
            request.setAttribute("mensajeUsuario", ex.getMensajeErrorUsuario());
            request.setAttribute("listaErrores", new ArrayList());
            request.getRequestDispatcher("bajausuario.jsp").forward(request, response);
        } catch (ExcepcionIncidencias ex) {
            Utilidades.mensajeErrorLog(ex.getCodigoError(), ex.getMensajeErrorAdministrador(), null);
            request.setAttribute("mensajeUsuario", ex.getMensajeErrorUsuario());
            request.setAttribute("listaErrores", new ArrayList());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception ex) {
            Utilidades.mensajeErrorLog(-1, ex.getMessage(), null);
            request.setAttribute("mensajeUsuario", "Error general del sistema. Consulte al administrador");
            request.setAttribute("listaErrores", new ArrayList());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
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
