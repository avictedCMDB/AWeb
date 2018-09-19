package com.avic.supervise.services.impl.bid;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.management.models.BidProjMateriel;
import com.avic.management.models.BidProjSplit;
import com.avic.management.models.BidProjSubject;
import com.avic.management.models.BidProjSupplier;
import com.avic.management.models.BidProjTender;
import com.avic.management.models.BidProject;
import com.avic.management.models.BidSubjectMtr;
import com.avic.supervise.mappers.bid.BidProjMaterielMapper;
import com.avic.supervise.mappers.bid.BidProjSplitMapper;
import com.avic.supervise.mappers.bid.BidProjSubjectMapper;
import com.avic.supervise.mappers.bid.BidProjSupplierMapper;
import com.avic.supervise.mappers.bid.BidProjTenderMapper;
import com.avic.supervise.mappers.bid.BidProjectMapper;
import com.avic.supervise.mappers.bid.SupAreaMapper;
import com.avic.supervise.services.bid.BidProjectService;



@Service
public class BidProjectServiceImpl implements BidProjectService {
    
    @Autowired
    BidProjectMapper bidProjectMapper;
    
    @Autowired
    BidProjMaterielMapper bidProjMaterielMapper;
    
    @Autowired
    BidProjSubjectMapper bidProjSubjectMapper;
    
    @Autowired
    BidProjSplitMapper bidProjSplitMapper;
    
    @Autowired
    BidProjSupplierMapper bidProjSupplierMapper;
    
    @Autowired
    BidProjTenderMapper bidProjTenderMapper;
    
    @Autowired
    SupAreaMapper supAreaMapper;

    @Transactional
    @Override
    public void publishProject(BidProject proj) {
        bidProjectMapper.insertProject(proj);
        
        if (proj.getMateriels() != null && proj.getMateriels().size() > 0) {
            for (BidProjMateriel i : proj.getMateriels()) {
                i.setProjId(proj.getProjId());
                bidProjMaterielMapper.insertProjMateriel(i);
            }
        }
        
        if (proj.getSubjects() != null && proj.getSubjects().size() > 0) {
            for (BidProjSubject i :proj.getSubjects()) {
                i.setProjId(proj.getProjId());
                bidProjSubjectMapper.insertProjSubject(i);
                
                if (i.getMaters() != null) {
                    for (String j : i.getMaters().split(",")) {
                        BidSubjectMtr m = new BidSubjectMtr();
                        m.setMaterSeq(Integer.parseInt(j));
                        m.setProjId(proj.getProjId());
                        m.setSubjectId(i.getSubjectId());
                        bidProjSubjectMapper.insertSubjectMtr(m);
                    }
                }
            }
        }
        
        if (proj.getSplits() != null && proj.getSplits().size() > 0) {
            for (BidProjSplit i : proj.getSplits()) {
                i.setProjId(proj.getProjId());
                bidProjSplitMapper.insertProjSplit(i);
            }
        }
        
        if (proj.getProjType() == 1 && proj.getSuppliers() != null && proj.getSuppliers().size() > 0) {
            Set<String> nums = new HashSet<String>();
            for (BidProjSupplier i : proj.getSuppliers()) {
                String num = null;
                do {
                    num = RandomStringUtils.random(3, "0123456789");
                } while(nums.contains(num));
                i.setBidNum("BH" + num);
                i.setProjId(proj.getProjId());
                i.setJoinType(1);
                i.setAuditStatus(2);
                bidProjSupplierMapper.insertProjSupplier(i);
            }
        }
        
        if (proj.getTenders() != null && proj.getTenders().size() > 0) {
            for (BidProjTender i : proj.getTenders()) {
                i.setProjId(proj.getProjId());
                bidProjTenderMapper.insertProjTender(i);
            }
        }
    }
    
    @Override
    public int queryHistoryMaterielCount(String name, String userId) {
        return bidProjMaterielMapper.queryHistoryMaterielCount(name, userId);
    }
    
    @Override
    public List<BidProjMateriel> queryHistoryMaterielList(String name, String userId, int page, int size) {

        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        return bidProjMaterielMapper.queryHistoryMaterielList(name, userId, start, end);
    }
    
    @Override
    public int queryProjectCount(String userId, String projId, String projName, String bidCat, String createTime, List<String> status,String companyId) {
        return bidProjectMapper.queryProjectCount(userId, projId, projName, bidCat, createTime, status,companyId);
    }
    
    @Override
    public List<BidProject> queryProjectList(String userId, String projId, String projName, String bidCat, String createTime, List<String> status, int order,
            int page, int size,String companyId) {
        if (page < 1) {
            page = 1;
        }
        
        int start = (page - 1) * size + 1;
        int end  = start + size - 1;
        return bidProjectMapper.queryProjectList(userId, projId, projName, bidCat, createTime, status, order, start, end,companyId);
    }

    @Transactional
    @Override
    public void deleteProject(String projId) {
        bidProjectMapper.deleteProjectById(projId);
        bidProjMaterielMapper.deleteByProjId(projId);
        bidProjSubjectMapper.deleteSubjectByProjId(projId);
        bidProjSubjectMapper.deleteSubjectMtrByProjId(projId);
        bidProjSplitMapper.deleteByProjId(projId);
        bidProjSupplierMapper.deleteByProjId(projId);
        bidProjTenderMapper.deleteByProjId(projId);
    }
    @Override
    public BidProject queryProjectById(String projId) {
        return bidProjectMapper.queryProjectById(projId);
    }
    @Override
    public void updatePublish(String projId) {
        bidProjectMapper.updateProjectPublish(projId);
    }
    
    @Override
    public BidProject queryProjectDetail(String projId) {
        BidProject proj = bidProjectMapper.queryProjectById(projId);
        
        if (proj != null) {
            proj.setMateriels(bidProjMaterielMapper.queryListByProj(projId));
            proj.setSubjects(bidProjSubjectMapper.querySubjectListByProj(projId));
            
            if (proj.getSubjects() != null) {
                for (BidProjSubject i : proj.getSubjects()) {
                    List<BidSubjectMtr> mtr = bidProjSubjectMapper.querySubjectMtrListBySubject(projId, i.getSubjectId());
                    if (mtr != null) {
                        StringBuffer strbuf = new StringBuffer();
                        for (BidSubjectMtr j : mtr) {
                            strbuf.append(j.getMaterSeq()).append(",");
                        }
                        
                        i.setMaters(strbuf.substring(0, strbuf.length() - 1));
                    }
                }
            }
            
            proj.setSplits(bidProjSplitMapper.queryListByProj(projId));
            proj.setSuppliers(bidProjSupplierMapper.querySupInfoByProj(projId));
            proj.setTenders(bidProjTenderMapper.queryListByProj(projId));
            
            if (proj.getTenders() != null) {
                
                for (BidProjTender i : proj.getTenders()) {
                    if (i.getTenderType() == 1) {
                        i.setAddrProvName(supAreaMapper.queryAreaById("1", i.getAddrProv()).getSupAreaName());
                        i.setAddrCityName(supAreaMapper.queryAreaById("1", i.getAddrCity()).getSupAreaName());
                        i.setAddrDistName(supAreaMapper.queryAreaById("1", i.getAddrDist()).getSupAreaName());
                    }
                }
            }
            
        }
        
        
        return proj;
    }
    
    @Transactional
    @Override
    public void updateProject(BidProject proj) {
        
        String projId = proj.getProjId();
        
        bidProjectMapper.updateProject(proj);

        bidProjMaterielMapper.deleteByProjId(projId);
        bidProjSubjectMapper.deleteSubjectByProjId(projId);
        bidProjSubjectMapper.deleteSubjectMtrByProjId(projId);
        bidProjSplitMapper.deleteByProjId(projId);
        bidProjSupplierMapper.deleteByProjId(projId);
        bidProjTenderMapper.deleteByProjId(projId);
        

        if (proj.getMateriels() != null && proj.getMateriels().size() > 0) {
            for (BidProjMateriel i : proj.getMateriels()) {
                i.setProjId(proj.getProjId());
                bidProjMaterielMapper.insertProjMateriel(i);
            }
        }
        
        if (proj.getSubjects() != null && proj.getSubjects().size() > 0) {
            for (BidProjSubject i :proj.getSubjects()) {
                i.setProjId(proj.getProjId());
                bidProjSubjectMapper.insertProjSubject(i);
                
                if (i.getMaters() != null) {
                    for (String j : i.getMaters().split(",")) {
                        BidSubjectMtr m = new BidSubjectMtr();
                        m.setMaterSeq(Integer.parseInt(j));
                        m.setProjId(proj.getProjId());
                        m.setSubjectId(i.getSubjectId());
                        bidProjSubjectMapper.insertSubjectMtr(m);
                    }
                }
            }
        }
        
        if (proj.getSplits() != null && proj.getSplits().size() > 0) {
            for (BidProjSplit i : proj.getSplits()) {
                i.setProjId(proj.getProjId());
                bidProjSplitMapper.insertProjSplit(i);
            }
        }
        
        if (proj.getProjType() == 1 && proj.getSuppliers() != null && proj.getSuppliers().size() > 0) {
            Set<String> nums = new HashSet<String>();
            for (BidProjSupplier i : proj.getSuppliers()) {
                String num = null;
                do {
                    num = RandomStringUtils.random(3, "0123456789");
                } while(nums.contains(num));
                i.setBidNum("BH" + num);
                i.setProjId(proj.getProjId());
                i.setJoinType(1);
                i.setAuditStatus(2);
                bidProjSupplierMapper.insertProjSupplier(i);
            }
        }
        
        if (proj.getTenders() != null && proj.getTenders().size() > 0) {
            for (BidProjTender i : proj.getTenders()) {
                i.setProjId(proj.getProjId());
                bidProjTenderMapper.insertProjTender(i);
            }
        }
    }
    
    @Override
    public void updateProjectNotice(String projId) {
        bidProjectMapper.updateProjectNotice(projId);
    }
    
    @Transactional
    @Override
    public void updateProjectObsolete(String projId, String reason) {
        bidProjectMapper.updateProjectObsolete(projId, reason);
        bidProjSupplierMapper.updateSupplierObsolete(projId);
    }
    
    @Transactional
    @Override
    public void updateProjectAward(String projId, String supCode, String contractTpl, int ifContract) {
        bidProjectMapper.updateProjectAward(projId, contractTpl, ifContract);
        bidProjSupplierMapper.updateSupplierAward(projId, supCode);
    }
    
    @Override
    public List<BidProjSubject> querySubjectList(String projId) {
        return bidProjSubjectMapper.querySubjectListByProj(projId);
    }
    
    @Transactional
    @Override
    public void updateProjectPublicity(String projId, String supCode, String publicityStart, String publicityEnd, String purchaserName, String purchaserAddr, String purchaserContact) {
        bidProjectMapper.updateProjectPublicity(projId, publicityStart, publicityEnd, purchaserName, purchaserAddr, purchaserContact);
        bidProjSupplierMapper.updateSupplierAward(projId, supCode);
    }
    
    @Override
    public String queryProjDeliverAddr(String projId) {
        
        List<BidProjTender> tenders = bidProjTenderMapper.queryListByType(projId, 1);
        return supAreaMapper.queryAreaById("1", tenders.get(0).getAddrCity()).getSupAreaName();
    }
    
    @Override
    public List<BidProjTender> queryBusiTender(String projId) {
        
        return bidProjTenderMapper.queryListByType(projId, 1);
    }
    
    @Override
    public List<BidProjMateriel> queryMaterielByProj(String projId) {
        return bidProjMaterielMapper.queryListByProj(projId);
    }
   
}