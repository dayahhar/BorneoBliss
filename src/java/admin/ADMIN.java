/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author nurna
 */
public class ADMIN {
    private String adminID;
    private String adminUsername;
    private String adminName;
    private String adminPassword;
    
    public ADMIN(String adminID, String adminUsername, String adminName, String adminPassword) {
        this.adminID = adminID;
        this.adminUsername = adminUsername;
        this.adminName = adminName;
        this.adminPassword = adminPassword;
    }

    public ADMIN() {
        this.adminID = "";
        this.adminUsername = "";
        this.adminName = "";
        this.adminPassword = "";
    }
    
    public String getAdminID() {
        return adminID;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    public String getAdminUsername() {
        return adminUsername;
    }

    public void setAdminUsername(String adminUsername) {
        this.adminUsername = adminUsername;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }
    
    public String getAdminName(String adminUsername) {
        String adminName = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");

            stm = conn.prepareStatement("SELECT ADMINNAME FROM ADMIN WHERE ADMINUSERNAME = ?");
            stm.setString(1, adminUsername);

            rs = stm.executeQuery();

            if (rs.next()) {
                adminName = rs.getString("ADMINNAME");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stm != null) stm.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return adminName;
    }
}
