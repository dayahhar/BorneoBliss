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
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author dayah
 */

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double amount = Double.parseDouble(request.getParameter("amount"));
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        int cvv = Integer.parseInt(request.getParameter("cvv"));
        String bookingID = request.getParameter("bookingID");
        String userID = request.getParameter("userID");

        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String dbUser = "app";
        String dbPassword = "app";

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "INSERT INTO Payment (amount, cardNumber, expiryDate, cvv, bookingID, userID) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setDouble(1, amount);
            statement.setString(2, cardNumber);
            statement.setString(3, expiryDate);
            statement.setInt(4, cvv);
            statement.setString(5, bookingID);
            statement.setString(6, userID);

            statement.executeUpdate();
            statement.close();
            connection.close();

            response.sendRedirect("payment_success.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}