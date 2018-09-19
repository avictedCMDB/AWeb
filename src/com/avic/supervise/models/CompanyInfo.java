package com.avic.supervise.models;

import java.util.ArrayList;
import java.util.List;

public class CompanyInfo {
    private String id;
    private String companyCode;
    private String companyName;
    private String createDate;
    private String createUser;
    private String parentCompanyId;
    private String ifCheck;
    private String companyType;
    private String contactPerson;
    private String contactIphone;
    private String contactEmail;
    private String userName;
    private String timeStart;
    private String timeEnd;
    private String level;
    private String searCompanyCode;
    private String contactFax;
    private String supID;
    
    private List<CompanyInfo> childDepartments = new ArrayList<CompanyInfo>();
    
    public List<CompanyInfo> getChildDepartments() {
		return childDepartments;
	}
	public void setChildDepartments(List<CompanyInfo> childDepartments) {
		this.childDepartments = childDepartments;
	}
	public String getTimeStart() {
		return timeStart;
	}
	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}
	public String getTimeEnd() {
		return timeEnd;
	}
	public void setTimeEnd(String timeEnd) {
		this.timeEnd = timeEnd;
	}
	public String getParentCompanyId() {
		return parentCompanyId;
	}
	public void setParentCompanyId(String parentCompanyId) {
		this.parentCompanyId = parentCompanyId;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	private int page = 1;
	private int pageSize = 10;
	@SuppressWarnings("unused")
	private int pageFrom ;				//开始数
	@SuppressWarnings("unused")
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
	public String getCompanyCode() {
		return companyCode;
	}
	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getIfCheck() {
		return ifCheck;
	}
	public void setIfCheck(String ifCheck) {
		this.ifCheck = ifCheck;
	}
	public String getCompanyType() {
		return companyType;
	}
	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}
	public String getContactPerson() {
		return contactPerson;
	}
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}
	public String getContactIphone() {
		return contactIphone;
	}
	public void setContactIphone(String contactIphone) {
		this.contactIphone = contactIphone;
	}
	public String getContactEmail() {
		return contactEmail;
	}
	public void setContactEmail(String contactEmail) {
		this.contactEmail = contactEmail;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getSearCompanyCode() {
		return searCompanyCode;
	}
	public void setSearCompanyCode(String searCompanyCode) {
		this.searCompanyCode = searCompanyCode;
	}
	public String getContactFax() {
		return contactFax;
	}
	public void setContactFax(String contactFax) {
		this.contactFax = contactFax;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}    
	
}
