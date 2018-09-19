package com.avic.market.models;

import java.util.Date;

public class Supplier {
    private int supId;
    private String supCode;
    private String supName;
    private String authUser;
    private String authPass;
    private String authCode;
    private String accessToken;
    private Date accessExpire;
    private String refreshToken;
    private Date refreshExpire;
    private String companyCode;
    private String deptCode;
    private String apiUrl;
    private int ifValid;
    private int supType;
    private String contactNum;
    private double pricePara;
    private String busiType;
    private String busiRange;
    private String supImage;
    private Date enterDate;
    private int ifBuilding;
    
    public int getIfBuilding() {
        return ifBuilding;
    }
    public void setIfBuilding(int ifBuilding) {
        this.ifBuilding = ifBuilding;
    }
    
    public String getBusiType() {
        return busiType;
    }
    public void setBusiType(String busiType) {
        this.busiType = busiType;
    }
    public String getBusiRange() {
        return busiRange;
    }
    public void setBusiRange(String busiRange) {
        this.busiRange = busiRange;
    }
    public String getSupImage() {
        return supImage;
    }
    public void setSupImage(String supImage) {
        this.supImage = supImage;
    }
    public Date getEnterDate() {
        return enterDate;
    }
    public void setEnterDate(Date enterDate) {
        this.enterDate = enterDate;
    }
    public double getPricePara() {
        return pricePara;
    }
    public void setPricePara(double pricePara) {
        this.pricePara = pricePara;
    }

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
    public String getSupCode() {
        return supCode;
    }
    public void setSupCode(String supCode) {
        this.supCode = supCode;
    }
    public String getSupName() {
        return supName;
    }
    public void setSupName(String supName) {
        this.supName = supName;
    }
    public String getAuthUser() {
        return authUser;
    }
    public void setAuthUser(String authUser) {
        this.authUser = authUser;
    }
    public String getAuthPass() {
        return authPass;
    }
    public void setAuthPass(String authPass) {
        this.authPass = authPass;
    }
    public String getAuthCode() {
        return authCode;
    }
    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }
    public String getAccessToken() {
        return accessToken;
    }
    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }
    public Date getAccessExpire() {
        return accessExpire;
    }
    public void setAccessExpire(Date accessExpire) {
        this.accessExpire = accessExpire;
    }
    public String getRefreshToken() {
        return refreshToken;
    }
    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }
    public Date getRefreshExpire() {
        return refreshExpire;
    }
    public void setRefreshExpire(Date refreshExpire) {
        this.refreshExpire = refreshExpire;
    }
    public String getCompanyCode() {
        return companyCode;
    }
    public void setCompanyCode(String companyCode) {
        this.companyCode = companyCode;
    }
    public String getDeptCode() {
        return deptCode;
    }
    public void setDeptCode(String deptCode) {
        this.deptCode = deptCode;
    }
    public String getApiUrl() {
        return apiUrl;
    }
    public void setApiUrl(String apiUrl) {
        this.apiUrl = apiUrl;
    }
    public int getIfValid() {
        return ifValid;
    }
    public void setIfValid(int ifValid) {
        this.ifValid = ifValid;
    }
    
    
}
