package com.avic.market.models;

import java.util.List;

public class SysCategory {
    private int sysCatId;
    private String sysCatName;
    private int sysCatLevel;
    private int parentId;
    private int showOrder;
    private List<SysCategory> childCategory;
    public int getSysCatId() {
        return sysCatId;
    }
    public void setSysCatId(int sysCatId) {
        this.sysCatId = sysCatId;
    }
    public String getSysCatName() {
        return sysCatName;
    }
    public void setSysCatName(String sysCatName) {
        this.sysCatName = sysCatName;
    }
    public int getSysCatLevel() {
        return sysCatLevel;
    }
    public void setSysCatLevel(int sysCatLevel) {
        this.sysCatLevel = sysCatLevel;
    }
    public int getParentId() {
        return parentId;
    }
    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
    public int getShowOrder() {
        return showOrder;
    }
    public void setShowOrder(int showOrder) {
        this.showOrder = showOrder;
    }
    public List<SysCategory> getChildCategory() {
        return childCategory;
    }
    public void setChildCategory(List<SysCategory> childCategory) {
        this.childCategory = childCategory;
    }
    
}
