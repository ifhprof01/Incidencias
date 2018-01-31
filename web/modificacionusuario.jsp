<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <h2 class="formulario">Modificación de Usuario</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Usuario usuario = iCAD.leerUsuario(Integer.parseInt(request.getParameter("usuarioId")));
                %>
                <form action="ServletModificacionUsuario" method="post" name="modificacionUsuario">
                    <input type="hidden" name="usuarioId" value="<%=usuario.getUsuarioId()%>">
                    <p class="formulario"><label>Cuenta: </label></p>
                    <%
                        String codigoCuentaUsuario;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("codigoCuentaUsuario")) != null) codigoCuentaUsuario = request.getParameter("codigoCuentaUsuario");
                        else codigoCuentaUsuario = usuario.getCuenta();
                    %>
                    <p class="formulario"><input name="codigoCuentaUsuario" type="text" value="<%=Utilidades.convertirNullAStringVacio(codigoCuentaUsuario)%>"/></p>
                    <p class="formulario"><label>Nombre: </label></p>
                    <%
                        String nombreUsuario;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("nombreUsuario")) != null) nombreUsuario = request.getParameter("nombreUsuario");
                        else nombreUsuario = usuario.getNombre();
                    %>
                    <p class="formulario"><input name="nombreUsuario" type="text" value="<%=Utilidades.convertirNullAStringVacio(nombreUsuario)%>"/></p>
                    <p class="formulario"><label>Apellido: </label></p>
                    <%
                        String apellidoUsuario;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("apellidoUsuario")) != null) apellidoUsuario = request.getParameter("apellidoUsuario");
                        else apellidoUsuario = usuario.getApellido();
                    %>
                    <p class="formulario"><input name="apellidoUsuario" type="text" value="<%=Utilidades.convertirNullAStringVacio(apellidoUsuario)%>"/></p>
                    <p class="formulario"><label>Departamento </label></p>
                    <%
                        String departamentoUsuario;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("departamentoUsuario")) != null) departamentoUsuario = request.getParameter("departamentoUsuario");
                        else departamentoUsuario = usuario.getDepartamento();
                    %>
                    <p class="formulario"><input name="departamentoUsuario" type="text" value="<%=Utilidades.convertirNullAStringVacio(departamentoUsuario)%>"/></p>
                    <p class="botones">
                        <a href="listausuarios.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Modificar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
