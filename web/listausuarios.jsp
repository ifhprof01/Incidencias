<%-- 
    Document   : index.jsp
    Created on : 03-dic-2017, 11:35:42
    Author     : Carlos
--%>

<%@page import="utilidades.Utilidades"%>
<%@page import="incidenciascad.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="incidenciascad.IncidenciasCAD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/cabecera.jsp" %>
<%@include file="includes/soloadministradores.jsp" %>

            <div id="content">
<%@include file="includes/mensajeusuario.jsp" %>
                <%
//                    if (request.getMethod() == "POST") {
                    Integer criterioOrdenacionUsuarios;
                    Integer ordenUsuarios;
                    if (session.getAttribute("criterioOrdenacionUsuarios") == null) {
                        criterioOrdenacionUsuarios = IncidenciasCAD.USUARIO_CUENTA;
                        ordenUsuarios = IncidenciasCAD.ASCENDENTE;
                    } else {
                        criterioOrdenacionUsuarios = (Integer) session.getAttribute("criterioOrdenacionUsuarios");
                        ordenUsuarios = (Integer) session.getAttribute("ordenUsuarios");
                    }
                    if (request.getParameter("actualizarFiltro") != null) {
                        criterioOrdenacionUsuarios = Integer.parseInt(request.getParameter("criterioOrdenacionUsuarios"));
                        ordenUsuarios = Integer.parseInt(request.getParameter("ordenUsuarios"));
                        session.setAttribute("criterioOrdenacionUsuarios", criterioOrdenacionUsuarios);
                        session.setAttribute("ordenUsuarios", ordenUsuarios);
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("usuarioId")).equals("")) {
                            session.setAttribute("usuarioId", Integer.parseInt(request.getParameter("usuarioId")));
                        } else {
                            session.removeAttribute("usuarioId");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("cuenta")).equals("")) {
                            session.setAttribute("cuenta", request.getParameter("cuenta"));
                        } else {
                            session.removeAttribute("cuenta");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("nombreUsuario")).equals("")) {
                            session.setAttribute("nombreUsuario", request.getParameter("nombreUsuario"));
                        } else {
                            session.removeAttribute("nombreUsuario");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("apellido")).equals("")) {
                            session.setAttribute("apellido", request.getParameter("apellido"));
                        } else {
                            session.removeAttribute("apellido");
                        }
                        if (!Utilidades.convertirNullAStringVacio(request.getParameter("departamento")).equals("")) {
                            session.setAttribute("departamento", request.getParameter("departamento"));
                        } else {
                            session.removeAttribute("departamento");
                        }
                        
                    }
                    IncidenciasCAD iCAD = new IncidenciasCAD();

                    ArrayList<Usuario> listaUsuarios=iCAD.leerUsuarios((String)session.getAttribute("cuenta"), (String)session.getAttribute("nombreUsuario"), (String)session.getAttribute("apellido"), (String)session.getAttribute("departamento"), criterioOrdenacionUsuarios, ordenUsuarios);
                            
                            
                    int cantidadIncidenciasPorPagina = 20;
                    int paginaListaUsuarios = 4;
                    if (request.getParameter("paginaListaUsuarios") == null) {
                            paginaListaUsuarios = 1;
                    } else {
                        paginaListaUsuarios = Integer.parseInt(request.getParameter("paginaListaUsuarios"));
                    }
                    int cantidadPaginasListaIncidencias = 1 + (int) (listaUsuarios.size()/cantidadIncidenciasPorPagina);
                %>
                <fieldset>
                    <legend>
                        <% if(paginaListaUsuarios > 1) {%>
                            <a href="listausuarios.jsp?paginaListaUsuarios=<%=paginaListaUsuarios-1%>"><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } else {%>
                            <a><img src='img/izquierda.png' alt='Anterior Pagina' title='Anterior Pagina'></a> 
                        <% } %>
                        Pagina <%=paginaListaUsuarios%> de <%=cantidadPaginasListaIncidencias%> 
                        <% if(paginaListaUsuarios < cantidadPaginasListaIncidencias) {%>
                            <a href="listausuarios.jsp?paginaListaUsuarios=<%=paginaListaUsuarios+1%>"><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } else {%>
                            <a><img src='img/derecha.png' alt='Siguiente Pagina' title='Siguiente Pagina'></a>
                        <% } %>
                    </legend>
                    <form method="post" action="listausuarios.jsp">
                        <p class="derecha">
                            <label>Ordenar por</label>
                            <select name="criterioOrdenacionUsuarios">
                                <option value="<%=IncidenciasCAD.USUARIO_CUENTA %>" <%if (IncidenciasCAD.USUARIO_CUENTA == criterioOrdenacionUsuarios) out.print("selected='selected'");%>>Cuenta</option>
                                <option value="<%=IncidenciasCAD.USUARIO_NOMBRE %>" <%if (IncidenciasCAD.USUARIO_NOMBRE == criterioOrdenacionUsuarios) out.print("selected='selected'");%>>Nombre</option>
                                <option value="<%=IncidenciasCAD.USUARIO_APELLIDO %>" <%if (IncidenciasCAD.USUARIO_APELLIDO == criterioOrdenacionUsuarios) out.print("selected='selected'");%>>Apellido</option>
                                <option value="<%=IncidenciasCAD.USUARIO_DEPARTAMENTO %>" <%if (IncidenciasCAD.USUARIO_DEPARTAMENTO == criterioOrdenacionUsuarios) out.print("selected='selected'");%>>Departamento</option>
                            </select> 
                            <select name="ordenUsuarios">
                                <option value="<%= IncidenciasCAD.ASCENDENTE%>" <%if (IncidenciasCAD.ASCENDENTE == ordenUsuarios) out.print("selected='selected'");%>>Ascendente</option>
                                <option value="<%= IncidenciasCAD.DESCENDENTE%>" <%if (IncidenciasCAD.DESCENDENTE == ordenUsuarios) out.print("selected='selected'");%>>Descendente</option>
                            </select> 
                            <input type="submit" value="Aplicar Filtro"/>
                        </p>
                        <table align="center" border="2" cellspacing="0" style="width: 100%">
                            <tr>
                                
                                <th>Cuenta</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Departamento</th>
                                <th></th>
                            </tr>
                            <tr>
                                <input type="hidden" name="actualizarFiltro" value="s"/>
                            <input type="hidden" name="usuarioId" max="<%=Integer.MAX_VALUE%>" value="<%=Utilidades.convertirAString((Integer)session.getAttribute("usuarioId"))%>"/>
                                <td><input type="text" name="cuenta" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("cuenta")))%>"/></td>
                                <td><input type="text" name="nombreUsuario" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("nombreUsuario")))%>"/></td>
                                <td><input type="text" name="apellido" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("apellido")))%>"/></td>
                                <td><input type="text" name="departamento" value="<%=Utilidades.convertirNullAStringVacio(((String)session.getAttribute("departamento")))%>"/></td>
                                <td></td>
                              
                            </tr>
                            <%  
                                Usuario usuario;
                                int posIni = (paginaListaUsuarios-1) * cantidadIncidenciasPorPagina;
                                int pos = posIni;
                                while (listaUsuarios.size() > pos && pos < posIni + cantidadIncidenciasPorPagina) {
                                    usuario = listaUsuarios.get(pos);
                                    pos++;
                                    out.println("<tr>");
                                    out.println("   <td>" + Utilidades.convertirNullAStringVacio(usuario.getCuenta()) + "</td>");
                                    out.println("   <td>" + Utilidades.convertirNullAStringVacio(usuario.getNombre()) + "</td>");
                                    out.println("   <td>" + Utilidades.convertirNullAStringVacio(usuario.getApellido()) + "</td>");
                                    out.println("   <td>" + Utilidades.convertirNullAStringVacio(usuario.getDepartamento()) + "</td>");
                                    out.println("   <td>"
                                            + "<a href='bajausuario.jsp?usuarioId="+usuario.getUsuarioId()+"'><img src='img/borrar.png' alt='Borrar Usuario' title='Borrar Usuario'></a>&nbsp;&nbsp;"
                                            + "<a href='modificacionusuario.jsp?usuarioId="+usuario.getUsuarioId()+"'><img src='img/editar.png' alt='Modificar Usuario' title='Modificar Usuario'></a>&nbsp;&nbsp;"
                                            + "<a href='consultausuario.jsp?usuarioId="+usuario.getUsuarioId()+"'><img src='img/detalle.png' alt='Ver Detalle de Usuario' title='Ver Detalle de Usuario'></a>&nbsp;&nbsp;"
                                            + "</td>");
                                    out.println("</tr>");
                                } 

                            %>
                        </table>
                    </form>
                </fieldset>
            </div>

<%@include file="includes/pie.jsp" %>
