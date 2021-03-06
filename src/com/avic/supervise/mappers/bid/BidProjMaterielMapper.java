package com.avic.supervise.mappers.bid;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidProjMateriel;

@Repository
public interface BidProjMaterielMapper {
    public void insertProjMateriel(BidProjMateriel bidProjMateriel);
    
    public int queryHistoryMaterielCount(@Param("name") String name, @Param("userId") String userId);
    public List<BidProjMateriel> queryHistoryMaterielList(@Param("name") String name, @Param("userId") String userId, @Param("start") int start, @Param("end") int end);
    
    public void deleteByProjId(@Param("projId") String projId);
    public List<BidProjMateriel> queryListByProj(@Param("projId") String projId);
}
