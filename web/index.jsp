<%-- 
    Document   : index
    Created on : 17-Jun-2024, 22:32:32
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Wildlife Watch</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body class="index">
        <nav>
            <a href="index.jsp">
                <div class="logo-placeholder">
                    <img src="images/logo.png" alt="Wildlife Watch Logo">
                </div>
            </a>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li class="dropdown">
                    <i class="fas fa-user"></i>
                    <div class="dropdown-content">
                        <a href="login.jsp">Login</a>
                        <a href="signup.jsp">Sign Up</a>
                    </div>
                </li>
            </ul>
        </nav>

        <div class="container">
            <div class="card">
                <div class="image-container">
                    <img src="images/tiger.jpg" alt="Wildlife Conservation Image">
                </div>
                <div class="content">
                    <h1>Welcome to Wildlife Watch</h1>
                    <p>Discover the wonders of wildlife and join us in protecting and preserving our natural world.
                    Our Wildlife Watch platform provides a comprehensive wildlife conservation management system, 
                    enabling users to contribute to conservation efforts, learn about endangered species, 
                    and engage with like-minded individuals.</p>
                    <h2>Join Our Community</h2>
                    <p>Register now to become a part of our vibrant <br> community dedicated to wildlife conservation.</p>
                    <a href="signup.jsp" class="button">Sign Up</a>
                </div>
            </div>
        </div>    

        <footer>
            <p>&copy; 2024 Wildlife Watch. All rights reserved.</p>
        </footer>
    </body>
</html>
