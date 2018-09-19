package com.avic.supervise.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SupplierRecommend implements Serializable{
	private static final long serialVersionUID = 1L;
	private String supID;				//����ƽ̨���
	private String supName;				//����ƽ̨����
	private String authUser;			//��Ȩ�û���
	private String authPass;			//��Ȩ����
	private String authCode;			//��Ȩ��
	private String accessToken;			//������
	private String accessExprice;		//��������Ч��
	private String refreshToken;		//ˢ����
	
	private String refreshExpire;		//ˢ������Ч��
	private String companyCode;			//��˾���
	private String deptCode;			//���ű��
	private String apiUrl;				//api��ַ
	private String ifValid;				//�Ƿ���Ч
	private String supCode;				//����ƽ̨����
	private String updateStatus;      	//�Ƿ���ʾ�鿴�ȶ�����
	private String lastUpdate;
	private String supType;
	private String ifRecommend;   		//0:�Ƽ� 1�����Ƽ�
	private String beginDate;			//�Ƽ���ʼʱ��
	private String endDate;				//�Ƽ�����ʱ��
	private String supImage;		    //��Ӧ��ͼƬ
	
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
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getSupName() {
		return supName;
	}
	public void setSupName(String supName) {
		this.supName = supName;
	}
	public String getAuthUser() {
		return authUser;
	}
	public void setAuthUser(String authUser) {
		this.authUser = authUser;
	}
	public String getAuthPass() {
		return authPass;
	}
	public void setAuthPass(String authPass) {
		this.authPass = authPass;
	}
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public String getAccessToken() {
		return accessToken;
	}
	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}
	public String getAccessExprice() {
		return accessExprice;
	}
	public void setAccessExprice(String accessExprice) {
		this.accessExprice = accessExprice;
	}
	public String getRefreshToken() {
		return refreshToken;
	}
	public void setRefreshToken(String refreshToken) {
		this.refreshToken = refreshToken;
	}
	public String getRefreshExpire() {
		return refreshExpire;
	}
	public void setRefreshExpire(String refreshExpire) {
		this.refreshExpire = refreshExpire;
	}
	public String getCompanyCode() {
		return companyCode;
	}
	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getApiUrl() {
		return apiUrl;
	}
	public void setApiUrl(String apiUrl) {
		this.apiUrl = apiUrl;
	}
	public String getIfValid() {
		return ifValid;
	}
	public void setIfValid(String ifValid) {
		this.ifValid = ifValid;
	}
	public String getSupCode() {
		return supCode;
	}
	public void setSupCode(String supCode) {
		this.supCode = supCode;
	}
	public String getUpdateStatus() {
		return updateStatus;
	}
	public void setUpdateStatus(String updateStatus) {
		this.updateStatus = updateStatus;
	}
	public String getLastUpdate() {
		return lastUpdate;
	}
	public void setLastUpdate(String lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	public String getSupType() {
		return supType;
	}
	public void setSupType(String supType) {
		this.supType = supType;
	}
	public String getIfRecommend() {
		return ifRecommend;
	}
	public void setIfRecommend(String ifRecommend) {
		this.ifRecommend = ifRecommend;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getSupImage() {
		return supImage;
	}
	public void setSupImage(String supImage) {
		this.supImage = supImage;
	}
	
}
