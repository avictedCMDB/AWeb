package com.avic.management.models;

import java.io.Serializable;

public class AuditImageInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;				//ͼƬid
	private String businessID;		//ҵ��id orderid
	private String businessType;	//ҵ������ 6���
	private String url;				//ͼƬ·��
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