<%-- 
    Document   : view_packages
    Created on : Jun 28, 2024, 2:27:21 PM
    Author     : Aqilah05
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <a href="admin.html" class="logo-link"><img src="imagesAdmin/logo.png" alt="Home" class="logo"></a>
        <a href="packageManage.html">Packages</a>
        <a href="bookingApprove.html">Booking</a>
        <a href="userProfile.html">Profile</a>
        <a href="report.html">Report</a>
        <a href="logout.html">Logout</a>
    </nav>
    <main>
        <h2 style="margin-left:125px">Manage Packages</h2>
        <button class="add-package-btn" onclick="window.location.href='add_packages.jsp'">Add Package</button>
        <div class="catalog">
            <%
                ResultSet packages = (ResultSet) request.getAttribute("packages");
                try {
                    while (packages.next()) {
            %>
            <div class="package">
                <img src="<%= packages.getString("imageURL") %>" alt="Package Image">
                <div class="package-details">
                    <h3><%= packages.getString("packageName") %></h3>
                    <p><%= packages.getString("packageDesc") %></p>
                    <button onclick="window.location.href='edit_packages.jsp?id=<%= packages.getString("packageID") %>'">Update</button>
                    <button onclick="confirmDelete('<%= packages.getString("packageID") %>')">Delete</button>
                </div>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
</body>
</html>
