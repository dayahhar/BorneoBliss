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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            String userID = request.getParameter("userID");
            String bookingDate = request.getParameter("bookingDate");
            String travelDate = request.getParameter("travelDate");
            String packageID = request.getParameter("packageID");
            int bookingPax = Integer.parseInt(request.getParameter("bookingPax"));

            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String bookingID = generateBookingID(conn);

                String query = "INSERT INTO APP.BOOKING (BOOKINGID, BOOKINGDATE, TRAVELDATE, USERID, PACKAGEID, BOOKINGPAX, BOOKINGSTATUS) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, bookingID);
                    stmt.setDate(2, Date.valueOf(bookingDate));
                    stmt.setDate(3, Date.valueOf(travelDate));
                    stmt.setString(4, userID);
                    stmt.setString(5, packageID);
                    stmt.setInt(6, bookingPax);
                    stmt.setString(7, "Pending");

                    stmt.executeUpdate();
                }

                response.sendRedirect("check_booking.jsp");
            } catch (SQLException e) {
                throw new ServletException("Database error while creating booking", e);
            }
        }
    }

    private List<BOOKING> getBookingsByUserID(String userID) throws SQLException {
        List<BOOKING> bookings = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String query = "SELECT * FROM APP.BOOKING WHERE USERID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, userID);
                try (ResultSet rs = stmt.executeQuery()) {
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
                }
            }
        }
        return bookings;
    }
    
    private String generateBookingID(Connection conn) throws SQLException {
        String bookingID = null;
        boolean isUnique = false;

        while (!isUnique) {
            bookingID = "B" + System.currentTimeMillis();
            String query = "SELECT COUNT(*) FROM APP.BOOKING WHERE BOOKINGID = ?";
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
