<%-- 
    Document   : UpdateProfile
    Created on : Jun 28, 2024, 2:32:12 PM
    Author     : Alesha Ruzi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - BORNEO BLISS TRAVEL</title>
    <link rel="stylesheet" href="styleUser.css">
</head>
    <body>
        
     
        <div class="profile-container">
        <h1>Update Profile</h1>
        <form action="updateProfile.jsp" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="${user.username}" required>
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="${user.name}" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${user.email}" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" value="${user.phone}" required>
            </div>
            <div class="profile-buttons">
                <button type="submit">Update</button>
                <button type="button" onclick="goToHomePage()">Back to Home Page</button>
            </div>
        </form>
    </div>

    <script>
        function goToHomePage() {
            window.location.href = 'index.html'; // Assuming home.jsp is the home page
        }
    </script>
        <footer>
        <div class="contact-info">
            <p>Contact Us: +60 12-345 6789 | info@borneobliss.com</p>
            <p>Address: 123 Borneo St, Kota Kinabalu, Malaysia</p>
        </div>
        <p>&copy; 2024 Borneo Bliss Travel. All rights reserved.</p>
        </footer>
    </body>
</html>
