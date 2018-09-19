package com.avic.management.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Refound implements Serializable{
	private static final long serialVersionUID = 1L;
	private String refoundID;			//退货单ID
	private String orderID;				//订单ID
	private String supID;				//供应商ID
	private String refoundStatus;		//0 待供应商确认，1 通过 2 拒绝 3,供应商待收货 4,供应商已收货
	private String refoundDate;			//采购方提交退货时间
	private String refoundSendDate;				//采购方发货时间
	private String supReviewDate;			//供应商收货时间
	private String refoundAmount;		//退货总数量
	private String refoundPrice;		//退货金额
	private String userID;				//用户ID
	private String remark;				//备注
	private String supCheckDate;		//供应商审核时间
	private String supCheckInfo;		//供应商审核意见
	private String supAddressID;				//供应商收货地址ID
	
	private String supName;				//供应商名称
	private String refoundStatusName;	//退货单状态名
	private String companyName;			//公司名
	private String addrName;			//收货人姓名
	private String addrPhone;			//收货人电话
	private String areaOne;
	private String areaTwo;
	private String areaThree;
	private String areaFour;
	private String supAddressDetail;
	private String refoundExpressName;
	private String refoundExpressCode;
	private String refoundExpressNameSup;
	private String refoundExpressCodeSup;
	private int orderStatus;			
	private String expressType;
	
	private List<OrderSnapshot> orderSnapshots = new ArrayList<OrderSnapshot>();
	
	private String startTime;
	private String endTime;
	private String searchRefoundID;
	private String searchSupName;
	private String searchOrderID;
	private String searchRefoundStatus;
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
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getSupCheckDate() {
		return supCheckDate;
	}
	public void setSupCheckDate(String supCheckDate) {
		this.supCheckDate = supCheckDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSupReviewDate() {
		return supReviewDate;
	}
	public void setSupReviewDate(String supReviewDate) {
		this.supReviewDate = supReviewDate;
	}
	public String getOrderID() {
		return orderID;
	}
	public void setOrderID(String orderID) {
		this.orderID = orderID;
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
	public String getRefoundID() {
		return refoundID;
	}
	public void setRefoundID(String refoundID) {
		this.refoundID = refoundID;
	}
	public String getRefoundStatus() {
		return refoundStatus;
	}
	public void setRefoundStatus(String refoundStatus) {
		this.refoundStatus = refoundStatus;
	}
	public String getRefoundDate() {
		return refoundDate;
	}
	public void setRefoundDate(String refoundDate) {
		this.refoundDate = refoundDate;
	}
	public String getRefoundSendDate() {
		return refoundSendDate;
	}
	public void setRefoundSendDate(String refoundSendDate) {
		this.refoundSendDate = refoundSendDate;
	}
	public String getRefoundAmount() {
		return refoundAmount;
	}
	public void setRefoundAmount(String refoundAmount) {
		this.refoundAmount = refoundAmount;
	}
	public String getRefoundPrice() {
		return refoundPrice;
	}
	public void setRefoundPrice(String refoundPrice) {
		this.refoundPrice = refoundPrice;
	}
	public String getSupCheckInfo() {
		return supCheckInfo;
	}
	public void setSupCheckInfo(String supCheckInfo) {
		this.supCheckInfo = supCheckInfo;
	}
	public String getSupAddressID() {
		return supAddressID;
	}
	public void setSupAddressID(String supAddressID) {
		this.supAddressID = supAddressID;
	}
	public String getRefoundStatusName() {
		return refoundStatusName;
	}
	public void setRefoundStatusName(String refoundStatusName) {
		this.refoundStatusName = refoundStatusName;
	}
	public String getRefoundExpressName() {
		return refoundExpressName;
	}
	public void setRefoundExpressName(String refoundExpressName) {
		this.refoundExpressName = refoundExpressName;
	}
	public String getRefoundExpressCode() {
		return refoundExpressCode;
	}
	public void setRefoundExpressCode(String refoundExpressCode) {
		this.refoundExpressCode = refoundExpressCode;
	}
	
	public List<OrderSnapshot> getOrderSnapshots() {
		return orderSnapshots;
	}
	public void setOrderSnapshots(List<OrderSnapshot> orderSnapshots) {
		this.orderSnapshots = orderSnapshots;
	}
	public String getSearchRefoundID() {
		return searchRefoundID;
	}
	public void setSearchRefoundID(String searchRefoundID) {
		this.searchRefoundID = searchRefoundID;
	}
	public String getSearchRefoundStatus() {
		return searchRefoundStatus;
	}
	public void setSearchRefoundStatus(String searchRefoundStatus) {
		this.searchRefoundStatus = searchRefoundStatus;
	}
	public String getRefoundExpressNameSup() {
		return refoundExpressNameSup;
	}
	public void setRefoundExpressNameSup(String refoundExpressNameSup) {
		this.refoundExpressNameSup = refoundExpressNameSup;
	}
	public String getRefoundExpressCodeSup() {
		return refoundExpressCodeSup;
	}
	public void setRefoundExpressCodeSup(String refoundExpressCodeSup) {
		this.refoundExpressCodeSup = refoundExpressCodeSup;
	}
	public String getExpressType() {
		return expressType;
	}
	public void setExpressType(String expressType) {
		this.expressType = expressType;
	}
	
}
