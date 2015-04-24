/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import java.util.Date;

/**
 *
 * @author dearmartinez
 */
public class Cliente {

    private String idClient;
    private int idType;
    private String names;
    private String lastNames;
    private String address;
    private String phone;
    private int idCity;
    private Date dateBirth;
    private Date dateEntry;

    public Cliente(String idClient, int idType, String names,
            String lastNames, String address, String phone,
            int idCity, Date dateBirth, Date dateEntry) {

        this.idClient = idClient;
        this.idType = idType;
        this.names = names;
        this.lastNames = lastNames;
        this.address = address;
        this.phone = phone;
        this.idCity = idCity;
        this.dateBirth = dateBirth;
        this.dateEntry = dateEntry;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public int getIdType() {
        return idType;
    }

    public void setIdType(int idType) {
        this.idType = idType;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getIdCity() {
        return idCity;
    }

    public void setIdCity(int idCity) {
        this.idCity = idCity;
    }

    public Date getDateBirth() {
        return dateBirth;
    }

    public void setDateBirth(Date dateBirth) {
        this.dateBirth = dateBirth;
    }

    public Date getDateEntry() {
        return dateEntry;
    }

    public void setDateEntry(Date dateEntry) {
        this.dateEntry = dateEntry;
    }

}
