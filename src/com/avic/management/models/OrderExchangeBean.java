package com.avic.management.models;

import java.io.Serializable;

public class OrderExchangeBean implements Serializable {
	private static final long serialVersionUID = 1L;
	private	String	order_id	;	//	�������
	private	String	sup_name	;	//	��Ӧ������
	private	String	addr_name	;	//	�ɹ���ϵ������
	private	String	addr_phone	;	//	�ɹ���ϵ�˵绰
	private	String	remark	;	//	��ע
	private	String	sup_id	;	//	��Ӧ�̱��
	private	String	sup_goods_id	;	//	��Ʒ���
	private	String	image_path	;	//	��ƷͼƬ
	private	String	goods_name	;	//	��Ʒ����
	private	double	goods_price	;	//	��Ʒ�۸�
	private	String	buy_num	;	//	��������
	private	String	exchange_reason	;	//	����ԭ��
	private	String	exchange_id	;	//	��������
	private	String	exchange_amount	;	//	����������
	private	String	exchange_price	;	//	�����ܽ��
	private	String	user_id	;	//	�û�����
	private	String	buy_num_show	;	//	�µ���������
	private	String	imgCount	;	//	�ϴ���Ƭ����
	private	String	imgPaths	;	//	�ϴ���Ƭ·���������ָ
	private	String	url	;	//	ͼƬ�ϴ�·��
	private double  goods_price_init;//��Ʒԭ��
	private String  exchange_price_init;//��������ʼ��
	public String getExchange_price_init() {
		return exchange_price_init;
	}
	public void setExchange_price_init(String exchange_price_init) {
		this.exchange_price_init = exchange_price_init;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
	public String getAddr_name() {
		return addr_name;
	}
	public void setAddr_name(String addr_name) {
		this.addr_name = addr_name;
	}
	public String getAddr_phone() {
		return addr_phone;
	}
	public void setAddr_phone(String addr_phone) {
		this.addr_phone = addr_phone;
	}
	public String getBuy_num() {
		return buy_num;
	}
	public void setBuy_num(String buy_num) {
		this.buy_num = buy_num;
	}
	public String getExchange_amount() {
		return exchange_amount;
	}
	public void setExchange_amount(String exchange_amount) {
		this.exchange_amount = exchange_amount;
	}
	public String getExchange_id() {
		return exchange_id;
	}
	public void setExchange_id(String exchange_id) {
		this.exchange_id = exchange_id;
	}
	public String getExchange_price() {
		return exchange_price;
	}
	public void setExchange_price(String exchange_price) {
		this.exchange_price = exchange_price;
	}
	public String getExchange_reason() {
		return exchange_reason;
	}
	public void setExchange_reason(String exchange_reason) {
		this.exchange_reason = exchange_reason;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public double getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(double goods_price) {
		this.goods_price = goods_price;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSup_goods_id() {
		return sup_goods_id;
	}
	public void setSup_goods_id(String sup_goods_id) {
		this.sup_goods_id = sup_goods_id;
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getBuy_num_show() {
		return buy_num_show;
	}
	public void setBuy_num_show(String buy_num_show) {
		this.buy_num_show = buy_num_show;
	}
	public double getGoods_price_init() {
		return goods_price_init;
	}
	public void setGoods_price_init(double goods_price_init) {
		this.goods_price_init = goods_price_init;
	}

}