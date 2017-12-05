<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <h2>Alta de Incidencia</h2>
                <p><label>Etiqueta del Equipo: </label><input name="numeroEtiquetaConsejeria" type="text" maxlength="100" /></p>
                <p><label>Descripción de la Incidencia: </label><textarea name="descripcion" rows="4" cols="50" maxlength="100"></textarea></p>
                <p><label>Dependencia: </label>
                <select name="dependenciaId">
                <%
                    out.println("<option value=''></option>");
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    ArrayList<Dependencia> listaDependencias = iCAD.leerDependencias(null, null, IncidenciasCAD.DEPENDENCIA_CODIGO, IncidenciasCAD.ASCENDENTE);
                    for (Dependencia dependencia : listaDependencias) {
                        out.println("<option value='" + dependencia.getDependenciaId() + "'>");
                        out.println(dependencia.getCodigo() + " - " + dependencia.getNombre());
                        out.println("</option>");
                    }
                %>
                </select></p>
                <p><label>Posición del Equipo: </label><textarea name="posicionEquipoDependencia" rows="4" cols="50" maxlength="100"></textarea></p>
            </div>

<%@include file="includes/pie.jsp" %>
