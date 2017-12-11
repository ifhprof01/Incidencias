<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <h2>Baja de Incidencia</h2>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Incidencia incidencia = iCAD.leerIncidencia(Integer.parseInt(request.getParameter("incidenciaId")));
                %>
                <p><label>Incidencia Id.: </label></p>
                <p><input name="incidenciaId" type="text" value="<%=incidencia.getIncidenciaId()%>"/></p>
                <p><label>Fecha de Registro: </label></p>
                <p><input name="fechaRegistro" type="text" value="<%=incidencia.getFechaRegistro()%>"/></p>
                <p><label>Tipo de Equipo: </label></p>
                <p><input name="tipoEquipoCodigoNombre" type="text" value="<%=incidencia.getEquipo().getTipoEquipo().getCodigo()%> - <%=incidencia.getEquipo().getTipoEquipo().getNombre()%>"/></p>
                <p><label>Dependencia: </label></p>
                <p><input name="dependenciaCodigoNombre" type="text" value="<%=incidencia.getDependencia().getCodigo()%> - <%=incidencia.getDependencia().getNombre()%>"/></p>
                <p><label>Posición del Equipo en la Dependencia: </label></p>
                <p><textarea name="posicionEquipoDependencia" rows="4"><%=incidencia.getPosicionEquipoDependencia()%></textarea></p>
                <p><label>Usuario: </label></p>
                <p><input name="usuarioCuentaNombreApellido" type="text" value="<%=incidencia.getUsuario().getCuenta()%> - <%=incidencia.getUsuario().getNombre()%> <%=incidencia.getUsuario().getApellido()%>"/></p>
                <p><label>Estado: </label></p>
                <p><input name="estadoCodigoNombre" type="text" value="<%=incidencia.getEstado().getCodigo()%> - <%=incidencia.getEstado().getNombre()%>"/></p>
                <p><label>Fecha de Transicion al Estado Actual: </label></p>
                <p><input name="fechaEstadoActual" type="text" value="<%=incidencia.getFechaEstadoActual()%>"/></p>
                <p><label>Descripción de la Incidencia: </label></p>
                <p><textarea name="descripcion" rows="4"><%=incidencia.getDescripcion()%></textarea></p>
                <p><label>Comentarios del Administrador: </label></p>
                <p><textarea name="comentarioAdministrador" rows="4"><%=incidencia.getComentarioAdministrador()%></textarea></p>
            </div>

<%@include file="includes/pie.jsp" %>
