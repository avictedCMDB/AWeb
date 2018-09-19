package com.avic.supplier.models;

import java.io.Serializable;

public class SupArea implements Serializable{
	private static final long serialVersionUID = 1L;
	private String supAreaID;			//合作平台区域编号
	private String supAreaName;			//合作平台区域名称
	private String supAreaLevel;		//合作平台区域等级
	private String supParentArea;		//上级区域
	private String supID;				//合作平台编号
	private String supType;
	public String getSupAreaID() {
		return supAreaID;
	}
	public void setSupAreaID(String supAreaID) {
		this.supAreaID = supAreaID;
	}
	public String getSupAreaName() {
		return supAreaName;
	}
	public void setSupAreaName(String supAreaName) {
		this.supAreaName = supAreaName;
	}
	public String getSupAreaLevel() {
		return supAreaLevel;
	}
	public void setSupAreaLevel(String supAreaLevel) {
		this.supAreaLevel = supAreaLevel;
	}
	public String getSupParentArea() {
		return supParentArea;
	}
	public void setSupParentArea(String supParentArea) {
		this.supParentArea = supParentArea;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getSupType() {
		return supType;
	}
	public void setSupType(String supType) {
		this.supType = supType;
	}
	
}
