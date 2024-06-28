/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author syahira
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

@WebServlet("/ApprovalBookingServlet")
public class ApprovalBookingServlet extends HttpServlet {

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

            String query = "SELECT A.BOOKINGID, A.BOOKINGDATE, A.TRAVELDATE, A.USERID, A.BOOKINGPAX, A.BOOKINGSTATUS, " +
                           "P.PACKAGEID, P.PACKAGENAME, P.PACKAGEPRICE, P.PACKAGESTATE, " +
                           "PAY.PAYMENTID, PAY.AMOUNT, PAY.PAYMENTSTATUS " +
                           "FROM APPENDING A " +
                           "INNER JOIN PACKAGE P ON A.PACKAGEID = P.PACKAGEID " +
                           "INNER JOIN PAYMENT PAY ON A.BOOKINGID = PAY.BOOKINGID " +
                           "WHERE A.BOOKINGSTATUS = 'PENDING'";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Use StringBuilder to accumulate data if multiple rows are expected
            StringBuilder approvalData = new StringBuilder();

            while (rs.next()) {
                String bookingID = rs.getString("BOOKINGID");
                String bookingDate = rs.getString("BOOKINGDATE");
                String travelDate = rs.getString("TRAVELDATE");
                String userID = rs.getString("USERID");
                String packageID = rs.getString("PACKAGEID");
                int bookingPax = rs.getInt("BOOKINGPAX");
                String bookingStatus = rs.getString("BOOKINGSTATUS");
                
               
                String packageName = rs.getString("PACKAGENAME");
                double packagePrice = rs.getDouble("PACKAGEPRICE");
                String packageState = rs.getString("PACKAGESTATE");
                
                String paymentID = rs.getString("PAYMENTID");
                double amount = rs.getDouble("AMOUNT");
                String paymentStatus = rs.getString("PAYMENTSTATUS");
                
                

                // Append each row's data to StringBuilder
                approvalData.append("<tr>")
                           .append("<td>").append(bookingID).append("</td>")
                           .append("<td>").append(bookingDate).append("</td>")
                           .append("<td>").append(travelDate).append("</td>")
                           .append("<td>").append(userID).append("</td>")
                           .append("<td>").append(bookingPax).append("</td>")
                           .append("<td>").append(bookingStatus).append("</td>")
                        
                           .append("<td>").append(packageID).append("</td>")
                           .append("<td>").append(packageName).append("</td>")
                           .append("<td>").append(packagePrice).append("</td>")
                           .append("<td>").append(packageState).append("</td>")
                        
                           .append("<td>").append(paymentID).append("</td>")
                           .append("<td>").append(amount).append("</td>")
                           .append("<td>").append(paymentStatus).append("</td>")
                           .append("<td><form action=\"ApprovalBookingActionServlet\" method=\"post\">")
                           .append("<input type=\"hidden\" name=\"bookingID\" value=\"").append(bookingID).append("\">")
                           .append("<input type=\"submit\" value=\"Approve\">")
                           .append("</form></td>")
                           .append("</tr>");
            }

            // Set the accumulated data as an attribute
            request.setAttribute("approvalData", approvalData.toString());

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle your exceptions appropriately
        } finally {
            // Close resources in reverse order of their creation
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        request.getRequestDispatcher("approve_bookings.jsp").forward(request, response);
    }
}
