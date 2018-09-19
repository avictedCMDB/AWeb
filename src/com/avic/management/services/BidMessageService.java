package com.avic.management.services;

import java.util.List;

import com.avic.management.models.BidMessage;

public interface BidMessageService {
    public void insertMessage(BidMessage message);
    public List<BidMessage> queryMessageList(String projId, int msgType, int msgId);
}
