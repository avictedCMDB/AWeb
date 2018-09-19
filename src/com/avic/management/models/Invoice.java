package com.avic.management.models;

import java.io.Serializable;

public class Invoice implements Serializable{
	private static final long serialVersionUID = 1L;
	private String companyName;			//���λ����
	private String invocieNum;			//˰��ǼǺ�
	private String invoiceFlag;			//˰���ʾ 1����ϸ��2���Զ���
	private String invoiceContent;		//��Ʊ����
	private String ifDefault;			//�Ƿ�Ĭ�Ϸ�Ʊ
	private String userID;				//�û�ID 
	private String invoiceID;			//��Ʊid
	private String invoiceNum;
	private String oldInvoiceNum;
	private String oldCompanyName;
	
	
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
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getInvocieNum() {
		return invocieNum;
	}
	public void setInvocieNum(String invocieNum) {
		this.invocieNum = invocieNum;
	}
	public String getInvoiceFlag() {
		return invoiceFlag;
	}
	public void setInvoiceFlag(String invoiceFlag) {
		this.invoiceFlag = invoiceFlag;
	}
	public String getInvoiceContent() {
		return invoiceContent;
	}
	public void setInvoiceContent(String invoiceContent) {
		this.invoiceContent = invoiceContent;
	}
	public String getIfDefault() {
		return ifDefault;
	}
	public void setIfDefault(String ifDefault) {
		this.ifDefault = ifDefault;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getInvoiceID() {
		return invoiceID;
	}
	public void setInvoiceID(String invoiceID) {
		this.invoiceID = invoiceID;
	}
	public String getInvoiceNum() {
		return invoiceNum;
	}
	public void setInvoiceNum(String invoiceNum) {
		this.invoiceNum = invoiceNum;
	}
	public String getOldInvoiceNum() {
		return oldInvoiceNum;
	}
	public void setOldInvoiceNum(String oldInvoiceNum) {
		this.oldInvoiceNum = oldInvoiceNum;
	}
	public String getOldCompanyName() {
		return oldCompanyName;
	}
	public void setOldCompanyName(String oldCompanyName) {
		this.oldCompanyName = oldCompanyName;
	}
	
}