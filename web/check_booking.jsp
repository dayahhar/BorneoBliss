<%-- 
    Document   : check_booking
    Created on : Jun 23, 2024, 12:10:16 AM
    Author     : dayah
--%>
<%@ page import="java.util.List" %>
<%@ page import="booking.BOOKING" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bookings - Borneo Bliss Travel</title>
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
        <a href="login.html">Log In</a>
    </nav>
    <div class="main">
        <h2>Check Your Booking</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>User ID</th>
                    <th>Package ID</th>
                    <th>Number of Pax</th>
                    <th>Booking Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<BOOKING> bookings = (List<BOOKING>) request.getAttribute("bookings");
                    if (bookings != null) {
                        for (BOOKING booking : bookings) {
                %>
                <tr>
                    <td><%= booking.getBookingID() %></td>
                    <td><%= booking.getBookingDate() %></td>
                    <td><%= booking.getTravelDate() %></td>
                    <td><%= booking.getUserID() %></td>
                    <td><%= booking.getPackageID() %></td>
                    <td><%= booking.getBookingPax() %></td>
                    <td><%= booking.getBookingStatus() %></td>
                </tr>
                <div class="status">
                    <h3>Booking Status: <span id="booking-status">Pending</span></h3>
                    <p id="booking-details">Your booking is currently being processed. Please check back later.</p>
                    <a href="payment.html" class="payment-button" style="display: none;" id="pay-now-button">Pay Now</a>
                </div>
                <%
                        }
                    }
                    else {
                %>
                <tr>
                    <td colspan="7">No bookings found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
            <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; 2024 Borneo Bliss Travel. All rights reserved.</p>
    </footer>
    <script>
        // Example script to handle booking status and show payment button
        document.addEventListener('DOMContentLoaded', function() {
            const bookingStatus = document.getElementById('booking-status');
            const bookingDetails = document.getElementById('booking-details');
            const payNowButton = document.getElementById('pay-now-button');

            // This would be replaced with actual logic to check booking status
            const status = 'Approved'; // Example status

            if (status === 'Approved') {
                bookingStatus.textContent = 'Approved';
                bookingDetails.textContent = 'Your booking has been approved. Please proceed with the payment.';
                payNowButton.style.display = 'inline-block';
            } else {
                bookingStatus.textContent = 'Pending';
                bookingDetails.textContent = 'Your booking is currently being processed. Please check back later.';
            }
        });
    </script>
</body>
</html>
