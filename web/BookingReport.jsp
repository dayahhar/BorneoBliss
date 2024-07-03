<%-- 
    Document   : BookingReport
    Created on : Jun 30, 2024, 11:52:09 PM
    Author     : nanab
--%>

<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Report</title>
    <link rel="stylesheet" href="styleAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <header>
        <h1>Booking Report</h1>
        <p>Borneo Bliss Management System</p>
    </header>
    <nav>   
        <a href="admin.jsp"><img src="imagesAdmin/logo.png" alt="Home" style="max-width: 50px; max-height: 50px;"></a>
        <a href="packageManage.jsp">Packages</a>
        <a href="bookingApprove.jsp">Booking</a>
        <a href="userProfile.jsp">Profile</a>
        <a href="report.jsp">Report</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <main>
        <%
            String bookingId = request.getParameter("bookingId");
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            String jdbcDriver = "org.apache.derby.jdbc.ClientDriver";
            String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
            String jdbcUsername = "app";
            String jdbcPassword = "app";
            String tableHTML = "";

            try {
                Class.forName(jdbcDriver);
                conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                stmt = conn.createStatement();
                String sql = "SELECT b.BOOKINGID, t.USERNAME, p.PACKAGENAME, b.BOOKINGDATE, b.BOOKINGPAX, b.BOOKINGSTATUS, p.PACKAGEPRICE * b.BOOKINGPAX AS TOTAL " +
                             "FROM BOOKING b " +
                             "JOIN TRAVELER t ON b.USERID = t.USERID " +
                             "JOIN PACKAGE p ON b.PACKAGEID = p.PACKAGEID " +
                             "WHERE b.BOOKINGID = '" + bookingId + "'";
                rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    tableHTML = "<table>" +
                                "<thead>" +
                                "<tr>" +
                                "<th>Booking ID</th>" +
                                "<th>Customer Name</th>" +
                                "<th>Package Name</th>" +
                                "<th>Booking Date</th>" +
                                "<th>Pax</th>" +
                                "<th>Status</th>" +
                                "<th>Total Price</th>" +
                                "</tr>" +
                                "</thead>" +
                                "<tbody>" +
                                "<tr>" +
                                "<td>" + rs.getString("BOOKINGID") + "</td>" +
                                "<td>" + rs.getString("USERNAME") + "</td>" +
                                "<td>" + rs.getString("PACKAGENAME") + "</td>" +
                                "<td>" + rs.getDate("BOOKINGDATE") + "</td>" +
                                "<td>" + rs.getInt("BOOKINGPAX") + "</td>" +
                                "<td>" + rs.getString("BOOKINGSTATUS") + "</td>" +
                                "<td>RM" + rs.getDouble("TOTAL") + "</td>" +
                                "</tr>" +
                                "</tbody>" +
                                "</table>";
                } else {
                    tableHTML = "<p>No booking data available for Booking ID: " + bookingId + "</p>";
                }
            } catch (Exception e) {
                e.printStackTrace();
                tableHTML = "<p>Error retrieving booking data. Please try again later.</p>";
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }

            out.print(tableHTML);
        %>
    </main>
    <div class="button-container">
            <!-- Adjust the path to your JSP file -->
            <a href="admin.jsp" class="index-btn">Back</a>
    </div>
</body>
<footer>
    <p>&copy; 2024 Borneo Bliss Management System</p>
</footer>
</html>

