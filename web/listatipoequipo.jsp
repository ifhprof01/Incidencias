<%-- 
    Document   : listatipoequipo
    Created on : 16-ene-2018, 18:53:36
    Author     : david
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
//                    if (request.getMethod() == "POST") {
                    Integer criterioOrdenacion;
                    Integer orden;
                    if (session.getAttribute("criterioOrdenacion") == null) {
                        criterioOrdenacion = IncidenciasCAD.TIPO_EQUIPO_CODIGO;
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
                    ArrayList<TipoEquipo> listaTipoEquipo = iCAD.leerTiposEquipo(
                            (String)session.getAttribute("codigo"), 
                            (String)session.getAttribute("nombre"),
                            criterioOrdenacion, 
                            orden);
                            
                    int cantidadTipoEquipoPorPagina = 20;
                    int paginaListaTipoEquipo = 1;
                    if (request.getParameter("paginaListaTipoEquipo") == null) {
                            paginaListaTipoEquipo = 1;
                    } else {
                        paginaListaTipoEquipo = Integer.parseInt(request.getParameter("paginaListaTipoEquipo"));
                    }
                    int cantidadPaginasListaIncidencias = 1 + (int) (listaTipoEquipo.size()/cantidadTipoEquipoPorPagina);
                %>
                <fieldset>
                    <legend>
                        <% if(paginaListaTipoEquipo > 1) {%>
                            <a href="listatipoequipo.jsp?paginaListaTipoEquipo=<%=paginaListaTipoEquipo-1%>"><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } else {%>
                            <a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } %>
                        Pagina <%=paginaListaTipoEquipo%> de <%=cantidadPaginasListaIncidencias%> 
                        <% if(paginaListaTipoEquipo < cantidadPaginasListaIncidencias) {%>
                            <a href="listatipoequipo.jsp?paginaListaTipoEquipo=<%=paginaListaTipoEquipo+1%>"><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } else {%>
                            <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } %>
                    </legend>
                    <form method="post" action="listatipoequipo.jsp">
                        <p class="derecha">
                            <label>Ordenar por</label>
                            <select name="criterioOrdenacion">
                                <option value="<%=IncidenciasCAD.TIPO_EQUIPO_CODIGO%>" <%if (IncidenciasCAD.TIPO_EQUIPO_CODIGO == criterioOrdenacion) out.print("selected='selected'");%>>Codigo</option>
                                <option value="<%=IncidenciasCAD.TIPO_EQUIPO_NOMBRE %>" <%if (IncidenciasCAD.TIPO_EQUIPO_NOMBRE == criterioOrdenacion) out.print("selected='selected'");%>>Nombre</option>                                
                            </select> 
                            <select name="orden">                              
                                <option value="<%= IncidenciasCAD.ASCENDENTE%>" <%if (IncidenciasCAD.ASCENDENTE == orden) out.print("selected='selected'");%>>Ascendente</option>
                                <option value="<%= IncidenciasCAD.DESCENDENTE%>" <%if (IncidenciasCAD.DESCENDENTE == orden) out.print("selected='selected'");%>>Descendente</option>
                            </select> 
                        </p>
                        <table align="center" border="2" cellspacing="0" style="width: 100%">
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>
                                    <a href="altatipoequipo.jsp"><img src="img/anadir.png" alt="Añadir Tipo Equipo" title="Añadir Tipo Equipo"></a>
                                </th>
                            </tr>
                            <tr>
                                <input type="hidden" name="actualizarFiltro" value="s"/>                               
                                <td><input type="text" name="codigo" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("codigo")))%>"/></td>
                                <td><input type="text" name="nombre" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("nombre")))%>"/></td>      
                                <td><input type="submit" value="Aplicar Filtro"/></td>                              
                            </tr>
                            <%  
                                TipoEquipo tipoEquipo;
                                int posIni = (paginaListaTipoEquipo-1) * cantidadTipoEquipoPorPagina;
                                int pos = posIni;
                                while (listaTipoEquipo.size() > pos && pos < posIni + cantidadTipoEquipoPorPagina) {
                                    tipoEquipo = listaTipoEquipo.get(pos);
                                    pos++;
                                    out.println("<tr>");
                                    out.println("   <td>" + tipoEquipo.getCodigo()+ "</td>");
                                    out.println("   <td>" + tipoEquipo.getNombre()+ "</td>");
                                    out.println("   <td>"
                                            + "<a href='bajatipoequipo.jsp?tipoEquipoId="+tipoEquipo.getTipoEquipoId()+"'><img src='img/borrar.png' alt='Borrar Incidencia' title='Borrar Incidencia'></a>&nbsp;&nbsp;"
                                            + "<a href='modificaciontipoequipo.jsp?tipoEquipoId="+tipoEquipo.getTipoEquipoId()+"'><img src='img/editar.png' alt='Modificar Incidencia' title='Modificar Incidencia'></a>&nbsp;&nbsp;"
                                            + "<a><img src='img/detalle.png' alt='Ver Detalle de Incidencia' title='Ver Detalle de Incidencia'></a>"
                                            + "</td>");
                                    out.println("</tr>");
                                } 

                            %>
                        </table>
                    </form>
                </fieldset>
            </div>

<%@include file="includes/pie.jsp" %>
