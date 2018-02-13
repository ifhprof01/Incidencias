/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilidades;

import incidenciascad.Usuario;
import java.util.Properties;
import java.util.logging.LogManager;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ifontecha
 */
public class Utilidades {
    public static String convertirAString(Integer i) {
        if (i == null) return "";
        else return i.toString();
    }
    
    public static String convertirNullAStringVacio(String cadena) {
        if (cadena == null) return "";
        if (cadena.equals("null")) return "";
        return cadena;
    }
    
    public static String convertirStringVacioANull(String cadena) {
        if (cadena == null) return null;
        if (cadena.equals("")) return null;
        return cadena;
    }
    
    public static String mensajeErrorLog(Integer codigoErrorSistema, String mensajeErrorAdministrador, String sentenciaSQL) {
        String mensaje = "Código de Error del Sistema: " + codigoErrorSistema + "\n";
        mensaje = mensaje + "Mensaje de Error del Sistema: " + mensajeErrorAdministrador + "\n";
        if (sentenciaSQL != null)
            mensaje = mensaje + "Sentencia SQL que ha producido el error: " + sentenciaSQL + "\n";
        LogManager logManager = LogManager.getLogManager();
        Logger logger = logManager.getLogger("incidencias");
        logger.warning(mensaje);
        return mensaje;
    }
    
    public static void enviarCorreo(String usuarioDe, 
                                    String contrasenaUsuarioDe,
                                    String mailSmtpStarttlsEnable,
                                    String mailSmtpAuth,
                                    String mailSmtpHost,
                                    String mailSmtpPort,
                                    String usuarioA,
                                    String asunto,
                                    String cuerpo) {

        Properties propiedades = new Properties();
        propiedades.put("mail.smtp.starttls.enable", mailSmtpStarttlsEnable);
        propiedades.put("mail.smtp.auth", mailSmtpAuth);
        propiedades.put("mail.smtp.host", mailSmtpHost);
        propiedades.put("mail.smtp.port", mailSmtpPort);

        Authenticator autenticador = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usuarioDe, contrasenaUsuarioDe);
            }
          };
        Session sesion = Session.getInstance(propiedades,autenticador);

        try {

            Message mensaje = new MimeMessage(sesion);
            InternetAddress iaDe = new InternetAddress(usuarioDe);
            mensaje.setFrom(iaDe);
            InternetAddress[] iaA = InternetAddress.parse(usuarioA);
            mensaje.setRecipients(Message.RecipientType.TO,iaA);
            mensaje.setSubject(asunto);
            mensaje.setText(cuerpo);

            Transport.send(mensaje);

            System.out.println("Mansaje enviado");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
    
    public static void verificarAdministrador(HttpServletRequest request) throws ExcepcionIncidencias {
        HttpSession session = request.getSession(true);
        Usuario usuarioSesion = (Usuario)session.getAttribute("usuarioSesion");
        Boolean admin = (Boolean)session.getAttribute("admin");
        if (usuarioSesion == null || admin == null) throw new ExcepcionIncidencias(1,"Acceso no autorizado",
                    "Intento de acceso a la aplicación sin objetos de sesión asociados a la autenticación");
        if (!admin) throw new ExcepcionIncidencias(1,"Acceso no autorizado",
                    "Intento de acceso no autorizado a " + request.getRequestURI() + " por el usuario " + usuarioSesion.getCuenta());
    }
    
    public static void verificarUsuario(HttpServletRequest request) throws ExcepcionIncidencias {
        HttpSession session = request.getSession(true);
        Usuario usuarioSesion = (Usuario)session.getAttribute("usuarioSesion");
        Boolean admin = (Boolean)session.getAttribute("admin");
        if (usuarioSesion == null || admin == null) throw new ExcepcionIncidencias(1,"Acceso no autorizado",
                    "Intento de acceso a la aplicación sin objetos de sesión asociados a la autenticación");
    }
}
