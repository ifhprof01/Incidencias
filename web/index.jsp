<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Historial"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabeceraindex.jsp" %>
            <div id="content">
<%@include file="includes/mensajeusuario.jsp" %>
                <form action="ServletControlAcceso" method="post">
                    <p class="formulario"><label>Usuario: </label></p>
                    <p class="formulario"><input name="usuario" type="text"/></p>
                    <p class="formulario"><label>Contraseña: </label></p>
                    <p class="formulario"><input name="contrasena" type="password"/></p>
                    <p class="botones">
                        <input type="submit" value="Entrar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
