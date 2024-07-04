<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="packages.PACKAGE" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Packages: Borneo Bliss</title>
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
        <h2 style="margin-left:100px">Manage Packages</h2>
        
        <!-- Display success message if available -->
        <% 
            String message = (String) session.getAttribute("message");
            if (message != null) {
        %>
        <div class="success-message" style="color: green; margin-left: 100px;"><%= message %></div>
        <% 
                session.removeAttribute("message");
            }
        %>
        <button class="add-package-btn" onclick="window.location.href='addPackage.jsp'">Add Package</button>
        <div class="catalog">
            <%
                List<PACKAGE> packages = PACKAGE.getAllPackages();
                if (packages != null && !packages.isEmpty()) {
                    for (PACKAGE pkg : packages) {
            %>
            <div class="package">
                <img src="<%= pkg.getImageURL() %>" alt="<%= pkg.getPackageName() %>">
                <div class="package-details">
                    <h3><%= pkg.getPackageName() %></h3>
                    <p><%= pkg.getPackageDesc() %></p>
                    <form action="updatePackage.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="packageID" value="<%= pkg.getPackageID() %>">
                        <button type="submit">Update</button>
                    </form>
                    <form action="ManagePackagesServlet" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="packageID" value="<%= pkg.getPackageID() %>">
                        <button type="submit" onclick="return confirm('Are you sure you want to delete this package?')">Delete</button>
                    </form>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p>No packages available.</p>
            <%
                }
            %>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
</body>
</html>