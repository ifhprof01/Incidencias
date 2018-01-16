<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : ifontecha
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
                        criterioOrdenacion = IncidenciasCAD.INCIDENCIA_FECHA_REGISTRO;
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
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("incidenciaId")).equals("")) {
                            session.setAttribute("incidenciaId", Integer.parseInt(request.getParameter("incidenciaId")));
                        } else {
                            session.removeAttribute("incidenciaId");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("descripcion")).equals("")) {
                            session.setAttribute("descripcion", request.getParameter("descripcion"));
                        } else {
                            session.removeAttribute("descripcion");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("numeroEtiquetaConsejeria")).equals("")) {
                            session.setAttribute("numeroEtiquetaConsejeria", request.getParameter("numeroEtiquetaConsejeria"));
                        } else {
                            session.removeAttribute("numeroEtiquetaConsejeria");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("usuarioId")).equals("")) {
                            session.setAttribute("usuarioId", Integer.parseInt(request.getParameter("usuarioId")));
                        } else {
                            session.removeAttribute("usuarioId");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("estadoId")).equals("")) {
                            session.setAttribute("estadoId", Integer.parseInt(request.getParameter("estadoId")));
                        } else {
                            session.removeAttribute("estadoId");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("dependenciaId")).equals("")) {
                            session.setAttribute("dependenciaId", Integer.parseInt(request.getParameter("dependenciaId")));
                        } else {
                            session.removeAttribute("dependenciaId");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("tipoEquipoId")).equals("")) {
                            session.setAttribute("tipoEquipoId", Integer.parseInt(request.getParameter("tipoEquipoId")));
                        } else {
                            session.removeAttribute("tipoEquipoId");
                        }
                    }
                    IncidenciasCAD iCAD = new IncidenciasCAD();
                    //ArrayList<Incidencia> listaIncidencias = iCAD.leerIncidencias();
                    //out.println("criterioOrdenacion: " + criterioOrdenacion);
                    //out.println("orden " + orden);
                    ArrayList<Incidencia> listaIncidencias = iCAD. leerIncidencias(
                            (Integer)session.getAttribute("incidenciaId"),
                            null,
                            (String)session.getAttribute("descripcion"),
                            null,null,null,
                            (Integer)session.getAttribute("usuarioId"),
                            (Integer)session.getAttribute("tipoEquipoId"),
                            (String)session.getAttribute("numeroEtiquetaConsejeria"),
                            (Integer)session.getAttribute("dependenciaId"),
                            (Integer)session.getAttribute("estadoId"),
                            criterioOrdenacion,
                            orden);
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
                    <form method="post" action="listaincidencias.jsp">
                        <p class="derecha">
                            <label>Ordenar por</label>
                            <select name="criterioOrdenacion">
                                <option value="<%=IncidenciasCAD.INCIDENCIA_ID%>" <%if (IncidenciasCAD.INCIDENCIA_ID == criterioOrdenacion) out.print("selected='selected'");%>>Identificador</option>
                                <option value="<%=IncidenciasCAD.INCIDENCIA_FECHA_REGISTRO %>" <%if (IncidenciasCAD.INCIDENCIA_FECHA_REGISTRO == criterioOrdenacion) out.print("selected='selected'");%>>Fecha de Registro</option>
                                <option value="<%=IncidenciasCAD.INCIDENCIA_DESCRIPCION %>" <%if (IncidenciasCAD.INCIDENCIA_DESCRIPCION == criterioOrdenacion) out.print("selected='selected'");%>>Descrpcion</option>
                                <option value="<%=IncidenciasCAD.ESTADO_CODIGO %>" <%if (IncidenciasCAD.ESTADO_CODIGO == criterioOrdenacion) out.print("selected='selected'");%>>Estado</option>
                                <option value="<%=IncidenciasCAD.USUARIO_CUENTA %>" <%if (IncidenciasCAD.USUARIO_CUENTA == criterioOrdenacion) out.print("selected='selected'");%>>Usuario</option>
                                <option value="<%=IncidenciasCAD.DEPENDENCIA_CODIGO %>" <%if (IncidenciasCAD.DEPENDENCIA_CODIGO == criterioOrdenacion) out.print("selected='selected'");%>>Dependencia</option>
                                <option value="<%=IncidenciasCAD.EQUIPO_NUMERO_ETIQUETA_CONSEJERIA %>" <%if (IncidenciasCAD.EQUIPO_NUMERO_ETIQUETA_CONSEJERIA == criterioOrdenacion) out.print("selected='selected'");%>>Estiqueta</option>
                                <option value="<%=IncidenciasCAD.TIPO_EQUIPO_CODIGO %>" <%if (IncidenciasCAD.TIPO_EQUIPO_CODIGO == criterioOrdenacion) out.print("selected='selected'");%>>Tipo de Equipo</option>
                            </select> 
                            <select name="orden">
                                
                                <option value="<%= IncidenciasCAD.ASCENDENTE%>" <%if (IncidenciasCAD.ASCENDENTE == orden) out.print("selected='selected'");%>>Ascendente</option>
                                <option value="<%= IncidenciasCAD.DESCENDENTE%>" <%if (IncidenciasCAD.DESCENDENTE == orden) out.print("selected='selected'");%>>Descendente</option>
                            </select> 
                        </p>
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
                                <input type="hidden" name="actualizarFiltro" value="s"/>
                                <td><input type="number" name="incidenciaId" max="<%=Integer.MAX_VALUE%>" value="<%=Utilidades.convertirAString((Integer)session.getAttribute("incidenciaId"))%>"/></td>
                                <td><input type="date" name="fechaRegistro" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("fechaRegistro")))%>"/></td>
                                <td><input type="text" name="descripcion" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("descripcion")))%>"/></td>
                                <td>
                                    <select name="estadoId">
                                    <%
                                        out.println("<option value=''></option>");
                                        iCAD = new IncidenciasCAD();
                                        ArrayList<Estado> listaEstados = iCAD.leerEstados(null, null, IncidenciasCAD.ESTADO_NOMBRE, IncidenciasCAD.ASCENDENTE);
                                        for (Estado estado : listaEstados) {
                                            if (session.getAttribute("estadoId") == estado.getEstadoId())
                                                out.println("<option value='" + estado.getEstadoId() + "' title='" + estado.getNombre() + "' selected>");
                                            else
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
                                            if (session.getAttribute("usuarioId") == usuario.getUsuarioId())
                                                out.println("<option value='" + usuario.getUsuarioId() + "' title='" + usuario.getNombre() + " " + usuario.getApellido() + "' selected>");
                                            else
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
                                            if (session.getAttribute("dependenciaId") == dependencia.getDependenciaId())
                                                out.println("<option value='" + dependencia.getDependenciaId() + "' title='" + dependencia.getNombre() + "' selected>");
                                            else
                                                out.println("<option value='" + dependencia.getDependenciaId() + "' title='" + dependencia.getNombre() + "'>");
                                            out.println(dependencia.getCodigo());
                                            out.println("</option>");
                                        }
                                    %>
                                    </select>
                                </td>
                                <td><input type="text" name="numeroEtiquetaConsejeria" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("numeroEtiquetaConsejeria")))%>"/></td>
                                <td>
                                    <select name="tipoEquipoId">
                                    <%
                                        out.println("<option value=''></option>");
                                        iCAD = new IncidenciasCAD();
                                        ArrayList<TipoEquipo> listaTiposEquipo = iCAD.leerTiposEquipo(null, null, IncidenciasCAD.TIPO_EQUIPO_CODIGO, IncidenciasCAD.ASCENDENTE);
                                        for (TipoEquipo tipoEquipo : listaTiposEquipo) {
                                            if (session.getAttribute("tipoEquipoId") == tipoEquipo.getTipoEquipoId())
                                                out.println("<option value='" + tipoEquipo.getTipoEquipoId() + "' title='" + tipoEquipo.getNombre()+ "' selected>");
                                            else
                                                out.println("<option value='" + tipoEquipo.getTipoEquipoId() + "' title='" + tipoEquipo.getNombre()+ "'>");
                                            out.println(tipoEquipo.getCodigo());
                                            out.println("</option>");
                                        }
                                    %>
                                    </select> 
                                </td>
                                <td><input type="submit" value="Aplicar Filtro"/></td>
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
                    </form>
                </fieldset>
            </div>

<%@include file="includes/pie.jsp" %>
