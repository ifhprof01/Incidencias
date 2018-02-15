<%-- 
    Document   : listadependencia.jsp
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
                    Integer criterioOrdenacion;
                    Integer orden;
                    if (session.getAttribute("criterioOrdenacion") == null) {
                        criterioOrdenacion = IncidenciasCAD.DEPENDENCIA_CODIGO;
                        orden = IncidenciasCAD.DESCENDENTE;
                    } else {
                        criterioOrdenacion = (Integer) session.getAttribute("criterioOrdenacion");
                        orden = (Integer) session.getAttribute("orden");
                    }
                    if (request.getParameter("actualizarFiltro") != null) {
                        criterioOrdenacion = Integer.parseInt(request.getParameter("criterioOrdenacion"));
                        orden = Integer.parseInt(request.getParameter("orden"));
                        session.setAttribute("criterioOrdenacion", criterioOrdenacion);
                        session.setAttribute("orden", orden);
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("codigo")).equals("")) {
                            session.setAttribute("codigo", request.getParameter("codigo"));
                        } else {
                            session.removeAttribute("codigo");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("nombre")).equals("")) {
                            session.setAttribute("nombre", request.getParameter("nombre"));
                        } else {
                            session.removeAttribute("nombre");
                        }
                        
                    }
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    //ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias();
                    //out.println("criterioOrdenacion: " + criterioOrdenacion);
                    //out.println("orden " + orden);
                    ArrayList<Dependencia> listaDependencias = iCAD. leerDependencias(
                            (String)session.getAttribute("codigo"),
                            (String)session.getAttribute("nombre"),
                            criterioOrdenacion,
                            orden);
                    int cantidadDependenciasPorPagina = 20;
                    int paginaListaDependencias = 4;
                    if (request.getParameter("paginaListaDependencias") == null) {
                            paginaListaDependencias = 1;
                    } else {
                        paginaListaDependencias = Integer.parseInt(request.getParameter("paginaListaDependencias"));
                    }
                    int cantidadPaginasListaIncidencias = 1 + (int) (listaDependencias.size()/cantidadDependenciasPorPagina);
                %>
                <fieldset>
                    <legend>
                        <% if(paginaListaDependencias > 1) {%>
                            <a href="listadependencias.jsp?paginaListaDependencias=<%=paginaListaDependencias-1%>"><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } else {%>
                            <a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } %>
                        Pagina <%=paginaListaDependencias%> de <%=cantidadPaginasListaIncidencias%> 
                        <% if(paginaListaDependencias < cantidadPaginasListaIncidencias) {%>
                            <a href="listadependencias.jsp?paginaListaDependencias=<%=paginaListaDependencias+1%>"><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } else {%>
                            <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } %>
                    </legend>
                    <form method="post" action="listadependencias.jsp">
                        <p class="derecha">
                            <label>Ordenar por</label>
                            <select name="criterioOrdenacion">
                                <option value="<%=IncidenciasCAD.DEPENDENCIA_CODIGO %>" <%if (IncidenciasCAD.DEPENDENCIA_CODIGO == criterioOrdenacion) out.print("selected='selected'");%>>Codigo</option>
                                <option value="<%=IncidenciasCAD.DEPENDENCIA_NOMBRE %>" <%if (IncidenciasCAD.DEPENDENCIA_NOMBRE == criterioOrdenacion) out.print("selected='selected'");%>>Nombre</option>
                            </select> 
                            <select name="orden">
                                
                                <option value="<%= IncidenciasCAD.ASCENDENTE%>" <%if (IncidenciasCAD.ASCENDENTE == orden) out.print("selected='selected'");%>>Ascendente</option>
                                <option value="<%= IncidenciasCAD.DESCENDENTE%>" <%if (IncidenciasCAD.DESCENDENTE == orden) out.print("selected='selected'");%>>Descendente</option>
                            </select> 
                            <input type="submit" value="Aplicar Filtro"/>
                        </p>
                        <table align="center" border="2" cellspacing="0" style="width: 100%">
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>
                                    <a href="altadependencia.jsp"><img src="img/anadir.png" alt="Añadir dependencia" title="Añadir dependencia"></a>
                                </th>
                            </tr>
                            <tr>
                                <input type="hidden" name="actualizarFiltro" value="s"/>
                                <td><input type="text" name="codigo" value="<%=Utilidades.convertirNullAStringVacio((String)session.getAttribute("codigo"))%>"/></td>
                                <td><input type="text" name="nombre" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("nombre")))%>"/></td>
                                <td></td>
                            </tr>
                            <%  
                                Dependencia dependencia;
                                int posIni = (paginaListaDependencias-1) * cantidadDependenciasPorPagina;
                                int pos = posIni;
                                while (listaDependencias.size() > pos && pos < posIni + cantidadDependenciasPorPagina) {
                                    dependencia = listaDependencias.get(pos);
                                    pos++;
                                    out.println("<tr>");
                                    out.println("   <td>" + dependencia.getCodigo()+ "</td>");
                                    out.println("   <td>" + dependencia.getNombre()+ "</td>");
                                    out.println("   <td>"
                                            + "<a href='bajadependencia.jsp?dependenciaId="+dependencia.getDependenciaId()+"'><img src='img/borrar.png' alt='Borrar Dependencia' title='Borrar Dependencia'></a>&nbsp;&nbsp;"
                                            + "<a href='modificaciondependencia.jsp?dependenciaId="+dependencia.getDependenciaId()+"'><img src='img/editar.png' alt='Modificar Dependencia' title='Modificar Dependencia'></a>&nbsp;&nbsp;"
                                            + "<a href='consultadependencia.jsp?dependenciaId="+dependencia.getDependenciaId()+"'><img src='img/detalle.png' alt='Ver Detalle de Dependencia' title='Ver Detalle de Dependencia'></a>"
                                            + "</td>");
                                    out.println("</tr>");
                                } 
                            %>
                        </table>
                    </form>
                </fieldset>
            </div>

<%@include file="includes/pie.jsp" %>
