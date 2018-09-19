package com.avic.supplier.models;

import java.util.List;

import com.avic.supplier.utils.BaseModels;

public class SupplierOffStandRequire extends BaseModels{
	
	private String id;
	
	private String goodsDescNew;
	
	private String supId;
	
	private String status;
	
	private String userId;
	
	private String createDate;
	
	private String goodsId;
	
	private String createDateStar;
	
	private String createDateEnd;
	
	private String closeDateStar;
	
	private String closeDateEnd;
	
	private String companyname;
	
	private String quotePath;
	
	private String showQuotePath;
	
	private String filePath;
	
	private String fileName;
	
	private String usernamecn;
	private String contactNum;
	
	private String goodsName;
	private String isRelease;
	private String isReleaseName;
	private String cancelReason;
	private String closeDate;
	
	private List<SupplierImageInfo>  imageList;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGoodsDescNew() {
		return goodsDescNew;
	}

	public void setGoodsDescNew(String goodsDescNew) {
		this.goodsDescNew = goodsDescNew;
	}

	public String getSupId() {
		return supId;
	}

	public void setSupId(String supId) {
		this.supId = supId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateDateStar() {
		return createDateStar;
	}

	public void setCreateDateStar(String createDateStar) {
		this.createDateStar = createDateStar;
	}

	public String getCreateDateEnd() {
		return createDateEnd;
	}

	public void setCreateDateEnd(String createDateEnd) {
		this.createDateEnd = createDateEnd;
	}

	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public List<SupplierImageInfo> getImageList() {
		return imageList;
	}

	public void setImageList(List<SupplierImageInfo> imageList) {
		this.imageList = imageList;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public String getQuotePath() {
		return quotePath;
	}

	public void setQuotePath(String quotePath) {
		this.quotePath = quotePath;
	}

	public String getShowQuotePath() {
		if ("".equals(quotePath) || quotePath == null) {
			return "";
		}else {
			showQuotePath = quotePath.substring(quotePath.lastIndexOf("/")+1,quotePath.length());
		}
		return showQuotePath;
	}

	public void setShowQuotePath(String showQuotePath) {
		this.showQuotePath = showQuotePath;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUsernamecn() {
		return usernamecn;
	}

	public void setUsernamecn(String usernamecn) {
		this.usernamecn = usernamecn;
	}

	public String getContactNum() {
		return contactNum;
	}

	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
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

	public String getIsReleaseName() {
		if ("0".equals(this.isRelease)) {
			isReleaseName = "非公开";
		}else {
			isReleaseName = "公开";
		}
		return isReleaseName;
	}

	public void setIsReleaseName(String isReleaseName) {
		this.isReleaseName = isReleaseName;
	}

	public String getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}

	public String getCloseDateStar() {
		return closeDateStar;
	}

	public void setCloseDateStar(String closeDateStar) {
		this.closeDateStar = closeDateStar;
	}

	public String getCloseDateEnd() {
		return closeDateEnd;
	}

	public void setCloseDateEnd(String closeDateEnd) {
		this.closeDateEnd = closeDateEnd;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	
}
