/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import incidenciascad.Dependencia;
import incidenciascad.Equipo;
import incidenciascad.Estado;
import incidenciascad.ExcepcionIncidenciasCAD;
import incidenciascad.Incidencia;
import incidenciascad.IncidenciasCAD;
import incidenciascad.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
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
public class ServletModificacionIncidencia extends HttpServlet {

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
                Incidencia incidencia = iCAD.leerIncidencia(Integer.parseInt(request.getParameter("incidenciaId")));
                Equipo equipo = iCAD.leerEquipo(request.getParameter("numeroEtiquetaConsejeria"));
                Estado estado = new Estado(Integer.parseInt(request.getParameter("estadoId")),null,null);
                incidencia.setPosicionEquipoDependencia(request.getParameter("posicionEquipoDependencia"));
                incidencia.setComentarioAdministrador(request.getParameter("comentarioAdministrador"));
                incidencia.setEquipo(equipo);
                incidencia.setEstado(estado);
                incidencia.setDependencia(new Dependencia(Integer.parseInt(request.getParameter("dependenciaId")),null,null));
                incidencia.setEstado(estado);
                iCAD.modificarIncidencia(incidencia.getIncidenciaId(),incidencia);
                request.setAttribute("mensajeUsuario", "Incidencia modificada correctamente");
                request.getRequestDispatcher("listaincidencias.jsp").forward(request, response);
            } else {
                Utilidades.mensajeErrorLog(-1, "Datos introducidos erróneos",null);
                request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("modificacionincidencia.jsp").forward(request, response);
            }
        } catch (ExcepcionIncidenciasCAD ex) {
            Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(),ex.getSentenciaSQL());
            request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
            listaErrores.add(ex.getMensajeErrorUsuario());
            request.setAttribute("listaErrores", listaErrores);
            request.getRequestDispatcher("modificacionincidencia.jsp").forward(request, response);
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
        else {
            try {
                IncidenciasCAD iCAD = new IncidenciasCAD();
                Equipo equipo = iCAD.leerEquipo(request.getParameter("numeroEtiquetaConsejeria"));
                if (equipo == null) {
                    listaErrores.add("El sistema no reconoce la etiqueta del equipo introducida");
                }
            } catch(ExcepcionIncidenciasCAD ex) {
                listaErrores.add(ex.getMensajeErrorUsuario());
                Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(), ex.getSentenciaSQL());
            }
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("dependenciaId")) == null)
            listaErrores.add("La dependencia de la incidencia es obligatoria");
        else if (request.getParameter("dependenciaId").length() > Integer.MAX_VALUE)
            listaErrores.add("El valor maximo del identificador de dependencia es " + Integer.MAX_VALUE);
        if (Utilidades.convertirStringVacioANull(request.getParameter("posicionEquipoDependencia")) != null)
        if (request.getParameter("posicionEquipoDependencia").length() > 500)
            listaErrores.add("La longitud maxima de la posicion del equipo en la dependencia es 500");
        if (Utilidades.convertirStringVacioANull(request.getParameter("estadoId")) == null)
            listaErrores.add("El estado de la incidencia es obligatorio");
        else if (request.getParameter("estadoId").length() > Integer.MAX_VALUE)
            listaErrores.add("El valor maximo del identificador de estado es " + Integer.MAX_VALUE);
        return listaErrores;
    }

}
