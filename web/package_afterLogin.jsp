<%-- 
    Document   : package_afterLogin
    Created on : Jun 30, 2024, 10:20:17 AM
    Author     : dayah
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Packages - BORNEO BLISS TRAVEL</title>
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
    
    <div class="packages">
        <div class="package">
            <a href="packageA_afterLogin.jsp">
                <img src="https://i.pinimg.com/736x/53/7c/93/537c93b841a2411d918766dc6773dc8d.jpg" alt="Package A">
                <div class="package-details">
                    <h3>5D4N KOTA KINABALU & KUNDASANG TOUR</h3>
                    <p>5-day tour offers perfect mix of relaxation, adventure, educational experiences for unforgettable family memories.</p>
                </div>
            </a>
        </div>
        <div class="package">
            <a href="packageB_afterLogin.jsp">
                <img src="https://www.malaysia.travel/webroot/articles/peekintomalaysia/kinabalu1.jpg" alt="Package B">
                <div class="package-details">
                    <h3>2D1N MOUNT KINABALU CLIMB</h3>
                    <p>FREE 1-night stay in KK for the 2D1N Mount Kinabalu Climb with Rata Lebom Resthouse. Limited slot!</p>
                </div>
            </a>
        </div>
        <div class="package">
            <a href="packageC_afterLogin.jsp">
                <img src="https://www.zubludiving.com/images/Malaysia/Sabah/Sipadan/Sipadan-Sabah-Malaysia-Diving-Drop-Off.jpg" alt="Package C">
                <div class="package-details">
                    <h3>DIVE TOUR AROUND SEMPORNA</h3>
                    <p>Stay at luxurious Sipadan-Kapalai Dive Resort and discover the incredible diving scene in Semporna.</p>
                </div>
            </a>
        </div>
        <div class="package">
            <a href="packageD_afterLogin.jsp">
                <img src="https://upload.wikimedia.org/wikipedia/commons/f/f4/Morning_fog_over_Danum_Valley_%2827329938517%29.jpg" alt="Package D">
                <div class="package-details">
                    <h3>4D3N BORNEO RAINFOREST LODGE ADVENTURE</h3>
                    <p>Danum Valley Conservation Area in eastern Sabah spans 43,800 hectares of pristine tropical rainforest.</p>
                </div>
            </a>
        </div>
        <div class="package">
            <a href="packageE_afterLogin.jsp">
                <img src="https://www.semadangkayak.com/wp-content/uploads/2020/05/semadang_kayaking-32-605x605.jpg" alt="Package E">
                <div class="package-details">
                    <h3>SEMADANG RIVER KAYAKING</h3>
                    <p>Experience thrill of kayaking on Semadang River and discover flora and fauna of Borneo.</p>
                </div>
            </a>
        </div>
        <div class="package">
            <a href="packageF_afterLogin.jsp">
                <img src="https://myrehat.com/wp-content/uploads/2023/08/18.jpeg" alt="Package F">
                <div class="package-details">
                    <h3>SUSUNG WATERFALL DAY TRIP</h3>
                    <p>Discover inner explorer on day trip to Bengoh Dam, hidden gem in Sarawak's jungles.</p>
                </div>
            </a>
        </div>
        <div class="package">
            <a href="packageG_afterLogin.jsp">
                <img src="https://sarawakforestry.com/layout2/wp-content/uploads/2017/05/wind-cave-photo1.png" alt="Package G">
                <div class="package-details">
                    <h3>KUCHING DAY TOUR - FAIRY AND WIND CAVES</h3>
                    <p>Explore enchanting Fairy and Wind Caves in Bau, Kuching. Witness stunning limestone formations, stalactites, stalagmites.</p>
                </div>
            </a>
        </div>
        <div class="package">
            <a href="packageH_afterLogin.jsp">
                <img src="https://i0.wp.com/borneoadventure.com/v3/wp-content/uploads/2011/12/sarawak-kee-lubok-kasai-02.jpg?fit=2000%2C1500&quality=60&strip=all&ssl=1" alt="Package H">
                <div class="package-details">
                    <h3>4D3N LUBOK KASAI JUNGLE EXPERIENCE</h3>
                    <p>Visit Nanga Sumpa longhouse to learn about Iban culture. Swim in Enseluai Waterfall, enjoy riverside BBQ.</p>
                </div>
            </a>
        </div>
    </div>
        <div class="chatbot-button-container" onclick="window.location.href='chatBox.html'">
            <img src="image/robotChatbot.png" alt="Chat Icon">
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
