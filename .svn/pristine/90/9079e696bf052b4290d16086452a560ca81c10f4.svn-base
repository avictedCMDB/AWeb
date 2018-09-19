package com.avic.supervise.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.models.SettleData;
import com.avic.supervise.models.SettleRecord;

public interface SettleService {
    public void insertSettleData(SettleData data) throws ServiceException;
    public int getSettleDataCount(int supId, String timeStart, String timeEnd, String companyName) throws ServiceException;
    public List<SettleData> getSettleDataList(int supId, String timeStart, String timeEnd, String companyName, int page, int size) throws ServiceException;
    public String settle(int supId, String timeStart, String timeEnd, String companyName, String operator) throws ServiceException;
    public List<SettleRecord> getSettleRecordList(String timeStart, String timeEnd, String settleId, int supId, int settleStatus, int page, int size) throws ServiceException;
    public int getSettleRecordCount(String timeStart, String timeEnd, String settleId, int supId, int settleStatus);
    public SettleRecord getSettleRecordDetail(String settleId) throws ServiceException;
    public List<SettleData> getSettleRecordData(String settleId) throws ServiceException;
    public void effective(List<String> settleId, String operator) throws ServiceException;
}
