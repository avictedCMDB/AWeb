package com.avic.market.models;

import java.util.Date;
import java.util.List;

public class Order {
    private String orderId;
    private String userId;
    private int supId;
    private int orderStatus;
    private Date orderTime;
    private Date reviewTime;
    private String reviewRemark;
    private Date payTime;
    private double orderAmount;
    private int expressType;
    private int addrProv;
    private int addrCity;
    private int addrDist;
    private int addrTown;
    private String addrDetail;
    private String addrAll;
    private String addrName;
    private String addrZip;
    private String addrPhone;
    private String addrTel;
    private int invoiceType;
    private int invoiceFlag;
    private String invoiceContent;
    private String invoiceCompany;
    private String invoiceNum;
    private String decideReason;
    private String addrEmail;
    private String supOrderId;
    private String reviewPerson;
    private String reviewResult;
    private String companyId;
    private String vatReceiveName;
    private String vatReceiveTel;
    private String vatReceiveDetail;
    private int vatReceiveProv;
    private int vatReceiveCity;
    private int vatReceiveDist;
    private double orderAmountInit;
    private int buyType;
    
    private String refoundAmount;
    private String exchangeAmount;
    private String exchangeID;
    private String refoundID;
    
    private String exchangeStatus; //����״̬
	
	private String refoundStatus; //�˻�״̬
    
    private List<String> imgs;
    
    private List<OrderSnapshot> snapshots;
    
    Contract contract;
    
    public Contract getContract() {
        return contract;
    }
    public void setContract(Contract contract) {
        this.contract = contract;
    }
    
    public int getBuyType() {
        return buyType;
    }
    public void setBuyType(int buyType) {
        this.buyType = buyType;
    }
    public double getOrderAmountInit() {
        return orderAmountInit;
    }
    public void setOrderAmountInit(double orderAmountInit) {
        this.orderAmountInit = orderAmountInit;
    }
    public List<String> getImgs() {
        return imgs;
    }
    public void setImgs(List<String> imgs) {
        this.imgs = imgs;
    }
    
    public String getVatReceiveName() {
        return vatReceiveName;
    }
    public void setVatReceiveName(String vatReceiveName) {
        this.vatReceiveName = vatReceiveName;
    }
    public String getVatReceiveTel() {
        return vatReceiveTel;
    }
    public void setVatReceiveTel(String vatReceiveTel) {
        this.vatReceiveTel = vatReceiveTel;
    }
    public String getVatReceiveDetail() {
        return vatReceiveDetail;
    }
    public void setVatReceiveDetail(String vatReceiveDetail) {
        this.vatReceiveDetail = vatReceiveDetail;
    }
    public int getVatReceiveProv() {
        return vatReceiveProv;
    }
    public void setVatReceiveProv(int vatReceiveProv) {
        this.vatReceiveProv = vatReceiveProv;
    }
    public int getVatReceiveCity() {
        return vatReceiveCity;
    }
    public void setVatReceiveCity(int vatReceiveCity) {
        this.vatReceiveCity = vatReceiveCity;
    }
    public int getVatReceiveDist() {
        return vatReceiveDist;
    }
    public void setVatReceiveDist(int vatReceiveDist) {
        this.vatReceiveDist = vatReceiveDist;
    }
    public String getReviewPerson() {
        return reviewPerson;
    }
    public void setReviewPerson(String reviewPerson) {
        this.reviewPerson = reviewPerson;
    }
    public String getReviewResult() {
        return reviewResult;
    }
    public void setReviewResult(String reviewResult) {
        this.reviewResult = reviewResult;
    }
    public String getCompanyId() {
        return companyId;
    }
    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }
    public String getSupOrderId() {
        return supOrderId;
    }
    public void setSupOrderId(String supOrderId) {
        this.supOrderId = supOrderId;
    }
    public String getAddrEmail() {
        return addrEmail;
    }
    public void setAddrEmail(String addrEmail) {
        this.addrEmail = addrEmail;
    }
    public List<OrderSnapshot> getSnapshots() {
        return snapshots;
    }
    public void setSnapshots(List<OrderSnapshot> snapshots) {
        this.snapshots = snapshots;
    }
    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public int getSupId() {
        return supId;
    }
    public void setSupId(int supId) {
        this.supId = supId;
    }
    public int getOrderStatus() {
        return orderStatus;
    }
    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }
    public Date getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }
    public Date getReviewTime() {
        return reviewTime;
    }
    public void setReviewTime(Date reviewTime) {
        this.reviewTime = reviewTime;
    }
    public String getReviewRemark() {
        return reviewRemark;
    }
    public void setReviewRemark(String reviewRemark) {
        this.reviewRemark = reviewRemark;
    }
    public Date getPayTime() {
        return payTime;
    }
    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }
    public double getOrderAmount() {
        return orderAmount;
    }
    public void setOrderAmount(double orderAmount) {
        this.orderAmount = orderAmount;
    }
    public int getExpressType() {
        return expressType;
    }
    public void setExpressType(int expressType) {
        this.expressType = expressType;
    }
    public int getAddrProv() {
        return addrProv;
    }
    public void setAddrProv(int addrProv) {
        this.addrProv = addrProv;
    }
    public int getAddrCity() {
        return addrCity;
    }
    public void setAddrCity(int addrCity) {
        this.addrCity = addrCity;
    }
    public int getAddrDist() {
        return addrDist;
    }
    public void setAddrDist(int addrDist) {
        this.addrDist = addrDist;
    }
    public int getAddrTown() {
        return addrTown;
    }
    public void setAddrTown(int addrTown) {
        this.addrTown = addrTown;
    }
    public String getAddrDetail() {
        return addrDetail;
    }
    public void setAddrDetail(String addrDetail) {
        this.addrDetail = addrDetail;
    }
    public String getAddrAll() {
        return addrAll;
    }
    public void setAddrAll(String addrAll) {
        this.addrAll = addrAll;
    }
    public String getAddrName() {
        return addrName;
    }
    public void setAddrName(String addrName) {
        this.addrName = addrName;
    }
    public String getAddrZip() {
        return addrZip;
    }
    public void setAddrZip(String addrZip) {
        this.addrZip = addrZip;
    }
    public String getAddrPhone() {
        return addrPhone;
    }
    public void setAddrPhone(String addrPhone) {
        this.addrPhone = addrPhone;
    }
    public String getAddrTel() {
        return addrTel;
    }
    public void setAddrTel(String addrTel) {
        this.addrTel = addrTel;
    }
    public int getInvoiceType() {
        return invoiceType;
    }
    public void setInvoiceType(int invoiceType) {
        this.invoiceType = invoiceType;
    }
    public int getInvoiceFlag() {
        return invoiceFlag;
    }
    public void setInvoiceFlag(int invoiceFlag) {
        this.invoiceFlag = invoiceFlag;
    }
    public String getInvoiceContent() {
        return invoiceContent;
    }
    public void setInvoiceContent(String invoiceContent) {
        this.invoiceContent = invoiceContent;
    }
    public String getInvoiceCompany() {
        return invoiceCompany;
    }
    public void setInvoiceCompany(String invoiceCompany) {
        this.invoiceCompany = invoiceCompany;
    }
    public String getInvoiceNum() {
        return invoiceNum;
    }
    public void setInvoiceNum(String invoiceNum) {
        this.invoiceNum = invoiceNum;
    }
    public String getDecideReason() {
        return decideReason;
    }
    public void setDecideReason(String decideReason) {
        this.decideReason = decideReason;
    }
	public String getExchangeStatus() {
		return exchangeStatus;
	}
	public void setExchangeStatus(String exchangeStatus) {
		this.exchangeStatus = exchangeStatus;
	}
	public String getRefoundStatus() {
		return refoundStatus;
	}
	public void setRefoundStatus(String refoundStatus) {
		this.refoundStatus = refoundStatus;
	}
	public String getRefoundAmount() {
		return refoundAmount;
	}
	public void setRefoundAmount(String refoundAmount) {
		this.refoundAmount = refoundAmount;
	}
	public String getExchangeAmount() {
		return exchangeAmount;
	}
	public void setExchangeAmount(String exchangeAmount) {
		this.exchangeAmount = exchangeAmount;
	}
	public String getExchangeID() {
		return exchangeID;
	}
	public void setExchangeID(String exchangeID) {
		this.exchangeID = exchangeID;
	}
	public String getRefoundID() {
		return refoundID;
	}
	public void setRefoundID(String refoundID) {
		this.refoundID = refoundID;
	}
    
    
}
