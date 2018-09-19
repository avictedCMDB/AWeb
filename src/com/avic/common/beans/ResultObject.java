package com.avic.common.beans;

public class ResultObject {
    
    public static int OK = 0;
    public static int FAIL = 1;
    public static int ALIPAYREFUND = 2;

    int status;
    Object result;
    
    public ResultObject(int status, Object result) {
        this.status = status;
        this.result = result;
    }
    
    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
    public Object getResult() {
        return result;
    }
    public void setResult(Object result) {
        this.result = result;
    }
    
    
}
