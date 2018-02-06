<%-- 
    Document   : envioemail
    Created on : 23-ene-2018, 19:30:08
    Author     : usuario
--%>

<%@page import="incidenciascad.Historial"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Configuracion"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
                <h2 class="formulario">Envio de e-mail</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Incidencia incidencia = iCAD.leerIncidencia(Integer.parseInt(request.getParameter("incidenciaId")));
                    Configuracion configuracion=iCAD.leerConfiguracion().get(0);
                    
                %>
                <form method="post" name="envioEmail" action="ServletEnvioEmail">
                    <p class="formulario"><label>Origen: </label></p>
                    <p class="formulario"><input name="origen" type="text"  value="<%=configuracion.getIesEmail()%>"/></p>
                    <p class="formulario"><label>Contraseña: </label></p>
                    <p class="formulario"><input name="contrasena" type="text"/></p>
                    <p class="formulario"><label>Destinatario: </label></p>
                    <p class="formulario"><input name="destinatario" type="text"  value="<%=configuracion.getEmpresaConsejeriaEmail()%>"/></p>
                    <p class="formulario"><label>Asunto: </label></p>
                    <p class="formulario"><input name="asunto" type="text" value="Incidencia <%=incidencia.getIncidenciaId()%>"/></p>
                    <p class="formulario"><label>Contenido: </label></p>
                    <p class="formulario">
                              <%
                              out.println("<textarea name='contenido' rows='18'>");
                              out.println("DATOS DEL CENTRO");
                              out.println("Nombre del centro: "+configuracion.getIesNombre());
                              out.println("CIF del centro: "+configuracion.getIesCif());
                              out.println("Código del centro: "+configuracion.getIesCodigoCentro());
                              out.println("Persona de contacto: "+configuracion.getIesPersonaContactoNombre()+" "+configuracion.getIesPersonaContactoApellido1()+" "+configuracion.getIesPersonaContactoApellido2());
                              out.println("");
                              out.println("DATOS DE LA INCIDENCIA");
                              out.println("Equipo: "+incidencia.getEquipo().getNumeroEtiquetaConsejeria());
                              out.println("Tipo de equipo: "+incidencia.getEquipo().getTipoEquipo().getNombre());
                              out.println("Dependencia: "+incidencia.getDependencia().getNombre());
                              out.println("Posición: "+incidencia.getPosicionEquipoDependencia());
                              out.println("Fecha de registro: "+incidencia.getFechaRegistro());
                              out.println("Usuario: "+incidencia.getUsuario().getCuenta());
                              out.println("Descripción: "+incidencia.getDescripcion());
                              out.println("Comentario del administrador: "+incidencia.getComentarioAdministrador());
                              out.println("");
                              out.println("HISTORIALES DE LA INCIDENCIA");
                              for (Historial historial : incidencia.getHistoriales()) {
                                out.print(historial.getFecha() + " -----> ");
                                out.println(historial.getEstado().getCodigo() + " - " + historial.getEstado().getNombre());
                              }
                            %>
                    </textarea></p>
                    <p class="botones">
                        <a href="listaincidencias.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Enviar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>

