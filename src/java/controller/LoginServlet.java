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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                response.sendRedirect("user_dashboard.jsp");
            }
        } else {
            // Authentication failed, redirect back to login with error message
            response.sendRedirect("login.jsp?error=Invalid username or password");
        }
    }

    private boolean authenticateUser(String role, String username, String password) {
        // TODO: Implement authentication logic (e.g., check against a database)
        // For demonstration purposes, we'll use hardcoded values
        if ("admin".equalsIgnoreCase(role) && "admin".equals(username) && "admin123".equals(password)) {
            return true;
        } else if ("user".equalsIgnoreCase(role) && "user".equals(username) && "user123".equals(password)) {
            return true;
        }
        return false;
    }
}
