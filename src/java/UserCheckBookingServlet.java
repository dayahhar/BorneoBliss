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

@WebServlet("/UserCheckBookingServlet")
public class UserCheckBookingServlet extends HttpServlet {
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
}
