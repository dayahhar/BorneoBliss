/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author nanab
 */
public class BookingData {
    private String bookingId;
    private String travelerName;
    private String bookingDate;
    private String travelDate;
    private String packageName;
    private String status;

    public BookingData(String bookingId, String travelerName, String bookingDate, String travelDate, String packageName, String status) {
        this.bookingId = bookingId;
        this.travelerName = travelerName;
        this.bookingDate = bookingDate;
        this.travelDate = travelDate;
        this.packageName = packageName;
        this.status = status;
    }

    public String getBookingId() {
        return bookingId;
    }

    public String getTravelerName() {
        return travelerName;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public String getTravelDate() {
        return travelDate;
    }

    public String getPackageName() {
        return packageName;
    }

    public String getStatus() {
        return status;
    }
}

