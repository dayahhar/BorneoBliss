/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package packages;

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

    public PACKAGE(String packageID, String packageName, double packagePrice, String packageDesc, String packageState) {
        this.packageID = packageID;
        this.packageName = packageName;
        this.packagePrice = packagePrice;
        this.packageDesc = packageDesc;
        this.packageState = packageState;
    }
    
    public PACKAGE() {
        packageID = "";
        packageName = "";
        packagePrice = 0;
        packageDesc = "";
        packageState = "";
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
    
    
}
