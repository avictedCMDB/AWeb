package com.avic.supervise.models;

public class RefundGoods {
    private String refundId;

    private String supGoodsId;

    private String supId;

    private int refundNum;

    private String refundReason;

    private String imagePath;

    private String goodsName;

    private double goodsPrice;
    private double goodsPriceInit;
    
    private int supType;
    public double getGoodsPriceInit() {
        return goodsPriceInit;
    }
    public void setGoodsPriceInit(double goodsPriceInit) {
        this.goodsPriceInit = goodsPriceInit;
    }
    public int getSupType() {
        return supType;
    }
    public void setSupType(int supType) {
        this.supType = supType;
    }

    public String getRefundId() {
        return refundId;
    }

    public void setRefundId(String refundId) {
        this.refundId = refundId;
    }

    public String getSupGoodsId() {
        return supGoodsId;
    }

    public void setSupGoodsId(String supGoodsId) {
        this.supGoodsId = supGoodsId;
    }

    public String getSupId() {
        return supId;
    }

    public void setSupId(String supId) {
        this.supId = supId;
    }

    public int getRefundNum() {
        return refundNum;
    }

    public void setRefundNum(int refundNum) {
        this.refundNum = refundNum;
    }

    public String getRefundReason() {
        return refundReason;
    }

    public void setRefundReason(String refundReason) {
        this.refundReason = refundReason;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public double getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(double goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

}