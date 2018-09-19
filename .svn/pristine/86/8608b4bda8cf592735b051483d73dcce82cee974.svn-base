package com.avic.supplier.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.supplier.models.BidProjMateriel;
import com.avic.supplier.models.ProjSubject;
import com.avic.supplier.models.ProjSupplier;
import com.avic.supplier.models.ProjTender;
import com.avic.supplier.models.SupplierProject;

@Repository
public interface SupplierProjectMapper {
	
	public List<SupplierProject> selectProject(
            @Param("supCode")String supCode,
			@Param("projType")String projType,
			@Param("auditStatus")String auditStatus,
			@Param("compName")String compName,
			@Param("projId")String projId,
			@Param("startTime")String startTime, 
			@Param("endTime")String endTime, 
			@Param("start")int start, 
			@Param("end")int end,
			@Param("type")String type);
	

	public int selectProjectCount(
            @Param("supCode")String supCode,
			@Param("projType")String projType,
			@Param("auditStatus")String auditStatus,
			@Param("compName")String compName,
			@Param("projId")String projId,
			@Param("startTime")String startTime, 
			@Param("endTime")String endTime,
			@Param("type")String type);

	public void insertBidProjSupplierByProjIdWithSupId(@Param("projId")String projId, @Param("supId")String supId);
	public SupplierProject selectProjectByProjIdAndSupCode(@Param("projId")String projId, @Param("supCode")String supCode);
	public SupplierProject selectProjectByProjId(@Param("projId")String projId);
	
	public List<ProjSupplier> selectProjSupplier(@Param("projId") String projId);
	
	public int selectProjectContractCount(
            @Param("supCode")String supCode,
            @Param("projId")String projId,
            @Param("projName")String projName,
            @Param("feeStatus")String feeStatus,
            @Param("contractStatus")String contractStatus
	        );
    public List<ProjSupplier> selectProjectContract(
            @Param("supCode")String supCode,
            @Param("projId")String projId,
            @Param("projName")String projName,
            @Param("feeStatus")String feeStatus,
            @Param("contractStatus")String contractStatus,
            @Param("start")int start, 
            @Param("end")int end
            );
    
    public ProjSupplier selectProjSupplierBySupCode(@Param("projId") String projId, @Param("supCode") String supCode);
    public void updateSupplierContractStatus(@Param("projId") String projId, @Param("supCode") String supCode);
    
    public SupplierProject selectProjectDetailByProjId(@Param("projId") String projId);
    
    public List<ProjSubject> selectProjSubject(@Param("projId") String projId);
    public List<ProjTender> selectProjTender(@Param("projId") String projId, @Param("tenderType") int tenderType);
    public ProjTender selectProjTenderById(@Param("projId") String projId, @Param("tenderType") int tenderType, @Param("tenderId") int tenderId);
    

    public List<BidProjMateriel> queryListByProj(@Param("projId") String projId);
    public List<BidProjMateriel> querySubjectMtr(@Param("projId") String projId, @Param("subjectId") String subjectId);
}
