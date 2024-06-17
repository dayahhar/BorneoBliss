<%-- 
    Document   : signup
    Created on : 16-Jun-2024, 18:46:23
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up - Wildlife Watch</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <nav>
            <a href="index.jsp">
                <div class="logo-placeholder">
                    <img src="images/logo.png" alt="Wildlife Watch Logo">
                </div>
            </a>
        </nav>

        <div class="container">
            <div class="card signup-card">
                <form action="#" method="POST">
                    <h2>Sign Up for Wildlife Watch</h2>
                    <div class="input-group">
                        <input type="text" id="userid" name="userid" placeholder="User ID" required>
                    </div>
                    <div class="input-group">
                        <input type="text" id="name" name="name" placeholder="Name" required>
                    </div>
                    <div class="input-group">
                        <input type="password" id="password" name="password" placeholder="Password" required>
                    </div>
                    <div class="input-group">
                        <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm Password" required>
                    </div>
                    <div class="input-group">
                        <input type="email" id="email" name="email" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <input type="text" id="contact-num" name="contact-num" placeholder="Contact Number" required>
                    </div>
                    <button type="submit">Sign Up</button>
                    <p>Already have an account? <a href="login.jsp">Login</a></p>
                </form>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Wildlife Watch. All rights reserved.</p>
        </footer>
    </body>
</html>

