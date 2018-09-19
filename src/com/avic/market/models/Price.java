package com.avic.market.models;

public class Price {
    private int supId;
    private String supGoodsId;
    private double salePrice;
    private double countPrice;
    private double agreePrice;
    private double businessPrice;
    
    public double getBusinessPrice() {
        return businessPrice;
    }
    public void setBusinessPrice(double businessPrice) {
        this.businessPrice = businessPrice;
    }
    public double getSalePrice() {
        return salePrice;
    }
    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }
    public double getCountPrice() {
        return countPrice;
    }
    public void setCountPrice(double countPrice) {
        this.countPrice = countPrice;
    }
    public double getAgreePrice() {
        return agreePrice;
    }
    public void setAgreePrice(double agreePrice) {
        this.agreePrice = agreePrice;
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
    
    
}
