package com.avic.market.models;

public class GoodsMessage {
    
    public interface Operation {
        public static final int NONE = 0;
        public static final int PRICE = 1;
        public static final int STATE_CHANGE = 10;
        public static final int STATE_ON = 2;
        public static final int STATE_OFF = 3;
        public static final int GOODS_ADD = 4;
        public static final int GOODS_UPDATE = 5;
        public static final int GOODS_DELETE = 6;
    }

    String sku;
    String msgId;
    int operation;
    
    public String getSku() {
        return sku;
    }
    public void setSku(String sku) {
        this.sku = sku;
    }
    public String getMsgId() {
        return msgId;
    }
    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }
    public int getOperation() {
        return operation;
    }
    public void setOperation(int operation) {
        this.operation = operation;
    }
    
    
}
