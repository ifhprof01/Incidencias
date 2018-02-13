<%-- 
    Document   : bajadependencia.jsp
--%>

<%@page import="incidenciascad.Historial"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
                <h2 class="formulario">Baja de Dependencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Dependencia dependencia = iCAD.leerDependencia(Integer.parseInt(request.getParameter("dependenciaId")));
                    if (dependencia == null) {
                            Utilidades.mensajeErrorLog(1, "Intento de acceso a " + request.getRequestURI() + "?" + request.getQueryString() + " .El dato al quie se pretende acceder no existe en la base de datos", null);
                            request.setAttribute("mensajeUsuario", "La dependencia no existe");
                            request.setAttribute("listaErrores", new ArrayList());
                            request.getRequestDispatcher("listadependencias.jsp").forward(request, response);
                    }
                %>
                <form action="ServletBajaDependencia" method="post" name="bajaDependencia">
                    <input type="hidden" name="dependenciaId" value="<%=dependencia.getDependenciaId()%>">
                    <p class="formulario"><label>Codigo: </label></p>
                    <p class="formulario"><input name="codigo" type="text" readonly disabled value="<%=dependencia.getCodigo()%>"/></p>
                    <p class="formulario"><label>Nombre: </label></p>
                    <p class="formulario"><input name="nombre" type="text" readonly disabled value="<%=dependencia.getNombre()%>"/></p>
                    
                    <p class="botones">
                        <a href="listadependencias.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Eliminar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
