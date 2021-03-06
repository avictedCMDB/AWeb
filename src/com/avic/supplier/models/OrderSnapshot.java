package com.avic.supplier.models;

public class OrderSnapshot {
    private String orderId;
    private int supId;
    private String supGoodsId;
    private String goodsName;
    private String imagePath;
    private double goodsPrice;
    private int buyNum;
    private int refundStatus;
    private String goodsModel;
    
    private String brandName; 
    
    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    public int getSupId() {
        return supId;
    }
    public void setSupId(int supId) {
        this.supId = supId;
    }
    public String getSupGoodsId() {
        return supGoodsId;
    }
    public void setSupGoodsId(String supGoodsId) {
        this.supGoodsId = supGoodsId;
    }
    public String getGoodsName() {
        return goodsName;
    }
    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }
    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    public double getGoodsPrice() {
        return goodsPrice;
    }
    public void setGoodsPrice(double goodsPrice) {
        this.goodsPrice = goodsPrice;
    }
    public int getBuyNum() {
        return buyNum;
    }
    public void setBuyNum(int buyNum) {
        this.buyNum = buyNum;
    }
    public int getRefundStatus() {
        return refundStatus;
    }
    public void setRefundStatus(int refundStatus) {
        this.refundStatus = refundStatus;
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
	
}
