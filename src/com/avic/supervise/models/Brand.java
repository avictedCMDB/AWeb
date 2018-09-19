package com.avic.supervise.models;

import java.io.Serializable;

public class Brand implements Serializable {
	private static final long serialVersionUID = 8293567835054991180L;

	private String bid; // 品牌id
	private String brand_name; // 品牌名称
	private String brand_image; // 品牌图片
	private String if_recommand; // 是否推荐（0 是 1 否）
	private	String	begin_date	;	//	推荐有效期开始
	private String end_date	;	//	推荐有效期结束
	private String recommand_date	;	//	推荐时间
	private int page = 1;
	private int pageSize = 10;
	private int pageFrom ;				//开始数
	private int pageTo;					//结束数
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

	public String getBid() {
		return bid;
	}

	public void setBid(String bid) {
		this.bid = bid;
	}

	public String getRecommand_date() {
		return recommand_date;
	}

	public void setRecommand_date(String recommand_date) {
		this.recommand_date = recommand_date;
	}

	public String getBegin_date() {
		return begin_date;
	}

	public void setBegin_date(String begin_date) {
		this.begin_date = begin_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getBrand_image() {
		return brand_image;
	}

	public void setBrand_image(String brand_image) {
		this.brand_image = brand_image;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

	public String getIf_recommand() {
		return if_recommand;
	}

	public void setIf_recommand(String if_recommand) {
		this.if_recommand = if_recommand;
	}

}