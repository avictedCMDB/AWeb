package com.avic.supplier.models;

import com.avic.supplier.utils.BaseModels;

public class Supplier extends BaseModels{

	private String confirmRefoundCount; //�˻� ��ȷ������
	private String takeRefoundCount;	//�˻� ���ջ�����
	private String confirmExchangeCount;//���� ��ȷ������
	private String takeExchangeCount;	//���� ���ջ�����
	private String sendExchangeCount;	//���� ����������
	private String supId;
	private String supImage;
	private String enquiryCount;
	private String standardCount;
	public String getConfirmRefoundCount() {
		return confirmRefoundCount;
	}
	public void setConfirmRefoundCount(String confirmRefoundCount) {
		this.confirmRefoundCount = confirmRefoundCount;
	}
	public String getTakeRefoundCount() {
		return takeRefoundCount;
	}
	public void setTakeRefoundCount(String takeRefoundCount) {
		this.takeRefoundCount = takeRefoundCount;
	}
	public String getConfirmExchangeCount() {
		return confirmExchangeCount;
	}
	public void setConfirmExchangeCount(String confirmExchangeCount) {
		this.confirmExchangeCount = confirmExchangeCount;
	}
	public String getTakeExchangeCount() {
		return takeExchangeCount;
	}
	public void setTakeExchangeCount(String takeExchangeCount) {
		this.takeExchangeCount = takeExchangeCount;
	}
	public String getSendExchangeCount() {
		return sendExchangeCount;
	}
	public void setSendExchangeCount(String sendExchangeCount) {
		this.sendExchangeCount = sendExchangeCount;
	}
	public String getSupId() {
		return supId;
	}
	public void setSupId(String supId) {
		this.supId = supId;
	}
	public String getSupImage() {
		return supImage;
	}
	public void setSupImage(String supImage) {
		this.supImage = supImage;
	}
	public String getEnquiryCount() {
		return enquiryCount;
	}
	public void setEnquiryCount(String enquiryCount) {
		this.enquiryCount = enquiryCount;
	}
	public String getStandardCount() {
		return standardCount;
	}
	public void setStandardCount(String standardCount) {
		this.standardCount = standardCount;
	}
	
}
