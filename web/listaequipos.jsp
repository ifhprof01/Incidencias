<%-- 
    Document   : listaEquipos
    Created on : 16-ene-2018, 19:04:42
    Author     : usuario
--%>
<%@page import="incidenciascad.Equipo"%>
<%@page import="incidenciascad.TipoEquipo"%>
<%@page import="incidenciascad.Dependencia"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="incidenciascad.Estado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.Incidencia"%>
<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

<div id="content">
    <%@include file="includes/mensajeusuario.jsp" %>
    <%//                    if (request.getMethod() == "POST") {
        Integer criterioOrdenacion;
        Integer orden;
        if (session.getAttribute("criterioOrdenacionEquipo") == null) {
            criterioOrdenacion = IncidenciasCAD.EQUIPO_NUMERO_ETIQUETA_CONSEJERIA;
            orden = IncidenciasCAD.DESCENDENTE;
        } else {
            criterioOrdenacion = (Integer) session.getAttribute("criterioOrdenacionEquipo");
            orden = (Integer) session.getAttribute("ordenEquipo");
        }

        if (session.getAttribute("criterioOrdenacionEquipo") == null) {
            criterioOrdenacion = IncidenciasCAD.EQUIPO_NUMERO_ETIQUETA_CONSEJERIA;
            orden = IncidenciasCAD.ASCENDENTE;
        } else {
            criterioOrdenacion = (Integer) session.getAttribute("criterioOrdenacionEquipo");
            orden = (Integer) session.getAttribute("ordenEquipo");
        }
        if (request.getParameter("actualizarFiltro") != null) {
            criterioOrdenacion = Integer.parseInt(request.getParameter("criterioOrdenacionEquipo"));
            orden = Integer.parseInt(request.getParameter("ordenEquipo"));
            session.setAttribute("criterioOrdenacionEquipo", criterioOrdenacion);
            session.setAttribute("ordenEquipo", orden);
            if (!Utilidades.convertirNullAStringVacio(request.getParameter("numeroEtiquetaConsejeria")).equals("")) {
                session.setAttribute("numeroEtiquetaConsejeria", request.getParameter("numeroEtiquetaConsejeria"));
            } else {
                session.removeAttribute("numeroEtiquetaConsejeria");
            }
            if (!Utilidades.convertirNullAStringVacio(request.getParameter("tipoEquipoNombre")).equals("")) {
                session.setAttribute("tipoEquipoNombre", (Integer.parseInt(request.getParameter("tipoEquipoNombre"))));
            } else {
                session.removeAttribute("tipoEquipoNombre");
            }

        }
        IncidenciasCAD iCAD = new IncidenciasCAD();
        //ArrayList<Equipo> listaEquipos =  iCAD.leerEquipos();
        //out.println("criterioOrdenacion: " + criterioOrdenacion);
        //out.println("orden " + orden);
        ArrayList<Equipo> listaEquipos = iCAD.leerEquipos((String) session.getAttribute("numeroEtiquetaConsejeria"), (Integer) session.getAttribute("tipoEquipoNombre"), criterioOrdenacion, orden);

        int cantidadEquipoPorPagina = 20;
        int paginaListaEquipos = 4;
        if (request.getParameter("paginaListaEquipos") == null) {
            paginaListaEquipos = 1;
        } else {
            paginaListaEquipos = Integer.parseInt(request.getParameter("paginaListaEquipos"));
        }
        int cantidadPaginasListaEquipos = 1 + (int) (listaEquipos.size() / cantidadEquipoPorPagina);
    %>
    <fieldset>
        <legend>
            <% if (paginaListaEquipos > 1) {%>
            <a href="listaequipos.jsp?paginaListaEquipos=<%=paginaListaEquipos - 1%>"><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                <% } else {%>
            <a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                <% }%>
            Pagina <%=paginaListaEquipos%> de <%=cantidadPaginasListaEquipos%> 
            <% if (paginaListaEquipos < cantidadPaginasListaEquipos) {%>
            <a href="listaequipos.jsp?paginaListaEquipos=<%=paginaListaEquipos + 1%>"><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                <% } else {%>
            <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                <% }%>
        </legend>
        <form method="post" action="listaequipos.jsp">
            <p class="derecha">
                <label>Ordenar por</label>
                <select name="criterioOrdenacionEquipo">
                        <option value="<%=IncidenciasCAD.EQUIPO_NUMERO_ETIQUETA_CONSEJERIA%>" <%if (IncidenciasCAD.EQUIPO_NUMERO_ETIQUETA_CONSEJERIA == criterioOrdenacion) {
                            out.print("selected='selected'");
                        }%>>Numero de Etiqueta de Conserjeria</option>
                            <option value="<%=IncidenciasCAD.TIPO_EQUIPO_NOMBRE%>" <%if (IncidenciasCAD.TIPO_EQUIPO_NOMBRE == criterioOrdenacion) {
                            out.print("selected='selected'");
                        }%>>Nombre de Tipo de Equipo</option>
                </select> 
                <select name="ordenEquipo">
                        <option value="<%= IncidenciasCAD.ASCENDENTE%>" <%if (IncidenciasCAD.ASCENDENTE == orden) {
                            out.print("selected='selected'");
                        }%>>Ascendente</option>
                            <option value="<%= IncidenciasCAD.DESCENDENTE%>" <%if (IncidenciasCAD.DESCENDENTE == orden) {
                            out.print("selected='selected'");
                        }%>>Descendente</option>
                </select> 
            <td><input type="submit" value="Aplicar Filtro"/></td>
            </p>
            <table align="center" border="2" cellspacing="0" style="width: 100%">
                <tr>

                    <th>Numero de Etiqueta Conserjeria</th>
                    <th>Nombre Tipo Equipo</th>
                    <th>
                        <a href="altaequipo.jsp"><img src="img/anadir.png" alt="Añadir Equipo" title="Añadir Equipo"></a>
                    </th>
                </tr>
                <tr>
                <input type="hidden" name="actualizarFiltro" value="s"/>
                <td><input type="text" name="numeroEtiquetaConsejeria" value="<%=Utilidades.convertirNullAStringVacio(((String) session.getAttribute("numeroEtiquetaConsejeria")))%>"/></td>
                <td>
                    <select name="tipoEquipoNombre">
                        <%
                            out.println("<option value=''></option>");
                            iCAD = new IncidenciasCAD();
                            ArrayList<Equipo> listaEquipo = iCAD.leerEquipos(null, null, IncidenciasCAD.TIPO_EQUIPO_CODIGO, IncidenciasCAD.ASCENDENTE);
                            for (Equipo equipo : listaEquipo) {
                                if (session.getAttribute("tipoEquipoNombre") == equipo.getTipoEquipo().getTipoEquipoId()) {
                                    out.println("<option value='" + equipo.getTipoEquipo().getTipoEquipoId() + "' title='" + equipo.getTipoEquipo().getNombre() + "' selected>");
                                } else {
                                    out.println("<option value='" + equipo.getTipoEquipo().getTipoEquipoId() + "' title='" + equipo.getTipoEquipo().getNombre() + "'>");
                                }
                                out.println(equipo.getTipoEquipo().getNombre() + " - " + equipo.getTipoEquipo().getCodigo());
                                out.println("</option>");
                            }
                        %>
                    </select>
                </td>

                </tr>
                <%
                    Equipo equipo;
                    int posIni = (paginaListaEquipos - 1) * cantidadEquipoPorPagina;
                    int pos = posIni;
                    while (listaEquipos.size() > pos && pos < posIni + cantidadEquipoPorPagina) {
                        equipo = listaEquipos.get(pos);
                        pos++;
                        out.println("<tr>");
                        out.println("   <td>" + equipo.getNumeroEtiquetaConsejeria() + "</td>");
                        out.println("   <td>" + equipo.getTipoEquipo().getNombre() + "</td>");
                        out.println("   <td>"
                                + "<a href='bajaequipo.jsp?equipoId=" + equipo.getEquipoId() + "'><img src='img/borrar.png' alt='Borrar Equipo' title='Borrar Equipo'></a>&nbsp;&nbsp;"
                                + "<a href='modificacionequipo.jsp?equipoId=" + equipo.getEquipoId() + "'><img src='img/editar.png' alt='Modificar Equipo' title='Modificar Equipo'></a>&nbsp;&nbsp;"
                                + "<a href='consultaequipo.jsp?equipoId=" + equipo.getEquipoId() + "'><img src='img/detalle.png' alt='Ver Detalle de Equipo' title='Ver Detalle de Equipo'></a>"
                                + "</td>");
                        out.println("</tr>");
                    }

                %>
            </table>
        </form>
    </fieldset>
</div>

<%@include file="includes/pie.jsp" %>