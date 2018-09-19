package com.avic.management.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class OrderCpi implements Serializable{
	private static final long serialVersionUID = 1L;
	private String operate_time;			//快递时间
	private String content;				//快递内容
	private String operator;			//客户
	private String msgTime;
	private List<String> names = new ArrayList<String>();				//商品名称
	
	private List<OrderCpi> orderCpis = new ArrayList<OrderCpi>();
	
	public String getMsgTime() {
		return msgTime;
	}
	public void setMsgTime(String msgTime) {
		this.msgTime = msgTime;
	}
	public String getOperate_time() {
		return operate_time;
	}
	public void setOperate_time(String operate_time) {
		this.operate_time = operate_time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public List<String> getNames() {
		return names;
	}
	public void setNames(List<String> names) {
		this.names = names;
	}
	public List<OrderCpi> getOrderCpis() {
		return orderCpis;
	}
	public void setOrderCpis(List<OrderCpi> orderCpis) {
		this.orderCpis = orderCpis;
	}
	
}
