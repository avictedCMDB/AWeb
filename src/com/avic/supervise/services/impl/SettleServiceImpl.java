package com.avic.supervise.services.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.supervise.mappers.SettleMapper;
import com.avic.supervise.models.SettleData;
import com.avic.supervise.models.SettleRecord;
import com.avic.supervise.services.SettleService;

@Service
public class SettleServiceImpl implements SettleService {
    
    @Autowired
    SettleMapper settleMapper;

    @Transactional
    @Override
    public void insertSettleData(SettleData data) throws ServiceException {
        try {
            settleMapper.insertSettleData(data);
        } catch (Exception e) {
            throw new ServiceException(e);
        }
    }

    @Override
    public int getSettleDataCount(int supId, String timeStart, String timeEnd, String companyName) throws ServiceException {

        if (!StringUtils.isEmpty(timeStart)) {
            timeStart += " 00:00:00";
        }
        
        if (!StringUtils.isEmpty(timeEnd)) {
            timeEnd += " 23:59:59";
        }
        
        return settleMapper.querySettleDataCount(supId, timeStart, timeEnd, companyName);
    }
    @Override
    public List<SettleData> getSettleDataList(int supId, String timeStart, String timeEnd, String companyName, int page, int size)
            throws ServiceException {

        if (!StringUtils.isEmpty(timeStart)) {
            timeStart += " 00:00:00";
        }
        
        if (!StringUtils.isEmpty(timeEnd)) {
            timeEnd += " 23:59:59";
        }
        
        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        return settleMapper.querySettleDataList(supId, timeStart, timeEnd, companyName, start, end);
    }
    
    @Transactional
    @Override
    public String settle(int supId, String timeStart, String timeEnd, String companyName, String operator) throws ServiceException {
        
        try {
            String idx = settleMapper.querySettleIndex();
            
            settleMapper.updateSettleStatus(idx, supId, timeStart + " 00:00:00", timeEnd + " 23:59:59", companyName, operator);
            
            SettleRecord record = settleMapper.querySettleDataStat(idx);
            
            if (record == null || record.getOrderNum() == 0) {
                throw new ServiceException("无待结算数据");
            }
            
            record.setDateStart(timeStart);
            record.setDateEnd(timeEnd);
            record.setSettleId(idx);
            record.setSupId(supId);
            record.setCreateOperator(operator);
            
            settleMapper.insertSettleRecord(record);
            
            return idx;
            
        } catch (ServiceException e) {
            throw e;
        } catch (Exception e) {
            throw new ServiceException("结算失败", e);
        }
    }
    
    @Override
    public int getSettleRecordCount(String timeStart, String timeEnd, String settleId, int supId, int settleStatus) {
        if (!StringUtils.isEmpty(timeStart)) {
            timeStart += " 00:00:00";
        }
        
        if (!StringUtils.isEmpty(timeEnd)) {
            timeEnd += " 23:59:59";
        }
        return settleMapper.querySettleRecordCount(timeStart, timeEnd, settleId, supId, settleStatus);
    }
    
    @Override
    public List<SettleRecord> getSettleRecordList(String timeStart, String timeEnd, String settleId, int supId, int settleStatus, int page,
            int size) throws ServiceException {
        if (!StringUtils.isEmpty(timeStart)) {
            timeStart += " 00:00:00";
        }
        
        if (!StringUtils.isEmpty(timeEnd)) {
            timeEnd += " 23:59:59";
        }
        
        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        return settleMapper.querySettleRecordList(timeStart, timeEnd, settleId, supId, settleStatus, start, end);
    }
    
    @Override
    public List<SettleData> getSettleRecordData(String settleId) throws ServiceException {
        return settleMapper.querySettleRecordData(settleId);
    }
    
    @Override
    public SettleRecord getSettleRecordDetail(String settleId) throws ServiceException {
        return settleMapper.querySettleRecordDetail(settleId);
    }
    
    @Override
    public void effective(List<String> settleId, String operator) throws ServiceException {
        try {
            settleMapper.updateSettleRecordStatus(settleId, operator);
            settleMapper.updateSettleRecordDataStatus(settleId);
        } catch (Exception e) {
            throw new ServiceException("生效失败", e);
        }
    }
}
