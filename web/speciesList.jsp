<%-- 
    Document   : speciesList
    Created on : 16-Jun-2024, 18:08:10
    Author     : Sarah Syazana
    Group      : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<sql:setDataSource var="WildlifeDB"
driver="org.apache.derby.jdbc.ClientDriver" 
url="jdbc:derby://localhost:1527/WildlifeDB"
user="app"
password="app"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Species - Wildlife Watch</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
        <script>
            function confirmDelete(speciesID) {
                var confirmed = confirm("Are you sure you want to delete this species?");
                if (confirmed) {
                    window.location.href = 'deleteSpecies.jsp?speciesID=' + speciesID;
                }
            }
        </script>
    </head>
    <body>
        <nav>
            <a href="index.html">
                <div class="logo-placeholder">
                    <img src="images/logo.png" alt="Wildlife Watch Logo">
                </div>
            </a>
            <ul class="nav-links">
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <div class="list">
                <h2><b>List of Species</b></h2>
                
                <sql:query var="result" dataSource="${WildlifeDB}">
                    SELECT * FROM SPECIES
                </sql:query>
        
                <div class="filter-section">
                    <label for="status-filter">Filter by Conservation Status:</label>
                    <select id="status-filter">
                        <option value="all">All</option>
                        <option value="critically_endangered">Critically Endangered</option>
                        <option value="endangered">Endangered</option>
                        <option value="least_concern">Least Concern</option>
                    </select>
                    <label for="species-filter">Filter by Species:</label>
                    <input type="text" id="species-filter">
                    <button>Apply Filters</button>
                </div>
            <table class="species-table">
                <thead>
                    <tr>
                        <th>Species ID</th>
                        <th>Species Name</th>
                        <th>Conservation Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="species" items="${result.rows}">
                        <tr>
                            <td><c:out value = "${species.speciesID}"/></td>
                            <td><c:out value = "${species.speciesName}"/></td>
                            <td><c:out value = "${species.conservationStatus}"/></td>
                            <td>
                                <a href="javascript:void(0);" onclick="confirmDelete('${species.speciesID}')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
                            
        <footer>
            <p>&copy; 2024 Wildlife Watch. All rights reserved.</p>
        </footer>
    </div>
    </body>
</html>
