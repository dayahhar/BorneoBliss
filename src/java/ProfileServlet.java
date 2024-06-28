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
import traveler.TRAVELER;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        TRAVELER user = getUserDetails(userId);
        request.setAttribute("user", user);
        request.getRequestDispatcher("updateProfile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        updateUserDetails(userId, username, name, email, phone);
        response.sendRedirect("ProfileServlet?userId=" + userId);
    }

    private TRAVELER getUserDetails(String userId) {
        TRAVELER user = null;
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app")) {
            String sql = "SELECT * FROM TRAVELER WHERE USERID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, userId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                user = new TRAVELER();
                user.setUserID(resultSet.getString("USERID"));
                user.setUsername(resultSet.getString("USERNAME"));
                user.setEmail(resultSet.getString("EMAIL"));
                user.setPhoneNo(resultSet.getString("PHONENO"));
                user.setName(resultSet.getString("NAME"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    private void updateUserDetails(String userId, String username, String name, String email, String phone) {
        try (Connection connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app")) {
            String sql = "UPDATE TRAVELER SET USERNAME = ?, NAME = ?, EMAIL = ?, PHONENO = ? WHERE USERID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, name);
            statement.setString(3, email);
            statement.setString(4, phone);
            statement.setString(5, userId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
