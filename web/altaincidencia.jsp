<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="utilidades.Utilidades"%>
<%@page import="java.util.Collections"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <h2 class="formulario">Alta de Incidencia</h2>
<%@include file="includes/mensajeusuario.jsp" %>
                <form action="ServletAltaIncidencia" method="post">
                    <p class="formulario"><label>Etiqueta del Equipo: </label></p>
                    <p class="formulario"><input name="numeroEtiquetaConsejeria" type="text" value="<%=Utilidades.convertirNullAStringVacio(request.getParameter("numeroEtiquetaConsejeria"))%>" /></p>
                    <p class="formulario"><label>Descripción de la Incidencia: </label></p>
                    <p class="formulario"><textarea name="descripcion" rows="4" ><%=Utilidades.convertirNullAStringVacio(request.getParameter("descripcion"))%></textarea></p>
                    <p class="formulario"><label>Dependencia: </label></p>
                    <p class="formulario"><select name="dependenciaId">
                    <%
                        out.println("<option value=''></option>");
                        IncidenciasCAD iCAD = new IncidenciasCAD();
                        ArrayList<Dependencia> listaDependencias = iCAD.leerDependencias(null, null, IncidenciasCAD.DEPENDENCIA_CODIGO, IncidenciasCAD.ASCENDENTE);
                        for (Dependencia dependencia : listaDependencias) {
                            if (Utilidades.convertirNullAStringVacio(request.getParameter("dependenciaId")).equals(dependencia.getDependenciaId().toString())) {
                                out.println("<option value='" + dependencia.getDependenciaId() + "' selected>");
                                out.println(dependencia.getCodigo() + " - " + dependencia.getNombre());
                                out.println("</option>");
                            } else {
                                out.println("<option value='" + dependencia.getDependenciaId() + "'>");
                                out.println(dependencia.getCodigo() + " - " + dependencia.getNombre());
                                out.println("</option>");
                            }
                        }
                    %>
                    </select></p>
                    <p class="formulario"><label>Posición del Equipo: </label></p>
                    <p class="formulario"><textarea name="posicionEquipoDependencia" rows="4" ><%=Utilidades.convertirNullAStringVacio(request.getParameter("posicionEquipoDependencia"))%></textarea></p>
                    <p class="botones">
                        <a href="listaincidencias.jsp"><input align="center" type="button" value="Cancelar"/></a>
                        <input type="submit" value="Crear"/>
                    </p>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
