/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import incidenciascad.Equipo;
import incidenciascad.ExcepcionIncidenciasCAD;
import incidenciascad.IncidenciasCAD;
import incidenciascad.TipoEquipo;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utilidades.ExcepcionIncidencias;
import utilidades.Utilidades;

/**
 *
 * @author usuario
 */
public class ServletModificacionEquipo extends HttpServlet {

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
        ArrayList<String> listaErrores = new ArrayList();
        try {
            Utilidades.verificarAdministrador(request);
            listaErrores = detectarErroresFormulario(request);
            if (listaErrores.isEmpty()) {
                IncidenciasCAD iCAD = new IncidenciasCAD();
                Equipo equipo = iCAD.leerEquipo(Integer.parseInt(request.getParameter("equipoId")));

                equipo.setNumeroEtiquetaConsejeria((String)request.getParameter("numeroEtiquetaConsejeria"));

                TipoEquipo tipoEquipo = new TipoEquipo();
                tipoEquipo.setTipoEquipoId(Integer.parseInt(request.getParameter("tipoEquipoId")));
                equipo.setTipoEquipo(tipoEquipo);

                iCAD.modificarEquipo(equipo.getEquipoId(), equipo);
                
                request.setAttribute("mensajeUsuario", "Equipo modificado correctamente");
                request.getRequestDispatcher("listaequipos.jsp").forward(request, response);
            } else {
                Utilidades.mensajeErrorLog(-1, "Datos introducidos erróneos",null);
                request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("modificacionequipo.jsp").forward(request, response);
            }
        } catch (ExcepcionIncidenciasCAD ex) {
            request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
            listaErrores.add(ex.getMensajeErrorUsuario());
            request.setAttribute("listaErrores", listaErrores);
            request.getRequestDispatcher("modificacionequipo.jsp").forward(request, response);
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

    
    protected ArrayList<String> detectarErroresFormulario(HttpServletRequest request) {
        ArrayList<String> listaErrores = new ArrayList();
        if (Utilidades.convertirStringVacioANull(request.getParameter("numeroEtiquetaConsejeria")) == null)
            listaErrores.add("El numero de etiqueta es obligatorio");
        else if (request.getParameter("numeroEtiquetaConsejeria").length() > 100)
            listaErrores.add("La longitud maxima del numero de etiqueta es 100");
        else if (Utilidades.convertirStringVacioANull(request.getParameter("tipoEquipoId")) == null)
            listaErrores.add("Tipo de Equipo no puede ser nulo");
        else {
            try {
                IncidenciasCAD iCAD = new IncidenciasCAD();
                
            } catch(ExcepcionIncidenciasCAD ex) {
                listaErrores.add(ex.getMensajeErrorUsuario());
                Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(), ex.getSentenciaSQL());
            }
        }
        return listaErrores;
    }
    
}
