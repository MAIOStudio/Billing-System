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
public class Producto {
    private String idProducto;
    private String description;
    private int precio;
    private int idIva;
    private String notas;
    private String photo;

    public Producto(
            String idProducto, String description, int precio, int idIva,
            String notas, String photo) {
        this.idProducto = idProducto;
        this.description = description;
        this.precio = precio;
        this.idIva = idIva;
        this.notas = notas;
        this.photo = photo;
    }

    public String getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public int getIdIva() {
        return idIva;
    }

    public void setIdIva(int idIva) {
        this.idIva = idIva;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

    public String getFoto() {
        return photo;
    }

    public void setFoto(String photo) {
        this.photo = photo;
    }
    
    
}
