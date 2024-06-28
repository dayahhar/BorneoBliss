import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/getBookingReport")
public class BookingReportServlet extends HttpServlet {
    
    String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
    String dbUser = "app";
    String dbPassword = "app";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            
            String sql = "SELECT traveler_name, booking_date, travel_date, details FROM bookings WHERE booking_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookingId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String travelerName = rs.getString("traveler_name");
                String bookingDate = rs.getString("booking_date");
                String travelDate = rs.getString("travel_date");
                String details = rs.getString("details");
                
                // Prepare JSON or HTML response
                String jsonResponse = "{\"travelerName\": \"" + travelerName + "\", \"bookingDate\": \"" + bookingDate + "\", \"travelDate\": \"" + travelDate + "\", \"details\": \"" + details + "\"}";
                
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
            
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
