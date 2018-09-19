package com.avic.market.models;

import java.io.Serializable;
import java.util.Date;

public class OffStandardRequire implements Serializable{
	private static final long serialVersionUID = 1L;
	private String ID;						
	private String goodsDescNew;			//商品描述
	private String supID;					//供应商ID
	private String goodsID;					//商品ID
	private int status;					//0 待供应商确认 1 供应商已提供
	private String userID;
	private Date createDate;
	private String quotePath;
	private String goodsName;
	private String isRelease;
	private Date closeDate;
	private String indexLink;
	
	public String getIndexLink() {
        return indexLink;
    }
	public void setIndexLink(String indexLink) {
        this.indexLink = indexLink;
    }
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getGoodsDescNew() {
		return goodsDescNew;
	}
	public void setGoodsDescNew(String goodsDescNew) {
		this.goodsDescNew = goodsDescNew;
	}
	public String getSupID() {
		return supID;
	}
	public void setSupID(String supID) {
		this.supID = supID;
	}
	public String getGoodsID() {
		return goodsID;
	}
	public void setGoodsID(String goodsID) {
		this.goodsID = goodsID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getQuotePath() {
		return quotePath;
	}
	public void setQuotePath(String quotePath) {
		this.quotePath = quotePath;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getIsRelease() {
		return isRelease;
	}
	public void setIsRelease(String isRelease) {
		this.isRelease = isRelease;
	}
    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
    public Date getCreateDate() {
        return createDate;
    }
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    public Date getCloseDate() {
        return closeDate;
    }
    public void setCloseDate(Date closeDate) {
        this.closeDate = closeDate;
    }
	
}
