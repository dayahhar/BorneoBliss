<%-- 
    Document   : successUpdateProfile
    Created on : Jun 28, 2024, 2:34:50 PM
    Author     : Alesha Ruzi
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Success Update Profile - BORNEO BLISS TRAVEL</title>
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
    <div class="message">
        <h1 align="center">Profile Updated Successfully!</h1>
        <a href="index.html"><button class="goback-btn">Go Back to Home Page</button></a>
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

