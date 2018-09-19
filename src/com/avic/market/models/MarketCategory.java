package com.avic.market.models;

import java.util.List;

public class MarketCategory {
    String marketCatName;
    int marketCatLevel;
    String parentId;
    String marketCatId;
    int ifValid;
    
    List<MarketCategory> subs;
    
    public List<MarketCategory> getSubs() {
        return subs;
    }
    
    public void setSubs(List<MarketCategory> subs) {
        this.subs = subs;
    }
    
    public String getMarketCatName() {
        return marketCatName;
    }
    public void setMarketCatName(String marketCatName) {
        this.marketCatName = marketCatName;
    }
    public int getMarketCatLevel() {
        return marketCatLevel;
    }
    public void setMarketCatLevel(int marketCatLevel) {
        this.marketCatLevel = marketCatLevel;
    }
    public String getParentId() {
        return parentId;
    }
    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    public String getMarketCatId() {
        return marketCatId;
    }
    public void setMarketCatId(String marketCatId) {
        this.marketCatId = marketCatId;
    }
    public int getIfValid() {
        return ifValid;
    }
    public void setIfValid(int ifValid) {
        this.ifValid = ifValid;
    }
    
    
}
