<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="packages.PACKAGE" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Package: Borneo Bliss</title>
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
        <h2 style="text-align: center;">Update Package</h2>
        <div class="form-card">
            <%
                String packageID = request.getParameter("packageID");
                if (packageID != null) {
                    PACKAGE pkg = null;
                    Connection conn = null;
                    try {
                        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
                        String jdbcUsername = "app";
                        String jdbcPassword = "app";
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                        pkg = PACKAGE.getPackageByID(packageID, conn);
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }

                    if (pkg != null) {
            %>
            <form action="ManagePackagesServlet" method="POST">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="packageID" value="<%= pkg.getPackageID() %>">
                <div class="form-group">
                    <input type="text" id="packageID" name="packageID" placeholder="<%= pkg.getPackageID() %>" readonly>
                </div>
                <div class="form-group">
                    <input type="text" id="packageName" name="packageName" placeholder="Package Name" value="<%= pkg.getPackageName() %>" required>
                </div>
                <div class="form-group">
                    <textarea id="packageDesc" name="packageDesc" rows="4" placeholder="Description" required><%= pkg.getPackageDesc() %></textarea>
                </div>
                <div class="form-group">
                    <input type="text" id="packagePrice" name="packagePrice" placeholder="Price" value="<%= pkg.getPackagePrice() %>" required>
                </div>
                <div class="form-group">
                    <select id="packageState" name="packageState" required>
                        <option value="Sabah" <%= "Sabah".equals(pkg.getPackageState()) ? "selected" : "" %>>Sabah</option>
                        <option value="Sarawak" <%= "Sarawak".equals(pkg.getPackageState()) ? "selected" : "" %>>Sarawak</option>
                    </select>
                </div>
                <div class="form-group">
                    <input type="text" id="imageURL" name="imageURL" placeholder="Image URL" value="<%= pkg.getImageURL() %>" required>
                </div>
                <button type="submit" class="button full-width">Update Package</button>
            </form>
            <%
                    } else {
            %>
            <p>Package not found.</p>
            <%
                    }
                } else {
            %>
            <p>No package ID provided.</p>
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
