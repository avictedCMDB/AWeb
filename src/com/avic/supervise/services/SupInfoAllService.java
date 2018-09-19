package com.avic.supervise.services;

import com.avic.supervise.models.SupInfoAll;

public interface SupInfoAllService {
	/**
     * 添加供应商信息
     * 
     * @return
     */
    public void addSupInfoAll(SupInfoAll supInfoAll);
    /**
     * 修改供应商信息
     * 
     * @return
     */
    public void updateSupInfoAll(SupInfoAll supInfoAll);
    
    /**
     * 生成ID
     * 
     * @return
     */
    public String querySupInfoAllIndex();
}
