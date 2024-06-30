<%-- 
    Document   : home
    Created on : Jun 30, 2024, 12:04:06 AM
    Author     : nurna
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - BORNEO BLISS TRAVEL </title>
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
        <div class="slideshow-container">
            <div class="slides fade">
                <img src="https://www.oryxphoto.com/wp-content/uploads/2019/02/Borneo-Tours_web.jpg" style="width: 100%; height: auto;">
            </div>
            <div class="slides fade">
                <img src="https://www.oryxphoto.com/wp-content/uploads/2019/04/Orangutan-Photo-Tour-1.jpg" style="width: 100%; height: auto;">
            </div>
            <div class="slides fade">
                <img src="https://www.oryxphoto.com/wp-content/uploads/2019/04/Orangutan-Photo-Tour-3.jpg" style="width: 100%; height: auto;">
            </div>
            <div class="slides fade">
                <img src="https://images.squarespace-cdn.com/content/v1/5766685d4402432fcc18efd4/1697437050818-VQQ7J0XAP52VA27NWIVP/Long-tailed-Macaque-Sepilok-RDC-09-07-23.png?format=1000w" style="width: 100%; height: auto;">
            </div>
            <div class="slides fade">
                <img src="https://mediaim.expedia.com/destination/1/1fae69e907143c28cc0ea9771f67f041.jpg" style="width: 100%; height: auto;">
            </div>
            <div class="slides fade">
                <img src="https://a.travel-assets.com/findyours-php/viewfinder/images/res70/532000/532651-kota-kinabalu.jpg" style="width: 100%; height: auto;">
            </div>
            <div class="slides fade">
                <img src="https://www.oryxphoto.com/wp-content/uploads/2019/02/Borneo-Photo-Expedition_web.jpg" style="width: 100%; height: auto;">
            </div>
            <div class="dot-container">
                <span class="dot" onclick="currentSlide(1)"></span>
                <span class="dot" onclick="currentSlide(2)"></span>
                <span class="dot" onclick="currentSlide(3)"></span>
                <span class="dot" onclick="currentSlide(4)"></span>
                <span class="dot" onclick="currentSlide(5)"></span>
                <span class="dot" onclick="currentSlide(6)"></span>
                <span class="dot" onclick="currentSlide(7)"></span>
            </div>
        </div>
        <div class="description">
            <h2>Discover Your Next Adventure With Us!</h2>
            <p>In the heart of Southeast Asia lies the breathtaking landscapes and cultural marvels of Sabah and Sarawak, East Malaysia. Inspired by the beauty and diversity of this region, let's embarked on a journey tailored specifically for the unique needs of travelers in this enchanting destination.</p>
            <p>Our vision for the Borneo Bliss Management System emerged from a deep understanding of the challenges faced by both travelers and travel agencies in East Malaysia. We recognized the need for a comprehensive solution that seamlessly integrates the entire travel experience, from browsing and booking to payment and feedback, all in one user-friendly platform.</p>
            <p>At its core, the Borneo Bliss Management System aims to empower travelers by providing them with a curated selection of tourist attractions, package deals, and tours, all easily accessible through a sleek and intuitive interface. We ensure that every journey is tailored to meet the unique desires of each individual, enhancing overall satisfaction and enjoyment.</p>
        </div>
    </div>
    <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; <%= java.time.Year.now().getValue() %> Borneo Bliss Travel. All rights reserved.</p>
    </footer>
    <script>
        let slideIndex = 0;
        showSlides();

        function showSlides() {
            let i;
            let slides = document.getElementsByClassName("slides");
            let dots = document.getElementsByClassName("dot");
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slideIndex++;
            if (slideIndex > slides.length) {slideIndex = 1;}
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex-1].style.display = "block";
            dots[slideIndex-1].className += " active";
            setTimeout(showSlides, 1800); // Change image every 1.8 seconds
        }

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {
            showSlides(slideIndex = n);
        }
    </script>
</body>
</html>

