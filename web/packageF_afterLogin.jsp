<%-- 
    Document   : packageF_afterLogin
    Created on : Jun 30, 2024, 10:29:08 AM
    Author     : dayah
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Package F - BORNEO BLISS TRAVEL</title>
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
    <div class="slideshow-container">
        <div class="slides fade">
            <img src="https://myrehat.com/wp-content/uploads/2023/08/18.jpeg" alt="Slide 1">
        </div>
        <div class="slides fade">
            <img src="https://asianitinerary.com/wp-content/uploads/2022/09/Tarzan-swing.jpg" alt="Slide 2">
        </div>
        <div class="slides fade">
            <img src="https://www.theborneopost.com/newsimages/2022/09/bengoh001.jpg" alt="Slide 3">
        </div>
        <div class="slides fade">
            <img src="https://myrehat.com/wp-content/uploads/2023/08/2.png" alt="Slide 4">
        </div>
        <div class="slides fade">
            <img src="https://www.theborneopost.com/newsimages/2022/09/bengoh001.jpg" alt="Slide 5">
        </div>
        <div class="slides fade">
            <img src="https://cphtravel.com.my/wp-content/uploads/2018/09/Bengoh-eco-retreat_8.jpg" alt="Slide 6">
        </div>
        <div class="dot-container">
            <span class="dot" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
            <span class="dot" onclick="currentSlide(3)"></span>
            <span class="dot" onclick="currentSlide(4)"></span>
            <span class="dot" onclick="currentSlide(5)"></span>
            <span class="dot" onclick="currentSlide(6)"></span>
        </div>
    </div>
    <div class="main">
        <div class="description">
            <h2>Package F Details - SUSUNG WATERFALL DAY TRIP</h2>
            <p>Includes guided tour, meals</p>
            <h3>Tour Highlights</h3>
            <ul>
                <li>Immerse into the breathtaking views of Bengoh Dam during boat ride.</li>
                <li>Trek through the lush rainforest to the refreshing Susung Waterfall.</li>
                <li>Rejuvenate in the natural beauty of the waterfall and surrounding environment.</li>
            </ul>
            <h4>Overview of the Susung Waterfall</h4>
            <p>Explore the hidden gem of Bengoh Dam in Sarawak's jungle! Near the Sarawak-Kalimantan border, it features stunning sights like Susung Waterfall and Curtain Waterfall, reminiscent of "Jurassic World." Enjoy a perfect mix of sightseeing, outdoor adventure, and relaxation amidst picturesque landscapes and serene waterfalls.</p>
            
            <table>
                <thead>
                    <tr>
                        <th>Category</th>
                        <th>Price per Pax</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Adult</td>
                        <td>RM550</td>
                    </tr>
                    <tr>
                        <td>Child</td>
                        <td>RM275</td>
                    </tr>
                </tbody>
            </table>
            
            <a href="create_booking.jsp"><button class="book-now-btn">Book Now!</button></a>
            <a href="package_afterLogin.jsp"><button class="goback-btn">Go Back to Packages</button></a>
        </div>
    </div>
    <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; 2024 Borneo Bliss Travel. All rights reserved.</p>
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
            if (slideIndex > slides.length) {slideIndex = 1}
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex-1].style.display = "block";
            dots[slideIndex-1].className += " active";
            setTimeout(showSlides, 1800);
        }

        function plusSlides(n) {
            slideIndex += n;
            if (slideIndex > document.getElementsByClassName("slides").length) {
                slideIndex = 1;
            } else if (slideIndex < 1) {
                slideIndex = document.getElementsByClassName("slides").length;
            }
            showSlides();
        }

        function currentSlide(n) {
            slideIndex = n;
            showSlides();
        }
    </script>
</body>
</html>
