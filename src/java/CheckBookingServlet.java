/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author syahira sofea
 */
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

@WebServlet("/CheckBookingServlet")
public class CheckBookingServlet extends HttpServlet {

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

            String query = "SELECT * FROM PAYMENT";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Use StringBuilder to accumulate data if multiple rows are expected
            StringBuilder checkAdminbookingData = new StringBuilder();

            while (rs.next()) {
                String paymentID = rs.getString("PAYMENTID");
                double amount = rs.getDouble("AMOUNT");
                String cardNumber = rs.getString("CARDNUMBER");
                String expiryDate = rs.getString("EXPIRYDATE");
                int cvv = rs.getInt("CVV");
                String bookingID = rs.getString("BOOKINGID");
                String userID = rs.getString("USERID");
                String paymentStatus = rs.getString("PAYMENTSTATUS");

                // Append each row's data to StringBuilder
                checkAdminbookingData.append("<tr>")
                           .append("<td>").append(paymentID).append("</td>")
                           .append("<td>").append(amount).append("</td>")
                           .append("<td>").append(cardNumber).append("</td>")
                           .append("<td>").append(expiryDate).append("</td>")
                           .append("<td>").append(cvv).append("</td>")
                           .append("<td>").append(bookingID).append("</td>")
                           .append("<td>").append(userID).append("</td>")
                           .append("<td>").append(paymentStatus).append("</td>")
                           .append("</tr>");
            }
            
             
            request.setAttribute("checkAdminbookingData", checkAdminbookingData.toString());
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle your exceptions appropriately
        } finally {
            // Close resources in reverse order of their creation
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        request.getRequestDispatcher("checkAdmin_bookings.jsp").forward(request, response);
    }
}
