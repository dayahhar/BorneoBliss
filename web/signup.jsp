<%-- 
    Document   : signup
    Created on : Jun 28, 2024, 12:13:14 PM
    Author     : nurna
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - BORNEO BLISS TRAVEL</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #2359B2;
            color: white;
            padding: 1rem 0;
            text-align: center;
        }
        nav img {
            max-height: 50px;
            margin-right: 20px;
        }
        nav h1, nav p {
            margin: 0;
        }
        nav {
            display: flex;
            justify-content: center;
            background-color: #333;
        }
        nav a {
            color: white;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            width: 100px;
            height: 50px;
            line-height: 50px;
            background: #333;
        }
        nav a:hover {
            background-color: #555;
        }
        .main {
            max-width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .main h2 {
            text-align: center;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #2359B2;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #003366;
        }
        footer {
            background-color: #333;
            color: white;
            padding: 10px 0;
            width: 96.5%;
            height: 45px;
            bottom: 0;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        footer p {
            margin: 0;
        }
        footer .contact-info {
            font-size: 0.9em;
        }
        .booking {
            color: white;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            width: 100px;
            height: 50px;
            line-height: 50px;
            background: #333;
        }
        .booking-nav {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #333;
        }
        .booking-nav .booking {
            color: white;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            width: 100px;
            height: 50px;
            line-height: 50px;
            background: #333;
            cursor: pointer;
        }
        .booking-nav .booking:hover {
            background-color: #555;
        }
        .dropdown {
            position: relative;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #333;
            min-width: 160px;
            z-index: 1;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .dropdown-content a {
            color: white;
            width: 100%;
            height: 50px;
            line-height: 50px;
            text-decoration: none;
            display: block;
            padding: 10px;
            text-align: center;
            background-color: #333;
        }
        .dropdown-content a:hover {
            background-color: #555;
        }
        .dropdown:hover .dropdown-content {
            display: block;
        }
    </style>
    <script>
        function toggleInternationalFields() {
            const nationality = document.getElementById('nationality').value;
            const passportField = document.getElementById('passport');
            const countryField = document.getElementById('country_origin');
            if (nationality === "international") {
                passportField.style.display = 'block';
                countryField.style.display = 'block';
            } else {
                passportField.style.display = 'none';
                countryField.style.display = 'none';
            }
        }
    </script>
</head>
<body>
    <header>
        <h1 align="center">Welcome to Borneo Bliss Travel</h1>
        <p align="center">Your one-stop solution for managing all your travel needs around Borneo</p>
    </header>
    <nav>
        <a href="index.html">
            <img src="image/logo.png" alt="Borneo Bliss Logo">
        </a>
        <a href="package.html">Packages</a>
        <a href="aboutus.html">About Us</a>
        <a href="contact.html">Contact</a>
        <div class="booking-nav">
            <div class="dropdown">
                <span class="booking">Booking</span>
                <div class="dropdown-content">
                    <a href="create_booking.jsp">Book Now</a>
                    <a href="check_booking.jsp">Check Booking</a>
                </div>
            </div>
        </div>
        <a href="login.jsp">Log In</a>
    </nav>
    <div class="main">
        <h2>Sign Up</h2>
        <form action="SignupServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <input type="submit" value="Sign Up">
            <p>Go back to log in. <a href="login.jsp">Log in</a></p>
        </form>
    </div>
    <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
        </div>
        <div>
            <p>&copy; 2023 Borneo Bliss Travel. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>

