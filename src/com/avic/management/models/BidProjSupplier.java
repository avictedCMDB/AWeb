package com.avic.management.models;

import java.util.Date;

public class BidProjSupplier {
    String projId;
    String supCode;
    int joinType;
    int auditStatus;
    Date joinTime;
    Date auditTime;
    String auditUser;
    String failReason;
    String bidNum;
    
    String supId;
    String projName;
    Date publishTime;
    Date bidStartTime;
    private String supName;
    private String contactNum;
    private String contactPerson;
    private String email;
    
    
    int trialBan;
    int realBan;
    
    int ban;
    
    int bidResult;
    int realCurrentQuota;
    int contractStatus;
    Date contractTime;
    String contractRemark;
    int feeStatus;
    int projStatus;
    
    public Date getBidStartTime() {
        return bidStartTime;
    }
    public void setBidStartTime(Date bidStartTime) {
        this.bidStartTime = bidStartTime;
    }
    public int getProjStatus() {
        return projStatus;
    }
    public void setProjStatus(int projStatus) {
        this.projStatus = projStatus;
    }
    public int getBidResult() {
        return bidResult;
    }
    public void setBidResult(int bidResult) {
        this.bidResult = bidResult;
    }
    public int getRealCurrentQuota() {
        return realCurrentQuota;
    }
    public void setRealCurrentQuota(int realCurrentQuota) {
        this.realCurrentQuota = realCurrentQuota;
    }
    public int getContractStatus() {
        return contractStatus;
    }
    public void setContractStatus(int contractStatus) {
        this.contractStatus = contractStatus;
    }
    public Date getContractTime() {
        return contractTime;
    }
    public void setContractTime(Date contractTime) {
        this.contractTime = contractTime;
    }
    public String getContractRemark() {
        return contractRemark;
    }
    public void setContractRemark(String contractRemark) {
        this.contractRemark = contractRemark;
    }
    public int getFeeStatus() {
        return feeStatus;
    }
    public void setFeeStatus(int feeStatus) {
        this.feeStatus = feeStatus;
    }
    public int getBan() {
        return ban;
    }
    public void setBan(int ban) {
        this.ban = ban;
    }
    public int getTrialBan() {
        return trialBan;
    }
    public void setTrialBan(int trialBan) {
        this.trialBan = trialBan;
    }
    public int getRealBan() {
        return realBan;
    }
    public void setRealBan(int realBan) {
        this.realBan = realBan;
    }
    public String getProjName() {
        return projName;
    }
    public void setProjName(String projName) {
        this.projName = projName;
    }
    public Date getPublishTime() {
        return publishTime;
    }
    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }
    public String getSupId() {
        return supId;
    }
    public void setSupId(String supId) {
        this.supId = supId;
    }
    public String getSupName() {
        return supName;
    }
    public void setSupName(String supName) {
        this.supName = supName;
    }
    public String getContactNum() {
        return contactNum;
    }

    public void setContactNum(String contactNum) {
        this.contactNum = contactNum;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBidNum() {
        return bidNum;
    }
    
    public void setBidNum(String bidNum) {
        this.bidNum = bidNum;
    }
    
    public String getProjId() {
        return projId;
    }
    public void setProjId(String projId) {
        this.projId = projId;
    }
    public String getSupCode() {
        return supCode;
    }
    public void setSupCode(String supCode) {
        this.supCode = supCode;
    }
    public int getJoinType() {
        return joinType;
    }
    public void setJoinType(int joinType) {
        this.joinType = joinType;
    }
    public int getAuditStatus() {
        return auditStatus;
    }
    public void setAuditStatus(int auditStatus) {
        this.auditStatus = auditStatus;
    }
    public Date getJoinTime() {
        return joinTime;
    }
    public void setJoinTime(Date joinTime) {
        this.joinTime = joinTime;
    }
    public Date getAuditTime() {
        return auditTime;
    }
    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }
    public String getAuditUser() {
        return auditUser;
    }
    public void setAuditUser(String auditUser) {
        this.auditUser = auditUser;
    }
    public String getFailReason() {
        return failReason;
    }
    public void setFailReason(String failReason) {
        this.failReason = failReason;
    }
    
    
}
