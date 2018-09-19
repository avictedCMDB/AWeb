package com.avic.market.models;

import java.io.Serializable;

public class CompareItem implements Serializable{
	private static final long serialVersionUID = 1L;
	//private static final long serialVersionUID = 1L;
    private int sysCatId;
    private int supId;
    private String supGoodsId;
    private String goodsName;
    private String imagePath;
    private double agreePrice;
    private int supType;
    
    public int getSupType() {
        return supType;
    }
    public void setSupType(int supType) {
        this.supType = supType;
    }
    public int getSysCatId() {
        return sysCatId;
    }
    public void setSysCatId(int sysCatId) {
        this.sysCatId = sysCatId;
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
    public double getAgreePrice() {
        return agreePrice;
    }
    public void setAgreePrice(double agreePrice) {
        this.agreePrice = agreePrice;
    }
    
    
}
