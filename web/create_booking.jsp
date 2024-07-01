<%-- 
    Document   : create_booking
    Created on : Jun 22, 2024, 11:53:32 PM
    Author     : dayah
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page import="booking.BOOKING" %>
<%@ page import="packages.PACKAGE" %>
<%@ page import="booking.UserBookingServlet" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>

<sql:setDataSource var="myDatasource"
    driver="org.apache.derby.jdbc.ClientDriver"
    url="jdbc:derby://localhost:1527/BorneoDB" 
    user="app"
    password="app" />

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("loginUser.jsp");
        return;
    }
%>
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
                    <a href="payment.jsp">Make Payment</a>
                </div>
            </div>
        </div>
        <a href="viewProfile.jsp">Profile</a>
        <a href="logout.jsp">Log Out</a>
    </nav>
    <div class="main">
        <h2>Book Your Adventure</h2>
        <form action="UserBookingServlet" method="post">
            <input type="hidden" name="action" value="create">
            
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="${sessionScope.username}" readonly required><br>
            
            <label for="bookingDate">Booking Date:</label>
            <input type="date" id="bookingDate" name="bookingDate" required><br>

            <label for="travelDate">Travel Date:</label>
            <input type="date" id="travelDate" name="travelDate" required><br>

            <label for="packageID">Package:</label>
            <select id="packageID" name="packageID" required>
                <sql:query dataSource="${myDatasource}" var="packageList">
                    SELECT PACKAGEID, PACKAGENAME FROM APP.PACKAGE
                </sql:query>
                <c:forEach var="package" items="${packageList.rows}">
                    <option value="${package.PACKAGEID}">${package.PACKAGENAME}</option>
                </c:forEach>
            </select><br>

            <label for="bookingPax">Number of Pax:</label>
            <input type="number" id="bookingPax" name="bookingPax" required><br><br>

            <input type="submit" value="Create Booking">
        </form>
        <c:if test="${not empty message}">
            <p style="color:green;">${message}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color:red;">${error}</p>
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
