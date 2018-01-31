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
                    <li><a class="active" href="#home">Incidencias</a></li>
                    <li><a href="#news">Tipos de Equipo</a></li>
                    <li><a href="#contact">Equipos</a></li>
                    <li><a href="#about">Dependencias</a></li>
                    <li><a href="#about">Estados</a></li>
                    <li><a href="#about">Dependencias</a></li>
                    <li><a href="#about">Configuración</a></li>
                    <%
                        String nombreCompletoUsuario = "";
                        Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
                        if (usuarioSesion != null) {
                            if (usuarioSesion.getNombre() != null) 
                                nombreCompletoUsuario = usuarioSesion.getNombre() + " " + usuarioSesion.getApellido();
                            else nombreCompletoUsuario = usuarioSesion.getCuenta();
                        }
                        else {
                            //Lanzar error de no autenticación
                        }
                        // out.println(nombreCompletoUsuario);
                    %>
                    <li><a href="#about">Salir (<%=nombreCompletoUsuario%>)</a></li>
                </ul>
            </div>
