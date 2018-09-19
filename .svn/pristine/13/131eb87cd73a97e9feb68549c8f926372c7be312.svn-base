package com.avic.management.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Exchange implements Serializable{
	private static final long serialVersionUID = 1L;
	private String exchangeID;			//换货单ID
	private String supID;				//供应商ID
	private String exchangeTime;		//采购员提交换货时间
	private String supCheckDate;		//供应商审核时间
	private String exchangeStatus;		//0 待供应商确认，1 通过 2 拒绝
	private String remark;				//备注
	private String supSendDate;			//供应商发货时间
	private String supReviewDate;		//供应商收货时间
	private String buyerSendDate;		//采购方发货时间
	private String orderID;				//订单ID
	private String buyReviewDate;		//采购方确认收货时间
	private String exchangeAmount;		//换货单商品数量
	private String exchangePrice;		//换货单商品总价格
	private String userID;				//用户ID
	private String supName;				//供应商名称
	private String exchangeStatusName;	//换货单状态名
	private String companyName;			//公司名
	private String addrName;			//收货人姓名
	private String addrPhone;			//收货人电话
	private String areaOne;
	private String areaTwo;
	private String areaThree;
	private String areaFour;
	private String supAddressDetail;
	private String exchangeExpressName;
	private String exchangeExpressCode;
	private String exchangeExpressNameSup;
	private String exchangeExpressCodeSup;
	private int orderStatus;			
	private String expressType;   //物流类型
	
	private List<OrderSnapshot> orderSnapshots = new ArrayList<OrderSnapshot>();
	
	private String startTime;
	private String endTime;
	private String searchExchangeID;
	private String searchSupName;
	private String searchOrderID;
	private String searchExchangeStatus;
	private List<String> searchOrderStatus = new ArrayList<String>();
	
	
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
	public String getExchangeID() {
		return exchangeID;
	}
	public void setExchangeID(String exchangeID) {
		this.exchangeID = exchangeID;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getExchangeTime() {
		return exchangeTime;
	}
	public void setExchangeTime(String exchangeTime) {
		this.exchangeTime = exchangeTime;
	}
	public String getSupCheckDate() {
		return supCheckDate;
	}
	public void setSupCheckDate(String supCheckDate) {
		this.supCheckDate = supCheckDate;
	}
	public String getExchangeStatus() {
		return exchangeStatus;
	}
	public void setExchangeStatus(String exchangeStatus) {
		this.exchangeStatus = exchangeStatus;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSupSendDate() {
		return supSendDate;
	}
	public void setSupSendDate(String supSendDate) {
		this.supSendDate = supSendDate;
	}
	public String getSupReviewDate() {
		return supReviewDate;
	}
	public void setSupReviewDate(String supReviewDate) {
		this.supReviewDate = supReviewDate;
	}
	public String getBuyerSendDate() {
		return buyerSendDate;
	}
	public void setBuyerSendDate(String buyerSendDate) {
		this.buyerSendDate = buyerSendDate;
	}
	public String getOrderID() {
		return orderID;
	}
	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}
	public String getBuyReviewDate() {
		return buyReviewDate;
	}
	public void setBuyReviewDate(String buyReviewDate) {
		this.buyReviewDate = buyReviewDate;
	}
	public String getExchangeAmount() {
		return exchangeAmount;
	}
	public void setExchangeAmount(String exchangeAmount) {
		this.exchangeAmount = exchangeAmount;
	}
	public String getExchangePrice() {
		return exchangePrice;
	}
	public void setExchangePrice(String exchangePrice) {
		this.exchangePrice = exchangePrice;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getSupName() {
		return supName;
	}
	public void setSupName(String supName) {
		this.supName = supName;
	}
	public String getExchangeStatusName() {
		return exchangeStatusName;
	}
	public void setExchangeStatusName(String exchangeStatusName) {
		this.exchangeStatusName = exchangeStatusName;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getSearchExchangeID() {
		return searchExchangeID;
	}
	public void setSearchExchangeID(String searchExchangeID) {
		this.searchExchangeID = searchExchangeID;
	}
	public String getSearchSupName() {
		return searchSupName;
	}
	public void setSearchSupName(String searchSupName) {
		this.searchSupName = searchSupName;
	}
	public String getSearchOrderID() {
		return searchOrderID;
	}
	public void setSearchOrderID(String searchOrderID) {
		this.searchOrderID = searchOrderID;
	}
	public List<String> getSearchOrderStatus() {
		return searchOrderStatus;
	}
	public void setSearchOrderStatus(List<String> searchOrderStatus) {
		this.searchOrderStatus = searchOrderStatus;
	}
	public String getSearchExchangeStatus() {
		return searchExchangeStatus;
	}
	public void setSearchExchangeStatus(String searchExchangeStatus) {
		this.searchExchangeStatus = searchExchangeStatus;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAddrName() {
		return addrName;
	}
	public void setAddrName(String addrName) {
		this.addrName = addrName;
	}
	public String getAddrPhone() {
		return addrPhone;
	}
	public void setAddrPhone(String addrPhone) {
		this.addrPhone = addrPhone;
	}
	public List<OrderSnapshot> getOrderSnapshots() {
		return orderSnapshots;
	}
	public void setOrderSnapshots(List<OrderSnapshot> orderSnapshots) {
		this.orderSnapshots = orderSnapshots;
	}
	public String getAreaOne() {
		return areaOne;
	}
	public void setAreaOne(String areaOne) {
		this.areaOne = areaOne;
	}
	public String getAreaTwo() {
		return areaTwo;
	}
	public void setAreaTwo(String areaTwo) {
		this.areaTwo = areaTwo;
	}
	public String getAreaThree() {
		return areaThree;
	}
	public void setAreaThree(String areaThree) {
		this.areaThree = areaThree;
	}
	public String getSupAddressDetail() {
		return supAddressDetail;
	}
	public void setSupAddressDetail(String supAddressDetail) {
		this.supAddressDetail = supAddressDetail;
	}
	public String getExchangeExpressName() {
		return exchangeExpressName;
	}
	public void setExchangeExpressName(String exchangeExpressName) {
		this.exchangeExpressName = exchangeExpressName;
	}
	public String getExchangeExpressCode() {
		return exchangeExpressCode;
	}
	public void setExchangeExpressCode(String exchangeExpressCode) {
		this.exchangeExpressCode = exchangeExpressCode;
	}
	public int getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getAreaFour() {
		return areaFour;
	}
	public void setAreaFour(String areaFour) {
		this.areaFour = areaFour;
	}
	public String getExchangeExpressNameSup() {
		return exchangeExpressNameSup;
	}
	public void setExchangeExpressNameSup(String exchangeExpressNameSup) {
		this.exchangeExpressNameSup = exchangeExpressNameSup;
	}
	public String getExchangeExpressCodeSup() {
		return exchangeExpressCodeSup;
	}
	public void setExchangeExpressCodeSup(String exchangeExpressCodeSup) {
		this.exchangeExpressCodeSup = exchangeExpressCodeSup;
	}
	public String getExpressType() {
		return expressType;
	}
	public void setExpressType(String expressType) {
		this.expressType = expressType;
	}
	
}
