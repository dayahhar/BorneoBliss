package report;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/getBookingStatus")
public class BookingStatusServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/your_database";
    private static final String DB_USER = "your_username";
    private static final String DB_PASSWORD = "your_password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HashMap<String, Integer> statusCounts = new HashMap<>();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "SELECT status, COUNT(*) as count FROM bookings GROUP BY status";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                statusCounts.put(rs.getString("status"), rs.getInt("count"));
            }
            
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Construct JSON response manually
        StringBuilder json = new StringBuilder("{");
        for (String key : statusCounts.keySet()) {
            if (json.length() > 1) {
                json.append(",");
            }
            json.append("\"").append(key).append("\":").append(statusCounts.get(key));
        }
        json.append("}");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.close();
    }
}
