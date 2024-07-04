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
import javax.servlet.http.HttpSession;
import traveler.TRAVELER;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String jdbcUsername = "app";
        String jdbcPassword = "app";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<TRAVELER> profile = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM TRAVELER")) {

            while (rs.next()) {
                TRAVELER tvl = new TRAVELER(
                    rs.getString("userID"),
                    rs.getString("username"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("phoneNo"),
                    rs.getString("userPassword")
                );
                profile.add(tvl);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String username = (String) session.getAttribute("username");

        if ("update".equals(action) && username != null && !username.isEmpty()) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phoneNo = request.getParameter("phoneNo");

            try (Connection conn = getConnection()) {
                String sql = "UPDATE TRAVELER SET name = ?, email = ?, phoneNo = ? WHERE username = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, phoneNo);
                    pstmt.setString(4, username);

                    int rowsUpdated = pstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        // Update session attributes
                        session.setAttribute("name", name);
                        session.setAttribute("email", email);
                        session.setAttribute("phoneNo", phoneNo);

                        response.sendRedirect("successUpdateProfile.jsp");
                    } else {
                        response.sendRedirect("updateProfile.jsp?error=Failed to update profile");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("updateProfile.jsp?error=Exception occurred: " + e.getMessage());
            }
        } else {
            response.sendRedirect("updateProfile.jsp?error=Invalid action or username");
        }
    }
}
