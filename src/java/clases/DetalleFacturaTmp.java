/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

/**
 *
 * @author dearmartinez
 */
public class DetalleFacturaTmp {
    private String idProducto;
    private String descripcion;
    private int precio;
    private int cantidad;

    public DetalleFacturaTmp(String idProducto, String descripcion, int precio, int cantidad) {
        this.idProducto = idProducto;
        this.descripcion = descripcion;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    public String getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
}
