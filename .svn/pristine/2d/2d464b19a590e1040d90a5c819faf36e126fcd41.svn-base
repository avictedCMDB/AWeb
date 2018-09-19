package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.BidProjMateriel;
import com.avic.market.models.BidProjSubject;

@Repository
public interface BidProjSubjectMapper {
    public List<BidProjSubject> querySubjectList(@Param("projId") String projId);
    public List<BidProjMateriel> querySubjectMtr(@Param("projId") String projId, @Param("subjectId") String subjectId);
}
