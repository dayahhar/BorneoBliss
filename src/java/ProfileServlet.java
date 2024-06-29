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
import javax.servlet.http.HttpSession;
import traveler.TRAVELER;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    // Database connection parameters
    private static final String dbURL = "jdbc:derby://localhost:1527/BorneoDB";
    private static final String dbUser = "app"; // Replace with your DB username
    private static final String dbPassword = "app"; // Replace with your DB password

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        TRAVELER user = getUserDetails(userId);

        request.setAttribute("user", user);
        request.getRequestDispatcher("restricted/updateProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneNo");
        String password = request.getParameter("password");

        updateUserDetails(userId, username, name, email, phoneNo, password);
        
        // Redirect to successUpdateProfile.jsp after updating the profile
        response.sendRedirect("successUpdateProfile.jsp");
    }

    private TRAVELER getUserDetails(String userId) throws ServletException {
        TRAVELER user = null;

        String sql = "SELECT username, name, email, phoneNo, password FROM users WHERE userId = ?";

        // Load the JDBC driver
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Database driver not found", e);
        }

        // Connect to the database and execute the query
        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    user = new TRAVELER();
                    user.setUsername(resultSet.getString("username"));
                    user.setName(resultSet.getString("name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPhoneNo(resultSet.getString("phoneNo"));
                    user.setPassword(resultSet.getString("password")); // Add this line if password is required
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error fetching user details", e);
        }

        return user;
    }

    private void updateUserDetails(String userId, String username, String name, String email, String phone, String password) {
        String sql = "UPDATE users SET username = ?, name = ?, email = ?, phoneNo = ?, password = ? WHERE userId = ?";

        try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);
            statement.setString(2, name);
            statement.setString(3, email);
            statement.setString(4, phone);
            statement.setString(5, password); // Add this line if password is required
            statement.setString(6, userId);

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
