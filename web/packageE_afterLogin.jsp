<%-- 
    Document   : packageE_afterLogin
    Created on : Jun 30, 2024, 10:28:52 AM
    Author     : dayah
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Package E - BORNEO BLISS TRAVEL</title>
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
    <div class="slideshow-container">
        <div class="slides fade">
            <img src="https://www.semadangkayak.com/wp-content/uploads/2020/05/semadang_kayaking-32-605x605.jpg" alt="Slide 1">
        </div>
        <div class="slides fade">
            <img src="https://www.semadangkayak.com/wp-content/uploads/2020/06/semadang_homepage-5.jpg" alt="Slide 2">
        </div>
        <div class="slides fade">
            <img src="https://www.semadangkayak.com/wp-content/uploads/2020/05/homepage-tour-1.jpg" alt="Slide 3">
        </div>
        <div class="slides fade">
            <img src="https://images.alltrails.com/eyJidWNrZXQiOiJhc3NldHMuYWxsdHJhaWxzLmNvbSIsImtleSI6InVwbG9hZHMvcGhvdG8vaW1hZ2UvNjg2ODc4ODcvMzY1OTlkMzE5NjA5MzNkYWM1YzRmY2VkMThiMDMxMmYuanBnIiwiZWRpdHMiOnsidG9Gb3JtYXQiOiJqcGVnIiwicmVzaXplIjp7IndpZHRoIjoyMDQ4LCJoZWlnaHQiOjIwNDgsImZpdCI6Imluc2lkZSJ9LCJyb3RhdGUiOm51bGwsImpwZWciOnsidHJlbGxpc1F1YW50aXNhdGlvbiI6dHJ1ZSwib3ZlcnNob290RGVyaW5naW5nIjp0cnVlLCJvcHRpbWlzZVNjYW5zIjp0cnVlLCJxdWFudGlzYXRpb25UYWJsZSI6M319fQ==" alt="Slide 4">
        </div>
        <div class="slides fade">
            <img src="https://keycdn.borneoecotours.com/images/cache/tours/gallery/kampong-bengoh/kampong-bengoh-04-1800x1200.webp" alt="Slide 5">
        </div>
        <div class="slides fade">
            <img src="https://www.amazingborneo.com/uploads/images/packages/437/medium/Semadang_03.jpg" alt="Slide 6">
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
            <h2>Package E Details - SEMADANG RIVER KAYAKING</h2>
            <h3>Tour Highlights</h3>
            <ul>
                <li>Experience the thrill of kayaking on the Semadang River and discover the flora and fauna of Borneo.</li>
                <li>Take memorable photos at the enchanting Aruang Piín Trusan Mini Waterfall and Sibudak Riverbank.</li>
                <li>Enjoy unique experiences such as refreshing swim, hand-feeding wild fish, and body rafting.</li>
            </ul>
            <h4>Overview of the Semadang River Kayaking</h4>
            <p>Experience the pristine Semadang River on an unforgettable journey! Perfect for all skill levels, no prior kayaking experience is needed. Begin with a scenic drive to Padawan, Sarawak's Kuching Division. Navigate 10km of crystal-clear waters surrounded by breathtaking scenery. Seasoned guides will lead you, with stops at the enchanting Aruang Piín Trusan Mini Waterfall and the Sibudak Riverbank for fun activities and a refreshing dip. The downstream adventure lasts about 1.5-2 hours, ending at a picturesque spot for a delicious home-cooked Bidayuh lunch.</p>
            
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
                        <td>RM400</td>
                    </tr>
                    <tr>
                        <td>Child</td>
                        <td>RM200</td>
                    </tr>
                </tbody>
            </table>
            
            <a href="create_booking.jsp"><button class="book-now-btn">Book Now!</button></a>
            <a href="package.html"><button class="goback-btn">Go Back to Packages</button></a>
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
