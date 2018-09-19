package com.avic.market.services;

import java.util.List;

import com.avic.market.models.BidMessage;

public interface BidMessageService {
    public void insertMessage(BidMessage message);
    public List<BidMessage> getMessageList(String projId, String supCode, int msgType, int msgId);
}
