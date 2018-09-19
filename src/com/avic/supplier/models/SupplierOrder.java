package com.avic.supplier.models;

import java.util.List;

import com.avic.supplier.utils.BaseModels;

public class SupplierOrder extends BaseModels{
	
	private String orderId; // �������

	private String supId; // ����ƽ̨���

	private String orderTime; // �µ�ʱ��

	private String orderStatus; // ����״̬
	
	private String orderStatusCode;

	private String orderAmount; // �������

	private String supName; // ����ƽ̨����

	private String goodsUrl; // ��Ʒurl

	private String supGoodsId; // ��Ʒ���

	private String imagePath; // ��ƷͼƬ

	private String goodsPrice; // ��Ʒ�۸�

	private String buyNum; // ��������

	private String totalprice; // ������Ʒ�Ĺ����ܼ�

	private String refundStatus; // �˻���״̬

	private String goodsName; // ��Ʒ����
	
	private String goodsModel;

	private String orderStatusName; // ����״̬����

	private String rowspan; // �кϲ�

	private String userId; // �û�id

	private String orderStatusType; // ҳ�涩��״̬��ѯ�����Ļ��Ա�־��1��selectѡ�У�2��liѡ�С�
	
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