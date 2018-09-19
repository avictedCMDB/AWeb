package com.avic.management.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidProjTender;

@Repository
public interface BidProjTenderMapper {
    public void insertProjTender(BidProjTender bidProjTender);
    public void deleteByProjId(@Param("projId") String projId);
    
    public List<BidProjTender> queryListByProj(@Param("projId") String projId);
    public List<BidProjTender> queryListByType(@Param("projId") String projId, @Param("type") int type);
}
