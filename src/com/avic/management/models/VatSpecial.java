package com.avic.management.models;

import java.io.Serializable;

public class VatSpecial implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;					//��Ʊid
	private String companyName;			//��λ����
	private String taxpayerCode;		//��˰��ʶ����
	private String registerPath;		//ע���ַ
	private String registerTel;			//ע��绰
	private String bankName;			//�������� 
	private String bankAccount;			//�����˻�
	private String userID;				//�û�ID
	private String auditStatus;			//���״̬
	private String createDate;			//����ʱ��
	private String url1;				//˰��Ǽ�֤����ͼƬurl
	private String url2;				//һ����˰��֤��ͼƬurl
	private String url3;				//��Ʊ��Ȩί����ͼƬurl
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getTaxpayerCode() {
		return taxpayerCode;
	}
	public void setTaxpayerCode(String taxpayerCode) {
		this.taxpayerCode = taxpayerCode;
	}
	public String getRegisterPath() {
		return registerPath;
	}
	public void setRegisterPath(String registerPath) {
		this.registerPath = registerPath;
	}
	public String getRegisterTel() {
		return registerTel;
	}
	public void setRegisterTel(String registerTel) {
		this.registerTel = registerTel;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUrl1() {
		return url1;
	}
	public void setUrl1(String url1) {
		this.url1 = url1;
	}
	public String getUrl2() {
		return url2;
	}
	public void setUrl2(String url2) {
		this.url2 = url2;
	}
	public String getUrl3() {
		return url3;
	}
	public void setUrl3(String url3) {
		this.url3 = url3;
	}
	public String getAuditStatus() {
		return auditStatus;
	}
	public void setAuditStatus(String auditStatus) {
		this.auditStatus = auditStatus;
	}
	
	
}