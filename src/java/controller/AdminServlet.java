package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Simulate retrieving data
        int totalPackages = 10; // Example data
        int totalBookings = 25; // Example data
        int totalCustomers = 100; // Example data
        String[] recentActivities = { "User1 booked a package", "User2 updated profile", "Admin approved a booking" };
        int newBookingsPending = 5; // Example data
        int customerInquiriesPending = 3; // Example data

        // Set attributes in request
        request.setAttribute("totalPackages", totalPackages);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("recentActivities", recentActivities);
        request.setAttribute("newBookingsPending", newBookingsPending);
        request.setAttribute("customerInquiriesPending", customerInquiriesPending);

        // Forward to JSP for rendering
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Process POST requests
        doGet(request, response);
    }
}

