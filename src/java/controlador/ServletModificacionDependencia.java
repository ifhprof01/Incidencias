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
import utilidades.Utilidades;

/**
 *
 * @author ifontecha
 */
public class ServletModificacionDependencia extends HttpServlet {

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
                Dependencia dependencia = iCAD.leerDependencia(Integer.parseInt(request.getParameter("dependenciaId")));
                dependencia.setDependenciaId(Integer.parseInt(request.getParameter("dependenciaId")));
                dependencia.setCodigo(request.getParameter("codigo"));
                dependencia.setNombre(request.getParameter("nombre"));
                iCAD.modificarDependencia(dependencia.getDependenciaId(),dependencia);
                request.setAttribute("mensajeUsuario", "Dependencia modificada correctamente");
                request.getRequestDispatcher("listadependencias.jsp").forward(request, response);
            } else {
                Utilidades.mensajeErrorLog(-1, "Datos introducidos erróneos",null);
                request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("modificaciondependencia.jsp").forward(request, response);
            }
        } catch (ExcepcionIncidenciasCAD ex) {
                Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(),ex.getSentenciaSQL());
                request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
                listaErrores.add(ex.getMensajeErrorUsuario());
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("modificaciondependencia.jsp").forward(request, response);
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
        if (Utilidades.convertirStringVacioANull(request.getParameter("codigo")) == null)
            listaErrores.add("El codigo es obligatorio");
        else if (request.getParameter("codigo").length() > 10)
            listaErrores.add("La longitud maxima del codigo es 10");
        
        if (Utilidades.convertirStringVacioANull(request.getParameter("nombre")) == null)
            listaErrores.add("El nombre es obligatorio");
        else if (request.getParameter("nombre").length() > 100)
            listaErrores.add("La longitud maxima del nombre es 100");
        
        return listaErrores;
    }

}
