/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import incidenciascad.Usuario;
import incidenciascad.ExcepcionIncidenciasCAD;
import incidenciascad.IncidenciasCAD;
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
public class ServletModificacionUsuario extends HttpServlet {

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
                Usuario usuario = iCAD.leerUsuario(Integer.parseInt(request.getParameter("usuarioId")));
                usuario.setCuenta(request.getParameter("codigoCuentaUsuario"));
                usuario.setNombre(request.getParameter("nombreUsuario"));
                usuario.setApellido(request.getParameter("apellidoUsuario"));
                usuario.setDepartamento(request.getParameter("departamentoUsuario"));
                iCAD.modificarUsuario(usuario.getUsuarioId(), usuario);
                request.setAttribute("mensajeUsuario", "Usuario modificado correctamente");
                request.getRequestDispatcher("listausuarios.jsp").forward(request, response);
            } else {
                Utilidades.mensajeErrorLog(-1, "Datos introducidos erróneos", null);
                request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("modificacionusuario.jsp").forward(request, response);
            }
        } catch (ExcepcionIncidenciasCAD ex) {
            Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(), ex.getSentenciaSQL());
            request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
            listaErrores.add(ex.getMensajeErrorUsuario());
            request.setAttribute("listaErrores", listaErrores);
            request.getRequestDispatcher("modificacionusuario.jsp").forward(request, response);
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
        if (Utilidades.convertirStringVacioANull(request.getParameter("codigoCuentaUsuario")) == null) {
            listaErrores.add("La cuenta es obligatoria");
        } else if (request.getParameter("codigoCuentaUsuario").length() > 100) {
            listaErrores.add("La longitud maxima de la cuenta es 100");
        } else {
            try {
                IncidenciasCAD iCAD = new IncidenciasCAD();
                ArrayList<Usuario> usuarios = iCAD.leerUsuarios();
                boolean repetido = false;
                for (int i = 0; i < usuarios.size(); i++) {
                    Usuario usuario = new Usuario();
                    usuario = usuarios.get(i);
                    if(usuario.getCuenta() == request.getParameter("codigoCuentaUsuario")){
                        repetido = true;
                    }
                }
                if (repetido == true) {
                    listaErrores.add("El sistema no puede introducir un codigo LDAP repetido");
                }
            } catch (ExcepcionIncidenciasCAD ex) {
                listaErrores.add(ex.getMensajeErrorUsuario());
                Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(), ex.getSentenciaSQL());
            }
        }
        if (request.getParameter("nombreUsuario").length() > 100) {
            listaErrores.add("La longitud máxima del nombre del usuario es de 100");
        }
        if (request.getParameter("apellidoUsuario").length() > 100) {
            listaErrores.add("La longitud máxima del apellido del usuario es de 100 ");
        }
        return listaErrores;
    }
}
