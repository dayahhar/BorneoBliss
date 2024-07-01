package booking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    private static final String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
    private static final String jdbcUsername = "app";
    private static final String jdbcPassword = "app";
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("loginUser.jsp");
            return;
        }

        List<BOOKING> bookings = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                "SELECT B.* FROM BOOKING B JOIN TRAVELER T ON B.USERID = T.USERID WHERE T.USERNAME = ?")) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BOOKING booking = new BOOKING(
                        rs.getString("BOOKINGID"),
                        rs.getDate("BOOKINGDATE"),
                        rs.getDate("TRAVELDATE"),
                        rs.getString("USERID"),
                        rs.getString("PACKAGEID"),
                        rs.getInt("BOOKINGPAX"),
                        rs.getString("BOOKINGSTATUS")
                    );
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("check_booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("loginUser.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("create".equals(action)) {
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
                    } else {
                        request.setAttribute("error", "Failed to create booking. Please try again.");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
        }

        doGet(request, response);
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
            int randomNum = (int) (Math.random() * 10000);
            bookingID = "BK" + String.format("%02d", randomNum);

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
