<%-- 
    Document   : ViewProfile
    Created on : Jun 28, 2024, 2:31:50 PM
    Author     : Alesha Ruzi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PROFILE - BORNEO BLISS TRAVEL</title>
    <link rel="stylesheet" href="styleUser.css">
</head>
    <body>
        <div class="profile-container">
        <h1>Profile Page</h1>
        <div class="profile-details">
            <p><strong>Username:</strong> ${user.username}</p>
            <p><strong>Name:</strong> ${user.name}</p>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Phone Number:</strong> ${user.phone}</p>
        </div>
        <div class="profile-buttons">
            <form action="viewProfile.jsp" method="post">
                <button type="submit">Update Profile</button>
            </form>
            <form action="index.html" method="get">
                <button type="submit">Back to Home Page</button>
            </form>
        </div>
    </div>
        <h1>View Profile Page</h1>
        <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; 2024 Borneo Bliss Travel. All rights reserved.</p>
         </footer>
    </body>
</html>
