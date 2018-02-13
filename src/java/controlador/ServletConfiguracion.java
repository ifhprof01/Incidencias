/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import incidenciascad.Configuracion;
import incidenciascad.Estado;
import incidenciascad.ExcepcionIncidenciasCAD;
import incidenciascad.IncidenciasCAD;
import java.io.IOException;
import java.util.ArrayList;
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
public class ServletConfiguracion extends HttpServlet {

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
                ArrayList<Configuracion> listaConfiguracion = iCAD.leerConfiguracion();
                Estado estadoInicial=new Estado();
                estadoInicial.setEstadoId(Integer.parseInt(request.getParameter("estadoInicial")));
                Estado estadoFinal=new Estado();
                estadoFinal.setEstadoId(Integer.parseInt(request.getParameter("estadoFinal")));
                
                Configuracion configuracion = new Configuracion(request.getParameter("empresaConsejeriaNombre"),request.getParameter("empresaConsejeriaTelefono"),request.getParameter("empresaConsejeriaEmail"), request.getParameter("iesNombre"),request.getParameter("iesCif"),request.getParameter("iesCodigoCentro"),request.getParameter("iesPersonaContactoNombre"),request.getParameter("iesPersonaContactoApellido1"),request.getParameter("iesPersonaContactoApellido2"),request.getParameter("iesEmail"),estadoInicial,estadoFinal,request.getParameter("ldapUrl"),request.getParameter("ldapDominio"),request.getParameter("ldapDn"),request.getParameter("ldapAtributoCuenta"),request.getParameter("ldapAtributoNombre"),request.getParameter("ldapAtributoApellido"),request.getParameter("ldapAtributoDepartamento"),request.getParameter("ldapAtributoPerfil"));
               

                iCAD.establecerConfiguracion(configuracion);
                request.setAttribute("mensajeUsuario", "Configuración establecida correctamente");
                request.getRequestDispatcher("configuracion.jsp").forward(request, response);
            } else {
                Utilidades.mensajeErrorLog(-1, "Datos introducidos erróneos", null);
                request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
                request.setAttribute("listaErrores", listaErrores);
                request.getRequestDispatcher("configuracion.jsp").forward(request, response);
            }
        } catch (ExcepcionIncidenciasCAD ex) {
            Utilidades.mensajeErrorLog(ex.getCodigoErrorSistema(), ex.getMensajeErrorSistema(), ex.getSentenciaSQL());
            request.setAttribute("mensajeUsuario", "La modificación no se ha podido realizar. Errores detectados:");
            listaErrores.add(ex.getMensajeErrorUsuario());
            request.setAttribute("listaErrores", listaErrores);
            request.getRequestDispatcher("configuracion.jsp").forward(request, response);
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
        if (Utilidades.convertirStringVacioANull(request.getParameter("empresaConsejeriaNombre")) == null) {
            listaErrores.add("El nombre de la empresa es obligatorio");
        } else if (request.getParameter("empresaConsejeriaNombre").length() > 100) {
            listaErrores.add("La longitud maxima del nombre de la empresa es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("empresaConsejeriaTelefono")) == null) {
            listaErrores.add("El telefono de la empresa es obligatorio");
        } else if (request.getParameter("empresaConsejeriaTelefono").length() > 100) {
            listaErrores.add("La longitud maxima del teléfono de la empresa es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("empresaConsejeriaEmail")) == null) {
            listaErrores.add("El email de la empresa es obligatorio");
        } else if (request.getParameter("empresaConsejeriaEmail").length() > 100) {
            listaErrores.add("La longitud maxima del email de la empresa es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesNombre")) == null) {
            listaErrores.add("El nombre del IES es obligatorio");
        } else if (request.getParameter("iesNombre").length() > 100) {
            listaErrores.add("La longitud maxima del nombre del IES es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesCif")) == null) {
            listaErrores.add("El CIF del IES es obligatorio");
        } else if (request.getParameter("iesCif").length() > 100) {
            listaErrores.add("La longitud maxima del CIF del IES es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesCodigoCentro")) == null) {
            listaErrores.add("El código del centro es obligatorio");
        } else if (request.getParameter("iesCodigoCentro").length() > 100) {
            listaErrores.add("La longitud maxima del código del centro es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesPersonaContactoNombre")) == null) {
            listaErrores.add("El nombre de la persona de contacto del IES es obligatorio");
        } else if (request.getParameter("iesPersonaContactoNombre").length() > 100) {
            listaErrores.add("La longitud maxima del código del nombre de la persona de contacto del IES es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesPersonaContactoApellido1")) == null) {
            listaErrores.add("El apellido1 de la persona de contacto del IES es obligatorio");
        } else if (request.getParameter("iesPersonaContactoApellido1").length() > 100) {
            listaErrores.add("La longitud maxima del código del apellido1 de la persona de contacto del IES es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesPersonaContactoApellido2")) == null) {
            listaErrores.add("El apellido2 de la persona de contacto del IES es obligatorio");
        } else if (request.getParameter("iesPersonaContactoApellido2").length() > 100) {
            listaErrores.add("La longitud maxima del código del apellido2 de la persona de contacto del IES es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesEmail")) == null) {
            listaErrores.add("El email del IES es obligatorio");
        } else if (request.getParameter("iesEmail").length() > 100) {
            listaErrores.add("La longitud maxima del email del IES es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("iesEmail")) == null) {
            listaErrores.add("El email del IES es obligatorio");
        } else if (request.getParameter("iesEmail").length() > 100) {
            listaErrores.add("La longitud maxima del email del IES es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("estadoInicial")) == null) {
            listaErrores.add("El estado inicial de las incidencias es obligatorio");
        } else if (request.getParameter("estadoInicial").length() > Integer.MAX_VALUE) {
            listaErrores.add("El valor maximo del indentificador de estado es " + Integer.MAX_VALUE);
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("estadoFinal")) == null) {
            listaErrores.add("El estado final de las incidencias es obligatorio");
        } else if (request.getParameter("estadoFinal").length() > Integer.MAX_VALUE) {
            listaErrores.add("El valor maximo del indentificador de estado es " + Integer.MAX_VALUE);
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapUrl")) == null) {
            listaErrores.add("La URL del LDAP es obligatoria");
        } else if (request.getParameter("ldapUrl").length() > 200) {
            listaErrores.add("La longitud maxima de la URL del LDAP es 200");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapDominio")) == null) {
            listaErrores.add("El dominio del LDAP es obligatorio");
        } else if (request.getParameter("ldapDominio").length() > 100) {
            listaErrores.add("La longitud maxima del dominio del LDAP es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapDn")) == null) {
            listaErrores.add("El Dn del LDAP es obligatorio");
        } else if (request.getParameter("ldapDn").length() > 100) {
            listaErrores.add("La longitud maxima del Dn del LDAP es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapAtributoCuenta")) == null) {
            listaErrores.add("La cuenta asociada al LDAP es obligatoria");
        } else if (request.getParameter("ldapAtributoCuenta").length() > 100) {
            listaErrores.add("La longitud de la cuenta asociada al LDAP es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapAtributoNombre")) == null) {
            listaErrores.add("El nombre asociado al LDAP es obligatorio");
        } else if (request.getParameter("ldapAtributoNombre").length() > 100) {
            listaErrores.add("La longitud del nombre asociado al LDAP es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapAtributoApellido")) == null) {
            listaErrores.add("El apellido asociado al LDAP es obligatorio");
        } else if (request.getParameter("ldapAtributoApellido").length() > 100) {
            listaErrores.add("La longitud del apellido asociado al LDAP es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapAtributoDepartamento")) == null) {
            listaErrores.add("El departamento asociado al LDAP es obligatorio");
        } else if (request.getParameter("ldapAtributoDepartamento").length() > 100) {
            listaErrores.add("La longitud del departamento asociado al LDAP es 100");
        }
        if (Utilidades.convertirStringVacioANull(request.getParameter("ldapAtributoPerfil")) == null) {
            listaErrores.add("El perfil asociado al LDAP es obligatorio");
        } else if (request.getParameter("ldapAtributoPerfil").length() > 100) {
            listaErrores.add("La longitud del perfil asociado al LDAP es 100");
        }
        return listaErrores;
    }

}
