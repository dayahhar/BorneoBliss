<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Package: Borneo Bliss</title>
    <link rel="stylesheet" href="styleAdmin.css">
    <script type="text/javascript">
        // Function to show alert message
        function showAlert(message) {
            alert(message);
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
        <h2 style="text-align: center;">Add New Package</h2>
        <div class="form-card">
            <form action="AddPackagesServlet" method="POST">
                <div class="form-group">
                    <input type="text" id="packageName" name="packageName" placeholder="Package Name" required>
                </div>
                <div class="form-group">
                    <textarea id="packageDesc" name="packageDesc" rows="4" placeholder="Description" required></textarea>
                </div>
                <div class="form-group">
                    <input type="text" id="packagePrice" name="packagePrice" placeholder="Price" required>
                </div>
                <div class="form-group">
                    <select id="packageState" name="packageState" required>
                        <option value="" disabled selected>Select State</option>
                        <option value="Sabah">Sabah</option>
                        <option value="Sarawak">Sarawak</option>
                    </select>
                </div>
                <div class="form-group">
                    <input type="text" id="imageURL" name="imageURL" placeholder="Image URL" required>
                </div>
                <div class="form-group">
                    <select id="category" name="category" required>
                        <option value="" disabled selected>Select Category</option>
                        <option value="none">None</option>
                        <option value="adult">Adult</option>
                        <option value="child">Child</option>
                    </select>
                </div>
                <button type="submit" class="button full-width">Add Package</button>
            </form>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
    
    <% 
        // Check if a success message is set in the session
        String message = (String) session.getAttribute("message");
        if (message != null) {
    %>
        <script type="text/javascript">
            // Display the alert message
            window.onload = function() {
                showAlert('<%= message %>');
            };
        </script>
    <% 
            // Remove the message after displaying it
            session.removeAttribute("message");
        }
    %>
</body>
</html>