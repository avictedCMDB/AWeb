package com.avic.supplier.models;

import java.util.List;

import com.avic.supplier.utils.BaseModels;

public class SupplierOrder extends BaseModels{
	
	private String orderId; // 订单编号

	private String supId; // 合作平台编号

	private String orderTime; // 下单时间

	private String orderStatus; // 订单状态
	
	private String orderStatusCode;

	private String orderAmount; // 订单金额

	private String supName; // 合作平台名称

	private String goodsUrl; // 商品url

	private String supGoodsId; // 商品编号

	private String imagePath; // 商品图片

	private String goodsPrice; // 商品价格

	private String buyNum; // 购买数量

	private String totalprice; // 单件商品的购买总价

	private String refundStatus; // 退换货状态

	private String goodsName; // 商品名称
	
	private String goodsModel;

	private String orderStatusName; // 订单状态名称

	private String rowspan; // 列合并

	private String userId; // 用户id

	private String orderStatusType; // 页面订单状态查询条件的回显标志，1：select选中；2：li选中。
	
	private String companyName;
	
	private String supplierReviewRemark;
	
	private String authority;
	
	private String supOrderId;
	
	private String supExpressName;
	
	private String supExpressCode;
	
	private String contractCode;
	
	
	public String getSupOrderId() {
		return supOrderId;
	}

	public void setSupOrderId(String supOrderId) {
		this.supOrderId = supOrderId;
	}

	private List<SupplierOrder> subOrderList;
	
	private int subCount;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getSupId() {
		return supId;
	}

	public void setSupId(String supId) {
		this.supId = supId;
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

	public String getOrderAmount() {
		return orderAmount;
	}

	public void setOrderAmount(String orderAmount) {
		this.orderAmount = orderAmount;
	}

	public String getSupName() {
		return supName;
	}

	public void setSupName(String supName) {
		this.supName = supName;
	}

	public String getGoodsUrl() {
		return goodsUrl;
	}

	public void setGoodsUrl(String goodsUrl) {
		this.goodsUrl = goodsUrl;
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

	public String getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public String getBuyNum() {
		return buyNum;
	}

	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
	}

	public String getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(String totalprice) {
		this.totalprice = totalprice;
	}

	public String getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public String getOrderStatusName() {
		return orderStatusName;
	}

	public void setOrderStatusName(String orderStatusName) {
		this.orderStatusName = orderStatusName;
	}

	public String getRowspan() {
		return rowspan;
	}

	public void setRowspan(String rowspan) {
		this.rowspan = rowspan;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getOrderStatusType() {
		return orderStatusType;
	}

	public void setOrderStatusType(String orderStatusType) {
		this.orderStatusType = orderStatusType;
	}

	public String getOrderStatusCode() {
		return orderStatusCode;
	}

	public void setOrderStatusCode(String orderStatusCode) {
		this.orderStatusCode = orderStatusCode;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public List<SupplierOrder> getSubOrderList() {
		return subOrderList;
	}

	public void setSubOrderList(List<SupplierOrder> subOrderList) {
		this.subOrderList = subOrderList;
	}

	public int getSubCount() {
		return subCount;
	}

	public void setSubCount(int subCount) {
		this.subCount = subCount;
	}

	public String getSupplierReviewRemark() {
		return supplierReviewRemark;
	}

	public void setSupplierReviewRemark(String supplierReviewRemark) {
		this.supplierReviewRemark = supplierReviewRemark;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public String getSupExpressName() {
		return supExpressName;
	}

	public void setSupExpressName(String supExpressName) {
		this.supExpressName = supExpressName;
	}

	public String getSupExpressCode() {
		return supExpressCode;
	}

	public void setSupExpressCode(String supExpressCode) {
		this.supExpressCode = supExpressCode;
	}

	public String getGoodsModel() {
		return goodsModel;
	}

	public void setGoodsModel(String goodsModel) {
		this.goodsModel = goodsModel;
	}

	public String getContractCode() {
		return contractCode;
	}

	public void setContractCode(String contractCode) {
		this.contractCode = contractCode;
	}
	
}
