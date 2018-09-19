package com.avic.supervise.models;

public class EnterpriseSupMapping {
	
	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String companyId;
	
	private String supInfoId;
	
	private String ifBuilding;
	
	private String joinDate;
	
	private String supName;
	
	private String companyName;
	
	private String searchSupName;
	
	private String supDate;
	
	private String contactPerson;
	
	private String contactNum;
	
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getSupInfoId() {
		return supInfoId;
	}

	public void setSupInfoId(String supInfoId) {
		this.supInfoId = supInfoId;
	}

	public String getIfBuilding() {
		return ifBuilding;
	}

	public void setIfBuilding(String ifBuilding) {
		this.ifBuilding = ifBuilding;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getSupName() {
		return supName;
	}

	public void setSupName(String supName) {
		this.supName = supName;
	}

	public String getSupDate() {
		return supDate;
	}

	public void setSupDate(String supDate) {
		this.supDate = supDate;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getContactNum() {
		return contactNum;
	}
	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	public String getSearchSupName() {
		return searchSupName;
	}
	public void setSearchSupName(String searchSupName) {
		this.searchSupName = searchSupName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	

}
