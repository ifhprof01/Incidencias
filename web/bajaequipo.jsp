<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

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
                <h2 class="formulario">Baja de Equipo</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Equipo equipo = iCAD.leerEquipo(Integer.parseInt(request.getParameter("equipoId")));
                    
                    //Incidencia incidencia = iCAD.leerIncidencia(Integer.parseInt(request.getParameter("incidenciaId")));
                    //incidencia.getHistoriales().get(1).getFecha();
                    //incidencia.getHistoriales().get(1).getEstado();
                    
                %>
                <form action="ServletBajaEquipo" method="post" name="bajaequipo">
                    <input type="hidden" name="equipoId" value="<%=equipo.getEquipoId()%>">
                    <p class="formulario"><label>Equipo Id.: </label></p>
                    <p class="formulario"><input name="equipoId" type="text" readonly disabled value="<%=equipo.getEquipoId()%>"/></p>
                    <p class="formulario"><label>Etiqueta del Equipo: </label></p>
                    <p class="formulario"><input name="numeroEtiquetaConsejeria" type="text" readonly disabled value="<%=equipo.getNumeroEtiquetaConsejeria()%>"/></p>
                    <p class="formulario"><label>Tipo de Equipo: </label></p>
                    <p class="formulario"><input name="tipoEquipoCodigoNombre" type="text" readonly disabled value="<%=equipo.getTipoEquipo().getCodigo()%> - <%=equipo.getTipoEquipo().getNombre()%>"/></p>
                    <p class="botones">
                        <a href="listaequipos.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Eliminar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
