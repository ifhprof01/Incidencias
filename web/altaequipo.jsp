<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
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
<%@include file="includes/soloadministradores.jsp" %>



<div id="content">
    <h2 class="formulario">Alta de Equipo</h2>
    <%@include file="includes/mensajeusuario.jsp" %>
    <form action="ServletAltaEquipo" method="post" name="altaEquipo">
        <p class="formulario"><label>Etiqueta de Consejeria: </label></p>
        <p class="formulario"><input name="numeroEtiquetaConsejeria" type="text" /></p>
        <p class="formulario"><label>Tipo de Equipo </label></p>
        <p class="formulario"><select name="tipoEquipoId">
                    <%
                        out.println("<option value=''></option>");
                        IncidenciasCAD iCAD = new IncidenciasCAD();
                        ArrayList<TipoEquipo> listaTiposEquipo = iCAD.leerTiposEquipo(null,null, IncidenciasCAD.TIPO_EQUIPO_CODIGO,IncidenciasCAD.ASCENDENTE);
                        for (TipoEquipo tipoEquipo : listaTiposEquipo) {
                            if (Utilidades.convertirNullAStringVacio(request.getParameter("tipoEquipoId")).equals(tipoEquipo.getTipoEquipoId().toString())) {
                                out.println("<option value='" + tipoEquipo.getTipoEquipoId() + "' selected>");
                                out.println(tipoEquipo.getCodigo()+ " - " + tipoEquipo.getNombre());
                                out.println("</option>");
                            } else {
                                out.println("<option value='" + tipoEquipo.getTipoEquipoId() + "'>");
                                out.println(tipoEquipo.getCodigo()+ " - " + tipoEquipo.getNombre());
                                out.println("</option>");
                            }
                        }
                    %>
                    </select></p>
        </select></p>
        <p class="botones">
            <a href="listaequipos.jsp"><input align="center" type="button" value="Cancelar"/></a>
            <input type="submit" value="Crear"/>
        </p>
    </form>
</div>

<%@include file="includes/pie.jsp" %>
