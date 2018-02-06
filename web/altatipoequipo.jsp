<%-- 
    Document   : altatipoequipo
    Created on : 16-ene-2018, 19:42:33
    Author     : david
--%>

<%@page import="utilidades.Utilidades"%>
<%@page import="java.util.Collections"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
                <h2 class="formulario">Alta de Tipo Equipo</h2>
                <%@include file="includes/mensajeusuario.jsp" %>
                <form action="ServletAltaTipoEquipo" method="post">
                    <p class="formulario"><label>Codigo del tipo de equipo: </label></p>
                    <p class="formulario"><input name="codigo" type="text" value="<%=Utilidades.convertirNullAStringVacio(request.getParameter("codigo"))%>" /></p>
                    <p class="formulario"><label>Nombre del tipo de equipo: </label></p>
                    <p class="formulario"><input name="nombre" type="text" value="<%=Utilidades.convertirNullAStringVacio(request.getParameter("nombre"))%>"/></p>
                    <p class="botones">
                        <a href="listatipoequipo.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Crear"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>