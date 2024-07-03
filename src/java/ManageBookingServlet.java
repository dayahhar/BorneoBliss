import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import booking.BOOKING;
import java.sql.SQLException;


@WebServlet("/ManageBookingsServlet")
public class ManageBookingServlet extends HttpServlet {
    // Define getConnection method for database connection
    private Connection getConnection() throws Exception {
        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String jdbcUsername = "app";
        String jdbcPassword = "app";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Handle GET requests to fetch and display bookings
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<BOOKING> bookings = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM BOOKING")) {

            while (rs.next()) {
                BOOKING booking = new BOOKING(
                    rs.getString("bookingID"),
                    rs.getDate("bookingDate"),
                    rs.getDate("travelDate"),
                    rs.getString("userID"),
                    rs.getString("packageID"),
                    rs.getInt("bookingPax"),
                    rs.getString("bookingStatus")
                );
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("view_bookings.jsp").forward(request, response);
        
        
    }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String bookingID = request.getParameter("bookingID");

        if ("approve".equals(action)) {
            try {
                approveBooking(bookingID);
                request.setAttribute("approvalSuccess", true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Refresh the list of bookings after approval
        List<BOOKING> bookings = new ArrayList<>();
        try {
            bookings = getBookings();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("view_bookings.jsp").forward(request, response);
    }

    private void approveBooking(String bookingID) throws Exception {
        try (Connection conn = getConnection()) {
            String updateQuery = "UPDATE BOOKING SET BOOKINGSTATUS = 'APPROVED' WHERE BOOKINGID = ?";
            try (PreparedStatement pstmtUpdate = conn.prepareStatement(updateQuery)) {
                pstmtUpdate.setString(1, bookingID);
                pstmtUpdate.executeUpdate();
            }
        }
    }

    private List<BOOKING> getBookings() throws Exception {
        List<BOOKING> bookings = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM BOOKING")) {

            while (rs.next()) {
                BOOKING booking = new BOOKING(
                        rs.getString("bookingID"),
                        rs.getDate("bookingDate"),
                        rs.getDate("travelDate"),
                        rs.getString("userID"),
                        rs.getString("packageID"),
                        rs.getInt("bookingPax"),
                        rs.getString("bookingStatus")
                );
                bookings.add(booking);
            }
        }
        return bookings;
    }

}