<%-- 
    Document   : approve_bookings
    Created on : Jun 28, 2024, 2:28:21 AM
    Author     : syahira
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Approve Bookings</title>
    <link rel="stylesheet" href="styleAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
        <h1>Approve Bookings</h1>
        <form id="ApproveBooking" action="ApprovalBookingServlet" method="get"> <!-- Form for refreshing data -->
        
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
            </form>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
</body>
</html>

