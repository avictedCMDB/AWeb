package com.avic.management.models;

import java.io.Serializable;

public class OrderRefoundBean implements Serializable {
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
	private	String	buy_num	;	//	�˻�����
	private	String	refound_reason	;	//	����ԭ��
	private	String	refound_id	;	//	��������
	private	String	refound_amount	;	//	����������
	private	String	refound_price	;	//	�����ܽ��
	private	String	user_id	;	//	�û�����
	private	String	buy_num_show	;	//	�µ���������
	private	String	imgCount	;	//	�ϴ���Ƭ����
	private	String	imgPaths	;	//	�ϴ���Ƭ·���������ָ
	private	String	url	;	//	ͼƬ�ϴ�·��
	private double  goods_price_init;//��Ʒԭ��
	private String  refound_price_init;//��������ʼ��
	
	public double getGoods_price_init() {
		return goods_price_init;
	}
	public void setGoods_price_init(double goods_price_init) {
		this.goods_price_init = goods_price_init;
	}
	public String getRefound_price_init() {
		return refound_price_init;
	}
	public void setRefound_price_init(String refound_price_init) {
		this.refound_price_init = refound_price_init;
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
	public String getRefound_amount() {
		return refound_amount;
	}
	public void setRefound_amount(String refound_amount) {
		this.refound_amount = refound_amount;
	}
	public String getRefound_id() {
		return refound_id;
	}
	public void setRefound_id(String refound_id) {
		this.refound_id = refound_id;
	}
	public String getRefound_price() {
		return refound_price;
	}
	public void setRefound_price(String refound_price) {
		this.refound_price = refound_price;
	}
	public String getRefound_reason() {
		return refound_reason;
	}
	public void setRefound_reason(String refound_reason) {
		this.refound_reason = refound_reason;
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

}