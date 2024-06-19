<%-- 
    Document   : addSpecies
    Created on : 16-Jun-2024, 18:08:56
    Author     : Sarah Syazana
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:setDataSource var="myDatasource"
driver="org.apache.derby.jdbc.ClientDriver"
url="jdbc:derby://localhost:1527/WildlifeDB" user="app" password="app"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Species Data - Wildlife Watch</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <nav>
            <a href="dashboard.jsp">
                <div class="logo-placeholder">
                <img src="images/logo.png" alt="Wildlife Watch Logo">
                </div>
            </a>
            <ul class="nav-links">
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <div class="add-card">
                <h2>Add Species Data</h2>
                <form action="addSpecies" method="post">
                    <div class="input-group">
                        <label for="species-id">Species ID:</label>
                        <input type="text" id="species-id" name="speciesID" required>
                    </div>
                    <div class="input-group">
                        <label for="species-name">Species Name:</label>
                        <input type="text" id="species-name" name="speciesName" required>
                    </div>
                    <div class="input-group">
                        <label for="conservation-status">Conservation Status:</label>
                        <select id="conservation-status" name="conservationStatus" required>
                            <option value="Critically Endangered">Critically Endangered</option>
                            <option value="Endangered">Endangered</option>
                            <option value="Least Concern">Least Concern</option>
                        </select>
                    </div>
                    <button type="submit">Add Species</button>
                </form>
                <c:if test="${param.status == 'success'}">
                    <p class="success-message">Species added successfully!</p>
                </c:if>
                <c:if test="${param.status == 'error'}">
                    <p class="error-message">Error adding species. Please try again.</p>
                </c:if>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Wildlife Watch. All rights reserved.</p>
        </footer>
    </body>
</html>