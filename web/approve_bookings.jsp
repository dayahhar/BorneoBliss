<%-- 
    Document   : approve_bookings
    Created on : Jun 28, 2024, 2:28:21 AM
    Author     : syahira
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Approve Bookings</title>
    <link rel="stylesheet" href="styleAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script>
    // Function to submit the form
    function submitForm() {
        document.getElementById("ApproveBooking").submit();
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
        <a href="view_bookings.jsp">Booking</a>
        <a href="userProfile.html">Profile</a>
        <a href="report.html">Report</a>
        <a href="logout.html">Logout</a>
    </nav>
    <main>
        <div class="container">
        <h1>Approve Bookings</h1>
        <form id="ApproveBooking" action="ApprovalBookingServlet" method="get"> <!-- Form for refreshing data -->
        </form>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>User ID</th>
                    <th>Booking Pax</th>
                    <th>Booking Status</th>
                    <th>Package ID</th>
                    <th>Package Name</th>
                    <th>Package Price</th>
                    <th>Package State</th>
                    <th>Payment ID</th>
                    <th>Amount</th>
                    <th>Payment Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                ${approvalData} <!-- Directly print the accumulated data -->
            </tbody>
        </table>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
</body>
</html>

