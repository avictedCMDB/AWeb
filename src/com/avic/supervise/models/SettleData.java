package com.avic.supervise.models;

import java.util.Date;

public class SettleData {
    private String busiId;
    private int busiType;
    private Date createTime;
    private String companyName;
    private int totalNum;
    private double settleAmount;
    private int settleStatus;
    private int supId;
    private Date settleTime;
    private String settleOperator;
    private String settleId;
    public String getBusiId() {
        return busiId;
    }
    public void setBusiId(String busiId) {
        this.busiId = busiId;
    }
    public int getBusiType() {
        return busiType;
    }
    public void setBusiType(int busiType) {
        this.busiType = busiType;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public String getCompanyName() {
        return companyName;
    }
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    public int getTotalNum() {
        return totalNum;
    }
    public void setTotalNum(int totalNum) {
        this.totalNum = totalNum;
    }
    public double getSettleAmount() {
        return settleAmount;
    }
    public void setSettleAmount(double settleAmount) {
        this.settleAmount = settleAmount;
    }
    public int getSettleStatus() {
        return settleStatus;
    }
    public void setSettleStatus(int settleStatus) {
        this.settleStatus = settleStatus;
    }
    public int getSupId() {
        return supId;
    }
    public void setSupId(int supId) {
        this.supId = supId;
    }
    public Date getSettleTime() {
        return settleTime;
    }
    public void setSettleTime(Date settleTime) {
        this.settleTime = settleTime;
    }
    public String getSettleOperator() {
        return settleOperator;
    }
    public void setSettleOperator(String settleOperator) {
        this.settleOperator = settleOperator;
    }
    public String getSettleId() {
        return settleId;
    }
    public void setSettleId(String settleId) {
        this.settleId = settleId;
    }
    
    
}
