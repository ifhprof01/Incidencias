                    <%
                        String mensajeUsuario = (String)request.getAttribute("mensajeUsuario");
                        if (mensajeUsuario != null) {
                            out.println(mensajeUsuario);
                            ArrayList<String> listaErrores = (ArrayList<String>) request.getAttribute("listaErrores");
                            if (listaErrores != null) {
                                out.println("<ul>");
                                for (String error : listaErrores) {
                                    out.println("<li>" + error + "</li>");
                                }
                                out.println("</ul>");
                            }
                        }
                    %>
