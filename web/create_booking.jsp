<%-- 
    Document   : create_booking
    Created on : Jun 22, 2024, 11:53:32 PM
    Author     : dayah
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Booking - Borneo Bliss Travel</title>
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
        <a href="login.jsp">Log In</a>
    </nav>
    <div class="main">
        <h2>Book Your Adventure</h2>
        <form action="UserBookingServlet" method="POST">
            <input type="hidden" name="action" value="create">

            <label for="bookingDate">Booking Date:</label>
            <input type="date" id="bookingDate" name="bookingDate" required><br>

            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" required><br>

            <label for="userID">User ID:</label>
            <input type="text" id="userID" name="userID" required><br>

            <label for="packageID">Package:</label>
            <select id="packageID" name="package" required>
                    <option value="P01A">5D4N KOTA KINABALU & KUNDASANG TOUR (ADULT)</option>
                    <option value="P01C">5D4N KOTA KINABALU & KUNDASANG TOUR (CHILD)</option>
                    <option value="P02">2D1N MOUNT KINABALU CLIMB (ADULT ONLY)</option>
                    <option value="P03A">SIPADAN ISLAND: SIPADAN DIVE TOUR (ADULT)</option>
                    <option value="P03C">SIPADAN ISLAND: SIPADAN DIVE TOUR (CHILD)</option>
                    <option value="P04A">4D3N BORNEO RAINFOREST LODGE ADVENTURE (ADULT)</option>
                    <option value="P04C">4D3N BORNEO RAINFOREST LODGE ADVENTURE (CHILD)</option>
                    <option value="P05A">SEMADANG RIVER KAYAKING (ADULT)</option>
                    <option value="P05A">SEMADANG RIVER KAYAKING (CHILD)</option>
                    <option value="P06A">SUSUNG WATERFALL DAY TRIP (ADULT)</option>
                    <option value="P06C">SUSUNG WATERFALL DAY TRIP (CHILD)</option>
                    <option value="P07A">GUA IN KUCHING DAY TOUR (ADULT)</option>
                    <option value="P07C">GUA IN KUCHING DAY TOUR (CHILD)</option>
                    <option value="P08A">4D3N LUBOK KASAI JUNGLE EXPERIENCE (ADULT)</option>
                    <option value="P08C">4D3N LUBOK KASAI JUNGLE EXPERIENCE (CHILD)</option>
                </select>

            <label for="bookingPax">Number of Pax:</label>
            <input type="number" id="bookingPax" name="bookingPax" required><br><br>

            <input type="submit" value="Create Booking">
        </form>
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
