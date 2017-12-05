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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Incidencias - Lista de Incidencias</title>
        <link href="css/style.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="container">
            <div id="banner">
                <span>Gestión de Incidencias</span>
            </div>
            <div id="menu">
                <ul>
                  <li><a class="active" href="#home">Incidencias</a></li>
                  <li><a href="#news">Tipos de Equipo</a></li>
                  <li><a href="#contact">Equipos</a></li>
                  <li><a href="#about">Dependencias</a></li>
                  <li><a href="#about">Estados</a></li>
                  <li><a href="#about">Dependencias</a></li>
                  <li><a href="#about">Configuración</a></li>
                  <li><a href="#about">Salir (Pepe Ruiz Sol)</a></li>
                </ul>
            </div>
            <div id="content">
                <h2>Alta de Incidencia</h2>
                <p><label>Etiqueta del Equipo: </label><input name="numeroEtiquetaConsejeria" type="text" maxlength="100" /></p>
                <p><label>Descripción de la Incidencia: </label><textarea name="descripcion" rows="4" cols="50" maxlength="100"></textarea></p>
                <p><label>Dependencia: </label>
                <select name="dependenciaId">
                <%
                    out.println("<option value=''></option>");
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    ArrayList<Dependencia> listaDependencias = iCAD.leerDependencias();
                    Dependencia dependencia = null;
                    int pos = 0;
                    while (listaDependencias.size() > pos) {
                        dependencia = listaDependencias.get(pos);
                        out.println("<option value='" + dependencia.getDependenciaId() + "'>");
                        out.println(dependencia.getCodigo() + " - " + dependencia.getNombre());
                        out.println("</option>");
                        pos++;
                    }
                %>
                </select></p>
                <p><label>Posición del Equipo: </label><textarea name="posicionEquipoDependencia" rows="4" cols="50" maxlength="100"></textarea></p>
            </div>
            <div id="footer">
                <span>IES Miguel Herrero. Curso 2017/2018</span>
            </div>
        </div>

    </body>
</html>
