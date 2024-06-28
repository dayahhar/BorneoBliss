<%-- 
    Document   : view_users
    Created on : Jun 25, 2024, 11:48:34 PM
    Author     : Aqilah05
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="ManageUsersServlet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Users - Borneo Bliss</title>
    </head>
    <body>
        <h1>User Management</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone No</th>
            <th>Action</th>
        </tr>
        <%
            ResultSet userList = (ResultSet) request.getAttribute("userList");
            try {
                while (userList.next()) {
        %>
        <tr>
            <td><%= userList.getString("userID") %></td>
            <td><%= userList.getString("username") %></td>
            <td><%= userList.getString("name") %></td>
            <td><%= userList.getString("email") %></td>
            <td><%= userList.getString("phoneNo") %></td>
            <td>
                <form action="ManageUsersServlet" method="post">
                    <input type="hidden" name="userId" value="<%= userList.getString("userID") %>" />
                    <input type="hidden" name="action" value="delete" />
                    <input type="submit" value="Delete" />
                </form>
            </td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
    </body>
</html>
