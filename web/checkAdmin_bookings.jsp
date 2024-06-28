<%-- 
    Document   : checkAdmin_bookings
    Created on : Jun 28, 2024, 2:28:21 AM
    Author     : syahira
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Check Bookings</title>
    <link rel="stylesheet" href="styleAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script>
    // Function to submit the form
    function submitForm() {
        document.getElementById("CheckBooking").submit();
    }

    // Check if page is opened for the first time using session storage
    if (sessionStorage.getItem("firstLoad") === null) {
        // Set session storage to mark the page as loaded
        sessionStorage.setItem("firstLoad", "true");

        // Execute when the page is opened for the first time
        window.onload = function() {
            submitForm();
        }; 
    } else if (performance.navigation.type === 1) {
        // Reload the page normally when refreshed
        window.onload = function() {
            submitForm();
        };
    }
</script>
</head>
<body>
    <header>
        <h1>Admin Page</h1>
        <p>Borneo Bliss Management System</p>
    </header>
    <nav>
        <a href="admin.html" class="logo-link"><img src="imagesAdmin/logo.png" alt="Home" class="logo"></a>
        <a href="packageManage.html">Packages</a>
        <a href="bookingApprove.html">Booking</a>
        <a href="userProfile.html">Profile</a>
        <a href="report.html">Report</a>
        <a href="logout.html">Logout</a>
    </nav>
    <main>
        <div class="container">
            <h1>Check Bookings</h1>
            <form id="CheckBooking" action="CheckBookingServlet" method="get"> <!-- Form for refreshing data -->
        </form>
            <table>
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Amount</th>
                        <th>Card Number</th>
                        <th>Expiry Date</th>
                        <th>CVV</th>
                        <th>Booking ID</th>
                        <th>User ID</th>
                        <th>Payment Status</th>
                       
                    </tr>
                </thead>
                <tbody>
                    ${checkAdminbookingData}<!-- Data will be populated dynamically by JavaScript -->
                </tbody>
            </table>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
</body>
</html>
