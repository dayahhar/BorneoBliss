<%-- 
    Document   : admin
    Created on : Jun 28, 2024, 5:21:00 PM
    Author     : nurna
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

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
        <a href="view_packages.jsp">Packages</a>
        <a href="view_bookings.jsp">Booking</a>
        <a href="view_users.jsp">Profile</a>
        <a href="report.jsp">Report</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <main>
        <h2>Welcome, Admin ${sessionScope.adminName}!</h2>
        <section class="dashboard">
            <sql:setDataSource var="myDatasource" 
                driver="org.apache.derby.jdbc.ClientDriver" 
                url="jdbc:derby://localhost:1527/BorneoDB" 
                user="app" 
                password="app" />
            
            <!-- Statistics -->
            <section class="section">
                <h2 class="section-title">Statistics</h2>
                <div class="stats-grid">
                    <sql:query var="packagesCountResult" dataSource="${myDatasource}">
                        SELECT COUNT(DISTINCT PACKAGEID) AS PACKAGE_COUNT FROM PACKAGE
                    </sql:query>
                    <sql:query var="bookingCountResult" dataSource="${myDatasource}">
                        SELECT COUNT(DISTINCT BOOKINGID) AS BOOKING_COUNT FROM BOOKING
                    </sql:query>
                    <sql:query var="customerCountResult" dataSource="${myDatasource}">
                        SELECT COUNT(DISTINCT USERID) AS CUSTOMER_COUNT FROM TRAVELER
                    </sql:query>
                    <div class="dashboard-cards">
                        <div class="card">
                            <h1>Total Packages</h1>
                            <h2><c:out value="${packagesCountResult.rows[0].PACKAGE_COUNT}"/></h2>
                        </div>
                        <div class="card">
                            <h1>Total Bookings</h1>
                            <h2><c:out value="${bookingCountResult.rows[0].BOOKING_COUNT}"/></h2>
                        </div>
                        <div class="card">
                            <h1>Total Customers</h1>
                            <h2><c:out value="${customerCountResult.rows[0].CUSTOMER_COUNT}"/></h2>
                        </div>        
                    </div>
                </div>
            </section>
                
            <div class="card recent-activity">
                <h1>Recent Activity</h1>
                <ul>
                    <c:forEach items="${requestScope.recentActivities}" var="activity">
                        <li><c:out value="${activity}"/></li>
                    </c:forEach>
                </ul>
            </div>
        </section>
        <section class="notifications">
            <h3>Notifications</h3>
            <ul>
                <li><c:out value="${requestScope.newBookingsPending}"/> new bookings pending approval</li>
                <li><c:out value="${requestScope.customerInquiriesPending}"/> customer inquiries awaiting response</li>
            </ul>
        </section>
    </main>
    <footer>
        <p>&copy; <%= java.time.Year.now().getValue() %> Borneo Bliss Management System</p>
    </footer>
</body>
</html>
