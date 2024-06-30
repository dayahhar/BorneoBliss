<%-- 
    Document   : aboutus_afterLogin
    Created on : Jun 30, 2024, 10:21:20 AM
    Author     : dayah
--%>

<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BORNEO BLISS TRAVEL</title>
    <link rel="stylesheet" href="styleUser.css">
</head>
<body>
    <header>
        <h1>Welcome to Borneo Bliss Travel, ${sessionScope.name}!</h1>
        <p>Your one-stop solution for managing all your travel needs around Borneo</p>
    </header>
    <nav>
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
        <%-- Check if user is logged in as admin or traveler --%>
        <c:if test="${empty sessionScope.adminUsername and empty sessionScope.travelerUsername}">
            <a href="viewProfile.jsp">Profile</a>
            <a href="logout.jsp">Log Out</a>
        </c:if>
        <%-- Show logout option if user is logged in --%>
        <c:if test="${not empty sessionScope.adminUsername or not empty sessionScope.travelerUsername}">
            <a href="logout.jsp">Logout</a>
        </c:if>
    </nav>
        
    <div class="main">
        <div class="about-content">
            <h2>About Us</h2>
            <p>Borneo Bliss Travel is a premier travel agency specializing in unforgettable experiences in the heart of Borneo. With our passion for exploration and commitment to customer satisfaction, we strive to create personalized journeys that exceed expectations.</p>
            <p>Our team consists of experienced travel professionals who are dedicated to curating unique itineraries tailored to your preferences. Whether you're seeking adventure in the lush rainforests, relaxation on pristine beaches, or cultural immersion in vibrant local communities, we have the expertise to make your dreams a reality.</p>
            <p>At Borneo Bliss Travel, we believe that travel is more than just visiting destinations – it's about connecting with nature, immersing yourself in diverse cultures, and creating memories that last a lifetime. Let us guide you on an unforgettable journey through the enchanting landscapes and rich heritage of Borneo.</p>
            <p>Thank you for choosing Borneo Bliss Travel. We look forward to helping you discover the wonders of this remarkable destination.</p>
        </div>
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
