package booking;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

public class BOOKING {
    private String bookingID;
    private Date bookingDate;
    private Date travelDate;
    private String userID;
    private String packageID;
    private int bookingPax;
    private String bookingStatus;

    public BOOKING() {
    }

    public BOOKING(String bookingID, Date bookingDate, Date travelDate, String userID, String packageID, int bookingPax, String bookingStatus) {
        this.bookingID = bookingID;
        this.bookingDate = bookingDate;
        this.travelDate = travelDate;
        this.userID = userID;
        this.packageID = packageID;
        this.bookingPax = bookingPax;
        this.bookingStatus = bookingStatus;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Date getTravelDate() {
        return travelDate;
    }

    public void setTravelDate(Date travelDate) {
        this.travelDate = travelDate;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getPackageID() {
        return packageID;
    }

    public void setPackageID(String packageID) {
        this.packageID = packageID;
    }

    public int getBookingPax() {
        return bookingPax;
    }

    public void setBookingPax(int bookingPax) {
        this.bookingPax = bookingPax;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public String getUserID(String username) {
        String userID = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/BorneoDB", "app", "app");

            String query = "SELECT USERID FROM APP.TRAVELER WHERE USERNAME = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);

            rs = stmt.executeQuery();

            if (rs.next()) {
                userID = rs.getString("USERID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return userID;
    }

}
