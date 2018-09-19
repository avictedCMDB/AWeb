package com.avic.supplier.models;

import java.util.Date;

public class ProjSupplier {
    private String supCode;
    private String supName;
    private int realCurrentQuota;
    private int bidResult;
    
    private String projId;
    private String projName;
    private Date noticeTime;
    private int feeStatus;
    private int contractStatus;
    private Date contractTime;
    private String contractRemark;
    private String userId;
    
    private int projStatus;
    
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public int getProjStatus() {
        return projStatus;
    }
    public void setProjStatus(int projStatus) {
        this.projStatus = projStatus;
    }
    public Date getContractTime() {
        return contractTime;
    }
    public void setContractTime(Date contractTime) {
        this.contractTime = contractTime;
    }
    public String getProjId() {
        return projId;
    }
    public void setProjId(String projId) {
        this.projId = projId;
    }
    public String getProjName() {
        return projName;
    }
    public void setProjName(String projName) {
        this.projName = projName;
    }
    public Date getNoticeTime() {
        return noticeTime;
    }
    public void setNoticeTime(Date noticeTime) {
        this.noticeTime = noticeTime;
    }
    public int getFeeStatus() {
        return feeStatus;
    }
    public void setFeeStatus(int feeStatus) {
        this.feeStatus = feeStatus;
    }
    public int getContractStatus() {
        return contractStatus;
    }
    public void setContractStatus(int contractStatus) {
        this.contractStatus = contractStatus;
    }
    public String getContractRemark() {
        return contractRemark;
    }
    public void setContractRemark(String contractRemark) {
        this.contractRemark = contractRemark;
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
    public int getRealCurrentQuota() {
        return realCurrentQuota;
    }
    public void setRealCurrentQuota(int realCurrentQuota) {
        this.realCurrentQuota = realCurrentQuota;
    }
    public int getBidResult() {
        return bidResult;
    }
    public void setBidResult(int bidResult) {
        this.bidResult = bidResult;
    }
    
    
}
