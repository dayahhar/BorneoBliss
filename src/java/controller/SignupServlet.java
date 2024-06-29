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

/**
 *
 * @author nurna
 */
@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    String urlDB = "jdbc:derby://localhost:1527/BorneoDB";
    String usernameDB = "app";
    String passwordDB = "app";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");
        String username = request.getParameter("username");
        String userpassword = request.getParameter("userpassword");
        
        // Simulate saving the user data
        boolean isSaved = saveUser(name, email, phoneNo, username, userpassword);

        if (isSaved) {
            // Redirect to success page
            response.sendRedirect("success_signup.jsp");
        } else {
            response.sendRedirect("signup.jsp?error=Unable To Sign Up, Please Try Again");
        }
    }

    private boolean saveUser(String name, String email, String phoneNo, String username, String userpassword) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;

        try {
            // Load the JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Establish a connection to the database
            connection = DriverManager.getConnection(urlDB, usernameDB, passwordDB);

            // Check if the username already exists
            String queryCheck = "SELECT USERNAME FROM TRAVELER WHERE USERNAME = ?";
            statement = connection.prepareStatement(queryCheck);
            statement.setString(1, username);
            rs = statement.executeQuery();
            
            if (rs.next()) {
                return false;
            }
            
            rs.close();
            statement.close();
            
            // Generate a new user ID
            String queryMaxId = "SELECT MAX(USERID) AS max_id FROM TRAVELER";
            statement = connection.prepareStatement(queryMaxId);
            rs = statement.executeQuery();
            String newUserID = "US01"; // Default value if no existing records

            if (rs.next() && rs.getString("max_id") != null) {
                String currentMaxId = rs.getString("max_id");
                int currentIdNum = Integer.parseInt(currentMaxId.substring(2));
                newUserID = "US" + String.format("%02d", currentIdNum + 1);
            }
            
            rs.close();
            statement.close();
            
            // Prepare the SQL insert statement
            String sql = "INSERT INTO TRAVELER (USERID, USERNAME, EMAIL, PHONENO, NAME, USERPASSWORD) VALUES (?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, newUserID);
            statement.setString(2, username);
            statement.setString(3, email);
            statement.setString(4, phoneNo);
            statement.setString(5, name);
            statement.setString(6, userpassword);

            // Execute the insert statement
            int rowsInserted = statement.executeUpdate();

            return rowsInserted > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}