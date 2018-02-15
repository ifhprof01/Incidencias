/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import incidenciascad.Configuracion;
import incidenciascad.ExcepcionIncidenciasCAD;
import incidenciascad.IncidenciasCAD;
import incidenciascad.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;
import javax.naming.AuthenticationException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utilidades.Autenticador;

/**
 *
 * @author ifontecha
 */
public class ServletControlAcceso extends HttpServlet {

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
            String cuenta = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");

            IncidenciasCAD iCAD = new IncidenciasCAD();
            Usuario usuario;
            Boolean admin;
            ArrayList<Usuario> listaUsuarios = iCAD.leerUsuarios(cuenta, null, null, null, null, null);

            ServletContext contextoAplicacion = request.getServletContext();
            String usuarioEmergencia = contextoAplicacion.getInitParameter("usuarioEmergencia");
            String contrasenaEmergencia = contextoAplicacion.getInitParameter("contrasenaEmergencia");
            
            if (cuenta.equals(usuarioEmergencia) && contrasena.equals(contrasenaEmergencia)) {
                if (listaUsuarios.isEmpty()) {
                    usuario = new Usuario();
                    usuario.setCuenta(cuenta);
                    usuario.setNombre("Administrador");
                    usuario.setApellido("Emergencia");
                    usuario.setDepartamento("Desconocido");
                    iCAD.insertarUsuario(usuario);
                    listaUsuarios = iCAD.leerUsuarios(cuenta, null, null, null, null, null);
                    if (listaUsuarios.isEmpty()) throw new Exception("No se puede leer un usuario que se acaba de crear");
                }
                usuario = listaUsuarios.get(0);
                admin = true;
            } else {
                ArrayList<Configuracion> listaConfiguracion = iCAD.leerConfiguracion();
                if (listaConfiguracion.isEmpty()) throw new Exception("No hay registros en la tabla configuracion de la base de datos");
                Configuracion configuracion = listaConfiguracion.get(0);
                Autenticador a = new Autenticador(
                        configuracion.getLdapDominio(),
                        configuracion.getLdapUrl(),
                        configuracion.getLdapDn()
    //                    "iesmhp.local", "ldap://10.0.1.48","dc=iesmhp,dc=local"
                );

                String atributos[] = {configuracion.getLdapAtributoPerfil(), configuracion.getLdapAtributoCuenta(), configuracion.getLdapAtributoNombre(), configuracion.getLdapAtributoApellido(), configuracion.getLdapAtributoDepartamento()};
    //            String atributos[] = {"title", "givenName", "mail", "sn", "name", "department"};

                Map m = a.autenticar(cuenta, contrasena, atributos);

                if (listaUsuarios.isEmpty()) {
                    usuario = new Usuario();
                    usuario.setCuenta(cuenta);
                    usuario.setNombre((String )m.get("name"));
                    usuario.setApellido((String )m.get("sn"));
                    usuario.setDepartamento((String )m.get("department"));
                    iCAD.insertarUsuario(usuario);
                    listaUsuarios = iCAD.leerUsuarios(cuenta, null, null, null, null, null);
                    if (listaUsuarios.isEmpty()) throw new Exception("No se puede leer un usuario que se acaba de crear");
                }
                usuario = listaUsuarios.get(0);
                admin = false;
                if (m.get("title") != null) admin = ((String )m.get("title")).equals("AI");
            }

            
            HttpSession session = request.getSession(true);
            session.setAttribute("usuarioSesion", usuario);
            session.setAttribute("admin", admin);
            
            request.getRequestDispatcher("listaincidencias.jsp").forward(request, response);
//        } catch (AuthenticationException ex) {
        } catch (Exception ex) {
            request.setAttribute("mensajeUsuario", "Acceso denegado: las credenciales son erróneas");
            request.setAttribute("listaErrores", new ArrayList<String>());

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
