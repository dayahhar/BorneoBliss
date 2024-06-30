import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import packages.PACKAGE;

@WebServlet("/ManagePackagesServlet")
public class ManagePackagesServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String jdbcUsername = "app";
        String jdbcPassword = "app";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<PACKAGE> packages = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM PACKAGE")) {

            while (rs.next()) {
                PACKAGE pkg = new PACKAGE(
                    rs.getString("packageID"),
                    rs.getString("packageName"),
                    rs.getDouble("packagePrice"),
                    rs.getString("packageDesc"),
                    rs.getString("packageState"),
                    rs.getString("imageURL")
                );
                packages.add(pkg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("packages", packages);
        request.getRequestDispatcher("view_packages.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String packageID = request.getParameter("packageID");
        
        if (action.equals("delete")) {
            try (Connection conn = getConnection();
                 PreparedStatement pstmtDelete = conn.prepareStatement("DELETE FROM PACKAGE WHERE packageID = ?")) {
                pstmtDelete.setString(1, packageID);
                pstmtDelete.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (action.equals("update")) {
            String packageName = request.getParameter("packageName");
            String packageDesc = request.getParameter("packageDesc");
            double packagePrice = Double.parseDouble(request.getParameter("packagePrice"));
            String packageState = request.getParameter("packageState");
            String imageURL = request.getParameter("imageURL");
            
            try (Connection conn = getConnection()) {
                PACKAGE pkg = PACKAGE.getPackageByID(packageID, conn);
                
                if (pkg != null) {
                    pkg.setPackageName(packageName);
                    pkg.setPackageDesc(packageDesc);
                    pkg.setPackagePrice(packagePrice);
                    pkg.setPackageState(packageState);
                    pkg.setImageURL(imageURL);
                    
                    try (PreparedStatement pstmtUpdate = conn.prepareStatement(
                            "UPDATE PACKAGE SET packageName = ?, packageDesc = ?, packagePrice = ?, " +
                            "packageState = ?, imageURL = ? WHERE packageID = ?")) {

                        pstmtUpdate.setString(1, pkg.getPackageName());
                        pstmtUpdate.setString(2, pkg.getPackageDesc());
                        pstmtUpdate.setDouble(3, pkg.getPackagePrice());
                        pstmtUpdate.setString(4, pkg.getPackageState());
                        pstmtUpdate.setString(5, pkg.getImageURL());
                        pstmtUpdate.setString(6, packageID);

                        int rowsUpdated = pstmtUpdate.executeUpdate();
                        if (rowsUpdated > 0) {
                            System.out.println("Package updated successfully.");
                        } else {
                            System.out.println("Failed to update package.");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // After delete or update, refresh the list of packages
        List<PACKAGE> packages = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM PACKAGE")) {

            while (rs.next()) {
                PACKAGE pkg = new PACKAGE(
                    rs.getString("packageID"),
                    rs.getString("packageName"),
                    rs.getDouble("packagePrice"),
                    rs.getString("packageDesc"),
                    rs.getString("packageState"),
                    rs.getString("imageURL")
                );
                packages.add(pkg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("packages", packages);
        request.getRequestDispatcher("view_packages.jsp").forward(request, response);
    }
}