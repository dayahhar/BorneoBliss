<%-- 
    Document   : login
    Created on : Jun 28, 2024, 9:24:21 AM
    Author     : nurna
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Log In - BORNEO BLISS TRAVEL</title>
    <link rel="stylesheet" href="styleUser.css">
</head>
<body>
    <header>
        <h1>Welcome to Borneo Bliss Travel</h1>
        <p>Your one-stop solution for managing all your travel needs around Borneo</p>
        <link rel="stylesheet" href="styleUser.css">
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
        <a href="login.jsp">Log In</a> <!-- This link might be changed to a logout or profile link after login -->
    </nav>
    <div class="main">
        <h2>Log In</h2>
        <form action="LoginServlet" method="POST">
            <label for="role">Log In As:</label>
            <select id="role" name="role" required>
                <option value="user">User</option>
                <option value="admin">Admin</option>
            </select>

            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <input type="submit" value="Log In">
        </form>
        <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
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
