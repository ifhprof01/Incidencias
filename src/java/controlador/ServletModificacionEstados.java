/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import incidenciascad.Estado;
import incidenciascad.ExcepcionIncidenciasCAD;
import incidenciascad.IncidenciasCAD;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.LogManager;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilidades.Utilidades;

/**
 *
 * @author Alberto Martínez - Pilar Sánchez
 */
public class ServletModificacionEstados extends HttpServlet {

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
        ArrayList<String> listaErrores = detectarErroresFormulario(request);
        try {
            if (listaErrores.isEmpty()) {
                IncidenciasCAD iCAD = new IncidenciasCAD();
                Estado estado = iCAD.leerEstado(Integer.parseInt(request.getParameter("estadoId")));
                estado.setCodigo(request.getParameter("estadoCodigo"));
                estado.setNombre(request.getParameter("estadoNombre"));
                iCAD.modificarEstado(estado.getEstadoId(),estado);
                request.setAttribute("mensajeUsuario", "Estado modificado correctamente");
                request.getRequestDispatcher("listaestados.jsp").forward(request, response);
            } else {
                Utilidades.mensajeErrorLog(-1, "Datos introducidos erróneos",null);
                request.setAttribute("mensajeUsuario", "La modificacion no se ha podido realizar. Errores detectados:");
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("modificacionestado.jsp").forward(request, response);
            }
        } catch (ExcepcionIncidenciasCAD ex) {
                Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(),ex.getSentenciaSQL());
                request.setAttribute("mensajeUsuario", "La modificacion no se ha podido realizar. Errores detectados:");
                listaErrores.add(ex.getMensajeErrorUsuario());
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("modificacionestado.jsp").forward(request, response);
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

    protected ArrayList<String> detectarErroresFormulario(HttpServletRequest request) {
        ArrayList<String> listaErrores = new ArrayList();
        if (Utilidades.convertirStringVacioANull(request.getParameter("estadoCodigo")) == null)
            listaErrores.add("El código del estado es obligatorio");
        else if (request.getParameter("estadoCodigo").length() > 10)
            listaErrores.add("La longitud maxima del código de estado es 10");
        if (Utilidades.convertirStringVacioANull(request.getParameter("estadoNombre")) == null)
            listaErrores.add("El nombre del estado es obligatorio");
        else if (request.getParameter("estadoNombre").length() > 100)
            listaErrores.add("La longitud maxima del nombre de estado es 100");
        return listaErrores;
    }

}