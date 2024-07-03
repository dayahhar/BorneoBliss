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
    table, th, td {
            border: 1px ;
            border-collapse: collapse;
            text-align: center;
            margin: 30px;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
</style>
<body>
    <header>
        <h1>Sales Report</h1>
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
                                out.print("RM" + salesCount);
                            %>
                        </td>
                    </tr>
                </table>
            </div>
        </div> 

        <h2>Monthly Sales Report</h2>
        <script>
            function applyFilters() {
                var monthFilter = document.getElementById('month-filter').value;
                var rows = document.querySelectorAll('.sales-table tbody tr');

                rows.forEach(function(row) {
                    var monthCell = row.getElementsByTagName('td')[0].innerText.trim();
                    var monthMatch = (monthFilter === 'All' || monthCell === monthFilter);

                    if (monthMatch) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }

            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('month-filter').addEventListener('change', applyFilters);
            });
        </script>
        <div class="container">
            <div class="list">
                <div class="filter-section">
                    <label for="month-filter">Filter by Month:</label>
                    <select id="month-filter">
                        <option value="All">All</option>
                        <option value="January">January</option>
                        <option value="February">February</option>
                        <option value="March">March</option>
                        <option value="April">April</option>
                        <option value="May">May</option>
                        <option value="June">June</option>
                        <option value="July">July</option>
                        <option value="August">August</option>
                        <option value="September">September</option>
                        <option value="October">October</option>
                        <option value="November">November</option>
                        <option value="December">December</option>
                    </select>
                </div> 
                <table class="sales-table">
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

                                String query = "SELECT MONTH(B.BOOKINGDATE) AS month, SUM(P.AMOUNT) AS totalSales " +
                                               "FROM BOOKING B " +
                                               "JOIN PAYMENT P ON B.BOOKINGID = P.BOOKINGID " +
                                               "GROUP BY MONTH(B.BOOKINGDATE) " +
                                               "ORDER BY MONTH(B.BOOKINGDATE)";
                                rs = stmt.executeQuery(query);

                                while (rs.next()) {
                                    int month = rs.getInt("month");
                                    double totalSales = rs.getDouble("totalSales");
                        %>
                                    <tr>
                                        <td><%= getMonthName(month) %></td>
                                        <td>RM<%= totalSales %></td>
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
            </div>
        </div>
    </main>
</body>
<footer>
    <p>&copy; 2024 Borneo Bliss Management System</p>
</footer>
</html>
    // Function to convert month number to month

<%!
    // Function to convert month number to month name (optional)
    String getMonthName(int monthNumber) {
        String[] months = {"January", "February", "March", "April", "May", "June",
                           "July", "August", "September", "October", "November", "December"};
        return months[monthNumber - 1];
    }
%>

