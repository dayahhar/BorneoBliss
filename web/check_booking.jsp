<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Check Booking - Borneo Bliss Travel</title>
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
        <h2>Your Bookings</h2>
        <c:if test="${not empty bookings}"> 
            <table border="1">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Booking Date</th>
                        <th>Travel Date</th>
                        <th>User ID</th>
                        <th>Package ID</th>
                        <th>Number of Pax</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>${booking.bookingID}</td>
                            <td>${booking.bookingDate}</td>
                            <td>${booking.travelDate}</td>
                            <td>${booking.packageID}</td>
                            <td>${booking.userID}</td>
                            <td>${booking.bookingPax}</td>
                            <td>${booking.bookingStatus}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty bookings}">
            <p>No bookings found.</p>
        </c:if>
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
