
<%-- 
    Document   : report
    Created on : Jun 27, 2024, 10:51:55 PM
    Author     : nanab
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <a href="admin.jsp"><img src="imagesAdmin/logo.png" alt="Home" style="max-width: 50px; max-height: 50px;"></a>
        <a href="packageManage.jsp">Packages</a>
        <a href="bookingApprove.jsp">Booking</a>
        <a href="userProfile.jsp">Profile</a>
        <a href="report.jsp">Report</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <main>
        <h2>Reports</h2>
        <div class="report-options">
            <button onclick="generateSalesReport()" style="margin-left: 40px;"><i class="fas fa-chart-line"></i> Generate Sales Report</button>
        </div><br>
        <h3 style="margin-left: 40px;">Booking List</h3>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Traveler Name</th>
                    <th>Booking Date</th>
                    <th>Travel Date</th>
                    <th>Report</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>B001</td>
                    <td>Sarah Johnson</td>
                    <td>20-06-2024</td>
                    <td>15-07-2024</td>
                    <td><button onclick="window.location.href='BookingReport.html?bookingId=B001'">Generate</button></td>
                </tr>
                <tr>
                    <td>B002</td>
                    <td>Amirul Hakim bin Mohd Zain</td>
                    <td>05-07-2024</td>
                    <td>05-08-2024</td>
                    <td><button onclick="window.location.href='BookingReport.html?bookingId=B002'">Generate</button></td>
                </tr>
                <tr>
                    <td>B003</td>
                    <td>Lee Cheng Wei</td>
                    <td>10-07-2024</td>
                    <td>10-09-2024</td>
                    <td><button onclick="window.location.href='BookingReport.html?bookingId=B003'">Generate</button></td>
                </tr>
                <tr>
                    <td>B004</td>
                    <td>Park Ji-hye</td>
                    <td>10-07-2024</td>
                    <td>20-10-2024</td>
                    <td><button onclick="window.location.href='BookingReport.html?bookingId=B004'">Generate</button></td>
                </tr>
                <tr>
                    <td>B005</td>
                    <td>Aina Sofea binti Abdul Rahman</td>
                    <td>20-07-2024</td>
                    <td>15-08-2024</td>
                    <td><button onclick="window.location.href='BookingReport.html?bookingId=B005'">Generate</button></td>
                </tr>
                <tr>
                    <td>B006</td>
                    <td>Nur Aisyah binti Ahmad</td>
                    <td>20-07-2024</td>
                    <td>15-08-2024</td>
                    <td><button onclick="window.location.href='BookingReport.html?bookingId=B006'">Generate</button></td>
                </tr>
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
                                    position: 'top',
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
