package com.avic.management.models;

import java.io.Serializable;
import java.util.List;

public class SupInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	private String supID;			//供应商ID
	private String supName;			//供应商名
	private String authUser;		//用户名
	private String authPass;		//用户密码
	private String companyCode;		//企业code
	private String supType;
	private String contactNum;
	private String contactPerson;
	private String email;
    private String supCode;
    private String address;
	
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
	private List<String> supIDS;
	
	public String getSupCode() {
        return supCode;
    }
	public void setSupCode(String supCode) {
        this.supCode = supCode;
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
    public String getContactNum() {
		return contactNum;
	}
	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	
	public List<String> getSupIDS() {
		return supIDS;
	}
	public void setSupIDS(List<String> supIDS) {
		this.supIDS = supIDS;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getSupName() {
		return supName;
	}
	public void setSupName(String supName) {
		this.supName = supName;
	}
	public String getAuthUser() {
		return authUser;
	}
	public void setAuthUser(String authUser) {
		this.authUser = authUser;
	}
	public String getAuthPass() {
		return authPass;
	}
	public void setAuthPass(String authPass) {
		this.authPass = authPass;
	}
	public String getCompanyCode() {
		return companyCode;
	}
	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	public String getSupType() {
		return supType;
	}
	public void setSupType(String supType) {
		this.supType = supType;
	}
	
	
}
