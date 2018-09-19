package com.avic.market.models;

public class Invoice {
    private String companyName;
    private String invoiceNum;
    private String invoiceFlag;
    private String invoiceContent;
    private String ifDefault;
    private String userId;
    public String getCompanyName() {
        return companyName;
    }
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    public String getInvoiceNum() {
        return invoiceNum;
    }
    public void setInvoiceNum(String invoiceNum) {
        this.invoiceNum = invoiceNum;
    }
    public String getInvoiceFlag() {
        return invoiceFlag;
    }
    public void setInvoiceFlag(String invoiceFlag) {
        this.invoiceFlag = invoiceFlag;
    }
    public String getInvoiceContent() {
        return invoiceContent;
    }
    public void setInvoiceContent(String invoiceContent) {
        this.invoiceContent = invoiceContent;
    }
    public String getIfDefault() {
        return ifDefault;
    }
    public void setIfDefault(String ifDefault) {
        this.ifDefault = ifDefault;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    
}
