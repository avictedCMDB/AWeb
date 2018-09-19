package com.avic.market.models;

import java.io.Serializable;
/**
 *服务单
 */
public class Services implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private String orderID;				//订单ID
    private String typeID;				//退换货单ID
    private String supOrderID;			//供应商订单ID
    private String servicesID;			//服务单ID(一个商品一个服务单)
    private String servicesType;		//服务类型（退货(10)、换货(20)、维修(30)）
    private String servicesStatus;		//服务单状态（申请阶段(10),审核不通过(20),客服审核(21),商家审核(22),京东收货(31),商家收货(32), 京东处理(33),商家处理(34), 用户确认(40),完成(50), 取消 60);）
    private String afsApplyTime;		//服务单申请时间
    private String ifCancel;			//是否可取消(0代表否，1代表是)
    private String supID;				//供应商ID
    private String supGoodsID;
    
    public String getOrderID() {
		return orderID;
	}
	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}
	public String getTypeID() {
		return typeID;
	}
	public void setTypeID(String typeID) {
		this.typeID = typeID;
	}
	public String getSupOrderID() {
		return supOrderID;
	}
	public void setSupOrderID(String supOrderID) {
		this.supOrderID = supOrderID;
	}
	public String getServicesID() {
		return servicesID;
	}
	public void setServicesID(String servicesID) {
		this.servicesID = servicesID;
	}
	public String getServicesType() {
		return servicesType;
	}
	public void setServicesType(String servicesType) {
		this.servicesType = servicesType;
	}
	public String getServicesStatus() {
		return servicesStatus;
	}
	public void setServicesStatus(String servicesStatus) {
		this.servicesStatus = servicesStatus;
	}
	public String getAfsApplyTime() {
		return afsApplyTime;
	}
	public void setAfsApplyTime(String afsApplyTime) {
		this.afsApplyTime = afsApplyTime;
	}
	public String getIfCancel() {
		return ifCancel;
	}
	public void setIfCancel(String ifCancel) {
		this.ifCancel = ifCancel;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSupGoodsID() {
		return supGoodsID;
	}
	public void setSupGoodsID(String supGoodsID) {
		this.supGoodsID = supGoodsID;
	}
	
}
