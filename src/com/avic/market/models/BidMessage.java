package com.avic.market.models;

import java.util.Date;

public class BidMessage {
    Integer msgId;
    String projId;
    String supCode;
    int sendType;
    String msgContent;
    Date sendTime;
    int msgType;
    
    
    public Integer getMsgId() {
        return msgId;
    }
    public void setMsgId(Integer msgId) {
        this.msgId = msgId;
    }
    public String getProjId() {
        return projId;
    }
    public void setProjId(String projId) {
        this.projId = projId;
    }
    public String getSupCode() {
        return supCode;
    }
    public void setSupCode(String supCode) {
        this.supCode = supCode;
    }
    public int getSendType() {
        return sendType;
    }
    public void setSendType(int sendType) {
        this.sendType = sendType;
    }
    public String getMsgContent() {
        return msgContent;
    }
    public void setMsgContent(String msgContent) {
        this.msgContent = msgContent;
    }
    public Date getSendTime() {
        return sendTime;
    }
    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }
    public int getMsgType() {
        return msgType;
    }
    public void setMsgType(int msgType) {
        this.msgType = msgType;
    }
    
    
}
