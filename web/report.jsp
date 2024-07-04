<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports</title>
    <link rel="stylesheet" href="styleAdmin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <header>
        <h1>Admin Page</h1>
        <p>Borneo Bliss Management System</p>
    </header>
    <nav>
        <a href="admin.jsp" class="logo-link"><img src="imagesAdmin/logo.png" alt="Home" class="logo"></a>
        <a href="view_packages.jsp">Packages</a>
        <a href="approve_bookings.jsp">Booking</a>
        <a href="view_users.jsp">Profile</a>
        <a href="report.jsp">Report</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <main>
        <h2>Reports</h2>
        <div class="report-options">
            <button onclick="window.location.href='SalesReport.jsp'" style="margin-left: 40px;"><i class="fas fa-chart-line"></i> Generate Sales Report</button>
        </div><br>
        
        <h3 style="margin-left: 40px;">Booking List</h3>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Traveler Name</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>Package</th>
                    <th>Traveler Contact</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection details
                    String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
                    String jdbcUsername = "app";
                    String jdbcPassword = "app";
                    
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                        stmt = conn.createStatement();
                        String query = "SELECT B.BOOKINGID, T.USERNAME, B.BOOKINGDATE, B.TRAVELDATE, B.PACKAGEID, T.PHONENO, B.BOOKINGSTATUS " +
                                       "FROM BOOKING B " + 
                                       "JOIN TRAVELER T ON B.USERID = T.USERID";
                        rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            String bookingId = rs.getString("BOOKINGID");
                            String USERNAME = rs.getString("USERNAME");
                            String BOOKINGDATE = rs.getString("BOOKINGDATE");
                            String TRAVELDATE = rs.getString("TRAVELDATE");
                            String PACKAGEID = rs.getString("PACKAGEID");
                            String PHONENO = rs.getString("PHONENO");
                            String BOOKINGSTATUS = rs.getString("BOOKINGSTATUS");

                            out.println("<tr>");
                            out.println("<td>" + bookingId + "</td>");
                            out.println("<td>" + USERNAME + "</td>");
                            out.println("<td>" + BOOKINGDATE + "</td>");
                            out.println("<td>" + TRAVELDATE + "</td>");
                            out.println("<td>" + PACKAGEID + "</td>");
                            out.println("<td>" + PHONENO + "</td>");
                            out.println("<td>" + BOOKINGSTATUS + "</td>");
                            out.println("<td><a href='BookingReport.jsp?bookingId=" + bookingId + "'><i class='fas fa-file-alt'></i> Generate Report</a></td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </tbody>
        </table>
        <div class="pagination">
            <button id="prevPageBtn" onclick="prevPage()"><i class="fas fa-chevron-left"></i></button>
            <button id="nextPageBtn" onclick="nextPage()"><i class="fas fa-chevron-right"></i></button>
        </div>
        <!-- Placeholder for Reports -->
        <div id="reportContainer" style="margin-left: 40px; margin-top: 20px;"></div>
        
        <!-- Pie Chart -->
        <canvas id="bookingStatusChart" width="400" height="400"></canvas>
        <!-- Bar Chart for Sales Report -->
        <canvas id="salesReportChart" width="400" height="400"></canvas>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
    
    <script>
        // Pagination Script
        let currentPage = 1;
        const rowsPerPage = 5;
        const tableRows = document.querySelectorAll('tbody tr');
        const totalPages = Math.ceil(tableRows.length / rowsPerPage);

        function showRows(page) {
            const start = (page - 1) * rowsPerPage;
            const end = start + rowsPerPage;

            tableRows.forEach((row, index) => {
                if (index >= start && index < end) {
                    row.style.display = 'table-row';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function prevPage() {
            if (currentPage > 1) {
                currentPage--;
                showRows(currentPage);
                updatePaginationButtons();
            }
        }

        function nextPage() {
            if (currentPage < totalPages) {
                currentPage++;
                showRows(currentPage);
                updatePaginationButtons();
            }
        }

        function updatePaginationButtons() {
            document.getElementById('prevPageBtn').disabled = currentPage === 1;
            document.getElementById('nextPageBtn').disabled = currentPage === totalPages;
        }

        window.onload = function () {
            showRows(currentPage);
            updatePaginationButtons();
        };
        
        // Sales Report Generation Script
        function generateSalesReport() {
            fetch('/getSalesReport')
                .then(response => response.json())
                .then(data => {
                    const ctx = document.getElementById('salesReportChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: Object.keys(data),
                            datasets: [{
                                label: 'Sales Report',
                                data: Object.values(data),
                                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                })
                .catch(error => console.error('Error fetching sales report:', error));
        }

        // Booking Status Pie Chart
        document.addEventListener('DOMContentLoaded', function () {
            fetch('/getBookingStatus')
                .then(response => response.json())
                .then(data => {
                    const ctx = document.getElementById('bookingStatusChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'pie',
                        data: {
                            labels: Object.keys(data),
                            datasets: [{
                                label: 'Booking Status',
                                data: Object.values(data),
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: true,
                            plugins: {
                                legend: {
                                    position: 'top'
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(context) {
                                            const label = context.label || '';
                                            const value = context.raw;
                                            return `${label}: ${value}`;
                                        }
                                    }
                                }
                            }
                        }
                    });
                })
                .catch(error => console.error('Error fetching booking status:', error));
        });
    </script>
</body>
</html>
