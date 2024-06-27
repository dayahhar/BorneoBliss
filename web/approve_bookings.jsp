<%-- 
    Document   : approve_bookings
    Created on : Jun 28, 2024, 2:28:21 AM
    Author     : syahira
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Approve Bookings</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="container">
    <h1>Approve Bookings</h1>
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
                <th>Card Number</th>
                <th>Expiry Date</th>
                <th>CVV</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            ${approvalData} <!-- Directly print the accumulated data -->
        </tbody>
    </table>
        <form action="ApprovalBookingServlet" method="get"> <!-- Form for refreshing data -->
            <input type="submit" value="Refresh">
        </form>
    </div>
</body>
</html>

