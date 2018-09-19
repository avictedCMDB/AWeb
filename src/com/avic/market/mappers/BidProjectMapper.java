package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.BidProject;


@Repository
public interface BidProjectMapper {
    public int queryProjectCount(@Param("projName") String projName, @Param("addrProv") String addrProv, @Param("companyId") String companyId, @Param("bidCat") String bidCat);
    public List<BidProject> queryProjectList(@Param("projName") String projName, @Param("addrProv") String addrProv, @Param("companyId") String companyId, @Param("bidCat") String bidCat, @Param("order") int order, @Param("start") int start, @Param("end") int end);
    
    public List<BidProject> queryRecommProject();
    public List<BidProject> queryExpiringProject();

    public int queryNoticeCount(@Param("projName") String projName, @Param("addrProv") String addrProv, @Param("companyId") String companyId, @Param("bidCat") String bidCat);
    public List<BidProject> queryNoticeList(@Param("projName") String projName, @Param("addrProv") String addrProv, @Param("companyId") String companyId, @Param("bidCat") String bidCat, @Param("start") int start, @Param("end") int end);
    
    public BidProject queryProjectById(@Param("projId") String projId);
    
    public void updateTimeoutEndTime(@Param("projId") String projId);
    
    public int queryResultCount(@Param("projName") String projName, @Param("addrProv") String addrProv, @Param("companyId") String companyId, @Param("bidCat") String bidCat, @Param("projStatus") int projStatus);
    public List<BidProject> queryResultList(@Param("projName") String projName, @Param("addrProv") String addrProv, @Param("companyId") String companyId, @Param("bidCat") String bidCat, @Param("projStatus") int projStatus,  @Param("start") int start, @Param("end") int end);
    
    
    public int queryAllProjectCount();
    public int queryAllProjectAmount();
    
}
