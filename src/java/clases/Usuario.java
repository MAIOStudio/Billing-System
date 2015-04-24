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
public class Usuario {
    
    private String idUser;
    private String names;
    private String lastNames;
    private String pass;
    private int idProfile;
    private String photo;

    public Usuario(String idUser, String names, String lastNames, String pass, int idProfile, String photo) {
        this.idUser = idUser;
        this.names = names;
        this.lastNames = lastNames;
        this.pass = pass;
        this.idProfile = idProfile;
        this.photo = photo;
    }

    public String getIdUser() {
        return idUser;
    }

    public void setIdUser(String idUser) {
        this.idUser = idUser;
    }

    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
    }

    public String getLastNames() {
        return lastNames;
    }

    public void setLastNames(String lastNames) {
        this.lastNames = lastNames;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public int getIdProfile() {
        return idProfile;
    }

    public void setIdProfile(int idProfile) {
        this.idProfile = idProfile;
    }

    public String getFoto() {
        return photo;
    }

    public void setFoto(String photo) {
        this.photo = photo;
    }  
}
