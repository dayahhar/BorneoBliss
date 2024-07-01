<%-- 
    Document   : UpdateProfile
    Created on : Jun 28, 2024, 2:32:12 PM
    Author     : Alesha Ruzi
--%>

<%@page import="traveler.TRAVELER"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - BORNEO BLISS TRAVEL</title>
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
        <a href="logout.jsp">Log Out</a>
    </nav>
        
        <div class="main">
        <h2>Update Profile</h2>
        <form action="updateProfile.jsp" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="${sessionScope.username}" >
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${sessionScope.name}" >
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${sessionScope.email}" >
            </div>
            <div class="form-group">
                <label for="phoneNo">Phone Number:</label>
                <input type="tel" id="phone" name="phoneNo" value="${sessionScope.phoneNo}" >
            </div>
            <a href="successUpdateProfile.jsp"><button type="submit" class="book-now-btn">Submit</button></a>       
        </form>
    </div>

    <script>
        function goToHomePage() {
            window.location.href = 'index.html'; // Assuming index.html is the home page
        }
    </script>
    
        <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; 2024 Borneo Bliss Travel. All rights reserved.</p>
        </footer>
    </body>
</html>
