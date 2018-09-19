package com.avic.management.models;

import java.io.Serializable;

public class SpecialGoodsBean implements Serializable {
	private static final long serialVersionUID = 1L;

	private	String	id	;	//	非标准件需求表主键;
	private	String	sup_type	;	//	1:合作供应商;2:平台其他供应商;
	private	String	sup_id	;	//	供应商id
	private	String	sup_name	;	//	供应商名称
	private	String	company_id	;	//	企业ID
	private	String	user_id	;	//	用户ID
	private	String	goods_desc_new	;	//	商品描述
	private	String	imgCount	;	//	上传照片数量
	private	String	imgPaths	;	//	上传照片路径串（，分割）
	private	String	url	;	//	图片上传路径
	private String  goodsName;
	private String  isRelease;
	private String  closeDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getImgCount() {
		return imgCount;
	}
	public void setImgCount(String imgCount) {
		this.imgCount = imgCount;
	}
	public String getImgPaths() {
		return imgPaths;
	}
	public void setImgPaths(String imgPaths) {
		this.imgPaths = imgPaths;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getGoods_desc_new() {
		return goods_desc_new;
	}
	public void setGoods_desc_new(String goods_desc_new) {
		this.goods_desc_new = goods_desc_new;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCompany_id() {
		return company_id;
	}
	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}
	public String getSup_id() {
		return sup_id;
	}
	public void setSup_id(String sup_id) {
		this.sup_id = sup_id;
	}
	public String getSup_name() {
		return sup_name;
	}
	public void setSup_name(String sup_name) {
		this.sup_name = sup_name;
	}
	public String getSup_type() {
		return sup_type;
	}
	public void setSup_type(String sup_type) {
		this.sup_type = sup_type;
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
	public String getCloseDate() {
		return closeDate;
	}
	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}
	
}