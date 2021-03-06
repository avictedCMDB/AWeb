package com.avic.management.models;

import java.io.Serializable;

public class AuditImageInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;				//图片id
	private String businessID;		//业务id orderid
	private String businessType;	//业务类型 6审核
	private String url;				//图片路径
	private String fileName;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBusinessID() {
		return businessID;
	}
	public void setBusinessID(String businessID) {
		this.businessID = businessID;
	}
	public String getBusinessType() {
		return businessType;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	
	
}
