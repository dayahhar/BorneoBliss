<%-- 
    Document   : SalesReport.jsp
    Created on : Jul 3, 2024, 3:31:38 PM
    Author     : nanab
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report new</title>
    <link rel="stylesheet" href="styleAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<style>
    .table-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .table-container div {
            flex: 1;
            margin: 30px;
            margin-left: 3px;
        }
        th {
            background-color: #2AAA8A;
            color: #fff;
            padding: 10px 20px;
            border: 1px solid #fff;
            font-weight: bold;
        }
</style>
<body>
    <header>
        <h1>Sales Report</h1>
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
        <div class="table-container">
                   <div>
                    <table>
                        <tr>
                            <th>Total User</th>
                        </tr>
                        <tr>
                            <td>
                                <%
                                    int bookingIdCount = 0;
                                    Connection conn = null;
                                    Statement stmt = null;
                                    ResultSet rs = null;

                                    try {
                                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                                        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");
                                        stmt = conn.createStatement();

                                        String query = "SELECT BOOKINGID FROM BOOKING";
                                        rs = stmt.executeQuery(query);

                                        while (rs.next()) {
                                            bookingIdCount++;
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException e) { }
                                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                                        if (conn != null) try { conn.close(); } catch (SQLException e) { }
                                    }
                                    out.print(bookingIdCount);
                                %>
                            </td>
                        </tr>
                    </table>
                </div>
                         <div>
                    <table>
                        <tr>
                            <th>Total Admin</th>
                        </tr>
                        <tr>
                            <td>
                                <%
                                    int adminIdCount = 0;
                                    conn = null;
                                    stmt = null;
                                    rs = null;

                                    try {
                                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                                        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");
                                        stmt = conn.createStatement();

                                        String query = "SELECT ADMINID FROM ADMIN";
                                        rs = stmt.executeQuery(query);

                                        while (rs.next()) {
                                            adminIdCount++;
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException e) { }
                                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                                        if (conn != null) try { conn.close(); } catch (SQLException e) { }
                                    }
                                    out.print(adminIdCount);
                                %>
                            </td>
                        </tr>
                    </table>
                </div>   
                <div>
                    <table>
                        <tr>
                            <th>Total Sales</th>
                        </tr>
                        <tr>
                            <td>
                                <%
                                    int salesCount = 0;
                                    conn = null;
                                    stmt = null;
                                    rs = null;

                                    try {
                                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                                        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");
                                        stmt = conn.createStatement();

                                        String query = "SELECT SUM(P.AMOUNT) AS totalSale FROM PAYMENT P";
                                        rs = stmt.executeQuery(query);

                                        if (rs.next()) {
                                            salesCount = rs.getInt("totalSale");
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) try { rs.close(); } catch (SQLException e) { }
                                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                                        if (conn != null) try { conn.close(); } catch (SQLException e) { }
                                    }
                                    out.print("$ "+salesCount);
                                %>
                            </td>
                        </tr>
                    </table>
                </div>
        </div> 

                            
       <h2>Monthly Sales Report</h2>
    <table>
        <thead>
            <tr>
                <th>Month</th>
                <th>Total Sales</th>
            </tr>
        </thead>
        <tbody>
            <% 
                conn = null;
                stmt = null;
                rs = null;

                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");
                    stmt = conn.createStatement();

                    String query = "SELECT MONTH(B.BOOKINGDATE) AS month, SUM(P.AMOUNT) AS totalSales, B.PACKAGEID " +
                                   "FROM BOOKING B " +
                                   "JOIN PAYMENT P ON B.BOOKINGID = P.BOOKINGID " +
                                   "GROUP BY MONTH(B.BOOKINGDATE), B.PACKAGEID " +
                                   "ORDER BY MONTH(B.BOOKINGDATE)";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int month = rs.getInt("month");
                        double totalSales = rs.getDouble("totalSales");
                        String packageId = rs.getString("PACKAGEID");
            %>
                        <tr>
                            <td><%= getMonthName(month) %></td>
                            <td>$ <%= totalSales %></td>
                        </tr>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                }
            %>
        </tbody>
    </table>
</body>
<footer>
    <p>&copy; 2024 Borneo Bliss Management System</p>
</footer>
</html>
<%!
    // Function to convert month number to month name (optional)
    String getMonthName(int monthNumber) {
        String[] months = {"January", "February", "March", "April", "May", "June",
                           "July", "August", "September", "October", "November", "December"};
        return months[monthNumber - 1];
    }
%>

