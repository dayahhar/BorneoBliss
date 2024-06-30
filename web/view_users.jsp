<%-- 
    Document   : view_users
    Created on : Jun 25, 2024, 11:48:34 PM
    Author     : Aqilah05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="traveler.TRAVELER" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Borneo Bliss</title>
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
        <a href="approve_bookings.jsp">Booking</a>
        <a href="view_users.jsp">Profile</a>
        <a href="report.jsp">Report</a>
        <a href="logout.jsp">Logout</a>
    </nav>
    <main>
        <h2>Manage Users</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone No</th>
                    <th>Password</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<TRAVELER> userList = (List<TRAVELER>) request.getAttribute("userList");
                    if (userList == null || userList.isEmpty()) {
                %>
                <tr>
                    <td colspan="7">No users found.</td>
                </tr>
                <%
                    } else {
                        for (TRAVELER user : userList) {
                %>
                <tr>
                    <td><%= user.getUserID() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhoneNo() %></td>
                    <td><%= user.getUserPassword() %></td>
                    <td>
                        <form action="ManageUsersServlet" method="POST">
                            <input type="hidden" name="userId" value="<%= user.getUserID() %>" />
                            <input type="hidden" name="action" value="delete" />
                            <input type="submit" value="Delete" />
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </main>
    <footer>
        <p>&copy; 2024 Borneo Bliss Management System</p>
    </footer>
</body>
</html>