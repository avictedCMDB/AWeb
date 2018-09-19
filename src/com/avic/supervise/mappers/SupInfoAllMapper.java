package com.avic.supervise.mappers;

import org.springframework.stereotype.Repository;

import com.avic.supervise.models.SupInfoAll;


@Repository
public interface SupInfoAllMapper {
    /**
     * ��ӹ�Ӧ����Ϣ
     * 
     * @return
     */
    public void addSupInfoAll(SupInfoAll supInfoAll);
    
    /**
     * �޸Ĺ�Ӧ����Ϣ
     * 
     * @return
     */
    public void updateSupInfoAll(SupInfoAll supInfoAll);
    
    /**
     * ����ID
     * 
     * @return
     */
    public String querySupInfoAllIndex();
}
