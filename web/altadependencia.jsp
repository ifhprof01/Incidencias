<%-- 
    Document   : altadependencia.jsp
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

            <div id="content">
                <h2 class="formulario">Alta de Dependencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <form action="ServletAltaDependencia" method="post">
                    <p class="formulario"><label>Codigo: </label></p>
                    <p class="formulario"><input name="codigo" type="text" value="<%=Utilidades.convertirNullAStringVacio(request.getParameter("codigo"))%>" /></p>
                    <p class="formulario"><label>Nombre: </label></p>
                    <p class="formulario"><input name="nombre" type="text" value="<%=Utilidades.convertirNullAStringVacio(request.getParameter("nombre"))%>" /></p>
                    <p class="botones">
                        <a href="listadependencias.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Crear"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
