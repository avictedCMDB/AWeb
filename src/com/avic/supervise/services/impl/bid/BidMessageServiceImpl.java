package com.avic.supervise.services.impl.bid;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.models.BidMessage;
import com.avic.supervise.mappers.bid.BidMessageMapper;
import com.avic.supervise.services.bid.BidMessageService;


@Service
public class BidMessageServiceImpl implements BidMessageService {
    
    @Autowired
    BidMessageMapper bidMessageMapper;

    @Override
    public void insertMessage(BidMessage message) {
        bidMessageMapper.insertMessage(message);
    }

    @Override
    public List<BidMessage> queryMessageList(String projId, int msgType, int msgId) {
        return bidMessageMapper.queryMessageList(projId, msgType, msgId);
    }

}
