<%-- 
    Document   : payment
    Created on : Jun 23, 2024, 2:25:49 AM
    Author     : dayah
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("loginUser.jsp");
        return;
    }
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
        <h1>Welcome to Borneo Bliss Travel, ${sessionScope.name}!</h1>
        <p>Your one-stop solution for managing all your travel needs around Borneo</p>
    </header>
    <nav>
        <a href="home.jsp">
            <img src="image/logo.png" alt="Borneo Bliss Logo">
        </a>
        <a href="package_afterLogin.jsp">Packages</a>
        <a href="aboutus_afterLogin.jsp">About Us</a>
        <a href="contact_afterLogin.jsp">Contact</a>
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
        <a href="LogoutServlet">Log Out</a>
    </nav>
    <div class="main">
        <h2>Make Your Payment</h2>
        <form action="UserPaymentServlet" method="post">
            <label for="bookingID">Booking ID:</label>
            <input type="text" id="bookingID" name="bookingID" value="${bookingID}" readonly><br>
            
            <label for="totalAmount">Total Amount:</label>
            <input type="text" id="totalAmount" name="totalAmount" value="${totalAmount}" readonly><br>

            <label for="cardNumber">Card Number:</label>
            <input type="text" id="cardNumber" name="cardNumber" required><br>
            
            <label for="expiryDate">Expiry Date (MM/YY):</label>
            <input type="text" id="expiryDate" name="expiryDate" required><br>
            
            <label for="cvv">CVV:</label>
            <input type="text" id="cvv" name="cvv" required><br>
            
            <input type="submit" value="Pay Now!">
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
