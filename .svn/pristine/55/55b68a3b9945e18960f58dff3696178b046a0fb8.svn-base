package com.avic.supervise.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supervise.models.SettleData;
import com.avic.supervise.models.SettleRecord;

@Repository
public interface SettleMapper {
    public void insertSettleData(SettleData data);
    public List<SettleData> querySettleDataList(@Param("supId") int supId, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("companyName") String companyName, @Param("start") int start, @Param("end") int end);
    public int querySettleDataCount(@Param("supId") int supId, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("companyName") String companyName);
    public String querySettleIndex();
    public void updateSettleStatus(@Param("settleId") String settleId, @Param("supId") int supId, @Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("companyName") String companyName, @Param("operator") String operator);
    public SettleRecord querySettleDataStat(@Param("settleId") String settleId);
    public void insertSettleRecord(SettleRecord record);
    public List<SettleRecord> querySettleRecordList(@Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("settleId") String settleId, @Param("supId") int supId, @Param("settleStatus") int settleStatus, @Param("start") int start, @Param("end") int end);
    public int querySettleRecordCount(@Param("timeStart") String timeStart, @Param("timeEnd") String timeEnd, @Param("settleId") String settleId, @Param("supId") int supId, @Param("settleStatus") int settleStatus);
    public SettleRecord querySettleRecordDetail(@Param("settleId") String settleId);
    public List<SettleData> querySettleRecordData(@Param("settleId") String settleId);
    public void updateSettleRecordStatus(@Param("list") List<String> settleId, @Param("operator") String operator);
    public void updateSettleRecordDataStatus(@Param("list") List<String> settleId);
}
