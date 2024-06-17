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

@WebServlet("/deleteSpecies")
public class deleteSpecies extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String speciesID = request.getParameter("speciesID");

        if (speciesID != null && !speciesID.isEmpty()) {
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                // Load the JDBC driver
                Class.forName("org.apache.derby.jdbc.ClientDriver");

                // Establish the connection
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/WildlifeDB", "app", "app");

                // Create the SQL delete query
                String sql = "DELETE FROM SPECIES WHERE speciesID = ?";

                // Create the PreparedStatement
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, speciesID);

                // Execute the query
                stmt.executeUpdate();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Redirect back to speciesList.jsp
        response.sendRedirect("speciesList.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}