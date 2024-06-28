import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import packages.PACKAGE;

@WebServlet("/managePackagesServlet")
public class ManagePackagesServlet extends HttpServlet {
    String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
    String jdbcUsername = "app";
    String jdbcPassword = "app";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagePackagesServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagePackagesServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String packageID = request.getParameter("id");

        if (action != null && packageID != null) {
            if (action.equals("delete")) {
                deletePackage(packageID);
            } else if (action.equals("edit")) {
                PACKAGE pkg = getPackageById(packageID);
                request.setAttribute("package", pkg);
                request.getRequestDispatcher("edit_packages.jsp").forward(request, response);
                return;
            }
        }

        ArrayList<PACKAGE> packages = null;
        try {
            packages = getAllPackages();
        } catch (SQLException ex) {
            Logger.getLogger(ManagePackagesServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("packages", packages);
        request.getRequestDispatcher("view_packages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packageID = request.getParameter("packageID");
        String packageName = request.getParameter("packageName");
        String packageDesc = request.getParameter("packageDesc");
        String packagePriceStr = request.getParameter("packagePrice");
        String packageState = request.getParameter("packageState");

        double packagePrice = Double.parseDouble(packagePriceStr);

        if (packageID != null && !packageID.isEmpty()) {
            try {
                updatePackage(packageID, packageName, packageDesc, packagePrice, packageState);
            } catch (SQLException ex) {
                Logger.getLogger(ManagePackagesServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                addPackage(packageName, packageDesc, packagePrice, packageState);  
            } catch (SQLException ex) {
                Logger.getLogger(ManagePackagesServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        response.sendRedirect("managePackagesServlet");
    }

    private void deletePackage(String packageID) {
        try {
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM Package WHERE packageID = ?");
            stmt.setString(1, packageID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private PACKAGE getPackageById(String packageID) {
        try {
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Package WHERE packageID = ?");
            stmt.setString(1, packageID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new PACKAGE(rs.getString("packageID"), rs.getString("packageName"), rs.getDouble("packagePrice"), rs.getString("packageDesc"), rs.getString("packageState"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private void updatePackage(String packageID, String packageName, String packageDesc, double packagePrice, String packageState) throws SQLException {
        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        PreparedStatement stmt = conn.prepareStatement("UPDATE Package SET packageName = ?, packageDesc = ?, packagePrice = ?, packageState = ? WHERE packageID = ?");
        try {
            stmt.setString(1, packageName);
            stmt.setString(2, packageDesc);
            stmt.setDouble(3, packagePrice);
            stmt.setString(4, packageState);
            stmt.setString(5, packageID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void addPackage(String packageName, String packageDesc, double packagePrice, String packageState) throws SQLException {
        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        PreparedStatement stmt = conn.prepareStatement("INSERT INTO Packages (packageName, packageDesc, packagePrice, packageState) VALUES (?, ?, ?, ?)");
        try {
            stmt.setString(1, packageName);
            stmt.setString(2, packageDesc);
            stmt.setDouble(3, packagePrice);
            stmt.setString(4, packageState);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private ArrayList<PACKAGE> getAllPackages() throws SQLException {
        ArrayList<PACKAGE> packages = new ArrayList<>();
        Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Packages");
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                packages.add(new PACKAGE(rs.getString("packageID"), rs.getString("packageName"), rs.getDouble("packagePrice"), rs.getString("packageDesc"), rs.getString("packageState")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return packages;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}