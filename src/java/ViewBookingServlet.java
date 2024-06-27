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

@WebServlet("/ViewBookingServlet")
public class ViewBookingServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:derby://localhost:1527/BorneoDB;create=true";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String query = "SELECT * FROM APPENDING UNION SELECT * FROM CONFIRMED";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Use StringBuilder to accumulate data if multiple rows are expected
            StringBuilder bookingData = new StringBuilder();

            while (rs.next()) {
                String bookingID = rs.getString("BOOKINGID");
                String bookingDate = rs.getString("BOOKINGDATE");
                String travelDate = rs.getString("TRAVELDATE");
                String userID = rs.getString("USERID");
                String packageID = rs.getString("PACKAGEID");
                int bookingPax = rs.getInt("BOOKINGPAX");
                String bookingStatus = rs.getString("BOOKINGSTATUS");
                
                
                String approveAction = "ManageUsersServlet"; // Action for pending bookings
                String editAction = "ManageUsersServlet";      // Action for confirmed bookings

                String buttonText = "";
                String formAction = "";
                
                
                if (bookingStatus.equals("APPROVED")) {
                    buttonText = "Approve Booking";
                    formAction = approveAction;
                } else if (bookingStatus.equals("PENDING")) {
                    buttonText = "Edit Booking";
                    formAction = editAction;
                }
             

                // Append each row's data to StringBuilder
                bookingData.append("<tr>")
                           .append("<td>").append(bookingID).append("</td>")
                           .append("<td>").append(bookingDate).append("</td>")
                           .append("<td>").append(travelDate).append("</td>")
                           .append("<td>").append(userID).append("</td>")
                           .append("<td>").append(packageID).append("</td>")
                           .append("<td>").append(bookingPax).append("</td>")
                           .append("<td>").append(bookingStatus).append("</td>")
                           .append("<td>")
                            .append("<form action=\"").append(formAction).append("\" method=\"post\">")
                            .append("<input type=\"submit\" value=\"").append(buttonText).append("\" />")
                            .append("</form>")
                            .append("</td>")
                           .append("</tr>");
            }

            // Set the accumulated data as an attribute
            request.setAttribute("bookingData", bookingData.toString());

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle your exceptions appropriately
        } finally {
            // Close resources in reverse order of their creation
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        request.getRequestDispatcher("view_bookings.jsp").forward(request, response);
    }
}
