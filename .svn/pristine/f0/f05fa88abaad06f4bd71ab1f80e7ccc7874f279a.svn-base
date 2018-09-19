package com.avic.supplier.services;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.avic.supplier.models.BidProjMateriel;
import com.avic.supplier.models.ProjSubject;
import com.avic.supplier.models.ProjSupplier;
import com.avic.supplier.models.ProjTender;
import com.avic.supplier.models.SupplierProject;

public interface SupplierProjectService {
	
	public List<SupplierProject> selectProject(
	        String supCode,
			String projType,
			String auditStatus,
			String compName,
			String projId,
			String startTime, 
			String endTime, 
			int page, String type);
	
	public int selectProjectCount(String supCode,String projType,String auditStatus,String compName,String projId,String startTime, String endTime, String type);
	public void insertBidProjSupplierByProjIdWithSupId(String projId, String supId);
	public SupplierProject selectProjectByProjIdAndSupCode(String projId, String supCode);
	public SupplierProject selectProjectByProjId(String projId);
	
	public List<ProjSupplier> selectProjSupplier(String projId);
	
	public int selectProjectContractCount(String supCode, String projId, String projName, String feeStatus, String contractStatus);
    public List<ProjSupplier> selectProjectContract(
            String supCode, String projId, String projName, String feeStatus, String contractStatus,
            int page, int size);
    
    public ProjSupplier selectProjSupplierBySupCode(String projId, String supCode);

    public List<BidProjMateriel> queryListByProj(String projId);
    public List<BidProjMateriel> querySubjectMtr(String projId, String subjectId);
    
    public SupplierProject selectProjectDetailByProjId(String projId);
    

    public List<ProjSubject> selectProjSubject(String projId);
    public List<ProjTender> selectProjTender(String projId, int tenderType);
    public ProjTender selectProjTenderById(String projId, int tenderType, int tenderId);
}
