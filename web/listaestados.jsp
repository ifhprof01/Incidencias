<%-- 
    Document   : listaestados.jsp
    Created on : 16-ene-2018, 18:54:18
    Author     : DAW216
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.TipoEquipo"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Estado"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    Integer criterioOrdenacionEstados;
                    Integer ordenEstados;
                    if (session.getAttribute("criterioOrdenacionEstados") == null) {
                        criterioOrdenacionEstados = IncidenciasCAD.ESTADO_CODIGO;
                        ordenEstados = IncidenciasCAD.ASCENDENTE;
                    } else {
                        criterioOrdenacionEstados = (Integer) session.getAttribute("criterioOrdenacionEstados");
                        ordenEstados = (Integer) session.getAttribute("ordenEstados");
                    }
                    if (request.getParameter("actualizarFiltro") != null) {
                        criterioOrdenacionEstados = Integer.parseInt(request.getParameter("criterioOrdenacionEstados"));
                        ordenEstados = Integer.parseInt(request.getParameter("ordenEstados"));
                        session.setAttribute("criterioOrdenacionEstados", criterioOrdenacionEstados);
                        session.setAttribute("ordenEstados", ordenEstados);
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("estadoCodigo")).equals("")) {
                            session.setAttribute("estadoCodigo", request.getParameter("estadoCodigo"));
                        } else {
                            session.removeAttribute("estadoCodigo");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("estadoNombre")).equals("")) {
                            session.setAttribute("estadoNombre", request.getParameter("estadoNombre"));
                        } else {
                            session.removeAttribute("estadoNombre");
                        }
                    }
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    //ArrayList<Estado> listaEstados = iCAD.leerEstados();
                    ArrayList<Estado> listaEstados = iCAD.leerEstados((String)session.getAttribute("estadoCodigo"), (String)session.getAttribute("estadoNombre"), criterioOrdenacionEstados, ordenEstados);
                    int cantidadEstadosPorPagina = 20;
                    int paginaListaEstados = 4;
                    if (request.getParameter("paginaListaEstados") == null) {
                            paginaListaEstados = 1;
                    } else {
                        paginaListaEstados = Integer.parseInt(request.getParameter("paginaListaEstados"));
                    }
                    int cantidadPaginasListaIncidencias = 1 + (int) (listaEstados.size()/cantidadEstadosPorPagina);
                %>
                <fieldset>
                    <legend>
                        <% if(paginaListaEstados > 1) {%>
                            <a href="listaestados.jsp?paginaListaEstados=<%=paginaListaEstados-1%>"><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } else {%>
                            <a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } %>
                        Pagina <%=paginaListaEstados%> de <%=cantidadPaginasListaIncidencias%> 
                        <% if(paginaListaEstados < cantidadPaginasListaIncidencias) {%>
                            <a href="listaestados.jsp?paginaListaEstados=<%=paginaListaEstados+1%>"><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } else {%>
                            <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } %>
                    </legend>
                    <form method="post" action="listaestados.jsp">
                        <p class="derecha">
                            <label>Ordenar por</label>
                            <select name="criterioOrdenacionEstados">
                                <option value="<%=IncidenciasCAD.ESTADO_CODIGO %>" <%if (IncidenciasCAD.ESTADO_CODIGO == criterioOrdenacionEstados) out.print("selected='selected'");%>>Código</option>
                                <option value="<%=IncidenciasCAD.ESTADO_NOMBRE %>" <%if (IncidenciasCAD.ESTADO_NOMBRE == criterioOrdenacionEstados) out.print("selected='selected'");%>>Nombre</option>
                            </select> 
                            <select name="ordenEstados">
                                <option value="<%= IncidenciasCAD.ASCENDENTE%>" <%if (IncidenciasCAD.ASCENDENTE == ordenEstados) out.print("selected='selected'");%>>Ascendente</option>
                                <option value="<%= IncidenciasCAD.DESCENDENTE%>" <%if (IncidenciasCAD.DESCENDENTE == ordenEstados) out.print("selected='selected'");%>>Descendente</option>
                            </select> 
                            <input type="submit" value="Aplicar Filtro"/>
                        </p>
                        <table align="center" border="2" cellspacing="0" style="width: 100%">
                            <tr>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>
                                    <a href="altaestado.jsp"><img src="img/anadir.png" alt="Añadir estado" title="Añadir Estado"></a>
                                </th>
                            </tr>
                            <tr>
                                <input type="hidden" name="actualizarFiltro" value="s"/>
                                <td>
                                    <input type="text" name="estadoCodigo" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("estadoCodigo")))%>"/>
                                </td>
                                <td>
                                     <input type="text" name="estadoNombre" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("estadoNombre")))%>"/>
                                </td>
                                <td></td>
                            </tr>
                            <%  
                                Estado estado;
                                int posIni = (paginaListaEstados-1) * cantidadEstadosPorPagina;
                                int pos = posIni;
                                while (listaEstados.size() > pos && pos < posIni + cantidadEstadosPorPagina) {
                                    estado = listaEstados.get(pos);
                                    pos++;
                                    out.println("<tr>");
                                    out.println("   <td>" + estado.getCodigo() + "</td>");
                                    out.println("   <td>" + estado.getNombre() + "</td>");
                                    out.println("   <td>"
                                            + "<a href='bajaestado.jsp?estadoId="+estado.getEstadoId()+"'><img src='img/borrar.png' alt='Borrar Estado' title='Borrar Estado'></a>&nbsp;&nbsp;"
                                            + "<a href='modificacionestado.jsp?estadoId="+estado.getEstadoId()+"'><img src='img/editar.png' alt='Modificar Estado' title='Modificar Estado'></a>&nbsp;&nbsp;"
                                            + "<a href='consultaestado.jsp?estadoId="+estado.getEstadoId()+"'><img src='img/detalle.png' alt='Ver Detalle de Estado' title='Ver Detalle de Estado'></a>"
                                            + "</td>");
                                    out.println("</tr>");
                                } 

                            %>
                        </table>
                    </form>
                </fieldset>
            </div>

<%@include file="includes/pie.jsp" %>
