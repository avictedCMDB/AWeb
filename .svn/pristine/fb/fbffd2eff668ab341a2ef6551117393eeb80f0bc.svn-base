package com.avic.supervise.mappers.bid;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidProjSplit;

@Repository
public interface BidProjSplitMapper {
    public void insertProjSplit(BidProjSplit bidProjSplit);
    public void deleteByProjId(@Param("projId") String projId);
    public List<BidProjSplit> queryListByProj(@Param("projId") String projId);
}
