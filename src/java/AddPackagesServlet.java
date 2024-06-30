import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddPackagesServlet")
public class AddPackagesServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String jdbcUsername = "app";
        String jdbcPassword = "app";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    private String generateNewPackageID(String category) {
        String newPackageID = "P01";  // Default value

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT MAX(packageID) AS max_id FROM PACKAGE");
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String currentMaxID = rs.getString("max_id");
                if (currentMaxID != null) {
                    // Extract the numeric part of the package ID
                    String numericPart = currentMaxID.substring(1, 3);
                    int currentIDNum = Integer.parseInt(numericPart);

                    // Increment the numeric part
                    int nextIDNum = currentIDNum + 1;
                    String formattedIDNum = String.format("%02d", nextIDNum);

                    // Append the category letter if applicable
                    if ("adult".equalsIgnoreCase(category)) {
                        newPackageID = "P" + formattedIDNum + "A";
                    } else if ("child".equalsIgnoreCase(category)) {
                        newPackageID = "P" + formattedIDNum + "C";
                    } else {
                        newPackageID = "P" + formattedIDNum;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return newPackageID;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String packageName = request.getParameter("packageName");
        double packagePrice = Double.parseDouble(request.getParameter("packagePrice"));
        String packageDesc = request.getParameter("packageDesc");
        String packageState = request.getParameter("packageState");
        String imageURL = request.getParameter("imageURL");
        String category = request.getParameter("category");

        // Generate package ID with category
        String packageID = generateNewPackageID(category);

        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO PACKAGE (packageID, packageName, packagePrice, packageDesc, packageState, imageURL) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, packageID);
                stmt.setString(2, packageName);
                stmt.setDouble(3, packagePrice);
                stmt.setString(4, packageDesc);
                stmt.setString(5, packageState);
                stmt.setString(6, imageURL);

                stmt.executeUpdate();
            }

            // Set success message in session
            HttpSession session = request.getSession();
            session.setAttribute("message", "Package ID " + packageID + " created successfully.");

            // Redirect to view_packages.jsp
            response.sendRedirect("view_packages.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}