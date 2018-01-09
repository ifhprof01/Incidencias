<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Historial"%>
<%@page import="incidenciascad.Estado"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <h2 class="formulario">Modificación de Incidencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Incidencia incidencia = iCAD.leerIncidencia(Integer.parseInt(request.getParameter("incidenciaId")));
                %>
                <form action="ServletModificacionIncidencia" method="post" name="modificacionIncidencia">
                    <input type="hidden" name="incidenciaId" value="<%=incidencia.getIncidenciaId()%>">
                    <p class="formulario"><label>Incidencia Id.: </label></p>
                    <p class="formulario"><input name="incidenciaId" type="text" readonly disabled value="<%=incidencia.getIncidenciaId()%>"/></p>
                    <p class="formulario"><label>Etiqueta del Equipo: </label></p>
                    <%
                        String numeroEtiquetaConsejeria;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("numeroEtiquetaConsejeria")) != null) numeroEtiquetaConsejeria = request.getParameter("numeroEtiquetaConsejeria");
                        else numeroEtiquetaConsejeria = incidencia.getEquipo().getNumeroEtiquetaConsejeria();
                    %>
                    <p class="formulario"><input name="numeroEtiquetaConsejeria" type="text" value="<%=numeroEtiquetaConsejeria%>"/></p>
                    <p class="formulario"><label>Fecha de Registro: </label></p>
                    <p class="formulario"><input name="fechaRegistro" type="text" readonly disabled value="<%=incidencia.getFechaRegistro()%>"/></p>
                    <p class="formulario"><label>Tipo de Equipo: </label></p>
                    <p class="formulario"><input name="tipoEquipoCodigoNombre" type="text" readonly disabled value="<%=incidencia.getEquipo().getTipoEquipo().getCodigo()%> - <%=incidencia.getEquipo().getTipoEquipo().getNombre()%>"/></p>
                    <p class="formulario"><label>Dependencia: </label></p>
                    <p class="formulario"><select name="dependenciaId">
                    <%
                        Integer dependenciaId;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("dependenciaId")) != null) dependenciaId = Integer.parseInt(request.getParameter("dependenciaId"));
                        else dependenciaId = incidencia.getDependencia().getDependenciaId();
                        out.println("<option value=''></option>");
                        ArrayList<Dependencia> listaDependencias = iCAD.leerDependencias(null, null, IncidenciasCAD.DEPENDENCIA_CODIGO, IncidenciasCAD.ASCENDENTE);
                        for (Dependencia dependencia : listaDependencias) {
                            if (dependencia.getDependenciaId() == dependenciaId) {
                                out.println("<option value='" + dependencia.getDependenciaId() + "' selected>");
                                out.println(dependencia.getCodigo() + " - " + dependencia.getNombre());
                                out.println("</option>");
                            } else {
                                out.println("<option value='" + dependencia.getDependenciaId() + "'>");
                                out.println(dependencia.getCodigo() + " - " + dependencia.getNombre());
                                out.println("</option>");
                            }
                        }
                    %>
                    </select></p>
                    <p class="formulario"><label>Posición del Equipo en la Dependencia: </label></p>
                    <%
                        String posicionEquipoDependencia;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("posicionEquipoDependencia")) != null) posicionEquipoDependencia = request.getParameter("posicionEquipoDependencia");
                        else posicionEquipoDependencia = incidencia.getPosicionEquipoDependencia();
                    %>
                    <p class="formulario"><textarea name="posicionEquipoDependencia" rows="4"><%=posicionEquipoDependencia%></textarea></p>
                    <p class="formulario"><label>Usuario: </label></p>
                    <p class="formulario"><input name="usuarioCuentaNombreApellido" type="text" readonly disabled value="<%=incidencia.getUsuario().getCuenta()%> - <%=incidencia.getUsuario().getNombre()%> <%=incidencia.getUsuario().getApellido()%>"/></p>
                    <p class="formulario"><label>Estado: </label></p>
                    <p class="formulario"><select name="estadoId">
                    <%
                        Integer estadoId;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("estadoId")) != null) estadoId = Integer.parseInt(request.getParameter("estadoId"));
                        else estadoId = incidencia.getEstado().getEstadoId();
                        out.println("<option value=''></option>");
                        ArrayList<Estado> listaEstados = iCAD.leerEstados(null, null, IncidenciasCAD.ESTADO_CODIGO, IncidenciasCAD.ASCENDENTE);
                        for (Estado estado : listaEstados) {
                            if (estado.getEstadoId() == estadoId) {
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
                    <p class="formulario"><label>Fecha de Transicion al Estado Actual: </label></p>
                    <p class="formulario"><input name="fechaEstadoActual" type="text" readonly disabled value="<%=incidencia.getFechaEstadoActual()%>"/></p>
                    <p class="formulario"><label>Descripción de la Incidencia: </label></p>
                    <p class="formulario"><textarea name="descripcion" rows="4" readonly disabled><%=incidencia.getDescripcion()%></textarea></p>
                    <p class="formulario"><label>Comentarios del Administrador: </label></p>
                    <%
                        String comentarioAdministrador;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("comentarioAdministrador")) != null) comentarioAdministrador = request.getParameter("comentarioAdministrador");
                        else comentarioAdministrador = incidencia.getComentarioAdministrador();
                    %>
                    <p class="formulario"><textarea name="comentarioAdministrador" rows="4"><%=Utilidades.convertirNullAStringVacio(comentarioAdministrador)%></textarea></p>
                    <p class="formulario"><label>Historial de Estados: </label></p>
                    <%for (Historial historial : incidencia.getHistoriales()) {
                        out.println("<p class='formulario'>");
                        out.print(historial.getFecha() + " -----> ");
                        out.print(historial.getEstado().getCodigo() + " - " + historial.getEstado().getNombre());
                        out.println("</p>");
                    }
                    %>
                    <p class="botones">
                        <a href="listaincidencias.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Modificar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
