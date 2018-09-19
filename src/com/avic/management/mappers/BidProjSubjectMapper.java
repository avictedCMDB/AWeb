package com.avic.management.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidProjSubject;
import com.avic.management.models.BidSubjectMtr;

@Repository
public interface BidProjSubjectMapper {
    public void insertProjSubject(BidProjSubject bidProjSubject);
    public void insertSubjectMtr(BidSubjectMtr bidSubjectMtr);
    
    public void deleteSubjectByProjId(@Param("projId") String projId);
    public void deleteSubjectMtrByProjId(@Param("projId") String projId);
    
    public List<BidProjSubject> querySubjectListByProj(@Param("projId") String projId);
    public List<BidSubjectMtr> querySubjectMtrListBySubject(@Param("projId") String projId, @Param("subjectId") String subjectId);
}
