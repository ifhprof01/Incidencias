                <%
                    String mensajeUsuario = (String)request.getAttribute("mensajeUsuario");
                    if (mensajeUsuario != null) {
                        ArrayList<String> listaErrores = (ArrayList<String>) request.getAttribute("listaErrores");
                        if (listaErrores != null) {
                            out.println("<span class='mensajeError'>" + mensajeUsuario + "</span>");
                            out.println("<ul class='mensajeError'>");
                            for (String error : listaErrores) {
                                out.println("<li>" + error + "</li>");
                            }
                            out.println("</ul>");
                        } else {
                            out.println("<span class='mensajeCorrecto'>" + mensajeUsuario + "</span>");
                        }
                    }
                %>
