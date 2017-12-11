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
                <p><label>Incidencia Id.: </label></p>
                <p><input name="incidenciaId" type="text"/></p>
                <p><label>Fecha de Registro: </label></p>
                <p><input name="fechaRegistro" type="text"/></p>
                <p><label>Tipo de Equipo: </label></p>
                <p><input name="tipoEquipoCodigoNombre" type="text"/></p>
                <p><label>Dependencia: </label></p>
                <p><input name="dependenciaCodigoNombre" type="text"/></p>
                <p><label>Posición del Equipo en la Dependencia: </label></p>
                <p><textarea name="posicionEquipoDependencia" rows="4"></textarea></p>
                <p><label>Usuario: </label></p>
                <p><input name="usuarioCuentaNombreApellido" type="text"/></p>
                <p><label>Estado: </label></p>
                <p><input name="estadoNombre" type="text"/></p>
                <p><label>Fecha de Transicion al Estado Actual: </label></p>
                <p><input name="fechaEstadoActual" type="text"/></p>
                <p><label>Descripción de la Incidencia: </label></p>
                <p><textarea name="descripcion" rows="4"></textarea></p>
                <p><label>Comentarios del Administrador: </label></p>
                <p><textarea name="comentarioAdministrador" rows="4"></textarea></p>
            </div>

<%@include file="includes/pie.jsp" %>
