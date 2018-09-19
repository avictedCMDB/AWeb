package com.avic.management.models;

import java.io.Serializable;

public class Cart implements Serializable{
	private static final long serialVersionUID = 1L;
	private String userID;			//�û�ID
	private String supID;			//��Ӧ��ID
	private String supGoodsID;		//��ƷID
	private String buyNum;			//��������
	private String compareID;		//�ȶ�ID
	private String quoteID;         
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getSupGoodsID() {
		return supGoodsID;
	}
	public void setSupGoodsID(String supGoodsID) {
		this.supGoodsID = supGoodsID;
	}
	public String getBuyNum() {
		return buyNum;
	}
	public void setBuyNum(String buyNum) {
		this.buyNum = buyNum;
	}
	public String getCompareID() {
		return compareID;
	}
	public void setCompareID(String compareID) {
		this.compareID = compareID;
	}
	public String getQuoteID() {
		return quoteID;
	}
	public void setQuoteID(String quoteID) {
		this.quoteID = quoteID;
	}
	
	
}