package com.avic.management.models;

import java.io.Serializable;

public class ExchangeGoods implements Serializable{
	private static final long serialVersionUID = 1L;
	private String exchangeID;				//������ID
	private String supGoodsID;				//��ƷID
	private String exchangeNum;			    //��������
	private String exchangeReason;			//��������
	private String supID;					//��Ӧ��ID
	public String getExchangeID() {
		return exchangeID;
	}
	public void setExchangeID(String exchangeID) {
		this.exchangeID = exchangeID;
	}
	public String getSupGoodsID() {
		return supGoodsID;
	}
	public void setSupGoodsID(String supGoodsID) {
		this.supGoodsID = supGoodsID;
	}
	public String getExchangeNum() {
		return exchangeNum;
	}
	public void setExchangeNum(String exchangeNum) {
		this.exchangeNum = exchangeNum;
	}
	public String getExchangeReason() {
		return exchangeReason;
	}
	public void setExchangeReason(String exchangeReason) {
		this.exchangeReason = exchangeReason;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	
}
