package com.avic.management.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class OffStandardRequire implements Serializable{
	private static final long serialVersionUID = 1L;
	private String ID;						
	private String goodsDescNew;			//商品描述
	private String supID;					//供应商ID
	private String goodsID;					//商品ID
	private String status;					//0 待供应商确认 1 供应商已提供
	private String userID;
	private String createDate;
	private String quotePath;
	private String goodsName;
	private String isRelease;
	private String closeDate;
	private List<AuditImageInfo> auditImageInfos = new ArrayList<AuditImageInfo>();
	private List<SupInfo> supInfos = new ArrayList<SupInfo>();
	private List<String> goodsIDS;
	private List<String> supIDS;
	private String cancelReason;
	private String beginDate;
	private String endDate;
	
	private String supIDSNames;
	
	private String imgCount;
	private String imgPaths;
	
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
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getGoodsDescNew() {
		return goodsDescNew;
	}
	public void setGoodsDescNew(String goodsDescNew) {
		this.goodsDescNew = goodsDescNew;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getGoodsID() {
		return goodsID;
	}
	public void setGoodsID(String goodsID) {
		this.goodsID = goodsID;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public List<String> getSupIDS() {
		return supIDS;
	}
	public void setSupIDS(List<String> supIDS) {
		this.supIDS = supIDS;
	}
	public List<AuditImageInfo> getAuditImageInfos() {
		return auditImageInfos;
	}
	public void setAuditImageInfos(List<AuditImageInfo> auditImageInfos) {
		this.auditImageInfos = auditImageInfos;
	}
	public List<SupInfo> getSupInfos() {
		return supInfos;
	}
	public void setSupInfos(List<SupInfo> supInfos) {
		this.supInfos = supInfos;
	}
	public List<String> getGoodsIDS() {
		return goodsIDS;
	}
	public void setGoodsIDS(List<String> goodsIDS) {
		this.goodsIDS = goodsIDS;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getQuotePath() {
		return quotePath;
	}
	public void setQuotePath(String quotePath) {
		this.quotePath = quotePath;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getIsRelease() {
		return isRelease;
	}
	public void setIsRelease(String isRelease) {
		this.isRelease = isRelease;
	}
	public String getCloseDate() {
		return closeDate;
	}
	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	public String getImgCount() {
		return imgCount;
	}
	public void setImgCount(String imgCount) {
		this.imgCount = imgCount;
	}
	public String getImgPaths() {
		return imgPaths;
	}
	public void setImgPaths(String imgPaths) {
		this.imgPaths = imgPaths;
	}
	public String getSupIDSNames() {
		return supIDSNames;
	}
	public void setSupIDSNames(String supIDSNames) {
		this.supIDSNames = supIDSNames;
	}
	
}
