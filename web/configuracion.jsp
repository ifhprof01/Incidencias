<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Configuracion"%>
<%@page import="incidenciascad.Historial"%>
<%@page import="incidenciascad.Estado"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

<%
    IncidenciasCAD iCAD = new IncidenciasCAD();
    ArrayList<Configuracion> listaConfiguracion = iCAD.leerConfiguracion();
    Configuracion configuracion=null;
    if(listaConfiguracion!=null){
            configuracion = listaConfiguracion.get(0);
    }
    
%>
<div id="content">
    <h2 class="formulario">Configuración</h2>
    <%@include file="includes/mensajeusuario.jsp" %>
    <form action="ServletConfiguracion" method="post" name="configuracion">
        <p class="formulario"><label>Nombre empresa conserjeria:</label></p>
        <p class="formulario"><input name="empresaConsejeriaNombre" type="text" value="<%=configuracion.getEmpresaConsejeriaNombre()%>"/></p>
        <p class="formulario"><label>Telefono empresa conserjeria:</label></p>
        <p class="formulario"><input name="empresaConsejeriaTelefono" type="text" value="<%=configuracion.getEmpresaConsejeriaTelefono()%>"/></p>
        <p class="formulario"><label>Email empresa conserjeria:</label></p>
        <p class="formulario"><input name="empresaConsejeriaEmail" type="text" value="<%=configuracion.getEmpresaConsejeriaEmail()%>"/></p>
        <p class="formulario"><label>Nombre del IES:</label></p>
        <p class="formulario"><input name="iesNombre" type="text" value="<%=configuracion.getIesNombre()%>"/></p>
        <p class="formulario"><label>CIF del IES:</label></p>
        <p class="formulario"><input name="iesCif" type="text" value="<%=configuracion.getIesCif()%>"/></p>
        <p class="formulario"><label>Código del Centro:</label></p>
        <p class="formulario"><input name="iesCodigoCentro" type="text" value="<%=configuracion.getIesCodigoCentro()%>"/></p>
        <p class="formulario"><label>Nombre de Persona de Contacto del IES:</label></p>
        <p class="formulario"><input name="iesPersonaContactoNombre" type="text" value="<%=configuracion.getIesPersonaContactoNombre()%>"/></p>
        <p class="formulario"><label>Apellido1 de Persona de Contacto del IES:</label></p>
        <p class="formulario"><input name="iesPersonaContactoApellido1" type="text" value="<%=configuracion.getIesPersonaContactoApellido1()%>"/></p>
        <p class="formulario"><label>Apellido2 de Persona de Contacto del IES:</label></p>
        <p class="formulario"><input name="iesPersonaContactoApellido2" type="text" value="<%=configuracion.getIesPersonaContactoApellido2()%>"/></p>
        <p class="formulario"><label>Email del IES:</label></p>
        <p class="formulario"><input name="iesEmail" type="text" value="<%=configuracion.getIesEmail()%>"/></p>
        <p class="formulario"><label>Estado inicial:</label></p>
        <p class="formulario"><select name="estadoInicial">
                <%
                    Integer estadoInicial;
                    if (Utilidades.convertirStringVacioANull(request.getParameter("estadoInicial")) != null) {
                        estadoInicial = Integer.parseInt(request.getParameter("estadoInicial"));
                    } else {
                        estadoInicial = configuracion.getEstadoInicial().getEstadoId();
                    }
                    out.println("<option value=''></option>");

                    ArrayList<Estado> listaEstados = iCAD.leerEstados(null, null, IncidenciasCAD.ESTADO_CODIGO, IncidenciasCAD.ASCENDENTE);
                    for (Estado estado : listaEstados) {
                        if (estado.getEstadoId() == estadoInicial) {
                            out.println("<option value='" + estado.getEstadoId() + "' selected>");
                            out.println(estado.getCodigo() + " - " + estado.getNombre());
                            out.println("</option>");
                        } else {
                            out.println("<option value='" + estado.getEstadoId() + "'>");
                            out.println(estado.getCodigo() + " - " + estado.getNombre());
                            out.println("</option>");
                        }
                    }
                %>
            </select></p>
        <p class="formulario"><label>Estado Final</label></p>
        <p class="formulario"><select name="estadoFinal">
                <%
                    Integer estadoFinal;
                    if (Utilidades.convertirStringVacioANull(request.getParameter("estadoFinal")) != null) {
                        estadoFinal = Integer.parseInt(request.getParameter("estadoFinal"));
                    } else {
                        estadoFinal = configuracion.getEstadoFinal().getEstadoId();
                    }
                    out.println("<option value=''></option>");

                    for (Estado estado : listaEstados) {
                        if (estado.getEstadoId() == estadoFinal) {
                            out.println("<option value='" + estado.getEstadoId() + "' selected>");
                            out.println(estado.getCodigo() + " - " + estado.getNombre());
                            out.println("</option>");
                        } else {
                            out.println("<option value='" + estado.getEstadoId() + "'>");
                            out.println(estado.getCodigo() + " - " + estado.getNombre());
                            out.println("</option>");
                        }
                    }


                %>
            </select></p>
        <p class="formulario"><label>Url del LDAP:</label></p>
        <p class="formulario"><input name="ldapUrl" type="text" value="<%=configuracion.getLdapUrl()%>"/></p>
        <p class="formulario"><label>Dominio del LDAP:</label></p>
        <p class="formulario"><input name="ldapDominio" type="text" value="<%=configuracion.getLdapDominio()%>"/></p>
        <p class="formulario"><label>Dn del LDAP:</label></p>
        <p class="formulario"><input name="ldapDn" type="text" value="<%=configuracion.getLdapDn()%>"/></p>
        <p class="formulario"><label>Atributo Cuenta LDAP:</label></p>
        <p class="formulario"><input name="ldapAtributoCuenta" type="text" value="<%=configuracion.getLdapAtributoCuenta()%>"/></p>
        <p class="formulario"><label>Atributo Nombre LDAP:</label></p>
        <p class="formulario"><input name="ldapAtributoNombre" type="text" value="<%=configuracion.getLdapAtributoNombre()%>"/></p>
        <p class="formulario"><label>Atributo Apellido LDAP:</label></p>
        <p class="formulario"><input name="ldapAtributoApellido" type="text" value="<%=configuracion.getLdapAtributoApellido()%>"/></p>
        <p class="formulario"><label>Atributo Departamento LDAP:</label></p>
        <p class="formulario"><input name="ldapAtributoDepartamento" type="text" value="<%=configuracion.getLdapAtributoDepartamento()%>"/></p>
        <p class="formulario"><label>Atributo Perfil LDAP:</label></p>
        <p class="formulario"><input name="ldapAtributoPerfil" type="text" value="<%=configuracion.getLdapAtributoPerfil()%>"/></p>
        <p class="botones">
            <a href="listaincidencias.jsp"><input align="center" type="button" value="Cancelar"/></a>
            <input type="submit" value="Modificar"/>
        </p>
    </form>
</div>

<%@include file="includes/pie.jsp" %>
