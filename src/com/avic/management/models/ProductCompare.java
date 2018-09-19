package com.avic.management.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ProductCompare implements Serializable{
	private static final long serialVersionUID = -4924624311155595695L;
	private String supOneID; 		    //比对供应商1ID
	private String supGoodsOneID; 		//比对商品1ID
	private String supTwoID; 		 	//比对供应商2ID
	private String supGoodsTwoID; 		//比对商品2ID
	private String supThreeID; 		 	//比对供应商3ID
	private String supGoodsThreeID; 	//比对商品3ID
	private String supFourID; 		 	//比对供应商4ID
	private String supGoodsFourID; 		//比对商品4ID
	private String userID;
	
	private String compareID; 		 		//比对ID
	private String supCheckedID; 			//比对后别选中的商品平台编号
	private String supGoodsCheckedID; 		//比对后别选中的商品编号
	private String proCheckedReason; 		//选中原因
	private String createDate;
	private String updateDate;
	private String remark;
	
	private String supGoodsOneImagePath;
	private String supGoodsOneGoodsName;
	private String supGoodsOneAgreePrice;
	private String supGoodsOneBrandName;
	private String supGoodsOneProductArea;
	private String supGoodsTwoImagePath;
	private String supGoodsTwoGoodsName;
	private String supGoodsTwoAgreePrice;
	private String supGoodsTwoBrandName;
	private String supGoodsTwoProductArea;
	private String supGoodsThreeImagePath;
	private String supGoodsThreeGoodsName;
	private String supGoodsThreeAgreePrice;
	private String supGoodsThreeBrandName;
	private String supGoodsThreeProductArea;
	private String supGoodsFourImagePath;
	private String supGoodsFourGoodsName;
	private String supGoodsFourAgreePrice;
	private String supGoodsFourBrandName;
	private String supGoodsFourProductArea;
	
	private String imagePath;				//选中商品图片
	private String goodsName;				//选中商品名称
	private String agreePrice;				//选中商品价格
	
	private List<SupGoods> supCompareGoods = new ArrayList<SupGoods>();
	private List<String> reasonText = new ArrayList<String>();
	
	private String startTime;			//查询条件开始时间
	private String endTime;				//查询条件结束时间
	private String searchGoodsName;		//查询条件商品名称
	private String searchSupName;		//查询条件供应商名
	
	private String orderID;				//订单ID
	private String linkOrderID;			//用于判断比对列表中比对商品是否有订单
	private List<String> compareIDS = new ArrayList<String>(); //审核查看比对商品列表比对ID数组
	
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
	public String getSupOneID() {
		return supOneID;
	}
	public void setSupOneID(String supOneID) {
		this.supOneID = supOneID;
	}
	public String getSupGoodsOneID() {
		return supGoodsOneID;
	}
	public void setSupGoodsOneID(String supGoodsOneID) {
		this.supGoodsOneID = supGoodsOneID;
	}
	public String getSupTwoID() {
		return supTwoID;
	}
	public void setSupTwoID(String supTwoID) {
		this.supTwoID = supTwoID;
	}
	public String getSupGoodsTwoID() {
		return supGoodsTwoID;
	}
	public void setSupGoodsTwoID(String supGoodsTwoID) {
		this.supGoodsTwoID = supGoodsTwoID;
	}
	public String getSupThreeID() {
		return supThreeID;
	}
	public void setSupThreeID(String supThreeID) {
		this.supThreeID = supThreeID;
	}
	public String getSupGoodsThreeID() {
		return supGoodsThreeID;
	}
	public void setSupGoodsThreeID(String supGoodsThreeID) {
		this.supGoodsThreeID = supGoodsThreeID;
	}
	public String getSupFourID() {
		return supFourID;
	}
	public void setSupFourID(String supFourID) {
		this.supFourID = supFourID;
	}
	public String getSupGoodsFourID() {
		return supGoodsFourID;
	}
	public void setSupGoodsFourID(String supGoodsFourID) {
		this.supGoodsFourID = supGoodsFourID;
	}
	public String getCompareID() {
		return compareID;
	}
	public void setCompareID(String compareID) {
		this.compareID = compareID;
	}
	public String getSupCheckedID() {
		return supCheckedID;
	}
	public void setSupCheckedID(String supCheckedID) {
		this.supCheckedID = supCheckedID;
	}
	public String getSupGoodsCheckedID() {
		return supGoodsCheckedID;
	}
	public void setSupGoodsCheckedID(String supGoodsCheckedID) {
		this.supGoodsCheckedID = supGoodsCheckedID;
	}
	public String getProCheckedReason() {
		return proCheckedReason;
	}
	
	public void setProCheckedReason(String proCheckedReason) {
		this.proCheckedReason = proCheckedReason;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public List<SupGoods> getSupCompareGoods() {
		return supCompareGoods;
	}
	public void setSupCompareGoods(List<SupGoods> supCompareGoods) {
		this.supCompareGoods = supCompareGoods;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getAgreePrice() {
		return agreePrice;
	}
	public void setAgreePrice(String agreePrice) {
		this.agreePrice = agreePrice;
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
	public String getSearchGoodsName() {
		return searchGoodsName;
	}
	public void setSearchGoodsName(String searchGoodsName) {
		this.searchGoodsName = searchGoodsName;
	}
	public String getSearchSupName() {
		return searchSupName;
	}
	public void setSearchSupName(String searchSupName) {
		this.searchSupName = searchSupName;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSupGoodsOneImagePath() {
		return supGoodsOneImagePath;
	}
	public void setSupGoodsOneImagePath(String supGoodsOneImagePath) {
		this.supGoodsOneImagePath = supGoodsOneImagePath;
	}
	public String getSupGoodsOneGoodsName() {
		return supGoodsOneGoodsName;
	}
	public void setSupGoodsOneGoodsName(String supGoodsOneGoodsName) {
		this.supGoodsOneGoodsName = supGoodsOneGoodsName;
	}
	public String getSupGoodsOneAgreePrice() {
		return supGoodsOneAgreePrice;
	}
	public void setSupGoodsOneAgreePrice(String supGoodsOneAgreePrice) {
		this.supGoodsOneAgreePrice = supGoodsOneAgreePrice;
	}
	public String getSupGoodsOneBrandName() {
		return supGoodsOneBrandName;
	}
	public void setSupGoodsOneBrandName(String supGoodsOneBrandName) {
		this.supGoodsOneBrandName = supGoodsOneBrandName;
	}
	public String getSupGoodsOneProductArea() {
		return supGoodsOneProductArea;
	}
	public void setSupGoodsOneProductArea(String supGoodsOneProductArea) {
		this.supGoodsOneProductArea = supGoodsOneProductArea;
	}
	public String getSupGoodsTwoImagePath() {
		return supGoodsTwoImagePath;
	}
	public void setSupGoodsTwoImagePath(String supGoodsTwoImagePath) {
		this.supGoodsTwoImagePath = supGoodsTwoImagePath;
	}
	public String getSupGoodsTwoGoodsName() {
		return supGoodsTwoGoodsName;
	}
	public void setSupGoodsTwoGoodsName(String supGoodsTwoGoodsName) {
		this.supGoodsTwoGoodsName = supGoodsTwoGoodsName;
	}
	public String getSupGoodsTwoAgreePrice() {
		return supGoodsTwoAgreePrice;
	}
	public void setSupGoodsTwoAgreePrice(String supGoodsTwoAgreePrice) {
		this.supGoodsTwoAgreePrice = supGoodsTwoAgreePrice;
	}
	public String getSupGoodsTwoBrandName() {
		return supGoodsTwoBrandName;
	}
	public void setSupGoodsTwoBrandName(String supGoodsTwoBrandName) {
		this.supGoodsTwoBrandName = supGoodsTwoBrandName;
	}
	public String getSupGoodsTwoProductArea() {
		return supGoodsTwoProductArea;
	}
	public void setSupGoodsTwoProductArea(String supGoodsTwoProductArea) {
		this.supGoodsTwoProductArea = supGoodsTwoProductArea;
	}
	public String getSupGoodsThreeImagePath() {
		return supGoodsThreeImagePath;
	}
	public void setSupGoodsThreeImagePath(String supGoodsThreeImagePath) {
		this.supGoodsThreeImagePath = supGoodsThreeImagePath;
	}
	public String getSupGoodsThreeGoodsName() {
		return supGoodsThreeGoodsName;
	}
	public void setSupGoodsThreeGoodsName(String supGoodsThreeGoodsName) {
		this.supGoodsThreeGoodsName = supGoodsThreeGoodsName;
	}
	public String getSupGoodsThreeAgreePrice() {
		return supGoodsThreeAgreePrice;
	}
	public void setSupGoodsThreeAgreePrice(String supGoodsThreeAgreePrice) {
		this.supGoodsThreeAgreePrice = supGoodsThreeAgreePrice;
	}
	public String getSupGoodsThreeBrandName() {
		return supGoodsThreeBrandName;
	}
	public void setSupGoodsThreeBrandName(String supGoodsThreeBrandName) {
		this.supGoodsThreeBrandName = supGoodsThreeBrandName;
	}
	public String getSupGoodsThreeProductArea() {
		return supGoodsThreeProductArea;
	}
	public void setSupGoodsThreeProductArea(String supGoodsThreeProductArea) {
		this.supGoodsThreeProductArea = supGoodsThreeProductArea;
	}
	public String getSupGoodsFourImagePath() {
		return supGoodsFourImagePath;
	}
	public void setSupGoodsFourImagePath(String supGoodsFourImagePath) {
		this.supGoodsFourImagePath = supGoodsFourImagePath;
	}
	public String getSupGoodsFourGoodsName() {
		return supGoodsFourGoodsName;
	}
	public void setSupGoodsFourGoodsName(String supGoodsFourGoodsName) {
		this.supGoodsFourGoodsName = supGoodsFourGoodsName;
	}
	public String getSupGoodsFourAgreePrice() {
		return supGoodsFourAgreePrice;
	}
	public void setSupGoodsFourAgreePrice(String supGoodsFourAgreePrice) {
		this.supGoodsFourAgreePrice = supGoodsFourAgreePrice;
	}
	public String getSupGoodsFourBrandName() {
		return supGoodsFourBrandName;
	}
	public void setSupGoodsFourBrandName(String supGoodsFourBrandName) {
		this.supGoodsFourBrandName = supGoodsFourBrandName;
	}
	public String getSupGoodsFourProductArea() {
		return supGoodsFourProductArea;
	}
	public void setSupGoodsFourProductArea(String supGoodsFourProductArea) {
		this.supGoodsFourProductArea = supGoodsFourProductArea;
	}
	public List<String> getReasonText() {
		return reasonText;
	}
	public void setReasonText(List<String> reasonText) {
		this.reasonText = reasonText;
	}
	public List<String> getCompareIDS() {
		return compareIDS;
	}
	public void setCompareIDS(List<String> compareIDS) {
		this.compareIDS = compareIDS;
	}
	public String getOrderID() {
		return orderID;
	}
	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}
	public String getLinkOrderID() {
		return linkOrderID;
	}
	public void setLinkOrderID(String linkOrderID) {
		this.linkOrderID = linkOrderID;
	}
	
}
