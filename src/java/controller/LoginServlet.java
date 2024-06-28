/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    
    private static final String urlDB = "jdbc:derby://localhost:1527/BorneoDB";
    private static final String usernameDB = "app";
    private static final String passwordDB = "app";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        // Retrieve form parameters
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Perform authentication
        boolean isAuthenticated = authenticateUser(role, username, password);

        if (isAuthenticated) {
            // Create a session and store user details
            HttpSession session = request.getSession();
            session.setAttribute("role", role);
            session.setAttribute("username", username);

            // Redirect based on role
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("index.html");
            }
        } else {
            // Authentication failed, redirect back to login with error message
            response.sendRedirect("login.jsp?error=Invalid username or password");
        }
    }

    private boolean authenticateUser(String role, String username, String password) {
        boolean isAuthenticated = false;

        // JDBC variables
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Load the JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(urlDB, usernameDB, passwordDB);

            // Prepare the SQL query based on role
            String sql;
            if ("admin".equalsIgnoreCase(role)) {
                sql = "SELECT * FROM admin WHERE ADMINUSERNAME = ? AND ADMINPASSWORD = ?";
            } else {
                sql = "SELECT * FROM traveler WHERE USERNAME = ? AND USERPASSWORD = ?";
            }
            statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            // Execute the query
            resultSet = statement.executeQuery();

            // Check if a matching user was found
            if (resultSet.next()) {
                isAuthenticated = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return isAuthenticated;
    }
}