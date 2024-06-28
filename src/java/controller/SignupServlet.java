/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
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

    private boolean saveUser(String name, String email, String username, String password) {
        // TODO: Implement the logic to save the user data to the database
        // For demonstration purposes, we'll assume the data is always saved successfully
        return true;
    }
}
