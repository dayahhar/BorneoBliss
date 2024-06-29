<%@ page import="java.util.List" %>
<%@ page import="booking.BOOKING" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Booking - Borneo Bliss Travel</title>
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
    <div class="main">
        <h2>Check Your Booking</h2>
        <%
            List<BOOKING> bookings = (List<BOOKING>) request.getAttribute("bookings");
            if (bookings != null && !bookings.isEmpty()) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>Package ID</th>
                    <th>Number of Pax</th>
                    <th>Booking Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (BOOKING booking : bookings) {
                %>
                <tr>
                    <td><%= booking.getBookingID() %></td>
                    <td><%= booking.getBookingDate() %></td>
                    <td><%= booking.getTravelDate() %></td>
                    <td><%= booking.getPackageID() %></td>
                    <td><%= booking.getBookingPax() %></td>
                    <td><%= booking.getBookingStatus() %></td>
                    <td>
                        <% if ("Approved".equals(booking.getBookingStatus())) { %>
                            <form action="payment.jsp" method="post">
                                <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>">
                                <button type="submit" class="payment-button">Pay Now</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p>No booking is made by the user.</p>
        <%
            }
        %>
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
