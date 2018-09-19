package com.avic.supervise.mappers.bid;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.BidProject;

@Repository
public interface BidProjectMapper {
    public void insertProject(BidProject proj);
    public int queryProjectCount(@Param("userId") String userId, @Param("projId") String projId, @Param("projName") String projName, @Param("bidCat") String bidCat, @Param("createTime") String createTime, @Param("status") List<String> status,@Param("companyId") String companyId);
    public List<BidProject> queryProjectList(@Param("userId") String userId, @Param("projId") String projId, @Param("projName") String projName, @Param("bidCat") String bidCat, @Param("createTime") String createTime, @Param("status") List<String> status, @Param("order") int order, @Param("start") int start, @Param("end") int end,@Param("companyId") String companyId);
    
    public BidProject queryProjectById(@Param("projId") String projId);
    public void updateProjectPublish(@Param("projId") String projId);
    public void deleteProjectById(@Param("projId") String projId);
    
    public void updateProject(BidProject proj);
    
    public void updateProjectAward(@Param("projId") String projId, @Param("contractTpl") String contractTpl, @Param("ifContract") int ifContract);
    public void updateProjectObsolete(@Param("projId") String projId, @Param("reason") String reason);
    public void updateProjectNotice(@Param("projId") String projId);
    
    public void updateProjectPublicity(@Param("projId") String projId, @Param("publicityStart") String publicityStart, @Param("publicityEnd") String publicityEnd, @Param("purchaserName") String purchaserName, @Param("purchaserAddr") String purchaserAddr, @Param("purchaserContact") String purchaserContact);
    }