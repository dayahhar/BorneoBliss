/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package traveler;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
    private String userpassword;

    public TRAVELER(String userID, String username, String name, String email, String phoneNo, String userpassword) {
        this.userID = userID;
        this.username = username;
        this.name = name;
        this.email = email;
        this.phoneNo = phoneNo;
        this.userpassword = userpassword;
    }
    
    public TRAVELER() {
        userID = "";
        username = "";
        name = "";
        email = "";
        phoneNo = "";
        userpassword = "";
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
    
    public String getUserpassword() {
        return userpassword;
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
    
    public void setUserPassword(String userpassword) {
        this.userpassword = userpassword;
    }
    
    public String getName(String username) {
        String name = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");

            stm = conn.prepareStatement("SELECT NAME FROM TRAVELER WHERE USERNAME = ?");
            stm.setString(1, username);

            rs = stm.executeQuery();

            if (rs.next()) {
                name = rs.getString("NAME");
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
        return name;
    }
    public String getEmail(String username) {
        String email = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");

            stm = conn.prepareStatement("SELECT EMAIL FROM TRAVELER WHERE USERNAME = ?");
            stm.setString(1, username);

            rs = stm.executeQuery();

            if (rs.next()) {
                email = rs.getString("EMAIL");
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
        return email;
    }
    public String getPhoneNo(String username) {
        String phoneNo = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");

            stm = conn.prepareStatement("SELECT PHONENO FROM TRAVELER WHERE USERNAME = ?");
            stm.setString(1, username);

            rs = stm.executeQuery();

            if (rs.next()) {
                phoneNo = rs.getString("PHONENO");
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
        return phoneNo;
    }
    public static List<TRAVELER> getAllUsers() {
        List<TRAVELER> userList = new ArrayList<>();
        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String jdbcUsername = "app";
        String jdbcPassword = "app";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM APP.TRAVELER");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                TRAVELER traveler = new TRAVELER(
                        rs.getString("userID"),
                        rs.getString("username"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phoneNo"),
                        rs.getString("userPassword")
                );
                userList.add(traveler);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error retrieving users: " + e.getMessage());
        }
        return userList;
    }
    public static TRAVELER getTravelerByID(String userID, Connection conn) throws Exception {
        TRAVELER traveler = null;
        String sql = "SELECT userID, username, name, email, phoneNo, userPassword FROM TRAVELER WHERE userID = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    traveler = new TRAVELER();
                    traveler.setUserID(rs.getString("userID"));
                    traveler.setUsername(rs.getString("username"));
                    traveler.setName(rs.getString("name"));
                    traveler.setEmail(rs.getString("email"));
                    traveler.setPhoneNo(rs.getString("phoneNo"));
                    traveler.setUserPassword(rs.getString("userPassword"));
                }
            }
        }
        return traveler;
    
}}
