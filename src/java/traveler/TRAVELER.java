/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package traveler;

/**
 *
 * @author Aqilah05
 */
public class TRAVELER {
    private String userID;
    private String username;
    private String name;
    private String email;
    private String phoneNo;

    public TRAVELER(String userID, String username, String name, String email, String phoneNo) {
        this.userID = userID;
        this.username = username;
        this.name = name;
        this.email = email;
        this.phoneNo = phoneNo;
    }
    
    public TRAVELER() {
        userID = "";
        username = "";
        name = "";
        email = "";
        phoneNo = "";
    }

    public String getUserID() {
        return userID;
    }

    public String getUsername() {
        return username;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }
    
    
}
