<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Usuario"%>
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
                <h2 class="formulario">Baja de Incidencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Usuario usuario= iCAD.leerUsuario(Integer.parseInt(request.getParameter("usuarioId")));
                    usuario.getCuenta();
                    usuario.getNombre();
                    usuario.getApellido();
                    usuario.getDepartamento();
                %>
                <form action="ServletBajaUsuario" method="post" name="bajaUsuario">
                    <input type="hidden" name="usuarioId" value="<%=usuario.getUsuarioId()%>">
                    <p class="formulario"><label>Cuenta de usuario: </label></p>
                    <p class="formulario"><input name="cuenta" type="text" readonly disabled value="<%=Utilidades.convertirNullAStringVacio(usuario.getCuenta())%>"/></p>
                    <p class="formulario"><label>Nombre: </label></p>
                    <p class="formulario"><input name="nombre" type="text" readonly disabled value="<%=Utilidades.convertirNullAStringVacio(usuario.getNombre())%>"/></p>
                    <p class="formulario"><label>Apellido: </label></p>
                    <p class="formulario"><input name="apellido" type="text" readonly disabled value="<%=Utilidades.convertirNullAStringVacio(usuario.getApellido())%>"/></p>
                    <p class="formulario"><label>Departamento </label></p>
                    <p class="formulario"><input name="departamento" type="text" readonly disabled value="<%=Utilidades.convertirNullAStringVacio(usuario.getDepartamento())%>"/></p>
                     <p class="botones">
                        <a href="listausuarios.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Eliminar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
