<%-- 
    Document   : loginAdmin
    Created on : Jun 29, 2024, 9:35:16 PM
    Author     : nurna
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="controller.LoginAdminServlet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Log In As Admin- BORNEO BLISS TRAVEL</title>
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
        <h2>Log In As Admin</h2>
        <form action="<%=request.getContextPath()%>/LoginAdminServlet" method="POST">

            <label for="username">Username:</label>
            <input type="text" id="username" name="adminUsername" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="adminPassword" required>

            <input type="submit" value="Log In">
        </form>
        <p><a href="index.html">Back to Home</a></p>
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