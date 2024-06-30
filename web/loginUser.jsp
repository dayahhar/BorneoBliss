<%-- 
    Document   : loginUser
    Created on : Jun 29, 2024, 9:36:03 PM
    Author     : nurna
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.LoginUserServlet" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Log In As Traveler - BORNEO BLISS TRAVEL</title>
        <link rel="stylesheet" href="styleUser.css">
    </head>
    <body>
        <header>
            <h1>Welcome to Borneo Bliss Travel</h1>
            <p>Your one-stop solution for managing all your travel needs around Borneo</p>
        </header>
        <nav>
            <a href="index.html">
                <img src="image/logo.png" alt="Borneo Bliss Logo">
            </a>
            <a href="package.html">Packages</a>
            <a href="aboutus.html">About Us</a>
            <a href="contact.html">Contact</a>
            
            <div class="login-nav">
                    <div class="dropdown">
                        <span class="login">Log In</span>
                        <div class="dropdown-content">
                            <a href="loginAdmin.jsp">Log In Admin</a>
                            <a href="loginUser.jsp">Log In Traveler</a>
                        </div>
                    </div>
            </div>
        </nav>
        <div class="main">
            <h2>Log In As Traveler</h2>
            <form action="<%=request.getContextPath()%>/LoginUserServlet" method="POST">

                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="userpassword" required>

                <input type="submit" value="Log In">
            </form>
            <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
            <p><a href="index.html">Back to Home</a></p>
        </div>
    </body>
</html>
