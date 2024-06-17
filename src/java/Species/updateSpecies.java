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
import java.sql.ResultSet;
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

@WebServlet("/updateSpecies")
public class updateSpecies extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String speciesID = request.getParameter("speciesID");
        Species species = null;

        // JDBC connection parameters
        String dbURL = "jdbc:derby://localhost:1527/WildlifeDB";
        String username = "app"; // replace with your DB username
        String password = "app"; // replace with your DB password

        String sql = "SELECT * FROM Species WHERE SpeciesID = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, username, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, speciesID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                species = new Species(
                    rs.getString("SpeciesID"),
                    rs.getString("SpeciesName"),
                    rs.getString("ConservationStatus")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("species", species);
        request.getRequestDispatcher("updateSpecies.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String speciesID = request.getParameter("speciesID");
        String speciesName = request.getParameter("speciesName");
        String conservationStatus = request.getParameter("conservationStatus");

        // JDBC connection parameters
        String dbURL = "jdbc:derby://localhost:1527/WildlifeDB";
        String username = "yourUsername"; // replace with your DB username
        String password = "yourPassword"; // replace with your DB password

        String sql = "UPDATE Species SET SpeciesName = ?, ConservationStatus = ? WHERE SpeciesID = ?";

        try (Connection conn = DriverManager.getConnection(dbURL, username, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, speciesName);
            stmt.setString(2, conservationStatus);
            stmt.setString(3, speciesID);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("speciesList.jsp?status=update_success");
            } else {
                response.sendRedirect("updateSpecies.jsp?speciesID=" + speciesID + "&status=error");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("updateSpecies.jsp?speciesID=" + speciesID + "&status=error");
        }
    }
}
