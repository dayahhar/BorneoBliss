<%-- 
    Document   : payment
    Created on : Jun 23, 2024, 2:25:49 AM
    Author     : dayah
--%>

<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>

<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String bookingID = request.getParameter("bookingID");
    String userID = request.getParameter("userID");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Borneo Bliss Travel</title>
    <link rel="stylesheet" href="styleUser.css">
</head>
<body>
    <header>
        <h1>Welcome to Borneo Bliss Travel</h1>
        <p>Your one-stop solution for managing all your travel needs around Borneo</p>
    </header>
    <nav>
        <a href="index.html">
            <img src="image/logo.png" alt="Borneo Bliss Logo">
        </a>
        <a href="package.html">Packages</a>
        <a href="aboutus.html">About Us</a>
        <a href="contact.html">Contact</a>
        <div class="booking-nav">
            <div class="dropdown">
                <span class="booking">Booking</span>
                <div class="dropdown-content">
                    <a href="create_booking.jsp">Book Now</a>
                    <a href="check_booking.jsp">Check Booking</a>
                </div>
            </div>
        </div>
        <a href="viewProfile.jsp">Profile</a>
        <div class="login-nav">
                <div class="dropdown">
                    <span class="login">Log In</span>
                    <div class="dropdown-content">
                        <a href="loginAdmin.jsp">Log In Admin</a>
                        <a href="loginUser.jsp">Log In Traveler</a>
                    </div>
                </div>
        </div>
    </nav>
    <div class="main">
        <h2>Make Your Payment</h2>
        <form action="PaymentServlet" method="POST">
            <label for="amount">Amount(RM)(incl. tax 6%):</label>
            <input type="number" step="0.01" id="amount" name="amount" required><br>

            <label for="cardNumber">Card Number:</label>
            <input type="text" id="cardNumber" name="cardNumber" required><br>

            <label for="expiryDate">Expiry Date:</label>
            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required><br>

            <label for="cvv">CVV:</label>
            <input type="number" id="cvv" name="cvv" required><br>

            <label for="bookingID">Booking ID:</label>
            <input type="text" id="bookingID" name="bookingID" value="<%= bookingID %>" required readonly><br>

            <label for="userID">User ID:</label>
            <input type="text" id="userID" name="userID" value="<%= userID %>" required readonly><br>

            <input type="submit" value="Pay">
        </form>
    </div>
    <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; 2024 Borneo Bliss Travel. All rights reserved.</p>
    </footer>
</body>
</html>
