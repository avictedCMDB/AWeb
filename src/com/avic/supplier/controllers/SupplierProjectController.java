package com.avic.supplier.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.supplier.models.BidProjMateriel;
import com.avic.supplier.models.ProjTender;
import com.avic.supplier.models.SupplierProject;
import com.avic.supplier.services.SupplierProjectService;
import com.avic.supplier.utils.NewExcel;

@Controller
@RequestMapping("/project")
public class SupplierProjectController {

	private static final int PAGE_SIZE = 10;
	@Autowired
	private SupplierProjectService supplierProjectService;
	private Log logger = LogFactory.getLog(SupplierProjectController.class);
	
	@RequestMapping("public")
	public String publicProject (
			Model model,
			String projType,
			String auditStatus,
			String compName,
			String projId,
			String startTime, 
			String endTime,
			@RequestParam(value = "page", defaultValue = "1") int page,
			HttpSession session) throws UnsupportedEncodingException {
		logger.debug("项目管理-最新公开的项目");
        String supCode = (String) session.getAttribute(SessionKeys.SUP_CODE);
		
		//page
		int total = supplierProjectService.selectProjectCount(supCode, projType, auditStatus, compName, projId, startTime, endTime, "public");
		int pages = (int) Math.ceil((double)total / PAGE_SIZE);
		//data
		List<SupplierProject> data = new ArrayList<SupplierProject>();
		if (total > 0) {
			data = supplierProjectService.selectProject(supCode, projType, auditStatus, compName, projId, startTime, endTime, page, "public");
		}
		
		model.addAttribute("pageAction", "supplier/project/public?"
				+ "projType=" + (projType == null ? "" : projType) 
				+ "&auditStatus=" + (auditStatus == null ? "" : auditStatus)
				+ "&compName=" + (compName == null ? "" : URLEncoder.encode(compName, "GBK"))
				+ "&projId=" + (projId == null ? "" : URLEncoder.encode(projId, "GBK"))
				+ "&startTime=" + (startTime == null ? "" : startTime)
				+ "&endTime=" + (endTime == null ? "" : endTime)
				+ "&page=%PAGE%");
		model.addAttribute("projType", projType);
		model.addAttribute("auditStatus", auditStatus);
		model.addAttribute("compName", compName);
		model.addAttribute("projId", projId);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("data", data);
		model.addAttribute("page", page);
		model.addAttribute("pages", pages);
		return "project/supplier_project_public";
	}
	@RequestMapping("underway")
	public String projectUnderway (
			Model model,
			String projType,
			String projStatus,
			String compName,
			String projId,
			String startTime, 
			String endTime,
			@RequestParam(value = "page", defaultValue = "1")int page,
            HttpSession session) throws UnsupportedEncodingException {
        String supCode = (String) session.getAttribute(SessionKeys.SUP_CODE);
		//page
		int total = supplierProjectService.selectProjectCount(supCode,projType, projStatus, compName, projId, startTime, endTime, "underway");
		int pages = (int) Math.ceil((double)total / PAGE_SIZE);
		//data
		List<SupplierProject> data = new ArrayList<SupplierProject>();
		if (total > 0) {
			data = supplierProjectService.selectProject(supCode,projType, projStatus, compName, projId, startTime, endTime, page, "underway");
		}
		
		model.addAttribute("pageAction", "supplier/project/underway?"
				+ "projType=" + (projType == null ? "" : projType) 
				+ "&projStatus=" + (projStatus == null ? "" : projStatus)
				+ "&compName=" + (compName == null ? "" : URLEncoder.encode(compName, "GBK"))
				+ "&projId=" + (projId == null ? "" : URLEncoder.encode(projId, "GBK"))
				+ "&startTime=" + (startTime == null ? "" : startTime)
				+ "&endTime=" + (endTime == null ? "" : endTime)
				+ "&page=%PAGE%");
		model.addAttribute("projType", projType);
		model.addAttribute("projStatus", projStatus);
		model.addAttribute("compName", compName);
		model.addAttribute("projId", projId);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("data", data);
		model.addAttribute("page", page);
		model.addAttribute("pages", pages);
		return "project/supplier_project_underway";
	}
	@RequestMapping("over")
	public String projectOver (
			Model model,
			String projType,
			String projStatus,
			String compName,
			String projId,
			String startTime, 
			String endTime,
			@RequestParam(value = "page", defaultValue = "1")int page,
            HttpSession session) throws UnsupportedEncodingException {
        String supCode = (String) session.getAttribute(SessionKeys.SUP_CODE);
		//page
		int total = supplierProjectService.selectProjectCount(supCode,projType, projStatus, compName, projId, startTime, endTime, "over");
		int pages = (int) Math.ceil((double)total / PAGE_SIZE);
		//data
		List<SupplierProject> data = new ArrayList<SupplierProject>();
		if (total > 0) {
			data = supplierProjectService.selectProject(supCode,projType, projStatus, compName, projId, startTime, endTime, page, "over");
		}
		
		model.addAttribute("pageAction", "supplier/project/over?"
				+ "projType=" + (projType == null ? "" : projType) 
				+ "&projStatus=" + (projStatus == null ? "" : projStatus)
				+ "&compName=" + (compName == null ? "" : URLEncoder.encode(compName, "GBK"))
				+ "&projId=" + (projId == null ? "" : URLEncoder.encode(projId, "GBK"))
				+ "&startTime=" + (startTime == null ? "" : startTime)
				+ "&endTime=" + (endTime == null ? "" : endTime)
				+ "&page=%PAGE%");
		model.addAttribute("projType", projType);
		model.addAttribute("projStatus", projStatus);
		model.addAttribute("compName", compName);
		model.addAttribute("projId", projId);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("data", data);
		model.addAttribute("page", page);
		model.addAttribute("pages", pages);
		return "project/supplier_project_over";
	}
	
	@RequestMapping("join_project")
	@ResponseBody
	public ResultObject joinProject(HttpSession session, String projId) {
		String supCode = (String) session.getAttribute(SessionKeys.SUP_CODE);
		String supType = (String) session.getAttribute(SessionKeys.SUP_TYPE);
		if (!"1".equals(supType)) {
			return new ResultObject(ResultObject.FAIL, "不是竞价供应商！");
		}
		SupplierProject p = supplierProjectService.selectProjectByProjIdAndSupCode(projId, supCode);
		if (p != null) {
			return new ResultObject(ResultObject.FAIL, "重复报名！");
		}
		p = supplierProjectService.selectProjectByProjId(projId);
		if (p.getProjType() == 1) {
			return new ResultObject(ResultObject.FAIL, "您没有被邀请!");
		}
		if (p.getProjStatus() != 2 || new Date().after(p.getJoinEndTime())) {
			return new ResultObject(ResultObject.FAIL, "报名已截至！");
		}
		supplierProjectService.insertBidProjSupplierByProjIdWithSupId(projId, supCode);;
		return new ResultObject(ResultObject.OK, "您已报名成功，请耐心等待审核结果！");
	}

    @RequestMapping("query")
	public String query(
            Model model,HttpSession session, String projId) {
        String supCode = (String) session.getAttribute(SessionKeys.SUP_CODE);
        
        SupplierProject proj = supplierProjectService.selectProjectByProjId(projId);

        model.addAttribute("supCode", supCode);
        model.addAttribute("proj", proj);
        model.addAttribute("list", supplierProjectService.selectProjSupplier(projId));
        
        return "project/supplier_project_query";
	}
	
    @RequestMapping("detail")
    public String detail(
            Model model,HttpSession session, String projId) {
        
        model.addAttribute("subject", supplierProjectService.selectProjSubject(projId));
        model.addAttribute("tender1", supplierProjectService.selectProjTender(projId, 1));
        model.addAttribute("tender2", supplierProjectService.selectProjTender(projId, 2));
        model.addAttribute("proj", supplierProjectService.selectProjectDetailByProjId(projId));
        return "project/supplier_project_detail";
    }
    

    @RequestMapping("/download")
    public void download(String projId, int tenderType, int tenderId, HttpServletRequest reqeust, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("multipart/form-data");
        ProjTender tender = supplierProjectService.selectProjTenderById(projId, tenderType, tenderId);
        String fileName = reqeust.getSession().getServletContext().getRealPath("/") + tender.getAttachPath();
        response.setHeader("Content-Disposition", "attachment;fileName=" + java.net.URLEncoder.encode(tender.getAttachName(), "UTF-8"));
        try {
            File file = new File(fileName);
            InputStream inputStream = new FileInputStream(file);
            OutputStream os = response.getOutputStream();
            byte[] b = new byte[1024];
            int length;
            while ((length = inputStream.read(b)) > 0) {
                os.write(b, 0, length);
            }
            inputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    

    @RequestMapping("/export/mtr")
    public void exportMtr(@RequestParam("projId") String projId, @RequestParam("subjectId") String subjectId, HttpServletResponse resp) throws IOException {

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/x-download");

        String filedisplay = "标的商品.xls";
        filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
        resp.addHeader("Content-Disposition", "attachment;filename=" + filedisplay);

        List<BidProjMateriel> mtrs = supplierProjectService.querySubjectMtr(projId, subjectId);
        
        if (mtrs != null) {

            List<String> columnName = Arrays.asList(new String[] { "物料名称", "数量", "单位", "品牌", "型号", "是否标配", "售后服务", "规格配置" });

            List<List<String>> values = new ArrayList<List<String>>();
            int idx = 1;
            for (BidProjMateriel i : mtrs) {
                List<String> item = new ArrayList<String>();
                item.add(i.getMaterName());
                item.add(String.valueOf(i.getMaterNum()));
                item.add(i.getMaterUnit());
                item.add(i.getMaterBrand());
                item.add(i.getMaterModel());
                item.add(i.getIfStandard());
                item.add(i.getSaleService());
                item.add(i.getSpecConf());
                
                values.add(item);
            }
            
            
            NewExcel.createExcel(resp, columnName, values);
        }

    }
}
