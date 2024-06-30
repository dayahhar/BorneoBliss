/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packages;

import java.sql.*;
import java.util.*;

/**
 *
 * @author Aqilah05
 */
public class PACKAGE {
    private String packageID;
    private String packageName;
    private double packagePrice;
    private String packageDesc;
    private String packageState;
    private String imageURL;

    public PACKAGE(String packageID, String packageName, double packagePrice, String packageDesc, String packageState, String imageURL) {
        this.packageID = packageID;
        this.packageName = packageName;
        this.packagePrice = packagePrice;
        this.packageDesc = packageDesc;
        this.packageState = packageState;
        this.imageURL = imageURL;
    }
    
    public PACKAGE() {
        packageID = "";
        packageName = "";
        packagePrice = 0;
        packageDesc = "";
        packageState = "";   
        imageURL = "";   
    }

    public String getPackageID() {
        return packageID;
    }

    public String getPackageName() {
        return packageName;
    }

    public double getPackagePrice() {
        return packagePrice;
    }

    public String getPackageDesc() {
        return packageDesc;
    }

    public String getPackageState() {
        return packageState;
    }
    public String getImageURL() {
        return imageURL;
    }

    public void setPackageID(String packageID) {
        this.packageID = packageID;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public void setPackagePrice(double packagePrice) {
        this.packagePrice = packagePrice;
    }

    public void setPackageDesc(String packageDesc) {
        this.packageDesc = packageDesc;
    }

    public void setPackageState(String packageState) {
        this.packageState = packageState;
    }
    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }  
    
    public static List<PACKAGE> getAllPackages() {
        List<PACKAGE> packages = new ArrayList<>();
        String dbURL = "jdbc:derby://localhost:1527/BorneoDB";
        String dbUser = "app";
        String dbPassword = "app";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return packages;
    }
    
    public boolean updatePackage() {
        String jdbcURL = "jdbc:derby://localhost:1527/BorneoDB";
        String jdbcUsername = "app";
        String jdbcPassword = "app";
        String sql = "UPDATE PACKAGE SET packageName=?, packagePrice=?, packageDesc=?, packageState=?, imageURL=? WHERE packageID=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, packageName);
            stmt.setDouble(2, packagePrice);
            stmt.setString(3, packageDesc);
            stmt.setString(4, packageState);
            stmt.setString(5, imageURL);
            stmt.setString(6, packageID);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static PACKAGE getPackageByID(String packageID, Connection conn) {
        PACKAGE pkg = null;
        try (PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM PACKAGE WHERE packageID = ?")) {
            pstmt.setString(1, packageID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                pkg = new PACKAGE(
                    rs.getString("packageID"),
                    rs.getString("packageName"),
                    rs.getDouble("packagePrice"),
                    rs.getString("packageDesc"),
                    rs.getString("packageState"),
                    rs.getString("imageURL")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pkg;
    }
}
