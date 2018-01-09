<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
--%>

<%@page import="incidenciascad.TipoEquipo"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Estado"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>

            <div id="content">
                <form id="filtro">
                    <fieldset>
                        <legend>Filtro y Ordenación</legend>
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
                            <option selected="selected" value="<%= IncidenciasCAD.ASCENDENTE%>">Ascendente</option>
                            <option value="<%= IncidenciasCAD.DESCENDENTE%>">Descendente</option>
                        </select> 
                    </fieldset>
                </form>
                <form>
<%@include file="includes/mensajeusuario.jsp" %>
                    <%
                        IncidenciasCAD iCAD = new IncidenciasCAD();
                        ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias();
                        // ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias(null,null,null,null,null,null,null,null,null,null,null,null,null);
                        int cantidadIncidenciasPorPagina = 20;
                        int paginaListaIncidencias = 4;
                        if (request.getParameter("paginaListaIncidencias") == null) {
                                paginaListaIncidencias = 1;
                        } else {
                            paginaListaIncidencias = Integer.parseInt(request.getParameter("paginaListaIncidencias"));
                        }
                        int cantidadPaginasListaIncidencias = 1 + (int) (listaIncidencias.size()/cantidadIncidenciasPorPagina);
                    %>
                    <fieldset>
                        <legend>
                            <% if(paginaListaIncidencias > 1) {%>
                                <a href="listaincidencias.jsp?paginaListaIncidencias=<%=paginaListaIncidencias-1%>"><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                            <% } else {%>
                                <a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                            <% } %>
                            Pagina <%=paginaListaIncidencias%> de <%=cantidadPaginasListaIncidencias%> 
                            <% if(paginaListaIncidencias < cantidadPaginasListaIncidencias) {%>
                                <a href="listaincidencias.jsp?paginaListaIncidencias=<%=paginaListaIncidencias+1%>"><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                            <% } else {%>
                                <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                            <% } %>
                        </legend>
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
                                    <a href="altaincidencia.jsp"><img src="img/anadir.png" alt="Añadir Incidencia" title="Añadir Incidencia"></a>
                                </th>
                            </tr>
                            <tr>
                                <form method="post" action="listaincidencias.jsp">
                                    <td><input type="text" name="incidenciaId" value="<%=session.getAttribute("incidenciaId")%>"/></td>
                                    <td><input type="date" name="fechaRegistro"/></td>
                                    <td><input type="text" name="descripcion"/></td>
                                    <td>
                                        <select name="estadoId">
                                        <%
                                            out.println("<option value=''></option>");
                                            iCAD = new IncidenciasCAD();
                                            ArrayList<Estado> listaEstados = iCAD.leerEstados(null, null, IncidenciasCAD.ESTADO_NOMBRE, IncidenciasCAD.ASCENDENTE);
                                            for (Estado estado : listaEstados) {
                                                out.println("<option value='" + estado.getEstadoId() + "' title='" + estado.getNombre() + "'>");
                                                out.println(estado.getCodigo());
                                                out.println("</option>");
                                            }
                                        %>
                                        </select>
                                    </td>
                                    <td>
                                        <select name="usuarioId">
                                        <%
                                            out.println("<option value=''></option>");
                                            iCAD = new IncidenciasCAD();
                                            ArrayList<Usuario> listaUsuarios = iCAD.leerUsuarios(null, null, null, null, IncidenciasCAD.USUARIO_CUENTA, IncidenciasCAD.ASCENDENTE);
                                            for (Usuario usuario : listaUsuarios) {
                                                out.println("<option value='" + usuario.getUsuarioId() + "' title='" + usuario.getNombre() + " " + usuario.getApellido() + "'>");
                                                out.println(usuario.getCuenta());
                                                out.println("</option>");
                                            }
                                        %>
                                        </select> 
                                    </td>
                                    <td>
                                        <select name="dependenciaId">
                                        <%
                                            out.println("<option value=''></option>");
                                            iCAD = new IncidenciasCAD();
                                            ArrayList<Dependencia> listaDependencias = iCAD.leerDependencias(null, null, IncidenciasCAD.DEPENDENCIA_CODIGO, IncidenciasCAD.ASCENDENTE);
                                            for (Dependencia dependencia : listaDependencias) {
                                                out.println("<option value='" + dependencia.getDependenciaId() + "' title='" + dependencia.getNombre() + "'>");
                                                out.println(dependencia.getCodigo());
                                                out.println("</option>");
                                            }
                                        %>
                                        </select>
                                    </td>
                                    <td><input type="text" name="descripcion"/></td>
                                    <td>
                                        <select name="tipoEquipoId">
                                        <%
                                            out.println("<option value=''></option>");
                                            iCAD = new IncidenciasCAD();
                                            ArrayList<TipoEquipo> listaTiposEquipo = iCAD.leerTiposEquipo(null, null, IncidenciasCAD.TIPO_EQUIPO_CODIGO, IncidenciasCAD.ASCENDENTE);
                                            for (TipoEquipo tipoEquipo : listaTiposEquipo) {
                                                out.println("<option value='" + tipoEquipo.getTipoEquipoId() + "' title='" + tipoEquipo.getNombre()+ "'>");
                                                out.println(tipoEquipo.getCodigo());
                                                out.println("</option>");
                                            }
                                        %>
                                        </select> 
                                    </td>
                                    <td><input type="submit" value="Aplicar Filtro"/></td>
                                </form>
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
                                            + "<a href='bajaincidencia.jsp?incidenciaId="+incidencia.getIncidenciaId()+"'><img src='img/borrar.png' alt='Borrar Incidencia' title='Borrar Incidencia'></a>&nbsp;&nbsp;"
                                            + "<a href='modificacionincidencia.jsp?incidenciaId="+incidencia.getIncidenciaId()+"'><img src='img/editar.png' alt='Modificar Incidencia' title='Modificar Incidencia'></a>&nbsp;&nbsp;"
                                            + "<a><img src='img/detalle.png' alt='Ver Detalle de Incidencia' title='Ver Detalle de Incidencia'></a>"
                                            + "</td>");
                                    out.println("</tr>");
                                } 
                            
                            %>
                        </table>
                    </fieldset>
                </form>
            </div>

<%@include file="includes/pie.jsp" %>
