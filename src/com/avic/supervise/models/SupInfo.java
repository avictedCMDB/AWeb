package com.avic.supervise.models;

public class SupInfo {
    private int supId;
    private int supType;
    private String supName;
    private String contactNum;
    
    public String getContactNum() {
        return contactNum;
    }
    public void setContactNum(String contactNum) {
        this.contactNum = contactNum;
    }
    public int getSupType() {
        return supType;
    }
    public void setSupType(int supType) {
        this.supType = supType;
    }
    public int getSupId() {
        return supId;
    }
    public void setSupId(int supId) {
        this.supId = supId;
    }
    public String getSupName() {
        return supName;
    }
    public void setSupName(String supName) {
        this.supName = supName;
    }
    
}
