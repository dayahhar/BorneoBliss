package booking;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("create".equals(action)) {
            createBooking(request, response);
        } else if ("view".equals(action)) {
            viewBookings(request, response);
        }
    }

    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingDateStr = request.getParameter("bookingDate");
        String travelDateStr = request.getParameter("travelDate");
        String userID = request.getParameter("userID");
        String packageID = request.getParameter("packageID");
        int bookingPax = Integer.parseInt(request.getParameter("bookingPax"));
        String bookingStatus = request.getParameter("bookingStatus");

        // Convert String to java.sql.Date
        java.sql.Date bookingDate = java.sql.Date.valueOf(bookingDateStr);
        java.sql.Date travelDate = java.sql.Date.valueOf(travelDateStr);

        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String dbUser = "app";
        String dbPassword = "app";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "INSERT INTO BOOKING (bookingDate, travelDate, userID, packageID, bookingPax, bookingStatus) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setDate(1, bookingDate);
            statement.setDate(2, travelDate);
            statement.setString(3, userID);
            statement.setString(4, packageID);
            statement.setInt(5, bookingPax);
            statement.setString(6, bookingStatus);

            statement.executeUpdate();
            statement.close();
            connection.close();

            response.sendRedirect("view_bookings.jsp?userID=" + userID);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void viewBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));

        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String dbUser = "app";
        String dbPassword = "app";

        List<BOOKING> bookings = new ArrayList<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "SELECT * FROM Booking WHERE userID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                BOOKING booking = new BOOKING();
                booking.setBookingID(resultSet.getString("bookingID"));

                // Convert java.sql.Date to String
                java.sql.Date bookingDate = resultSet.getDate("bookingDate");
                booking.setBookingDate(bookingDate.toString());

                java.sql.Date travelDate = resultSet.getDate("travelDate");
                booking.setTravelDate(travelDate.toString());

                booking.setUserID(resultSet.getString("userID"));
                booking.setPackageID(resultSet.getString("packageID"));
                booking.setBookingPax(resultSet.getInt("bookingPax"));
                booking.setBookingStatus(resultSet.getString("bookingStatus"));
                bookings.add(booking);
            }

            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("view_bookings.jsp").forward(request, response);
    }
}
