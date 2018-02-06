<%-- 
    Document   : bajatipoequipo
    Created on : 16-ene-2018, 19:45:27
    Author     : david
--%>


<%@page import="incidenciascad.TipoEquipo"%>
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
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
                <h2 class="formulario">Baja de Tipo Equipo</h2>
                <%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    TipoEquipo tipoEquipo = iCAD.leerTipoEquipo(Integer.parseInt(request.getParameter("tipoEquipoId")));
                    //incidencia.getHistoriales().get(1).getFecha();
                    //incidencia.getHistoriales().get(1).getEstado();
                    
                %>
                <form action="ServletBajaTipoEquipo" method="post" name="bajaTipoEquipo">
                    <input type="hidden" name="tipoEquipoId" value="<%=tipoEquipo.getTipoEquipoId()%>">
                    <p class="formulario"><label>Tipo Equipo Id.: </label></p>
                    <p class="formulario"><input name="tipoEquipoId" type="text" readonly disabled value="<%=tipoEquipo.getTipoEquipoId()%>"/></p>
                    <p class="formulario"><label>Etiqueta del Equipo: </label></p>
                    <p class="formulario"><input name="codigo" type="text" readonly disabled value="<%=tipoEquipo.getCodigo()%>"/></p>
                    <p class="formulario"><label>Fecha de Registro: </label></p>
                    <p class="formulario"><input name="nombre" type="text" readonly disabled value="<%=tipoEquipo.getNombre()%>"/></p>
                    <p class="botones">
                        <a href="listatipoequipo.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Eliminar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>