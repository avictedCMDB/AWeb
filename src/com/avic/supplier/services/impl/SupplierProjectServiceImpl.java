package com.avic.supplier.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supplier.mappers.SupplierProjectMapper;
import com.avic.supplier.models.BidProjMateriel;
import com.avic.supplier.models.ProjSubject;
import com.avic.supplier.models.ProjSupplier;
import com.avic.supplier.models.ProjTender;
import com.avic.supplier.models.SupplierProject;
import com.avic.supplier.services.SupplierProjectService;


@Service
public class SupplierProjectServiceImpl implements SupplierProjectService {
	
	private static final int PAGE_SIZE = 10;

	@Autowired
	private SupplierProjectMapper supplierProjectMapper;
	
	@Override
	public List<SupplierProject> selectProject(String supCode,String projType, String auditStatus, String compName, String projId,
			String startTime, String endTime, int page, String type) {
		int start = (page - 1) * PAGE_SIZE + 1;
		int end = page * PAGE_SIZE;
		List<SupplierProject> list = supplierProjectMapper.selectProject(supCode,projType, auditStatus, compName, projId, startTime, endTime, start, end, type);
		return list;
	}

	@Override
	public int selectProjectCount(String supCode,String projType, String auditStatus, String compName, String projId, String startTime,
			String endTime, String type) {
		return supplierProjectMapper.selectProjectCount(supCode,projType, auditStatus, compName, projId, startTime, endTime, type);
	}

	@Override
	public void insertBidProjSupplierByProjIdWithSupId(String projId, String supId) {
		supplierProjectMapper.insertBidProjSupplierByProjIdWithSupId(projId, supId);
	}

	@Override
	public SupplierProject selectProjectByProjIdAndSupCode(String projId, String supCode) {
		return supplierProjectMapper.selectProjectByProjIdAndSupCode(projId, supCode);
	}

	@Override
	public SupplierProject selectProjectByProjId(String projId) {
		return supplierProjectMapper.selectProjectByProjId(projId);
	}

	@Override
	public List<ProjSupplier> selectProjSupplier(String projId) {
	    return supplierProjectMapper.selectProjSupplier(projId);
	}
	
	@Override
	public List<ProjSupplier> selectProjectContract(String supCode, String projId, String projName, String feeStatus,
	        String contractStatus, int page, int size) {
	    int start = (page - 1) * PAGE_SIZE + 1;
        int end = page * PAGE_SIZE;
	    return supplierProjectMapper.selectProjectContract(supCode, projId, projName, feeStatus, contractStatus, start, end);
	}
	@Override
	public int selectProjectContractCount(String supCode, String projId, String projName, String feeStatus, String contractStatus) {
	    return supplierProjectMapper.selectProjectContractCount(supCode, projId, projName, feeStatus, contractStatus);
	}
	
	@Override
	public ProjSupplier selectProjSupplierBySupCode(String projId, String supCode) {
	    return supplierProjectMapper.selectProjSupplierBySupCode(projId, supCode);
	}
	
	@Override
	public SupplierProject selectProjectDetailByProjId(String projId) {
	    return supplierProjectMapper.selectProjectDetailByProjId(projId);
	}
	
	@Override
	public List<ProjSubject> selectProjSubject(String projId) {
	    return supplierProjectMapper.selectProjSubject(projId);
	}
	
	@Override
	public List<ProjTender> selectProjTender(String projId, int tenderType) {
	    return supplierProjectMapper.selectProjTender(projId, tenderType);
	}
	
	@Override
	public ProjTender selectProjTenderById(String projId, int tenderType, int tenderId) {
	    return supplierProjectMapper.selectProjTenderById(projId, tenderType, tenderId);
	}
	
	@Override
	public List<BidProjMateriel> queryListByProj(String projId) {
	    return supplierProjectMapper.queryListByProj(projId);
	}
	
	@Override
	public List<BidProjMateriel> querySubjectMtr(String projId, String subjectId) {
	    return supplierProjectMapper.querySubjectMtr(projId, subjectId);
	}
}
