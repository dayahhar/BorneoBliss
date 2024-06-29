package booking;
import java.util.Date;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author dayah
 */
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
    
}
