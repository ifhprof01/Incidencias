<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

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
                <form id="filtro">
                    <fieldset>
                        <legend>Filtro y Ordenación</legend>
                        <label>Incidencia Id. </label><input name="fechaRegistro" type="text" maxlength="10"/>
                        <label>Descripción </label><input name="descripcion" type="text" maxlength="10"/>
                        <label>Fecha Registro </label><input name="fechaRegistro" type="text" maxlength="10"/>
                        <label>Etiqueta </label><input name="etiqueta" type="text" maxlength="10"/>
                        <label>Estado</label>
                        <select name="estado">
                            <option selected="selected" value="Ford">Ford</option>
                            <option value="Opel">Opel</option>
                            <option value="Citroen">Citroen</option>
                            <option value="Bmw">BMW</option>
                            <option value="Mercedes">Mercedes</option>
                            <option value="Nissan">AUDI</option>
                            <option value="Seat">Seat</option>
                        </select> 
                        <label>Dependencia</label>
                        <select name="dependencia">
                            <option selected="selected" value="Ford">Ford</option>
                            <option value="Opel">Opel</option>
                            <option value="Citroen">Citroen</option>
                            <option value="Bmw">BMW</option>
                            <option value="Mercedes">Mercedes</option>
                            <option value="Nissan">AUDI</option>
                            <option value="Seat">Seat</option>
                        </select> 
                        <label>Usuario</label>
                        <select name="usuario">
                            <option selected="selected" value="Ford">Ford</option>
                            <option value="Opel">Opel</option>
                            <option value="Citroen">CitroenCitroenCitroenCitroenCitroenCitroenCitroenCitroen</option>
                            <option value="Bmw">BMW</option>
                            <option value="Mercedes">Mercedes</option>
                            <option value="Nissan">AUDI</option>
                            <option value="Seat">Seat</option>
                        </select> 
                        <label>Tipo Equipo</label>
                        <select name="tipoEquipo">
                            <option selected="selected" value="Ford">Ford</option>
                            <option value="Opel">Opel</option>
                            <option value="Citroen">Citroen</option>
                            <option value="Bmw">BMW</option>
                            <option value="Mercedes">Mercedes</option>
                            <option value="Nissan">AUDI</option>
                            <option value="Seat">Seat</option>
                        </select> 
                        <label>Ordenar por</label>
                        <select name="criterioOrdenacion">
                            <option selected="selected" value="Ford">Ford</option>
                            <option value="Opel">Opel</option>
                            <option value="Citroen">Citroen</option>
                            <option value="Bmw">BMW</option>
                            <option value="Mercedes">Mercedes</option>
                            <option value="Nissan">AUDI</option>
                            <option value="Seat">Seat</option>
                        </select> 
                        <select name="orden">
                            <option selected="selected" value="Ford">Ascendente</option>
                            <option value="Opel">Descendente</option>
                        </select> 
                    </fieldset>
                </form>
                <form>
                    <%
                        IncidenciasCAD iCAD = new IncidenciasCAD();
                        ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias();
                        // ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias(null,null,null,null,null,null,null,null,null,null,null,null,null);
                        int cantidadIncidenciasPorPagina = 20;
                        int paginaListaIncidencias = 1;
                        int cantidadPaginasListaIncidencias = 1 + (int) (listaIncidencias.size()/cantidadIncidenciasPorPagina);
                    %>
                    <fieldset>
                        <legend>&lt; Pagina <%=paginaListaIncidencias%> de <%=cantidadPaginasListaIncidencias%> &gt;</legend>
                        <table align="center" border="2" cellspacing="0" style="width: 100%">
                            <tr>
                                <th>Id</th>
                                <th>Fecha Registro</th>
                                <th>Descripción</th>
                                <th>Estado</th>
                                <th>Usuario</th>
                                <th>Dependencia</th>
                                <th>Etiqueta</th>
                                <th>Tipo Equipo</th>
                                <th>
                                    <a><img src="img/anadir.png" alt="Añadir Incidencia" title="Añadir Incidencia"></a>
                                </th>
                            </tr>
                            <%  
                                Incidencia incidencia;
                                int posIni = (paginaListaIncidencias-1) * cantidadIncidenciasPorPagina;
                                int pos = posIni;
                                while (listaIncidencias.size() > pos && pos < posIni + cantidadIncidenciasPorPagina) {
                                    incidencia = listaIncidencias.get(pos);
                                    pos++;
                                    out.println("<tr>");
                                    out.println("   <td>" + incidencia.getIncidenciaId() + "</td>");
                                    out.println("   <td>" + incidencia.getFechaRegistro() + "</td>");
                                    out.println("   <td>" + incidencia.getDescripcion() + "</td>");
                                    out.println("   <td>" + incidencia.getEstado().getCodigo() + "</td>");
                                    out.println("   <td>" + incidencia.getUsuario().getCuenta() + "</td>");
                                    out.println("   <td>" + incidencia.getDependencia().getCodigo() + "</td>");
                                    out.println("   <td>" + incidencia.getEquipo().getNumeroEtiquetaConsejeria()+ "</td>");
                                    out.println("   <td>" + incidencia.getEquipo().getTipoEquipo().getCodigo() + "</td>");
                                    out.println("   <td>"
                                            + "<a><img src='img/borrar.png' alt='Borrar Incidencia' title='Borrar Incidencia'></a>&nbsp;&nbsp;"
                                            + "<a><img src='img/editar.png' alt='Editar Incidencia' title='Editar Incidencia'></a>"
                                            + "</td>");
                                    out.println("</tr>");
                                } 
                            
                            %>
                        </table>
                    </fieldset>
                </form>
            </div>
            <div id="footer">
                <span>IES Miguel Herrero. Curso 2017/2018</span>
            </div>
        </div>

    </body>
</html>
