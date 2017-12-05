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
                <p><label>Incidencia Id.: </label><input name="incidenciaId" type="text"/></p>
                <p><label>Fecha de Registro: </label><input name="fechaRegistro" type="text"/></p>
                <p><label>Tipo de Equipo: </label><input name="tipoEquipoNombre" type="text"/></p>
                <p><label>Dependencia: </label><input name="codigo" type="text"/> - <input name="nombre" type="text"/></p>
                <p><label>Posición del Equipo: </label><textarea name="posicionEquipoDependencia" rows="4" cols="50"></textarea></p>
                <p><label>Usuario: </label><input name="usuarioCuenta" type="text"/> - <input name="usuarioNombreApellido" type="text"/></p>
                <p><label>Estado: </label><input name="estadoNombre" type="text"/> (<input name="fechaEstadoActual" type="text"/>)</p>
                <p><label>Descripción de la Incidencia: </label><textarea name="descripcion" rows="4" cols="50"></textarea></p>
                <p><label>Comentarios del Administrador: </label><textarea name="comentarioAdministrador" rows="4" cols="50"></textarea></p>
            </div>

<%@include file="includes/pie.jsp" %>
