<%-- 
    Document   : admin
    Created on : Jun 28, 2024, 5:21:00 PM
    Author     : nurna
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin: Borneo Bliss</title>
    <link rel="stylesheet" href="styleAdmin.css">
</head>
<body>
    <header>
        <h1>Admin Page</h1>
        <p>Borneo Bliss Management System</p>
    </header>
    <nav>
        <a href="admin.jsp" class="logo-link"><img src="imagesAdmin/logo.png" alt="Home" class="logo"></a>
        <a href="packageManage.html">Packages</a>
        <a href="approve_bookings.jsp">Booking</a>
        <a href="viewProfile.jsp">Profile</a>
        <a href="report.html">Report</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <main>
        <h2>Welcome, Admin ${sessionScope.adminName}!</h2>
        <section class="dashboard">
            <div class="dashboard-cards">
                <div class="card">
                    <h1>Total Packages</h1>
                    <h2>${requestScope.totalPackages}</h2>
                </div>
                <div class="card">
                    <h1>Total Bookings</h1>
                    <h2>${requestScope.totalBookings}</h2>
                </div>
                <div class="card">
                    <h1>Total Customers</h1>
                    <h2>${requestScope.totalCustomers}</h2>
                </div>
                <div class="card recent-activity">
                    <h1>Recent Activity</h1>
                    <ul>
                        <c:forEach items="${requestScope.recentActivities}" var="activity">
                            <li>${activity}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </section>
        <section class="notifications">
            <h3>Notifications</h3>
            <ul>
                <li>${requestScope.newBookingsPending} new bookings pending approval</li>
                <li>${requestScope.customerInquiriesPending} customer inquiries awaiting response</li>
            </ul>
        </section>
    </main>
    <footer>
        <p>&copy; <%= java.time.Year.now().getValue() %> Borneo Bliss Management System</p>
    </footer>
</body>
</html>