package com.avic.supervise.models;

import java.util.Date;

public class SettleRecord {
    private String settleId;
    private int supId;
    private int orderNum;
    private int goodsNum;
    private double settleAmount;
    private String dateStart;
    private String dateEnd;
    private int settleStatus;
    private Date createTime;
    private String createOperator;
    private Date completeTime;
    private String completeOperator;
    private String supName;
    public String getSupName() {
        return supName;
    }
    public void setSupName(String supName) {
        this.supName = supName;
    }
    public void setSettleId(String settleId) {
        this.settleId = settleId;
    }
    public String getSettleId() {
        return settleId;
    }
    public int getSupId() {
        return supId;
    }
    public void setSupId(int supId) {
        this.supId = supId;
    }
    public int getOrderNum() {
        return orderNum;
    }
    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }
    public int getGoodsNum() {
        return goodsNum;
    }
    public void setGoodsNum(int goodsNum) {
        this.goodsNum = goodsNum;
    }
    public double getSettleAmount() {
        return settleAmount;
    }
    public void setSettleAmount(double settleAmount) {
        this.settleAmount = settleAmount;
    }
    public String getDateStart() {
        return dateStart;
    }
    public void setDateStart(String dateStart) {
        this.dateStart = dateStart;
    }
    public String getDateEnd() {
        return dateEnd;
    }
    public void setDateEnd(String dateEnd) {
        this.dateEnd = dateEnd;
    }
    public int getSettleStatus() {
        return settleStatus;
    }
    public void setSettleStatus(int settleStatus) {
        this.settleStatus = settleStatus;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getCompleteTime() {
        return completeTime;
    }
    public void setCompleteTime(Date completeTime) {
        this.completeTime = completeTime;
    }
    public String getCompleteOperator() {
        return completeOperator;
    }
    public void setCompleteOperator(String completeOperator) {
        this.completeOperator = completeOperator;
    }
    public String getCreateOperator() {
        return createOperator;
    }
    public void setCreateOperator(String createOperator) {
        this.createOperator = createOperator;
    }
    
}
