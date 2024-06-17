/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Species;

/**
 *
 * @author User
 */
public class Species implements java.io.Serializable{
    
    String speciesID;
    String speciesName;
    String conservationStatus;
    
    public Species(String speciesID, String speciesName, String conservationStatus){
        this.speciesID = speciesID;
        this.speciesName = speciesName;
        this.conservationStatus = conservationStatus;
    }

    public String getSpeciesID() {
        return speciesID;
    }

    public String getSpeciesName() {
        return speciesName;
    }

    public String getConservationStatus() {
        return conservationStatus;
    }

    public void setSpeciesID(String speciesID) {
        this.speciesID = speciesID;
    }

    public void setSpeciesName(String speciesName) {
        this.speciesName = speciesName;
    }

    public void setConservationStatus(String conservationStatus) {
        this.conservationStatus = conservationStatus;
    }
}
