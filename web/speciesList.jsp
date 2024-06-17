<%-- 
    Document   : speciesList
    Created on : 16-Jun-2024, 18:08:10
    Author     : Sarah Syazana
    Group      : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Species List</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
        <style>
            .centered {
                text-align: center;
            }
            .species-table {
                width: 80%; /* Adjust the width as necessary */
            }
        </style>
    </head>
    <body>
        
        <nav>
            <a href="index.html">
                <div class="logo-placeholder">
                    <img src="images/logo.png" alt="Wildlife Watch Logo">
                </div>
            </a>
            <ul class="nav-links">
                <a href="logout.jsp">Logout</a>
            </ul>
        </nav>
        
        <div class="container centered">
            <div class="list">
                <h2><b>Species List</b></h2>
                <div class="filter-section">
                    <label for="status-filter">Filter by State:</label>
                    <select id="status-filter">
                        <option value="all">All</option>
                        <option value="critically_endangered">Critically Endangered</option>
                        <option value="endangered">Endangered</option>
                        <option value="least_concern">Least Concern</option>
                    </select>
                    <label for="state-filter">Filter by Status:</label>
                    <select id="state-filter">
                        <option value="all">All</option>
                        <option value="johor">Johor</option>
                        <option value="kedah">Kedah</option>
                        <option value="kelantan">Kelantan</option>
                        <option value="pahang">Pahang</option>
                        <option value="perak">Perak</option>
                        <option value="perlis">Perlis</option>
                        <option value="sabah">Sabah</option>
                        <option value="sarawak">Sarawak</option>
                        <option value="selangor">Selangor</option>
                        <option value="terengganu">Terengganu</option>
                    </select>
                    <label for="species-filter">Filter by Species:</label>
                    <input type="text" id="species-filter">
                    <button>Apply Filters</button>
                </div> <br>
            <table class="species-table">
                <thead>
                    <tr>
                        <th>Species ID</th>
                        <th>Species Name</th>
                        <th>Conservation Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="species" items="${speciesList}">
                        <tr>
                            <td>${species.speciesID}</td>
                            <td>${species.speciesName}</td>
                            <td>${species.conservationStatus}</td>
                            <td>
                                <a href="deleteSpecies.jsp?speciesID=${species.speciesID}">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
    <footer class="centered">
        <p>&copy; 2024 Wildlife Watch. All rights reserved.</p>
    </footer>
    </div>
    </body>
</html>
