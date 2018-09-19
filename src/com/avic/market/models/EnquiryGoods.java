package com.avic.market.models;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class EnquiryGoods implements Serializable{
	private static final long serialVersionUID = 3581420168806725943L;
	
	private String id;						//id
    private String goodsID;					//��ƷID
    private String goodsNum;				//��Ʒ��������
    private String goodsPriceBefore;		//��Ʒѯ��ǰ�۸�
    private String goodsPriceAfter;			//��Ʒѯ�ۺ�۸�
    private String enquiryDate;				//�ɹ���ѯ��ʱ��
    private String superOfferDate;			//��Ӧ�̱��ۺ�ʱ��
    private String supID;					//��Ӧ��ID
    private String enquiryStatus;			//ѯ�۵�״̬��0 ����Ӧ�̱��� 1 ��Ӧ���ѱ��� 2 ��Ӧ�ܾ̾����� 3 ���ϣ�
    private String contactTel;				//��ϵ�˵绰
    private String priceValidDate;			//�۸���Ч��
    private String contactName;				//��ϵ������
    private String userID;					//�û�ID
    
    private String goodsName;				//��Ʒ����
    private String goodsModel;				//��Ʒ�ͺ�
    
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
	public String getGoodsID() {
		return goodsID;
	}
	public void setGoodsID(String goodsID) {
		this.goodsID = goodsID;
	}
	public String getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(String goodsNum) {
		this.goodsNum = goodsNum;
	}
	public String getGoodsPriceBefore() {
		return goodsPriceBefore;
	}
	public void setGoodsPriceBefore(String goodsPriceBefore) {
		this.goodsPriceBefore = goodsPriceBefore;
	}
	public String getGoodsPriceAfter() {
		return goodsPriceAfter;
	}
	public void setGoodsPriceAfter(String goodsPriceAfter) {
		this.goodsPriceAfter = goodsPriceAfter;
	}
	public String getEnquiryDate() {
		return enquiryDate;
	}
	public void setEnquiryDate(String enquiryDate) {
		this.enquiryDate = enquiryDate;
	}
	public String getSuperOfferDate() {
		return superOfferDate;
	}
	public void setSuperOfferDate(String superOfferDate) {
		this.superOfferDate = superOfferDate;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getEnquiryStatus() {
		return enquiryStatus;
	}
	public void setEnquiryStatus(String enquiryStatus) {
		this.enquiryStatus = enquiryStatus;
	}
	public String getContactTel() {
		return contactTel;
	}
	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}
	public String getPriceValidDate() {
		return priceValidDate;
	}
	public void setPriceValidDate(String priceValidDate) {
		this.priceValidDate = priceValidDate;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsModel() {
		return goodsModel;
	}
	public void setGoodsModel(String goodsModel) {
		this.goodsModel = goodsModel;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
    
}