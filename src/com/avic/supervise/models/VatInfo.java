package com.avic.supervise.models;

import java.util.List;

public class VatInfo {
	private String id;
	private String companyName;
	private String taxpayerCode;
	private String registerPath;
	private String registerTel;
	private String bankName;
	private String bankAccount;
	private String userId;
	private String createDate;
	private String vatReceiveName;
	private String vatReceiveTel;
	private String vatReceiveProv;
	private String vatReceiveCity;
	private String vatReceiveDist;
	private String vatReceiveDetail;
	private List<ImageInfo> imgOne;
	private List<ImageInfo> imgTwo;
	private List<ImageInfo> imgThree;
	private String auditStatus;
	private String auditContent;
	private int page = 1;
	private int pageSize = 10;
	@SuppressWarnings("unused")
	private int pageFrom; // ¿ªÊ¼Êý
	@SuppressWarnings("unused")
	private int pageTo;
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageFrom() {
		return (this.page - 1) * this.pageSize + 1;
	}

	public void setPageFrom(int pageFrom) {
		this.pageFrom = pageFrom;
	}

	public int getPageTo() {
		return this.page * this.pageSize;
	}

	public void setPageTo(int pageTo) {
		this.pageTo = pageTo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getTaxpayerCode() {
		return taxpayerCode;
	}
	public void setTaxpayerCode(String taxpayerCode) {
		this.taxpayerCode = taxpayerCode;
	}
	public String getRegisterPath() {
		return registerPath;
	}
	public void setRegisterPath(String registerPath) {
		this.registerPath = registerPath;
	}
	public String getRegisterTel() {
		return registerTel;
	}
	public void setRegisterTel(String registerTel) {
		this.registerTel = registerTel;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
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
	public String getVatReceiveProv() {
		return vatReceiveProv;
	}
	public void setVatReceiveProv(String vatReceiveProv) {
		this.vatReceiveProv = vatReceiveProv;
	}
	public String getVatReceiveCity() {
		return vatReceiveCity;
	}
	public void setVatReceiveCity(String vatReceiveCity) {
		this.vatReceiveCity = vatReceiveCity;
	}
	public String getVatReceiveDist() {
		return vatReceiveDist;
	}
	public void setVatReceiveDist(String vatReceiveDist) {
		this.vatReceiveDist = vatReceiveDist;
	}
	public String getVatReceiveDetail() {
		return vatReceiveDetail;
	}
	public void setVatReceiveDetail(String vatReceiveDetail) {
		this.vatReceiveDetail = vatReceiveDetail;
	}
	public List<ImageInfo> getImgOne() {
		return imgOne;
	}
	public void setImgOne(List<ImageInfo> imgOne) {
		this.imgOne = imgOne;
	}
	public List<ImageInfo> getImgTwo() {
		return imgTwo;
	}
	public void setImgTwo(List<ImageInfo> imgTwo) {
		this.imgTwo = imgTwo;
	}
	public List<ImageInfo> getImgThree() {
		return imgThree;
	}
	public void setImgThree(List<ImageInfo> imgThree) {
		this.imgThree = imgThree;
	}

	public String getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(String auditStatus) {
		this.auditStatus = auditStatus;
	}

	public String getAuditContent() {
		return auditContent;
	}

	public void setAuditContent(String auditContent) {
		this.auditContent = auditContent;
	}
	
}
