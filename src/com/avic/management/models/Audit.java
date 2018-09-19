package com.avic.management.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Audit implements Serializable{
	private static final long serialVersionUID = 1L;
	private String orderID;				//订单id
	private String supID;				//供应商id
	private String orderTime;			//下单时间
	private String orderStatus;			//订单状态
	private String supName;				//供应商名
	private String orderStatusName;		//订单状态名 
	private String goodsAmount;			//总金额
	private String companyID;			//公司id
	private String reviewPerson;
	
	private String searchSupName;		//查询条件 供应商名
	private String searchOrderId;		//查询条件 订单id
	private String searchGoodsName;			//查询条件 商品名
	private String startTime;			//查询条件 下单开始时间
	private String endTime;				//查询条件 下单结束时间
	private String searchOrderStatus;	//查询条件 订单状态
	private List<String> orderIDs;	    //订单id数组（根据商品名模糊查询获得）
	
	private String showCompareFlg;      //是否显示查看比对链接
	
	private List<OrderSnapshot> orderSnapshots = new ArrayList<OrderSnapshot>();
	
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
	public String getOrderID() {
		return orderID;
	}
	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public String getSupName() {
		return supName;
	}
	public void setSupName(String supName) {
		this.supName = supName;
	}
	public String getOrderStatusName() {
		return orderStatusName;
	}
	public void setOrderStatusName(String orderStatusName) {
		this.orderStatusName = orderStatusName;
	}
	public String getGoodsAmount() {
		return goodsAmount;
	}
	public void setGoodsAmount(String goodsAmount) {
		this.goodsAmount = goodsAmount;
	}
	public String getSearchSupName() {
		return searchSupName;
	}
	public void setSearchSupName(String searchSupName) {
		this.searchSupName = searchSupName;
	}
	public String getSearchOrderId() {
		return searchOrderId;
	}
	public void setSearchOrderId(String searchOrderId) {
		this.searchOrderId = searchOrderId;
	}
	
	public String getSearchGoodsName() {
		return searchGoodsName;
	}
	public void setSearchGoodsName(String searchGoodsName) {
		this.searchGoodsName = searchGoodsName;
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
	public String getSearchOrderStatus() {
		return searchOrderStatus;
	}
	public void setSearchOrderStatus(String searchOrderStatus) {
		this.searchOrderStatus = searchOrderStatus;
	}
	public String getCompanyID() {
		return companyID;
	}
	public void setCompanyID(String companyID) {
		this.companyID = companyID;
	}
	public List<String> getOrderIDs() {
		return orderIDs;
	}
	public void setOrderIDs(List<String> orderIDs) {
		this.orderIDs = orderIDs;
	}
	public List<OrderSnapshot> getOrderSnapshots() {
		return orderSnapshots;
	}
	public void setOrderSnapshots(List<OrderSnapshot> orderSnapshots) {
		this.orderSnapshots = orderSnapshots;
	}
	public String getShowCompareFlg() {
		return showCompareFlg;
	}
	public void setShowCompareFlg(String showCompareFlg) {
		this.showCompareFlg = showCompareFlg;
	}
	public String getReviewPerson() {
		return reviewPerson;
	}
	public void setReviewPerson(String reviewPerson) {
		this.reviewPerson = reviewPerson;
	}
	
}
