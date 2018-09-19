package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.BidMessage;

@Repository
public interface BidMessageMapper {
    public void insertMessage(BidMessage message);
    
    public List<BidMessage> queryMessageList(@Param("projId") String projId, @Param("supCode") String supCode, @Param("msgType") int msgType, @Param("msgId") int msgId);
}
