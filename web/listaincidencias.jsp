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
                        <label>Incidencia Id. </label><input name="fechaRegistro" type="text" maxlength="10"/>
                        <label>Descripción </label><input name="descripcion" type="text" maxlength="10"/>
                        <label>Fecha Registro </label><input name="fechaRegistro" type="text" maxlength="10"/>
                        <label>Etiqueta </label><input name="etiqueta" type="text" maxlength="10"/>
                        <label>Estado</label>
                        <select name="estadoId">
                        <%
                            out.println("<option value=''></option>");
                            IncidenciasCAD iCAD = new IncidenciasCAD();
                            ArrayList<Estado> listaEstados = iCAD.leerEstados(null, null, IncidenciasCAD.ESTADO_NOMBRE, IncidenciasCAD.ASCENDENTE);
                            for (Estado estado : listaEstados) {
                                out.println("<option value='" + estado.getEstadoId() + "'>");
                                out.println(estado.getNombre());
                                out.println("</option>");
                            }
                        %>
                        </select>
                        <label>Dependencia</label>
                        <select name="dependenciaId">
                        <%
                            out.println("<option value=''></option>");
                            iCAD = new IncidenciasCAD();
                            ArrayList<Dependencia> listaDependencias = iCAD.leerDependencias(null, null, IncidenciasCAD.DEPENDENCIA_CODIGO, IncidenciasCAD.ASCENDENTE);
                            for (Dependencia dependencia : listaDependencias) {
                                out.println("<option value='" + dependencia.getDependenciaId() + "'>");
                                out.println(dependencia.getCodigo() + " - " + dependencia.getNombre());
                                out.println("</option>");
                            }
                        %>
                        </select></p>
                        <label>Usuario</label>
                        <select name="usuarioId">
                        <%
                            out.println("<option value=''></option>");
                            iCAD = new IncidenciasCAD();
                            ArrayList<Usuario> listaUsuarios = iCAD.leerUsuarios(null, null, null, null, IncidenciasCAD.USUARIO_CUENTA, IncidenciasCAD.ASCENDENTE);
                            for (Usuario usuario : listaUsuarios) {
                                out.println("<option value='" + usuario.getUsuarioId() + "'>");
                                out.println(usuario.getCuenta());
                                out.println("</option>");
                            }
                        %>
                        </select> 
                        <label>Tipo Equipo</label>
                        <select name="tipoEquipoId">
                        <%
                            out.println("<option value=''></option>");
                            iCAD = new IncidenciasCAD();
                            ArrayList<TipoEquipo> listaTiposEquipo = iCAD.leerTiposEquipo(null, null, IncidenciasCAD.TIPO_EQUIPO_CODIGO, IncidenciasCAD.ASCENDENTE);
                            for (TipoEquipo tipoEquipo : listaTiposEquipo) {
                                out.println("<option value='" + tipoEquipo.getTipoEquipoId() + "'>");
                                out.println(tipoEquipo.getCodigo());
                                out.println("</option>");
                            }
                        %>
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
                    <%
                        String mensajeUsuario = (String)request.getAttribute("mensajeUsuario");
                        if (mensajeUsuario != null) out.println(mensajeUsuario);
                    %>
                    <%
                        iCAD = new IncidenciasCAD();
                        ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias();
                        // ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias(null,null,null,null,null,null,null,null,null,null,null,null,null);
                        int cantidadIncidenciasPorPagina = 20;
                        int paginaListaIncidencias = 4;
                        int cantidadPaginasListaIncidencias = 1 + (int) (listaIncidencias.size()/cantidadIncidenciasPorPagina);
                    %>
                    <fieldset>
                        <legend><a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> Pagina <%=paginaListaIncidencias%> de <%=cantidadPaginasListaIncidencias%> <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a></legend>
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
                                            + "<a><img src='img/editar.png' alt='Editar Incidencia' title='Editar Incidencia'></a>&nbsp;&nbsp;"
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
