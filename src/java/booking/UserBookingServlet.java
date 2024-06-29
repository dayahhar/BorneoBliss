/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package booking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserBookingServlet")
public class UserBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
    String jdbcUsername = "app";
    String jdbcPassword = "app";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<BOOKING> bookings = new ArrayList<>();
        try {
            bookings = getBookingsByUserID(userID);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("check_booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createBooking(request, response);
        }
    }

    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("userID");

        if (userID == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String bookingID = request.getParameter("bookingID");
        Date bookingDate = Date.valueOf(request.getParameter("bookingDate"));
        Date travelDate = Date.valueOf(request.getParameter("travelDate"));
        String packageID = request.getParameter("package");
        int bookingPax = Integer.parseInt(request.getParameter("bookingPax"));
        String bookingStatus = "Pending";

        try {
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO BOOKING (BOOKINGID, BOOKINGDATE, TRAVELDATE, USERID, PACKAGEID, BOOKINGPAX, BOOKINGSTATUS) VALUES (?, ?, ?, ?, ?, ?, ?)");
            stmt.setString(1, bookingID);
            stmt.setDate(2, bookingDate);
            stmt.setDate(3, travelDate);
            stmt.setString(4, userID);
            stmt.setString(5, packageID);
            stmt.setInt(6, bookingPax);
            stmt.setString(7, bookingStatus);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("UserBookingServlet");
    }

    private List<BOOKING> getBookingsByUserID(String userID) throws SQLException {
        List<BOOKING> bookings = new ArrayList<>();
        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM BOOKING WHERE USERID = ?");
        stmt.setString(1, userID);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            bookings.add(new BOOKING(
                rs.getString("BOOKINGID"),
                rs.getDate("BOOKINGDATE"),
                rs.getDate("TRAVELDATE"),
                rs.getString("USERID"),
                rs.getString("PACKAGEID"),
                rs.getInt("BOOKINGPAX"),
                rs.getString("BOOKINGSTATUS")
            ));
        }
        rs.close();
        stmt.close();
        conn.close();
        return bookings;
    }
}
