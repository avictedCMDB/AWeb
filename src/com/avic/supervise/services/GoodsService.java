package com.avic.supervise.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.models.Goods;
import com.avic.supervise.models.TradeRecord;

public interface GoodsService {
    public Goods getGoodsDetail(int supId, String supGoodsId) throws ServiceException;
    public List<TradeRecord> getTradeRecordList(int supId, String supGoodsId, int page, int size) throws ServiceException;
    public int getTradeRecordCount(int supId, String supGoodsId) throws ServiceException;
}
