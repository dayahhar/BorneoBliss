package booking;

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
    private String bookingDate;
    private String travelDate;
    private String userID;
    private String packageID;
    private int bookingPax;
    private String bookingStatus;

    public BOOKING() {
        bookingID = "";
        bookingDate = "";
        travelDate = "";
        userID = "";
        packageID = "";
        bookingPax = 0;
        bookingStatus = "";
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getTravelDate() {
        return travelDate;
    }

    public void setTravelDate(String travelDate) {
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
