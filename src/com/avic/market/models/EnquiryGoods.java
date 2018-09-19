package com.avic.market.models;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class EnquiryGoods implements Serializable{
	private static final long serialVersionUID = 3581420168806725943L;
	
	private String id;						//id
    private String goodsID;					//商品ID
    private String goodsNum;				//商品购买数量
    private String goodsPriceBefore;		//商品询价前价格
    private String goodsPriceAfter;			//商品询价后价格
    private String enquiryDate;				//采购人询价时间
    private String superOfferDate;			//供应商报价后时间
    private String supID;					//供应商ID
    private String enquiryStatus;			//询价单状态（0 待供应商报价 1 供应商已报价 2 供应商拒绝报价 3 作废）
    private String contactTel;				//联系人电话
    private String priceValidDate;			//价格有效期
    private String contactName;				//联系人姓名
    private String userID;					//用户ID
    
    private String goodsName;				//商品名称
    private String goodsModel;				//商品型号
    
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
	public String getGoodsID() {
		return goodsID;
	}
	public void setGoodsID(String goodsID) {
		this.goodsID = goodsID;
	}
	public String getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(String goodsNum) {
		this.goodsNum = goodsNum;
	}
	public String getGoodsPriceBefore() {
		return goodsPriceBefore;
	}
	public void setGoodsPriceBefore(String goodsPriceBefore) {
		this.goodsPriceBefore = goodsPriceBefore;
	}
	public String getGoodsPriceAfter() {
		return goodsPriceAfter;
	}
	public void setGoodsPriceAfter(String goodsPriceAfter) {
		this.goodsPriceAfter = goodsPriceAfter;
	}
	public String getEnquiryDate() {
		return enquiryDate;
	}
	public void setEnquiryDate(String enquiryDate) {
		this.enquiryDate = enquiryDate;
	}
	public String getSuperOfferDate() {
		return superOfferDate;
	}
	public void setSuperOfferDate(String superOfferDate) {
		this.superOfferDate = superOfferDate;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getEnquiryStatus() {
		return enquiryStatus;
	}
	public void setEnquiryStatus(String enquiryStatus) {
		this.enquiryStatus = enquiryStatus;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}
	public String getPriceValidDate() {
		return priceValidDate;
	}
	public void setPriceValidDate(String priceValidDate) {
		this.priceValidDate = priceValidDate;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsModel() {
		return goodsModel;
	}
	public void setGoodsModel(String goodsModel) {
		this.goodsModel = goodsModel;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
    
}
