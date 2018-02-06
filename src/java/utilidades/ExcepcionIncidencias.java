/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilidades;

/**
 *
 * @author ifontecha
 */
public class ExcepcionIncidencias extends Exception {
    private Integer codigoError;
    private String mensajeErrorUsuario;
    private String mensajeErrorAdministrador;

    public ExcepcionIncidencias() {
    }

    public ExcepcionIncidencias(Integer codigoError, String mensajeErrorUsuario, String mensajeErrorAdministrador) {
        this.codigoError = codigoError;
        this.mensajeErrorUsuario = mensajeErrorUsuario;
        this.mensajeErrorAdministrador = mensajeErrorAdministrador;
    }

    public Integer getCodigoError() {
        return codigoError;
    }

    public void setCodigoError(Integer codigoError) {
        this.codigoError = codigoError;
    }

    public String getMensajeErrorUsuario() {
        return mensajeErrorUsuario;
    }

    public void setMensajeErrorUsuario(String mensajeErrorUsuario) {
        this.mensajeErrorUsuario = mensajeErrorUsuario;
    }

    public String getMensajeErrorAdministrador() {
        return mensajeErrorAdministrador;
    }

    public void setMensajeErrorAdministrador(String mensajeErrorAdministrador) {
        this.mensajeErrorAdministrador = mensajeErrorAdministrador;
    }

    @Override
    public String toString() {
        return "ExcepcionIncidencias{" + "codigoError=" + codigoError + ", mensajeErrorUsuario=" + mensajeErrorUsuario + ", mensajeErrorAdministrador=" + mensajeErrorAdministrador + '}';
    }

}
