package com.avic.market.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.BidMessageMapper;
import com.avic.market.models.BidMessage;
import com.avic.market.services.BidMessageService;

@Service
public class BidMessageServiceImpl implements BidMessageService {
    
    @Autowired
    BidMessageMapper bidMessageMapper;
    
    @Override
    public void insertMessage(BidMessage message) {
        bidMessageMapper.insertMessage(message);
    }
    
    @Override
    public List<BidMessage> getMessageList(String projId, String supCode, int msgType, int msgId) {
        return bidMessageMapper.queryMessageList(projId, supCode, msgType, msgId);
    }
}
