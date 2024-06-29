/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import admin.ADMIN;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nurna
 */
@WebServlet(name = "LoginAdminServlet", urlPatterns = {"/LoginAdminServlet"})
public class LoginAdminServlet extends HttpServlet {

    String urlDB = "jdbc:derby://localhost:1527/BorneoDB";
    String usernameDB = "app";
    String passwordDB = "app";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        String adminUsername = request.getParameter("adminUsername");
        String adminPassword = request.getParameter("adminPassword");
        
        // Perform authentication
        boolean isAuthenticated = authenticateAdmin(adminUsername, adminPassword);

        if (isAuthenticated) {
            String adminName = new ADMIN().getAdminName(adminUsername);
            // Create a session and store user details
            HttpSession session = request.getSession();
            session.setAttribute("adminUsername", adminUsername);
            session.setAttribute("adminName", adminName);
            
            response.sendRedirect("admin.jsp");
            
        } else {
            // Authentication failed, redirect back to login with error message
            response.sendRedirect("loginAdmin.jsp?error=Invalid username or password");
        }
    }

    private boolean authenticateAdmin(String adminUsername, String adminPassword) {
        boolean isAuthenticated = false;

        // JDBC variables
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            // Load the JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(urlDB, usernameDB, passwordDB);

            stm = conn.prepareStatement("SELECT * FROM ADMIN WHERE ADMINUSERNAME = ? AND ADMINPASSWORD = ?");
            stm.setString(1, adminUsername);
            stm.setString(2, adminPassword);

            // Execute the query
            rs = stm.executeQuery();

            // Check if a matching user was found
            if (rs.next()) {
                isAuthenticated = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stm != null) stm.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return isAuthenticated;
    }
    
}