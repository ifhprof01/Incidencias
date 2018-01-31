<%-- 
    Document   : modificaciontipoequipo
    Created on : 23-ene-2018, 19:19:10
    Author     : david
--%>

<%@page import="incidenciascad.TipoEquipo"%>
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
                <h2 class="formulario">Modificacion de Tipo Equipo</h2>
                <%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    TipoEquipo tipoEquipo = iCAD.leerTipoEquipo(Integer.parseInt(request.getParameter("tipoEquipoId")));
                %>
                    <form action="ServletModificacionTipoEquipo" method="post" name="modificacionTipoEquipo">
                    <input type="hidden" name="tipoEquipoId" value="<%=tipoEquipo.getTipoEquipoId()%>">
                    <p class="formulario"><label>Tipo de Equipo Id: </label></p>
                    <p class="formulario"><input name="tipoEquipoId" type="text" readonly disabled value="<%=tipoEquipo.getTipoEquipoId() %>" /></p>
                    <p class="formulario"><label>Codigo del tipo de equipo: </label></p>
                    <p class="formulario"><input name="codigo" type="text" value="<%=tipoEquipo.getCodigo() %>" /></p>
                    <p class="formulario"><label>Nombre del tipo de equipo: </label></p>
                    <p class="formulario"><input name="nombre" type="text" value="<%=tipoEquipo.getNombre() %>"/></p>
                    <p class="botones">
                        <a href="listatipoequipo.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Modificar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>