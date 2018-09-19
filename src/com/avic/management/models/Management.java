package com.avic.management.models;

import java.io.Serializable;

public class Management implements Serializable{
	private static final long serialVersionUID = 1L;
	private int waitOrderCount;			//订单带收货数量
	private int checkOrderCount;			//订单待审核数量
	private int waitPayOrderCount;		//订单待支付数量
	private int waitPayOrderCountB2B;		//订单待支付数量
	private int rejectOrderCount;		//订单已拒绝数量
	private int returnOrderCount;		//订单已退货数量
	private int changeOrderCount;		//订单已换货数量
	private int rejectRefoundCount;		//退货单已退回数量
	private int rejectExchangeCount;	//换货单已退回数量
	private int enquiryGoodsCount;		//询价商品供应商已报价数量
	private int offStandardRequireCount;//非标商品供应商已提供数量
	private String userID;
	private String enquiryStatus;		//询价商品状态
	private String status;				//非标商品状态
	private String companyId;				//企业id
	
	public int getWaitPayOrderCountB2B() {
		return waitPayOrderCountB2B;
	}
	public void setWaitPayOrderCountB2B(int waitPayOrderCountB2B) {
		this.waitPayOrderCountB2B = waitPayOrderCountB2B;
	}
	public int getCheckOrderCount() {
		return checkOrderCount;
	}
	public void setCheckOrderCount(int checkOrderCount) {
		this.checkOrderCount = checkOrderCount;
	}	
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getWaitOrderCount() {
		return waitOrderCount;
	}
	public void setWaitOrderCount(int waitOrderCount) {
		this.waitOrderCount = waitOrderCount;
	}
	public int getRejectOrderCount() {
		return rejectOrderCount;
	}
	public void setRejectOrderCount(int rejectOrderCount) {
		this.rejectOrderCount = rejectOrderCount;
	}
	public int getReturnOrderCount() {
		return returnOrderCount;
	}
	public void setReturnOrderCount(int returnOrderCount) {
		this.returnOrderCount = returnOrderCount;
	}
	public int getChangeOrderCount() {
		return changeOrderCount;
	}
	public void setChangeOrderCount(int changeOrderCount) {
		this.changeOrderCount = changeOrderCount;
	}
	public int getRejectRefoundCount() {
		return rejectRefoundCount;
	}
	public void setRejectRefoundCount(int rejectRefoundCount) {
		this.rejectRefoundCount = rejectRefoundCount;
	}
	public int getRejectExchangeCount() {
		return rejectExchangeCount;
	}
	public void setRejectExchangeCount(int rejectExchangeCount) {
		this.rejectExchangeCount = rejectExchangeCount;
	}
	public int getWaitPayOrderCount() {
		return waitPayOrderCount;
	}
	public void setWaitPayOrderCount(int waitPayOrderCount) {
		this.waitPayOrderCount = waitPayOrderCount;
	}
	public int getEnquiryGoodsCount() {
		return enquiryGoodsCount;
	}
	public void setEnquiryGoodsCount(int enquiryGoodsCount) {
		this.enquiryGoodsCount = enquiryGoodsCount;
	}
	public int getOffStandardRequireCount() {
		return offStandardRequireCount;
	}
	public void setOffStandardRequireCount(int offStandardRequireCount) {
		this.offStandardRequireCount = offStandardRequireCount;
	}
	public String getEnquiryStatus() {
		return enquiryStatus;
	}
	public void setEnquiryStatus(String enquiryStatus) {
		this.enquiryStatus = enquiryStatus;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}