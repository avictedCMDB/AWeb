package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.Goods;
import com.avic.supervise.models.TradeRecord;


@Repository
public interface GoodsMapper {
    public Goods queryGoodsById(@Param("supId") int supId, @Param("supGoodsId") String supGoodsId);
    public List<TradeRecord> queryTradeRecordList(@Param("supId") int supId, @Param("supGoodsId") String supGoodsId, @Param("start") int start, @Param("end") int end);
    public int queryTradeRecordCount(@Param("supId") int supId, @Param("supGoodsId") String supGoodsId);
    public List<String> queryGoodsImage(@Param("supId") int supId, @Param("supGoodsId") String supGoodsId);
    
}
