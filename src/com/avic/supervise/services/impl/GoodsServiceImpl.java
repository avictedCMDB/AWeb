package com.avic.supervise.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.mappers.GoodsMapper;
import com.avic.supervise.models.Goods;
import com.avic.supervise.models.TradeRecord;
import com.avic.supervise.services.GoodsService;

@Service
public class GoodsServiceImpl implements GoodsService {
    protected static final Log logger = LogFactory.getLog(GoodsServiceImpl.class);
    
    @Autowired
    GoodsMapper goodsMapper;

    @Override
    public Goods getGoodsDetail(int supId, String supGoodsId) throws ServiceException {
        logger.info("获取商品详情Service--supId["+supId+"], supGoodsId["+supGoodsId+"]");
        Goods goods = goodsMapper.queryGoodsById(supId, supGoodsId);
        if (goods != null) {
            goods.setImages(goodsMapper.queryGoodsImage(supId, supGoodsId));
        }
        return goods;
    }
    
    
    @Override
    public int getTradeRecordCount(int supId, String supGoodsId) throws ServiceException {
        logger.info("商品交易记录数量Service--supId["+supId+"], supGoodsId["+supGoodsId+"]");
        
        return goodsMapper.queryTradeRecordCount(supId, supGoodsId);
    }
    
    @Override
    public List<TradeRecord> getTradeRecordList(int supId, String supGoodsId, int page, int size) throws ServiceException {
        logger.info("商品查询Service--supId["+supId+"], supGoodsId["+supGoodsId+"], page["+page+"], size["+size+"]");
        
        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        
        
        return goodsMapper.queryTradeRecordList(supId, supGoodsId, start, end);
    }
    
}
