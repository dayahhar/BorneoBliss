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
        List<TRAVELER> travelers = new ArrayList<>();
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
                    rs.getString("userpassword")
                );
                travelers.add(tvl);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("travelers", travelers);
        request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String userID = request.getParameter("userID");
        
        if (action.equals("update")) {
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phoneNo = request.getParameter("phoneNo");

            try (Connection conn = getConnection()) {
                TRAVELER tvl = TRAVELER.getTravelerByID(userID, conn);

                if (tvl != null) {
                    tvl.setUsername(username);
                    tvl.setName(name);
                    tvl.setEmail(email);
                    tvl.setPhoneNo(phoneNo);

                    try (PreparedStatement pstmtUpdate = conn.prepareStatement(
                            "UPDATE TRAVELER SET username = ?, name = ?, email = ?, phoneNo = ? WHERE userID = ?")) {
                        pstmtUpdate.setString(1, tvl.getUsername());
                        pstmtUpdate.setString(2, tvl.getName());
                        pstmtUpdate.setString(3, tvl.getEmail());
                        pstmtUpdate.setString(4, tvl.getPhoneNo());
                        pstmtUpdate.setString(5, userID); // This line is necessary to set the userID

                        int rowsUpdated = pstmtUpdate.executeUpdate();
                        if (rowsUpdated > 0) {
                            System.out.println("Profile updated successfully.");
                        } else {
                            System.out.println("Failed to update profile.");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // After update, refresh the list of travelers
        List<TRAVELER> travelers = new ArrayList<>();
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
                    rs.getString("userpassword")
                );
                travelers.add(tvl);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("travelers", travelers);
        request.getRequestDispatcher("successUpdateProfile.jsp").forward(request, response);
    }
}
