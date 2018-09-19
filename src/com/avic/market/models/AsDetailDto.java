package com.avic.market.models;
/**
 *申请单明细
 */
public class AsDetailDto {
    private String skuId;		//商品编号
    private String skuNum;		//申请数量
	public String getSkuId() {
		return skuId;
	}
	public void setSkuId(String skuId) {
		this.skuId = skuId;
	}
	public String getSkuNum() {
		return skuNum;
	}
	public void setSkuNum(String skuNum) {
		this.skuNum = skuNum;
	}

    
}
