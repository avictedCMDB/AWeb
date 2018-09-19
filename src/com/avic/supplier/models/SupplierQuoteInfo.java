package com.avic.supplier.models;

public class SupplierQuoteInfo {
	
	private String id;
	
	private String orderId;
	
	private String buyCompany;
	
	private String contactName;
	
	private String contactTel;
	
	private String contactFax;
	
	private String quoteDate;
	
	private String sendPerson;
	
	private String sendPersonTel;
	
	private String sendPersonFax;
	
	private String supId;
	
	private String fileName;
	
	private String quoteAttachmentPath;
	
	private String showQuoteAttachmentPath;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getBuyCompany() {
		return buyCompany;
	}

	public void setBuyCompany(String buyCompany) {
		this.buyCompany = buyCompany;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getContactTel() {
		return contactTel;
	}

	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}

	public String getContactFax() {
		return contactFax;
	}

	public void setContactFax(String contactFax) {
		this.contactFax = contactFax;
	}

	public String getQuoteDate() {
		return quoteDate;
	}

	public void setQuoteDate(String quoteDate) {
		this.quoteDate = quoteDate;
	}

	public String getSendPerson() {
		return sendPerson;
	}

	public void setSendPerson(String sendPerson) {
		this.sendPerson = sendPerson;
	}

	public String getSendPersonTel() {
		return sendPersonTel;
	}

	public void setSendPersonTel(String sendPersonTel) {
		this.sendPersonTel = sendPersonTel;
	}

	public String getSendPersonFax() {
		return sendPersonFax;
	}

	public void setSendPersonFax(String sendPersonFax) {
		this.sendPersonFax = sendPersonFax;
	}

	public String getSupId() {
		return supId;
	}

	public void setSupId(String supId) {
		this.supId = supId;
	}

	public String getQuoteAttachmentPath() {
		return quoteAttachmentPath;
	}

	public void setQuoteAttachmentPath(String quoteAttachmentPath) {
		this.quoteAttachmentPath = quoteAttachmentPath;
	}

	public String getShowQuoteAttachmentPath() {
		if ("".equals(quoteAttachmentPath) || quoteAttachmentPath == null) {
			return "";
		}else {
			showQuoteAttachmentPath = quoteAttachmentPath.substring(quoteAttachmentPath.lastIndexOf("/")+1,quoteAttachmentPath.length());
		}
		return showQuoteAttachmentPath;
	}

	public void setShowQuoteAttachmentPath(String showQuoteAttachmentPath) {
		this.showQuoteAttachmentPath = showQuoteAttachmentPath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}
