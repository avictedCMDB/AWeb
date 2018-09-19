package com.avic.management.models;

import java.io.Serializable;

public class Management implements Serializable{
	private static final long serialVersionUID = 1L;
	private int waitOrderCount;			//�������ջ�����
	private int checkOrderCount;			//�������������
	private int waitPayOrderCount;		//������֧������
	private int waitPayOrderCountB2B;		//������֧������
	private int rejectOrderCount;		//�����Ѿܾ�����
	private int returnOrderCount;		//�������˻�����
	private int changeOrderCount;		//�����ѻ�������
	private int rejectRefoundCount;		//�˻������˻�����
	private int rejectExchangeCount;	//���������˻�����
	private int enquiryGoodsCount;		//ѯ����Ʒ��Ӧ���ѱ�������
	private int offStandardRequireCount;//�Ǳ���Ʒ��Ӧ�����ṩ����
	private String userID;
	private String enquiryStatus;		//ѯ����Ʒ״̬
	private String status;				//�Ǳ���Ʒ״̬
	private String companyId;				//��ҵid
	
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