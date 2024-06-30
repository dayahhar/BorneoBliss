<%-- 
    Document   : packageD_afterLogin
    Created on : Jun 30, 2024, 10:28:41 AM
    Author     : dayah
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Package D - BORNEO BLISS TRAVEL</title>
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
            <img src="https://upload.wikimedia.org/wikipedia/commons/f/f4/Morning_fog_over_Danum_Valley_%2827329938517%29.jpg" alt="Slide 1">
        </div>
        <div class="slides fade">
            <img src="https://danumvalley.rainforestlodge.com/cdn/shop/files/borneo-rainforest-lodge-danum-valley-outdoor-bath-pool.jpg?v=1614318668" alt="Slide 2">
        </div>
        <div class="slides fade">
            <img src="https://danumvalley.rainforestlodge.com/cdn/shop/products/Main-Lodge-Borneo-Rainforest_800x600_crop_center.jpg" alt="Slide 3">
        </div>
        <div class="slides fade">
            <img src="https://danumvalley.rainforestlodge.com/cdn/shop/products/kawag-danum-valley-lodge.jpg" alt="Slide 4">
        </div>
        <div class="slides fade">
            <img src="https://danumvalley.rainforestlodge.com/cdn/shop/products/Danum-BRL-Canopy_grande.jpg?v=1589505361" alt="Slide 5">
        </div>
        <div class="slides fade">
            <img src="https://borneocalling.com/wp-content/uploads/2020/12/Danum-Valley-Borneo-Rainforest-Lodge-2-1.jpg" alt="Slide 6">
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
            <h2>Package D Details - 4D3N BORNEO RAINFOREST LODGE ADVENTURE</h2>
            <p>Includes guided tour, accommodation, meals</p>
            <h3>Tour Highlights</h3>
            <ul>
                <li>Luxury stay at the Borneo Rainforest Lodge</li>
                <li>Jungle habitat of the Danum Valley Conservation Area</li>
                <li>Borneo Wildlife Sightings</li>
                <li>Trek to Kadazandusun burial site - Coffin Cliff</li>
                <li>Tubing down the Danum River</li>
                <li>Fairy and Serpent Falls</li>
            </ul>
            <h4>Overview of the Borneo Rainforest Lodge</h4>
            <p>The award-winning Borneo Rainforest Lodge is situated by the Danum River in Sabah's largest protected Lowland Rainforest, the Danum Valley Conservation Area. Spanning 43,800 hectares, this pristine rainforest is home to over 340 bird species, 124 mammal species, 72 reptile species, 56 amphibian species, and 200 plant species per hectare. The lodge offers 31 chalets with fans and en-suite bathrooms, accommodating up to 60 guests on a full-board basis.</p>
            <h4>Location of the Borneo Rainforest Lodge</h4>
            <p>The nearest town to Danum Valley Conservation Area is Lahad Datu on Sabah's southeastern coast. It is accessible overland from Sandakan, Tawau, and Kota Kinabalu, with daily flights from Kota Kinabalu via MASwings.</p>
            <p>The 97 km drive from Lahad Datu to the Borneo Rainforest Lodge takes about two hours. The first 15 km is on a sealed road along the main Lahad Datu-Tawau Highway. At Silam, turn off onto a gravel road for the remaining 82 km to reach the lodge.</p>
            
            <h5>JUNGLE CHALET</h5>
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
                        <td>RM7730</td>
                    </tr>
                    <tr>
                        <td>Child</td>
                        <td>RM7165</td>
                    </tr>
                </tbody>
            
            Child Policy
            <ul>
                <li>No charge for child 5 years old and below, sharing room with parent.</li>
            </ul>
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
