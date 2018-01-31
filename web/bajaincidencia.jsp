<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Historial"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <h2 class="formulario">Baja de Incidencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Incidencia incidencia = iCAD.leerIncidencia(Integer.parseInt(request.getParameter("incidenciaId")));
                    //incidencia.getHistoriales().get(1).getFecha();
                    //incidencia.getHistoriales().get(1).getEstado();
                    
                %>
                <form action="ServletBajaIncidencia" method="post" name="bajaIncidencia">
                    <input type="hidden" name="incidenciaId" value="<%=incidencia.getIncidenciaId()%>">
                    <p class="formulario"><label>Incidencia Id.: </label></p>
                    <p class="formulario"><input name="incidenciaId" type="text" readonly disabled value="<%=incidencia.getIncidenciaId()%>"/></p>
                    <p class="formulario"><label>Etiqueta del Equipo: </label></p>
                    <p class="formulario"><input name="numeroEtiquetaConsejeria" type="text" readonly disabled value="<%=incidencia.getEquipo().getNumeroEtiquetaConsejeria()%>"/></p>
                    <p class="formulario"><label>Fecha de Registro: </label></p>
                    <p class="formulario"><input name="fechaRegistro" type="text" readonly disabled value="<%=incidencia.getFechaRegistro()%>"/></p>
                    <p class="formulario"><label>Tipo de Equipo: </label></p>
                    <p class="formulario"><input name="tipoEquipoCodigoNombre" type="text" readonly disabled value="<%=incidencia.getEquipo().getTipoEquipo().getCodigo()%> - <%=incidencia.getEquipo().getTipoEquipo().getNombre()%>"/></p>
                    <p class="formulario"><label>Dependencia: </label></p>
                    <p class="formulario"><input name="dependenciaCodigoNombre" type="text" readonly disabled value="<%=incidencia.getDependencia().getCodigo()%> - <%=incidencia.getDependencia().getNombre()%>"/></p>
                    <p class="formulario"><label>Posición del Equipo en la Dependencia: </label></p>
                    <p class="formulario"><textarea name="posicionEquipoDependencia" rows="4" readonly disabled><%=incidencia.getPosicionEquipoDependencia()%></textarea></p>
                    <p class="formulario"><label>Usuario: </label></p>
                    <p class="formulario"><input name="usuarioCuentaNombreApellido" type="text" readonly disabled value="<%=incidencia.getUsuario().getCuenta()%> - <%=incidencia.getUsuario().getNombre()%> <%=incidencia.getUsuario().getApellido()%>"/></p>
                    <p class="formulario"><label>Estado: </label></p>
                    <p class="formulario"><input name="estadoCodigoNombre" type="text" readonly disabled value="<%=incidencia.getEstado().getCodigo()%> - <%=incidencia.getEstado().getNombre()%>"/></p>
                    <p class="formulario"><label>Fecha de Transicion al Estado Actual: </label></p>
                    <p class="formulario"><input name="fechaEstadoActual" type="text" readonly disabled value="<%=incidencia.getFechaEstadoActual()%>"/></p>
                    <p class="formulario"><label>Descripción de la Incidencia: </label></p>
                    <p class="formulario"><textarea name="descripcion" rows="4" readonly disabled><%=incidencia.getDescripcion()%></textarea></p>
                    <p class="formulario"><label>Comentarios del Administrador: </label></p>
                    <p class="formulario"><textarea name="comentarioAdministrador" rows="4" readonly disabled><%=Utilidades.convertirNullAStringVacio(incidencia.getComentarioAdministrador())%></textarea></p>
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
                        <input type="submit" value="Eliminar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
