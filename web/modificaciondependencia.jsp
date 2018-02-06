<%-- 
    Document   : modificaciondependencia.jsp
--%>


<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
                <h2 class="formulario">Modificación de Dependencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Dependencia dependencia = iCAD.leerDependencia(Integer.parseInt(request.getParameter("dependenciaId")));
                %>
                <form action="ServletModificacionDependencia" method="post" name="modificacionDependencia">
                    <input type="hidden" name="dependenciaId" value="<%=dependencia.getDependenciaId()%>">
                    <p class="formulario"><label>Codigo: </label></p>
                    <p class="formulario"><input name="codigo" type="text" value="<%=dependencia.getCodigo()%>"/></p>
                    <p class="formulario"><label>Nombre: </label></p>
                    <p class="formulario"><input name="nombre" type="text" value="<%=dependencia.getNombre()%>"/></p>
                    <p class="botones">
                        <a href="listadependencias.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Modificar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
