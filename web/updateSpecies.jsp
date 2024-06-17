<%-- 
    Document   : updateSpecies
    Created on : 16-Jun-2024, 18:09:16
    Author     : Sarah Syazana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Species Information - Wildlife Watch</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <nav>
            <a href="index.html">
                <div class="logo-placeholder">
                    <img src="images/logo.png" alt="Wildlife Watch Logo">
                </div>
            </a>
            <ul class="nav-links">
                <li><a href="logout.html">Logout</a></li>
            </ul>
        </nav>

        <div class="container">
            <div class="edit-card">
                <h2>Edit Species Information</h2>
                <form>
                    <div class="input-group">
                        <label for="species-id">Species ID:</label>
                        <input type="text" id="species-id" name="species-id" required>
                    </div>
                    <div class="input-group">
                        <label for="species-name">Species Name:</label>
                        <input type="text" id="species-name" name="species-name" required>
                    </div>
                    <div class="input-group">
                        <label for="status">Status Conservation:</label>
                        <select id="status" name="status" required>
                            <option value="critically-endangered">Critically Endangered</option>
                            <option value="endangered">Endangered</option>
                            <option value="least-concern">Least Concern</option>
                        </select>
                    </div>
                    <div class="button-group">
                        <button type="submit">Update</button>
                        <button type="reset">Reset</button>
                    </div>
                </form>
                <c:if test="${param.status == 'error'}">
                    <p class="error-message">Error updating species. Please try again.</p>
                </c:if>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Wildlife Watch. All rights reserved.</p>
        </footer>

    </body>
</html>
