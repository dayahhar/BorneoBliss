/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author dayah
 */
package com.traveler.model;
public class SignupItem implements java.io.Serializable {
    private String name;
    private String email;
    private String username;
    private String password;
    private String nationality;
    private String passportNo;
    private String country;

    public SignupItem(String name, String email, String username, String password, String nationality, String passportNo, String country) {
        this.name = name;
        this.email = email;
        this.username = username;
        this.password = password;
        this.nationality = nationality;
        this.passportNo = passportNo;
        this.country = country;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getNationality() {
        return nationality;
    }

    public String getPassportNo() {
        return passportNo;
    }

    public String getCountry() {
        return country;
    }
}
