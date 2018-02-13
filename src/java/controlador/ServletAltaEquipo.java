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
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utilidades.ExcepcionIncidencias;
import utilidades.Utilidades;

/**
 *
 * @author ifontecha
 */
public class ServletAltaEquipo extends HttpServlet {

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
                Equipo equipo =new Equipo();          
                equipo.setNumeroEtiquetaConsejeria((String) request.getParameter("numeroEtiquetaConsejeria"));
                TipoEquipo tipoequipo = new TipoEquipo();
                tipoequipo.setTipoEquipoId(Integer.parseInt(request.getParameter("tipoEquipoId")));
                equipo.setTipoEquipo(tipoequipo);
                iCAD.insertarEquipo(equipo);
                request.setAttribute("mensajeUsuario", "Equipo creado correctamente");
                request.getRequestDispatcher("listaequipos.jsp").forward(request, response);
            } else {
                Utilidades.mensajeErrorLog(-1, "Datos introducidos erróneos", null);
                request.setAttribute("mensajeUsuario", "El alta no se ha podido realizar. Errores detectados:");
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("altaequipo.jsp").forward(request, response);
            }
        } catch (ExcepcionIncidenciasCAD ex) {
            Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(), ex.getSentenciaSQL());
            request.setAttribute("mensajeUsuario", "El alta no se ha podido realizar. Errores detectados:");
            listaErrores.add(ex.getMensajeErrorUsuario());
            request.setAttribute("listaErrores", listaErrores);
            request.getRequestDispatcher("altaequipo.jsp").forward(request, response);
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
        if (Utilidades.convertirNullAStringVacio(request.getParameter("numeroEtiquetaConsejeria")).equals("")) {
            listaErrores.add("El numero de etiqueta es obligatorio");
        } else if (request.getParameter("numeroEtiquetaConsejeria").length() > 100) {
            listaErrores.add("La longitud maxima del numero de etiqueta es 100");
        } else {
            try {
                IncidenciasCAD iCAD = new IncidenciasCAD();
                Equipo equipo = iCAD.leerEquipo(request.getParameter("numeroEtiquetaConsejeria"));
              if (equipo == null) {
                    listaErrores.add("El sistema no reconoce la etiqueta del equipo introducida");
                }
            } catch (ExcepcionIncidenciasCAD ex) {
                listaErrores.add(ex.getMensajeErrorUsuario());
                Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(), ex.getSentenciaSQL());
            }
        }

        return listaErrores;
    }

}
