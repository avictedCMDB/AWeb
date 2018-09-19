package com.avic.supplier.models;

public class SupplierGoodsImage {
    private int supId;
    private String supGoodsId;
    private String imagePath;
    private int showOrder;
    private String businessType;
    private String businessId;
    private String url;
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
    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    public int getShowOrder() {
        return showOrder;
    }
    public void setShowOrder(int showOrder) {
        this.showOrder = showOrder;
    }
	public String getBusinessType() {
		return businessType;
	}
	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
    
}
