
package booking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CreateBookingUserServlet", urlPatterns = {"/CreateBookingUserServlet"})
public class CreateBookingUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
    private static final String jdbcUsername = "app";
    private static final String jdbcPassword = "app";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("loginUser.jsp");
            return;
        }

        String bookingDate = request.getParameter("bookingDate");
        String travelDate = request.getParameter("travelDate");
        String packageID = request.getParameter("packageID");
        int bookingPax = Integer.parseInt(request.getParameter("bookingPax"));

        try (Connection conn = getConnection()) {
            String bookingID = generateBookingID(conn);
            String userID = getUserIDByUsername(conn, username);

            String query = "INSERT INTO BOOKING (BOOKINGID, BOOKINGDATE, TRAVELDATE, USERID, PACKAGEID, BOOKINGPAX, BOOKINGSTATUS) VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, bookingID);
                stmt.setDate(2, java.sql.Date.valueOf(bookingDate));
                stmt.setDate(3, java.sql.Date.valueOf(travelDate));
                stmt.setString(4, userID);
                stmt.setString(5, packageID);
                stmt.setInt(6, bookingPax);

                int rowCount = stmt.executeUpdate();
                if (rowCount > 0) {
                    request.setAttribute("message", "Booking created successfully!");
                    response.sendRedirect("check_booking.jsp");
                } else {
                    request.setAttribute("error", "Failed to create booking. Please try again.");
                    request.getRequestDispatcher("create_booking.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("create_booking.jsp").forward(request, response);
        }
    }

    private String getUserIDByUsername(Connection conn, String username) throws SQLException {
        String userID = null;
        String query = "SELECT USERID FROM TRAVELER WHERE USERNAME = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    userID = rs.getString("USERID");
                }
            }
        }
        return userID;
    }

    private String generateBookingID(Connection conn) throws SQLException {
        String bookingID = null;
        boolean isUnique = false;

        while (!isUnique) {
            int randomNum = (int) (Math.random() * 100); // Generates a number between 0 and 99
            bookingID = "BK" + String.format("%02d", randomNum); // Generates IDs like BK00, BK01, ..., BK99

            String query = "SELECT COUNT(*) FROM BOOKING WHERE BOOKINGID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, bookingID);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        isUnique = true;
                    }
                }
            }
        }

        return bookingID;
    }
}
