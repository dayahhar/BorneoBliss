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
@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    private static final String urlDB = "jdbc:derby://localhost:1527/BorneoDB";
    private static final String usernameDB = "app";
    private static final String passwordDB = "app";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Simulate saving the user data
        boolean isSaved = saveUser(name, email, username, password);

        if (isSaved) {
            // Redirect to success page
            response.sendRedirect("success_signup.jsp");
        } else {
            // Registration failed, redirect back to signup with error message
            response.sendRedirect("signup.jsp?error=Unable to sign up. Please try again.");
        }
    }

        private boolean saveUser(String name, String email, String username, String userpassword) {
        boolean isSaved = false;

        // JDBC variables
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // Load the JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish a connection to the database
            connection = DriverManager.getConnection(urlDB, usernameDB, passwordDB);

            // Prepare the SQL insert statement
            String sql = "INSERT INTO traveler (name, email, username, userpassword) VALUES (?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, username);
            statement.setString(4, userpassword);

            // Execute the insert statement
            int rowsInserted = statement.executeUpdate();

            // If at least one row was inserted, set isSaved to true
            if (rowsInserted > 0) {
                isSaved = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return isSaved;
    }
}
