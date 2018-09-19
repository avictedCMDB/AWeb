package com.avic.management.models;

import java.io.Serializable;

public class User implements Serializable{
	private static final long serialVersionUID = 1L;
	private String userName;
	private String password;
	private String userID;
	
	String address;
	String companyName;
	String contactNum;
	String contactFax;
	String responsibleName;
	String responsibleMobile;
	String contactPerson;
	String contactIphone;
	String organizationCode;
	
	
	public String getOrganizationCode() {
        return organizationCode;
    }
	public void setOrganizationCode(String organizationCode) {
        this.organizationCode = organizationCode;
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
	public String getResponsibleName() {
        return responsibleName;
    }
    public void setResponsibleName(String responsibleName) {
        this.responsibleName = responsibleName;
    }
    public String getResponsibleMobile() {
        return responsibleMobile;
    }
    public void setResponsibleMobile(String responsibleMobile) {
        this.responsibleMobile = responsibleMobile;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
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
    public String getContactFax() {
        return contactFax;
    }
    public void setContactFax(String contactFax) {
        this.contactFax = contactFax;
    }
    public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	
}