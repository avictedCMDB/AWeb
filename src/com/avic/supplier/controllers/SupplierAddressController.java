package com.avic.supplier.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SessionKeys;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.supplier.models.SupArea;
import com.avic.supplier.models.SupplierAddress;
import com.avic.supplier.services.SupAreaService;
import com.avic.supplier.services.SupplierAddressService;
import com.avic.supplier.utils.CodeConstants;

@Controller
@RequestMapping("/address")
public class SupplierAddressController {
    protected static final Log logger = LogFactory.getLog(SupplierAddressController.class);
    
    @Autowired
    SupplierAddressService supplierAddressService;
    
    @Autowired
	SupAreaService areaService;
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     */
    @RequestMapping("")
    public String index(Map<String, Object> map,HttpSession httpSession) {
        logger.info("��Ӧ�̵�ַ�������Ϣ");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        SupplierAddress supplierAddress = new SupplierAddress();
        supplierAddress.setSupId(supId);
      //��ͳ��Ӧ��Ĭ�ϵ�ַΪ�����ַ
		if ("1".equals(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString())) {
			// ����Ϊ�����ַ
			supplierAddress.setAreSupId("1");
			
		}else {
			supplierAddress.setAreSupId(supId);
		}
        List<SupplierAddress> supplierAddressList = supplierAddressService.querySupplierAddressList(supplierAddress);
        map.put("supplierAddressList", supplierAddressList);
        //��ҳ��Ϣ
		String page = String.valueOf(supplierAddress.getPage());
		
        int total = supplierAddressService.querySupplierAddressListCount(supplierAddress);

        int pages = (int) Math.ceil((double) total / supplierAddress.getPageSize());
        
        map.put("page", page);
        map.put("total", total);
        map.put("pages", pages);
        map.put("pageAction","supplier/address"
                + "?page=%PAGE%");
        return "address/supplier_address";
    }
    /**
     * ɾ����ַ
     * @param map
     * @param supAddressId
     * @return
     */
    @RequestMapping("/delete/{supAddressId}")
    public String deleteAddress(Map<String, Object> map,@PathVariable("supAddressId")String supAddressId) {
        logger.info("ɾ������");
        supplierAddressService.deleteSupplierAddress(supAddressId);
        return "redirect:/supplier/address";
    }
    /**
     * ����ΪĬ�ϵ�ַ
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/setDefault/{addressID}")
    public String querySupplierAddress(Map<String, Object> map,@PathVariable("addressID")String addressID,HttpSession httpSession) {
    	logger.info("��Ӧ�̵�ַ��鿴");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
    	SupplierAddress unDefParam =  new SupplierAddress();
    	// ��������õ�Ĭ�ϵ�ַ
    	unDefParam.setIfDefault(CodeConstants.NO_DEFAULT);
    	unDefParam.setSupId(supId);
    	supplierAddressService.updateSupplierAddress(unDefParam);
    	//����Ĭ�ϵ�ַ
    	SupplierAddress defParam =  new SupplierAddress();
    	defParam.setIfDefault(CodeConstants.IS_DEFAULT);
    	defParam.setSupAddressId(addressID);
    	supplierAddressService.updateSupplierAddress(defParam);
        return "redirect:/supplier/address";
    }
    /**
     * Ǩ����������
     * @param map
     * @return
     */
    @RequestMapping("/insertPage")
    public String insertSupplierAddressPage(Map<String, Object> map,HttpSession httpSession) {
        logger.info("��������ҳ��");
        // ȡ�õ�����Ϣ
		SupArea supArea = new SupArea();
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		supArea.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		// ���ص�����Ϣ
		List<SupArea> areas = areaService.queryAreas(supArea);
		map.put("areasList", areas);
        map.put("processType", "insert");
        return "address/supplier_address_add";
    }
    /**
     * Ǩ���޸Ļ���
     * @param map
     * @return
     */
    @RequestMapping("/updatePage/{addressID}")
    public String updateSupplierAddressPage(Map<String, Object> map,@PathVariable("addressID")String addressID,HttpSession httpSession) {
        logger.info("�޸ĵ���ҳ��");
        map.put("processType", "update");
        SupplierAddress supplierAddress = supplierAddressService.querySupplierAddress(addressID);
        map.put("supplierAddress", supplierAddress);
        map.put("supAddressId", addressID);
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        // ȡ��һ��������Ϣ
		SupArea supArea = new SupArea();
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		supArea.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		// ���ص�����Ϣ
		List<SupArea> areas = areaService.queryAreas(supArea);
		map.put("areasList", areas);
		//ȡ�ö���������Ϣ
		SupArea supAreaSub = new SupArea();
		supAreaSub.setSupID(supId);
		supAreaSub.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		supAreaSub.setSupParentArea(supplierAddress.getSupAreaLevelOne());
		List<SupArea> supAreaSubList = areaService.querySubAreas(supAreaSub);
		map.put("areasSubList", supAreaSubList);
		//ȡ������������Ϣ
		SupArea supAreaLast = new SupArea();
		supAreaLast.setSupID(supId);
		supAreaLast.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		supAreaLast.setSupParentArea(supplierAddress.getSupAreaLevelTwo());
		List<SupArea> supAreaLastList = areaService.querySubAreas(supAreaLast);
		map.put("areasLastList", supAreaLastList);
        return "address/supplier_address_add";
    }
    /**
     * ������������
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/insert")
    public String insertSupplierAddress(@ModelAttribute("supplierAddress") SupplierAddress supplierAddress,HttpSession httpSession) {
        logger.info("������������");
        // ���ӹ�Ӧ��
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        supplierAddress.setSupId(supId);
        supplierAddressService.insertSupplierAddress(supplierAddress);
        return "redirect:/supplier/address";
    }
    /**
     * �޸ĵ�������
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/update")
    public String updateSupplierAddress(@ModelAttribute("supplierAddress") SupplierAddress supplierAddress,HttpSession httpSession) {
        logger.info("�޸ĵ���");
        String supId = httpSession.getAttribute(SessionKeys.SUP_ID).toString();
        if (CodeConstants.IS_DEFAULT.equals(supplierAddress.getIfDefault())) {
        	SupplierAddress unDefParam =  new SupplierAddress();
        	// ��������õ�Ĭ�ϵ�ַ
        	unDefParam.setIfDefault(CodeConstants.NO_DEFAULT);
        	unDefParam.setSupId(supId);
        	supplierAddressService.updateSupplierAddress(unDefParam);
		}
        supplierAddress.setSupId(supId);
        supplierAddressService.updateSupplierAddress(supplierAddress);
        return "redirect:/supplier/address";
    }
    /**
     * ���ط���
     * @param map
     * @param addressID
     * @return
     */
    @RequestMapping("/back")
    public String backSupplierAddress(Map<String, Object> map) {
        logger.info("���ص���");
        return "redirect:/supplier/address";
    }
    
	@RequestMapping("/loadSubArea")
	@ResponseBody
	public Object loadSubArea(@RequestParam("parentId") String parentId,
			HttpSession httpSession)
			throws NoSuchSupplierException, ServiceExecutionFailedException {
		SupArea supArea = new SupArea();
		supArea.setSupParentArea(parentId);
		supArea.setSupID(httpSession.getAttribute(SessionKeys.SUP_ID).toString());
		supArea.setSupType(httpSession.getAttribute(SessionKeys.SUP_TYPE).toString());
		// ���ص�����Ϣ
		List<SupArea> areas = new ArrayList<SupArea>();
		areas = areaService.querySubAreas(supArea);
		return areas;
	}
    
}