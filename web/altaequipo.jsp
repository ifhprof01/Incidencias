<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

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
    <h2 class="formulario">Alta de Equipo</h2>
    <%@include file="includes/mensajeusuario.jsp" %>
    <form action="ServletAltaEquipo" method="post" name="altaEquipo">
        <p class="formulario"><label>Etiqueta de Consejeria: </label></p>
        <p class="formulario"><input name="numeroEtiquetaConsejeria" type="text" /></p>
        <p class="formulario"><label>TipoEquipo </label></p>
        <p class="formulario"><select name="tipoEquipoId">
                    <%
                        out.println("<option value=''></option>");
                        IncidenciasCAD iCAD = new IncidenciasCAD();
                        ArrayList<Equipo> listaEquipos = iCAD.leerEquipos(null,null, IncidenciasCAD.TIPO_EQUIPO_CODIGO,IncidenciasCAD.ASCENDENTE);
                        for (Equipo equipo : listaEquipos) {
                            if (Utilidades.convertirNullAStringVacio(request.getParameter("tipoEquipoId")).equals(equipo.getTipoEquipo().toString())) {
                                out.println("<option value='" + equipo.getTipoEquipo().getNombre()+" - "+equipo.getTipoEquipo().getCodigo()+ "' selected>");
                                out.println("</option>");
                            } else {
                             out.println("<option value='" + equipo.getEquipoId()+ "'>");
                                out.println(equipo.getTipoEquipo().getNombre()+ " - " + equipo.getTipoEquipo().getCodigo());
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
