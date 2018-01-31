<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/estilos.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="container">
            <div id="banner">
                <span>Gestión de Incidencias</span>
            </div>
            <div id="menu">
                <ul>
                    <% if (request.getRequestURI().equals("/Incidencias/listaincidencias.jsp")) {%>
                        <li><a class="active" href="listaincidencias.jsp">Incidencias</a></li>
                    <% } else {%>
                        <li><a href="listaincidencias.jsp">Incidencias</a></li>
                    <% }%>
                    <% if (request.getRequestURI().equals("/Incidencias/listatipoequipo.jsp")) {%>
                        <li><a class="active" href="listatipoequipo.jsp">Tipos de Equipo</a></li>
                    <% } else {%>
                        <li><a href="listatipoequipo.jsp">Tipos de Equipo</a></li>
                    <% }%>
                    <% if (request.getRequestURI().equals("/Incidencias/listaequipos.jsp")) {%>
                        <li><a class="active" href="listaequipos.jsp">Equipos</a></li>
                    <% } else {%>
                        <li><a href="listaequipos.jsp">Equipos</a></li>
                    <% }%>
                    <% if (request.getRequestURI().equals("/Incidencias/listadependencias.jsp")) {%>
                        <li><a class="active" href="listadependencias.jsp">Dependencias</a></li>
                    <% } else {%>
                        <li><a href="listadependencias.jsp">Dependencias</a></li>
                    <% }%>
                    <% if (request.getRequestURI().equals("/Incidencias/listaestados.jsp")) {%>
                        <li><a class="active" href="listaestados.jsp">Estados</a></li>
                    <% } else {%>
                        <li><a href="listaestados.jsp">Estados</a></li>
                    <% }%>
                    <% if (request.getRequestURI().equals("/Incidencias/listausuarios.jsp")) {%>
                        <li><a class="active" href="listausuarios.jsp">Usuarios</a></li>
                    <% } else {%>
                        <li><a href="listausuarios.jsp">Usuarios</a></li>
                    <% }%>
                    <% if (request.getRequestURI().equals("/Incidencias/configuracion.jsp")) {%>
                        <li><a class="active" href="configuracion.jsp">Configuración</a></li>
                    <% } else {%>
                        <li><a href="configuracion.jsp">Configuración</a></li>
                    <% }%>
                    <%
                        String nombreCompletoUsuario = "Desconocido";
                        Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
                        if (usuarioSesion != null) {
                            if (usuarioSesion.getNombre() != null) 
                                nombreCompletoUsuario = usuarioSesion.getNombre() + " " + usuarioSesion.getApellido();
                            else nombreCompletoUsuario = usuarioSesion.getCuenta();
                        }
                        else {
                            //Lanzar error de no autenticación
                        }
                    %>
                    <li><a href="index.jsp">Salir (<%=nombreCompletoUsuario%>)</a></li>
                </ul>
            </div>
