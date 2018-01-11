/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilidades;

import java.util.logging.LogManager;
import java.util.logging.Logger;

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
}
