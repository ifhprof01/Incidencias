<%-- 
    Document   : altaestado
    Created on : 17-ene-2018, 19:53:08
    Author     : DAW216
--%>

<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <h2 class="formulario">Alta de Estado</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <form action="ServletAltaEstados" method="post">
                    <p class="formulario"><label>Código del Estado: </label></p>
                    <p class="formulario"><input name="estadoCodigo" type="text" value="<%=Utilidades.convertirNullAStringVacio(request.getParameter("estadoCodigo"))%>" /></p>
                    <p class="formulario"><label>Nombre del Estado: </label></p>
                    <p class="formulario"><input name="estadoNombre" type="text" value="<%=Utilidades.convertirNullAStringVacio(request.getParameter("estadoNombre"))%>" /></p>
                    <p class="botones">
                        <a href="listaestados.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Crear"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
