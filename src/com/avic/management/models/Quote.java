package com.avic.management.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @author samsung
 *
 */
public class Quote implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;							//id
	private String orderID;						//订单ID
	private String buyCompany;					//采购单位名称
	private String contactName;					//采购联系人
	private String contactTel;					//采购电话
	private String contactFax;					//采购传真
	private String quoteDate;					//报价日期
	private String sendPerson;					//发件人
	private String sendPersonTel;				//发件人电话
	private String sendPersonFax;				//发件人传真
	private String supID;						//供应商ID
	private String qupteAttachmentPath;			//报价单上传地址
	private String supName;
	private String fileName;
	private String requireID;
	
	private List<String> fileNames = new ArrayList<String>();
	private List<String> paths = new ArrayList<String>();
	
	private List<QuoteDetail> quoteDetails = new ArrayList<QuoteDetail>();
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderID() {
		return orderID;
	}
	public void setOrderID(String orderID) {
		this.orderID = orderID;
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
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getQupteAttachmentPath() {
		return qupteAttachmentPath;
	}
	public void setQupteAttachmentPath(String qupteAttachmentPath) {
		this.qupteAttachmentPath = qupteAttachmentPath;
	}
	public String getSupName() {
		return supName;
	}
	public void setSupName(String supName) {
		this.supName = supName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getRequireID() {
		return requireID;
	}
	public void setRequireID(String requireID) {
		this.requireID = requireID;
	}
	public List<QuoteDetail> getQuoteDetails() {
		return quoteDetails;
	}
	public void setQuoteDetails(List<QuoteDetail> quoteDetails) {
		this.quoteDetails = quoteDetails;
	}
	public List<String> getFileNames() {
		return fileNames;
	}
	public void setFileNames(List<String> fileNames) {
		this.fileNames = fileNames;
	}
	public List<String> getPaths() {
		return paths;
	}
	public void setPaths(List<String> paths) {
		this.paths = paths;
	}
	
	
	
}
