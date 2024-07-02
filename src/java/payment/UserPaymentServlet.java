package payment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserPaymentServlet")
public class UserPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
    private static final String jdbcUsername = "app";
    private static final String jdbcPassword = "app";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("loginUser.jsp");
            return;
        }

        String bookingID = request.getParameter("bookingID");
        if (bookingID == null || bookingID.isEmpty()) {
            response.sendRedirect("check_booking.jsp");
            return;
        }

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String query = "SELECT b.BOOKINGPAX, p.PACKAGEPRICE " +
                           "FROM APP.BOOKING b, APP.PACKAGE p " +
                           "WHERE b.PACKAGEID = p.PACKAGEID AND b.BOOKINGID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, bookingID);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int bookingPax = rs.getInt("BOOKINGPAX");
                        double packagePrice = rs.getDouble("PACKAGEPRICE");
                        double totalAmount = bookingPax * packagePrice;

                        request.setAttribute("totalAmount", totalAmount);
                        request.setAttribute("bookingID", bookingID);
                        request.getRequestDispatcher("payment.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("check_booking.jsp");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("check_booking.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingID = request.getParameter("bookingID");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        int cvv = Integer.parseInt(request.getParameter("cvv"));
        double amount = Double.parseDouble(request.getParameter("totalAmount"));

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("loginUser.jsp");
            return;
        }

        String userID = new PAYMENT().getUserID(username);

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            String paymentID = generatePaymentID(conn);
            String paymentQuery = "INSERT INTO APP.PAYMENT (PAYMENTID, AMOUNT, CARDNUMBER, EXPIRYDATE, CVV, BOOKINGID, USERID, PAYMENTSTATUS) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            String updateBookingQuery = "UPDATE APP.BOOKING SET BOOKINGSTATUS = 'PAID' WHERE BOOKINGID = ?";

            try (PreparedStatement paymentStmt = conn.prepareStatement(paymentQuery);
                 PreparedStatement bookingStmt = conn.prepareStatement(updateBookingQuery)) {
                conn.setAutoCommit(false);

                paymentStmt.setString(1, paymentID);
                paymentStmt.setDouble(2, amount);
                paymentStmt.setString(3, cardNumber);
                paymentStmt.setString(4, expiryDate);
                paymentStmt.setInt(5, cvv);
                paymentStmt.setString(6, bookingID);
                paymentStmt.setString(7, userID);
                paymentStmt.setString(8, "PAID");

                int paymentRowCount = paymentStmt.executeUpdate();

                if (paymentRowCount > 0) {
                    bookingStmt.setString(1, bookingID);
                    int bookingRowCount = bookingStmt.executeUpdate();

                    if (bookingRowCount > 0) {
                        conn.commit();
                        response.sendRedirect("check_booking.jsp");
                    } else {
                        conn.rollback();
                        request.setAttribute("error", "Failed to update booking status. Please try again.");
                        request.getRequestDispatcher("payment.jsp").forward(request, response);
                    }
                } else {
                    conn.rollback();
                    request.setAttribute("error", "Failed to process payment. Please try again.");
                    request.getRequestDispatcher("payment.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("payment.jsp").forward(request, response);
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }

    private String generatePaymentID(Connection conn) throws SQLException {
        String paymentID = null;
        boolean isUnique = false;

        while (!isUnique) {
            int randomNum = (int) (Math.random() * 100);
            paymentID = "P" + String.format("%02d", randomNum);
            String query = "SELECT COUNT(*) FROM APP.PAYMENT WHERE PAYMENTID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, paymentID);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        isUnique = true;
                    }
                }
            }
        }

        return paymentID;
    }
}
