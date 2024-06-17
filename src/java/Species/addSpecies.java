/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Species;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */

@WebServlet("/addSpecies")
public class addSpecies extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String speciesID = request.getParameter("speciesID");
        String speciesName = request.getParameter("speciesName");
        String conservationStatus = request.getParameter("conservationStatus");

        // JDBC connection parameters
        String dbURL = "jdbc:derby://localhost:1527/WildlifeDB";
        String username = "app"; // replace with your DB username
        String password = "app"; // replace with your DB password

        // SQL INSERT statement
        String sql = "INSERT INTO Species (SpeciesID, SpeciesName, ConservationStatus) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(dbURL, username, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set parameters for the SQL query
            stmt.setString(1, speciesID);
            stmt.setString(2, speciesName);
            stmt.setString(3, conservationStatus);

            // Execute the query
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("speciesList.jsp?status=success");
            } else {
                response.sendRedirect("addSpecies.jsp?status=error");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addSpecies.jsp?status=error");
        }
    }
}
