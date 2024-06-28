/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import payment.PAYMENT;

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
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;


/**
 *
 * @author dayah
 */

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:derby://localhost:1527/BorneoDB";
    private static final String DB_USER = "app";
    private static final String DB_PASSWORD = "app";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingID = request.getParameter("bookingID");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String userID = request.getParameter("userID");
        double amount = 0;

        // Validate payment information
        if (!isValidCard(cardNumber, expiryDate, cvv)) {
            request.setAttribute("errorMessage", "Invalid card details.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
            return;
        }

        // Retrieve the booking amount from the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT price FROM bookings WHERE bookingID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, bookingID);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        amount = rs.getDouble("price");
                    } else {
                        request.setAttribute("errorMessage", "Booking not found.");
                        request.getRequestDispatcher("payment.jsp").forward(request, response);
                        return;
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error retrieving booking price", e);
        }

        // Process payment
        if (processPayment(cardNumber, expiryDate, cvv, amount)) {
            // Update booking status to 'Paid'
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String updateQuery = "UPDATE bookings SET status = 'PAID' WHERE bookingID = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateQuery)) {
                    stmt.setString(1, bookingID);
                    stmt.executeUpdate();
                }
            } catch (SQLException e) {
                throw new ServletException("Database error updating booking status", e);
            }

            // Redirect to payment success page
            request.setAttribute("amount", amount);
            request.setAttribute("bookingID", bookingID);
            request.getRequestDispatcher("payment_success.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Payment failed.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }

    private boolean isValidCard(String cardNumber, String expiryDate, String cvv) {
        // Validate card number (13-19 digits)
        if (!cardNumber.matches("\\d{13,19}")) {
            return false;
        }

        // Validate expiry date (MM/YY format and future date)
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/yy");
            YearMonth expiry = YearMonth.parse(expiryDate, formatter);
            YearMonth currentMonth = YearMonth.now();
            if (expiry.isBefore(currentMonth)) {
                return false;
            }
        } catch (DateTimeParseException e) {
            return false;
        }

        // Validate CVV (3-4 digits)
        if (!cvv.matches("\\d{3,4}")) {
            return false;
        }

        return true;
    }

    private boolean processPayment(String cardNumber, String expiryDate, String cvv, double amount) {
        // Implement payment processing logic here (e.g., using a payment gateway API)

        // For example purposes, we'll assume a fictional payment gateway API
        try {
            // Create a payment request object
            PaymentRequest paymentRequest = new PaymentRequest();
            paymentRequest.setCardNumber(cardNumber);
            paymentRequest.setExpiryDate(expiryDate);
            paymentRequest.setCvv(cvv);
            paymentRequest.setAmount(amount);

            // Send the payment request to the payment gateway
            PaymentGateway paymentGateway = new PaymentGateway();
            PaymentResponse paymentResponse = paymentGateway.processPayment(paymentRequest);

            // Check the response from the payment gateway
            if (paymentResponse.isSuccessful()) {
                return true;
            } else {
                // Log the error message
                System.err.println("Payment failed: " + paymentResponse.getErrorMessage());
                return false;
            }
        } catch (Exception e) {
            // Log the exception
            System.err.println("Exception during payment processing: " + e.getMessage());
            return false;
        }
    }
    
    class PaymentRequest {
        private String cardNumber;
        private String expiryDate;
        private String cvv;
        private double amount;

        // Getters and setters
        public String getCardNumber() {
            return cardNumber;
        }

        public void setCardNumber(String cardNumber) {
            this.cardNumber = cardNumber;
        }

        public String getExpiryDate() {
            return expiryDate;
        }

        public void setExpiryDate(String expiryDate) {
            this.expiryDate = expiryDate;
        }

        public String getCvv() {
            return cvv;
        }

        public void setCvv(String cvv) {
            this.cvv = cvv;
        }

        public double getAmount() {
            return amount;
        }

        public void setAmount(double amount) {
            this.amount = amount;
        }
    }

    class PaymentResponse {
        private boolean successful;
        private String errorMessage;

        // Getters and setters
        public boolean isSuccessful() {
            return successful;
        }

        public void setSuccessful(boolean successful) {
            this.successful = successful;
        }

        public String getErrorMessage() {
            return errorMessage;
        }

        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }
    }

    // Example class to represent the payment gateway
    class PaymentGateway {
        public PaymentResponse processPayment(PaymentRequest paymentRequest) {
            // Implement the actual interaction with the payment gateway here
            // For example purposes, we'll simulate a successful payment response

            PaymentResponse paymentResponse = new PaymentResponse();
            paymentResponse.setSuccessful(true);
            return paymentResponse;
        }
    }
}
    