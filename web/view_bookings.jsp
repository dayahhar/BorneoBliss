<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="booking.BOOKING" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings - Borneo Bliss</title>
    <link rel="stylesheet" href="styleAdmin.css">
    
    <script>
        function showApprovalMessage() {
            alert("Booking has been approved successfully!");
        }
    </script>
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
        <h2>Manage Bookings</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>User ID</th>
                    <th>Package ID</th>
                    <th>Booking Pax</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<BOOKING> bookingList = BOOKING.getAllBookings();
                    if (bookingList == null || bookingList.isEmpty()) {
                %>
                <tr>
                    <td colspan="8">No bookings found.</td>
                </tr>
                <%
                    } else {
                        for (BOOKING booking : bookingList) {
                %>
                <tr>
                    <td><%= booking.getBookingID() %></td>
                    <td><%= booking.getBookingDate() %></td>
                    <td><%= booking.getTravelDate() %></td>
                    <td><%= booking.getUserID() %></td>
                    <td><%= booking.getPackageID() %></td>
                    <td><%= booking.getBookingPax() %></td>
                    <td><%= booking.getBookingStatus() %></td>
                    <td>
                        <% if (booking.getBookingStatus().equals("APPROVED")) { %>
                            <form action="CheckBookingServlet" method="GET">
                                <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>" />
                                <button type="submit">Check</button>
                            </form>
                        <% } else if (booking.getBookingStatus().equals("PENDING")) { %>
                            <form action="ManageBookingServlet" method="POST">
                                <input type="hidden" name="bookingID" value="<%= booking.getBookingID() %>" />
                                <input type="hidden" name="action" value="approve" />
                                <button type="submit">Approve</button>
                            </form>
                        <% } %>
                    </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
            <c:if test="${not empty approvalSuccess}">
            <script>
                showApprovalMessage();
            </script>
        </c:if>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
</body>
</html>
