package com.avic.supervise.models;

import java.io.Serializable;

public class Company implements Serializable{
	private static final long serialVersionUID = -7755142517962013334L;
	private String companyMappingID;
	private String companyID;
    private String companyName;
    private String contactNum;
    private String supID;
    
    private int page = 1;
	private int pageSize = 10;
	private int pageFrom ;				//开始数
	private int pageTo;					//结束数
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
		return (this.page-1)*this.pageSize+1;
	}
	public void setPageFrom(int pageFrom) {
		this.pageFrom = pageFrom;
	}
	public int getPageTo() {
		return this.page*this.pageSize;
	}
	public void setPageTo(int pageTo) {
		this.pageTo = pageTo;
	}
	public String getCompanyID() {
		return companyID;
	}
	public void setCompanyID(String companyID) {
		this.companyID = companyID;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getContactNum() {
		return contactNum;
	}
	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getCompanyMappingID() {
		return companyMappingID;
	}
	public void setCompanyMappingID(String companyMappingID) {
		this.companyMappingID = companyMappingID;
	}
    
}
