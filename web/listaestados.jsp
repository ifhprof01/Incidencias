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

            <div id="content">
<%@include file="includes/mensajeusuario.jsp" %>
                <%
                    Integer criterioOrdenacion;
                    Integer orden;
                    if (session.getAttribute("criterioOrdenacion") == null) {
                        criterioOrdenacion = IncidenciasCAD.ESTADO_CODIGO;
                        orden = IncidenciasCAD.ASCENDENTE;
                    } else {
                        criterioOrdenacion = (Integer) session.getAttribute("criterioOrdenacion");
                        orden = (Integer) session.getAttribute("orden");
                    }
                    if (request.getParameter("actualizarFiltro") != null) {
                        criterioOrdenacion = Integer.parseInt(request.getParameter("criterioOrdenacion"));
                        orden = Integer.parseInt(request.getParameter("orden"));
                        session.setAttribute("criterioOrdenacion", criterioOrdenacion);
                        session.setAttribute("orden", orden);
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
                    ArrayList<Estado> listaEstados = iCAD.leerEstados((String)session.getAttribute("estadoCodigo"), (String)session.getAttribute("estadoNombre"), criterioOrdenacion, orden);
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
                            <a href="listaincidencias.jsp?paginaListaIncidencias=<%=paginaListaEstados-1%>"><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } else {%>
                            <a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } %>
                        Pagina <%=paginaListaEstados%> de <%=cantidadPaginasListaIncidencias%> 
                        <% if(paginaListaEstados < cantidadPaginasListaIncidencias) {%>
                            <a href="listaincidencias.jsp?paginaListaIncidencias=<%=paginaListaEstados+1%>"><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } else {%>
                            <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } %>
                    </legend>
                    <form method="post" action="listaestados.jsp">
                        <p class="derecha">
                            <label>Ordenar por</label>
                            <select name="criterioOrdenacion">
                                <option value="<%=IncidenciasCAD.ESTADO_CODIGO %>" <%if (IncidenciasCAD.ESTADO_CODIGO == criterioOrdenacion) out.print("selected='selected'");%>>Código</option>
                                <option value="<%=IncidenciasCAD.ESTADO_NOMBRE %>" <%if (IncidenciasCAD.ESTADO_NOMBRE == criterioOrdenacion) out.print("selected='selected'");%>>Nombre</option>
                            </select> 
                            <select name="orden">
                                <option value="<%= IncidenciasCAD.ASCENDENTE%>" <%if (IncidenciasCAD.ASCENDENTE == orden) out.print("selected='selected'");%>>Ascendente</option>
                                <option value="<%= IncidenciasCAD.DESCENDENTE%>" <%if (IncidenciasCAD.DESCENDENTE == orden) out.print("selected='selected'");%>>Descendente</option>
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
                                            + "<a><img src='img/detalle.png' alt='Ver Detalle de Estado' title='Ver Detalle de Estado'></a>"
                                            + "</td>");
                                    out.println("</tr>");
                                } 

                            %>
                        </table>
                    </form>
                </fieldset>
            </div>

<%@include file="includes/pie.jsp" %>
