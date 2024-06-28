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
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }
        .message {
            font-size: 18px;
            color: #333;
        }
    </style>
    <script>
        function redirect() {
            setTimeout(function() {
                window.location.href = 'http://localhost:8080/BorneoBlissTravel/index.html';
            }, 3000);
        }
    </script>
</head>
<body onload="redirect()">
    <div class="message">You are being redirected, please wait....</div>
</body>
</html>

