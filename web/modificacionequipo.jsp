<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Historial"%>
<%@page import="incidenciascad.Estado"%>
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
                <h2 class="formulario">Modificación de Incidencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    Equipo equipo = iCAD.leerEquipo(Integer.parseInt(request.getParameter("equipoId")));
                %>
                <form action="ServletModificacionEquipo" method="post" name="modificacionEquipo">
                    <input type="hidden" name="equipoId" value="<%=equipo.getEquipoId()%>">
                    <p class="formulario"><label>Equipo Id.: </label></p>
                    <p class="formulario"><input name="equipoId" type="text" readonly disabled value="<%=equipo.getEquipoId()%>"/></p>
                    <p class="formulario"><label>Numero Etiqueta Consegeria:</label></p>
                    <%
                        String numeroEtiquetaConsejeria;
                        if (Utilidades.convertirStringVacioANull(request.getParameter("numeroEtiquetaConsejeria")) != null) numeroEtiquetaConsejeria = request.getParameter("numeroEtiquetaConsejeria");
                        else numeroEtiquetaConsejeria = equipo.getNumeroEtiquetaConsejeria();
                    %>
                    <p class="formulario"><input name="numeroEtiquetaConsejeria" type="text" value="<%=numeroEtiquetaConsejeria%>"/></p>
                    <p class="formulario"><label>Tipo de Equipo: </label></p>
                       <p class="formulario"><select name="tipoEquipoId">
                    <%
                        out.println("<option value=''></option>");
                        ArrayList<Equipo> listaEquipos = iCAD.leerEquipos(null,null, IncidenciasCAD.TIPO_EQUIPO_CODIGO,IncidenciasCAD.ASCENDENTE);
                        for (Equipo equipo2 : listaEquipos) {
                            if (equipo.getTipoEquipo().getTipoEquipoId().equals(equipo2.getTipoEquipo().getTipoEquipoId())) {
                                out.println("<option value='" + equipo2.getTipoEquipo().getTipoEquipoId() + "' selected>");
                                out.println(equipo2.getTipoEquipo().getNombre()+" - "+equipo2.getTipoEquipo().getCodigo());
                                out.println("</option>");
                            } else {
                                out.println("<option value='" + equipo2.getTipoEquipo().getTipoEquipoId() + "'>");
                                out.println(equipo2.getTipoEquipo().getNombre()+" - "+equipo2.getTipoEquipo().getCodigo());
                                out.println("</option>");
                            }
                        }
                    %>
                    </select></p>
                    <input type="hidden" name="tipoEquipoId" value="<%=equipo.getTipoEquipo().getTipoEquipoId()%>">
                    <p class="botones">
                        <a href="listaEquipos.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Modificar"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
