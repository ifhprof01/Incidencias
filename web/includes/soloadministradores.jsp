            <%@page import="utilidades.Utilidades"%>
<%
                if (!admin) {
                    Utilidades.mensajeErrorLog(1, "Intento de acceso no autorizado a " + request.getRequestURI() + " por el usuario " + usuarioSesion.getCuenta(), null);
                    request.setAttribute("mensajeUsuario", "Acceso no autorizado");
                    request.setAttribute("listaErrores", new ArrayList());
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            %>
                        