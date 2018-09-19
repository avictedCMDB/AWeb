package com.avic.supervise.services.bid;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avic.management.models.BidProjMateriel;
import com.avic.management.models.BidProjSubject;
import com.avic.management.models.BidProjTender;
import com.avic.management.models.BidProject;

public interface BidProjectService {
	public void publishProject(BidProject proj);
	
    public int queryHistoryMaterielCount(String name, String userId);
    public List<BidProjMateriel> queryHistoryMaterielList(String name, String userId, int page, int size);
    
    public int queryProjectCount(String userId, String projId, String projName, String bidCat, String createTime, List<String> status,String companyId);
    public List<BidProject> queryProjectList(String userId, String projId, String projName, String bidCat, String createTime, List<String> status, int order, int page, int size,String companyId);
    
    
    public BidProject queryProjectById(String projId);
    public BidProject queryProjectDetail(String projId);
    public void updatePublish(String projId);
    public void deleteProject(String projId);
    
    public void updateProject(BidProject proj);
    
    public void updateProjectAward(String projId, String supCode, String contractTpl, int ifContract);
    public void updateProjectObsolete(String projId, String reason);
    public void updateProjectNotice(String projId);
    
    public List<BidProjSubject> querySubjectList(String projId);

    public void updateProjectPublicity(String projId, String supCode, String publicityStart, String publicityEnd, String purchaserName, String purchaserAddr, String purcharContact);
    
    public String queryProjDeliverAddr(String projId);
    
    public List<BidProjMateriel> queryMaterielByProj(String projId);
    
    public List<BidProjTender> queryBusiTender(String projId);
}
