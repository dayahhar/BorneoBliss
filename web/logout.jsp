<%-- 
    Document   : logout
    Created on : Jun 28, 2024, 12:08:48 PM
    Author     : nurna
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Redirecting...</title>
    <link rel="stylesheet" href="styleUser.css">
    <script>
        function redirect() {
            setTimeout(function() {
                window.location.href = 'http://localhost:8080/BorneoBlissTravel/index.html';
            }, 3000);
        }
    </script>
</head>
<body onload="redirect()">
    <header>
        <h1>Welcome to Borneo Bliss Travel</h1>
        <p>Your one-stop solution for managing all your travel needs around Borneo</p>
        <link rel="stylesheet" href="styleUser.css">
    </header>
    <div align="center" class="message">
        <h1 align="center">Log Out Successful!</h1>
        <p align="center">See You Again!</p>
        You are being redirected, please wait....</div>
    <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; 2024 Borneo Bliss Travel. All rights reserved.</p>
    </footer>
</body>
</html>

