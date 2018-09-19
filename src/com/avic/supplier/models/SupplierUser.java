package com.avic.supplier.models;

import java.io.Serializable;

public class SupplierUser implements Serializable{
	private static final long serialVersionUID = 1L;
	private String supId;
	
	private String supName;
	
	private String supPassword;
	
	private String supUsernamecn;
	
	private String supEnabled;
	
	private String supType;
	
	private String contactNum;
	
	private String supCode;
	
	
	String userId;
    String address;
    String companyName;
    String contactFax;
    String responsibleName;
    String responsibleMobile;
    String ifCheck;
    
    private String errorMsg;
	
	public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
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
    public String getContactFax() {
        return contactFax;
    }
    public void setContactFax(String contactFax) {
        this.contactFax = contactFax;
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
    public String getSupCode() {
        return supCode;
    }
	public void setSupCode(String supCode) {
        this.supCode = supCode;
    }

	public String getSupId() {
		return supId;
	}

	public void setSupId(String supId) {
		this.supId = supId;
	}

	public String getSupName() {
		return supName;
	}

	public void setSupName(String supName) {
		this.supName = supName;
	}

	public String getSupPassword() {
		return supPassword;
	}

	public void setSupPassword(String supPassword) {
		this.supPassword = supPassword;
	}

	public String getSupUsernamecn() {
		return supUsernamecn;
	}

	public void setSupUsernamecn(String supUsernamecn) {
		this.supUsernamecn = supUsernamecn;
	}

	public String getSupEnabled() {
		return supEnabled;
	}

	public void setSupEnabled(String supEnabled) {
		this.supEnabled = supEnabled;
	}

	public String getSupType() {
		return supType;
	}

	public void setSupType(String supType) {
		this.supType = supType;
	}

	public String getContactNum() {
		return contactNum;
	}

	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	public String getIfCheck() {
		return ifCheck;
	}
	public void setIfCheck(String ifCheck) {
		this.ifCheck = ifCheck;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
}
