package com.avic.management.models;

import java.util.Date;
import java.util.List;

public class BidProject {
    String projId;
    String projName;
    String bidCat;
    int projType;
    int decideType;
    String currency;
    String exchangeRate;
    int minTender;
    String userId;
    String companyId;
    int quotaType;
    int quotaLimitType;
    int quotaLimitNum;
    int splitType;
    int projStatus;
    Date trialEndTime;
    Date joinEndTime;
    Date bidStartTime;
    Date bidEndTime;
    int bidDuration;
    int timeoutInterval;
    int minIncrType;
    int minIncrVal;
    int quotaDecrLimit;
    int timesLimitType;
    int timesLimitNum;
    int acceptType;
    int tenderPrice;
    int bidBond;
    String purchaserName;
    String bidderQual;
    String bidInvitation;
    String bidTimeRule;
    String bidQuotaRule;
    String caution;
    String remark;
    Date createTime;
    int publishQuota;
    int noticeStatus;
    int budget;
    int budgetPublic;

    Date publishTime;
    String bidCatName;
    Date timeoutEndTime;
    String currencyName;
    
    String obsoleteReason;
    
    int ifPublicity;
    Date publicityStart;
    Date publicityEnd;
    int ifContract;
    int showMinQuota;
    Date noticeTime;
    
    List<BidProjMateriel> materiels;
    List<BidProjSubject> subjects;
    List<BidProjSplit> splits;
    List<BidProjSupplier> suppliers;
    List<BidProjTender> tenders;
    
    String terminateReason;
    
    public Date getNoticeTime() {
        return noticeTime;
    }
    public void setNoticeTime(Date noticeTime) {
        this.noticeTime = noticeTime;
    }
    
    public int getShowMinQuota() {
        return showMinQuota;
    }
    public void setShowMinQuota(int showMinQuota) {
        this.showMinQuota = showMinQuota;
    }
    public int getIfContract() {
        return ifContract;
    }
    public void setIfContract(int ifContract) {
        this.ifContract = ifContract;
    }
    public int getIfPublicity() {
        return ifPublicity;
    }
    public void setIfPublicity(int ifPublicity) {
        this.ifPublicity = ifPublicity;
    }
    public Date getPublicityStart() {
        return publicityStart;
    }
    public void setPublicityStart(Date publicityStart) {
        this.publicityStart = publicityStart;
    }
    public Date getPublicityEnd() {
        return publicityEnd;
    }
    public void setPublicityEnd(Date publicityEnd) {
        this.publicityEnd = publicityEnd;
    }
    public int getBudgetPublic() {
        return budgetPublic;
    }
    public void setBudgetPublic(int budgetPublic) {
        this.budgetPublic = budgetPublic;
    }
    public String getObsoleteReason() {
        return obsoleteReason;
    }
    public void setObsoleteReason(String obsoleteReason) {
        this.obsoleteReason = obsoleteReason;
    }
    public String getCurrencyName() {
        return currencyName;
    }
    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }
    public int getBudget() {
        return budget;
    }
    public void setBudget(int budget) {
        this.budget = budget;
    }
    public Date getTimeoutEndTime() {
        return timeoutEndTime;
    }
    public void setTimeoutEndTime(Date timeoutEndTime) {
        this.timeoutEndTime = timeoutEndTime;
    }
    public Date getBidEndTime() {
        return bidEndTime;
    }
    public void setBidEndTime(Date bidEndTime) {
        this.bidEndTime = bidEndTime;
    }
    public Date getPublishTime() {
        return publishTime;
    }
    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }
    public String getBidCatName() {
        return bidCatName;
    }
    public void setBidCatName(String bidCatName) {
        this.bidCatName = bidCatName;
    }
    public List<BidProjMateriel> getMateriels() {
        return materiels;
    }
    public void setMateriels(List<BidProjMateriel> materiels) {
        this.materiels = materiels;
    }
    public List<BidProjSubject> getSubjects() {
        return subjects;
    }
    public void setSubjects(List<BidProjSubject> subjects) {
        this.subjects = subjects;
    }
    public List<BidProjSplit> getSplits() {
        return splits;
    }
    public void setSplits(List<BidProjSplit> splits) {
        this.splits = splits;
    }
    public List<BidProjSupplier> getSuppliers() {
        return suppliers;
    }
    public void setSuppliers(List<BidProjSupplier> suppliers) {
        this.suppliers = suppliers;
    }
    public List<BidProjTender> getTenders() {
        return tenders;
    }
    public void setTenders(List<BidProjTender> tenders) {
        this.tenders = tenders;
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
    public String getBidCat() {
        return bidCat;
    }
    public void setBidCat(String bidCat) {
        this.bidCat = bidCat;
    }
    public int getProjType() {
        return projType;
    }
    public void setProjType(int projType) {
        this.projType = projType;
    }
    public int getDecideType() {
        return decideType;
    }
    public void setDecideType(int decideType) {
        this.decideType = decideType;
    }
    public String getCurrency() {
        return currency;
    }
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    public String getExchangeRate() {
        return exchangeRate;
    }
    public void setExchangeRate(String exchangeRate) {
        this.exchangeRate = exchangeRate;
    }
    public int getMinTender() {
        return minTender;
    }
    public void setMinTender(int minTender) {
        this.minTender = minTender;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getCompanyId() {
        return companyId;
    }
    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }
    public int getQuotaType() {
        return quotaType;
    }
    public void setQuotaType(int quotaType) {
        this.quotaType = quotaType;
    }
    public int getQuotaLimitType() {
        return quotaLimitType;
    }
    public void setQuotaLimitType(int quotaLimitType) {
        this.quotaLimitType = quotaLimitType;
    }
    public int getQuotaLimitNum() {
        return quotaLimitNum;
    }
    public void setQuotaLimitNum(int quotaLimitNum) {
        this.quotaLimitNum = quotaLimitNum;
    }
    public int getSplitType() {
        return splitType;
    }
    public void setSplitType(int splitType) {
        this.splitType = splitType;
    }
    public int getProjStatus() {
        return projStatus;
    }
    public void setProjStatus(int projStatus) {
        this.projStatus = projStatus;
    }

    public Date getBidStartTime() {
        return bidStartTime;
    }
    public void setBidStartTime(Date bidStartTime) {
        this.bidStartTime = bidStartTime;
    }
    public int getBidDuration() {
        return bidDuration;
    }
    public void setBidDuration(int bidDuration) {
        this.bidDuration = bidDuration;
    }
    public int getTimeoutInterval() {
        return timeoutInterval;
    }
    public void setTimeoutInterval(int timeoutInterval) {
        this.timeoutInterval = timeoutInterval;
    }
    public int getMinIncrType() {
        return minIncrType;
    }
    public void setMinIncrType(int minIncrType) {
        this.minIncrType = minIncrType;
    }
    public int getMinIncrVal() {
        return minIncrVal;
    }
    public void setMinIncrVal(int minIncrVal) {
        this.minIncrVal = minIncrVal;
    }
    public int getQuotaDecrLimit() {
        return quotaDecrLimit;
    }
    public void setQuotaDecrLimit(int quotaDecrLimit) {
        this.quotaDecrLimit = quotaDecrLimit;
    }
    public int getTimesLimitType() {
        return timesLimitType;
    }
    public void setTimesLimitType(int timesLimitType) {
        this.timesLimitType = timesLimitType;
    }
    public int getTimesLimitNum() {
        return timesLimitNum;
    }
    public void setTimesLimitNum(int timesLimitNum) {
        this.timesLimitNum = timesLimitNum;
    }
    public int getAcceptType() {
        return acceptType;
    }
    public void setAcceptType(int acceptType) {
        this.acceptType = acceptType;
    }
    public int getTenderPrice() {
        return tenderPrice;
    }
    public void setTenderPrice(int tenderPrice) {
        this.tenderPrice = tenderPrice;
    }
    public int getBidBond() {
        return bidBond;
    }
    public void setBidBond(int bidBond) {
        this.bidBond = bidBond;
    }
    public String getBidderQual() {
        return bidderQual;
    }
    public void setBidderQual(String bidderQual) {
        this.bidderQual = bidderQual;
    }
    public String getBidInvitation() {
        return bidInvitation;
    }
    public void setBidInvitation(String bidInvitation) {
        this.bidInvitation = bidInvitation;
    }
    public String getBidTimeRule() {
        return bidTimeRule;
    }
    public void setBidTimeRule(String bidTimeRule) {
        this.bidTimeRule = bidTimeRule;
    }
    public String getBidQuotaRule() {
        return bidQuotaRule;
    }
    public void setBidQuotaRule(String bidQuotaRule) {
        this.bidQuotaRule = bidQuotaRule;
    }
    public String getCaution() {
        return caution;
    }
    public void setCaution(String caution) {
        this.caution = caution;
    }
    public String getRemark() {
        return remark;
    }
    public void setRemark(String remark) {
        this.remark = remark;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getTrialEndTime() {
        return trialEndTime;
    }
    public void setTrialEndTime(Date trialEndTime) {
        this.trialEndTime = trialEndTime;
    }
    public Date getJoinEndTime() {
        return joinEndTime;
    }
    public void setJoinEndTime(Date joinEndTime) {
        this.joinEndTime = joinEndTime;
    }
    public int getPublishQuota() {
        return publishQuota;
    }
    public void setPublishQuota(int publishQuota) {
        this.publishQuota = publishQuota;
    }
    public int getNoticeStatus() {
        return noticeStatus;
    }
    public void setNoticeStatus(int noticeStatus) {
        this.noticeStatus = noticeStatus;
    }
	public String getTerminateReason() {
		return terminateReason;
	}
	public void setTerminateReason(String terminateReason) {
		this.terminateReason = terminateReason;
	}
	public String getPurchaserName() {
		return purchaserName;
	}
	public void setPurchaserName(String purchaserName) {
		this.purchaserName = purchaserName;
	}
    
    
}
