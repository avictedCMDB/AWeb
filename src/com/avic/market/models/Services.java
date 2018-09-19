package com.avic.market.models;

import java.io.Serializable;
/**
 *����
 */
public class Services implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private String orderID;				//����ID
    private String typeID;				//�˻�����ID
    private String supOrderID;			//��Ӧ�̶���ID
    private String servicesID;			//����ID(һ����Ʒһ������)
    private String servicesType;		//�������ͣ��˻�(10)������(20)��ά��(30)��
    private String servicesStatus;		//����״̬������׶�(10),��˲�ͨ��(20),�ͷ����(21),�̼����(22),�����ջ�(31),�̼��ջ�(32), ��������(33),�̼Ҵ���(34), �û�ȷ��(40),���(50), ȡ�� 60);��
    private String afsApplyTime;		//��������ʱ��
    private String ifCancel;			//�Ƿ��ȡ��(0�����1������)
    private String supID;				//��Ӧ��ID
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
	private int pageFrom ;				//��ʼ��
	private int pageTo;					//������
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
