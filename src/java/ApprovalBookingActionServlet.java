/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author user
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ApprovalBookingActionServlet")
public class ApprovalBookingActionServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:derby://localhost:1527/BorneoDB;create=true";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String bookingID = request.getParameter("bookingID");

    if (bookingID != null && !bookingID.isEmpty()) {
        Connection conn = null;
        PreparedStatement insertStmt = null;
        PreparedStatement deleteStmt = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false); // Disable auto-commit to manage transactions

            // Insert into CONFIRMED table after approval
            String insertQuery = "INSERT INTO CONFIRMED (BOOKINGID, BOOKINGDATE, TRAVELDATE, USERID, PACKAGEID, BOOKINGPAX, BOOKINGSTATUS) " +
                                 "SELECT A.BOOKINGID, A.BOOKINGDATE, A.TRAVELDATE, A.USERID, A.PACKAGEID, A.BOOKINGPAX, 'APPROVED' " +
                                 "FROM APPENDING A " +
                                 "WHERE A.BOOKINGID = ?";
            insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, bookingID);
            int rowsInserted = insertStmt.executeUpdate();

            if (rowsInserted > 0) {
                // Delete from APPENDING table after insertion into CONFIRMED
                String deleteQuery = "DELETE FROM APPENDING WHERE BOOKINGID = ?";
                deleteStmt = conn.prepareStatement(deleteQuery);
                deleteStmt.setString(1, bookingID);
                int rowsDeleted = deleteStmt.executeUpdate();

                if (rowsDeleted > 0) {
                    conn.commit(); // Commit the transaction
                    // Redirect back to ApprovalBookingServlet
                    response.sendRedirect(request.getContextPath() + "/ApprovalBookingServlet");
                } else {
                    conn.rollback(); // Rollback if deletion fails
                    response.getWriter().println("Failed to delete booking from APPENDING table.");
                }
            } else {
                conn.rollback(); // Rollback if insertion into CONFIRMED fails
                response.getWriter().println("Failed to insert into CONFIRMED table.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Handle your exceptions appropriately
            response.getWriter().println("Failed to update booking status.");
            try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            // Close resources and enable auto-commit
            try { if (insertStmt != null) insertStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (deleteStmt != null) deleteStmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        response.getWriter().println("Invalid booking ID.");
    }
}

}
