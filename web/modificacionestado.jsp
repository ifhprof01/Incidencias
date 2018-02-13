<%-- 
    Document   : altaestado
    Created on : 17-ene-2018, 19:53:08
    Author     : DAW216
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Estado"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="java.util.Collections"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
                <h2 class="formulario">Modificación de Estado</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Estado estado = iCAD.leerEstado(Integer.parseInt(request.getParameter("estadoId")));
                %>
                <form action="ServletModificacionEstado" method="post">
                    <input type="hidden" name="estadoId" value="<%=estado.getEstadoId()%>">
                    <p class="formulario"><label>Código del Estado: </label></p>
                    <p class="formulario"><input name="estadoCodigo" type="text" value="<%=estado.getCodigo()%>" /></p>
                    <p class="formulario"><label>Nombre del Estado: </label></p>
                    <p class="formulario"><input name="estadoNombre" type="text" value="<%=estado.getNombre()%>" /></p>
                    <p class="botones">
                        <a href="listaestados.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Modificar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
