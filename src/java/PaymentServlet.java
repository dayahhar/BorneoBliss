/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import payment.PAYMENT;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author dayah
 */
@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amount = request.getParameter("amount");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String bookingID = request.getParameter("bookingID");
        String userID = request.getParameter("userID");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");

            String paymentID = "P" + (int) (Math.random() * 10000); // Generate a random payment ID

            String insertPaymentSQL = "INSERT INTO APP.PAYMENT (PAYMENTID, AMOUNT, CARDNUMBER, EXPIRYDATE, CVV, BOOKINGID, USERID, PAYMENTSTATUS) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(insertPaymentSQL);
            pstmt.setString(1, paymentID);
            pstmt.setDouble(2, Double.parseDouble(amount));
            pstmt.setString(3, cardNumber);
            pstmt.setString(4, expiryDate);
            pstmt.setInt(5, Integer.parseInt(cvv));
            pstmt.setString(6, bookingID);
            pstmt.setString(7, userID);
            pstmt.setString(8, "paid");
            pstmt.executeUpdate();

            String updateBookingSQL = "UPDATE APP.BOOKING SET BOOKINGSTATUS = ? WHERE BOOKINGID = ?";
            PreparedStatement pstmt2 = conn.prepareStatement(updateBookingSQL);
            pstmt2.setString(1, "paid");
            pstmt2.setString(2, bookingID);
            pstmt2.executeUpdate();

            response.sendRedirect("check_booking.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}