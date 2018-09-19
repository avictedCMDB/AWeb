package com.avic.management.models;

import java.io.Serializable;

public class QuoteDetail implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;							//id
	private String quoteID;						//需求单ID
	private String supID;					    //供应商ID
	private String goodsID;						//商品ID
	private String quoteNum;					//报价单数量
	
	private String goodsModel;					//商品型号
	private String brandName;					//商品规格
	private String goodsName;					//商品名称
	private String goodsStuff;					//商品材质
	private String salePrice;					//商品价格
	private String priceAll;					//单项商品总价
	public String getPriceAll() {
		return priceAll;
	}
	public void setPriceAll(String priceAll) {
		this.priceAll = priceAll;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getQuoteID() {
		return quoteID;
	}
	public void setQuoteID(String quoteID) {
		this.quoteID = quoteID;
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
	public String getQuoteNum() {
		return quoteNum;
	}
	public void setQuoteNum(String quoteNum) {
		this.quoteNum = quoteNum;
	}
	public String getGoodsModel() {
		return goodsModel;
	}
	public void setGoodsModel(String goodsModel) {
		this.goodsModel = goodsModel;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsStuff() {
		return goodsStuff;
	}
	public void setGoodsStuff(String goodsStuff) {
		this.goodsStuff = goodsStuff;
	}
	public String getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}
	
	
}
