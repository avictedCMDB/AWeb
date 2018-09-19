package com.avic.supplier.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.rmi.RemoteException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.avic.common.constants.SessionKeys;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.MD5;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.supplier.models.SupplierInfoExt;
import com.avic.supplier.models.SupplierOrder;
import com.avic.supplier.models.SupplierUser;
import com.avic.supplier.services.SupplierInfoExtService;
import com.avic.supplier.services.SupplierSupUserService;

@Controller
@RequestMapping("/goodsInfoExt")
public class SupplierGoodsInfoExtController {

	@Autowired
	SupplierInfoExtService supplierInfoExtService;
	
	@Autowired
	SupplierSupUserService supplierSupUserService;
	
	protected static final Log logger = LogFactory
	.getLog(SupplierGoodsInfoExtController.class);
	
	/**
	 * ҳ���ʼ������
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws RemoteException 
	 */
	@RequestMapping("")
	public String index(Map<String, Object> map,HttpSession httpSession) throws UnsupportedEncodingException, RemoteException {
		SupplierInfoExt supplierInfoExtParam = new SupplierInfoExt();
		String supId = (String)httpSession.getAttribute(SessionKeys.SUP_ID);
		supplierInfoExtParam.setSupId(supId);
		SupplierInfoExt supplierInfoExt = supplierInfoExtService.querySupplierInfoExt(supplierInfoExtParam);
		map.put("supplierInfoExt", supplierInfoExt);
		return "goodsExt/supplier_info";
	}
	
	/**
	 * ͼƬ�ϴ�
	 * @param map
	 * @param httpSession
	 * @param supplierGoodsInfo
	 * @param uploadFiles
	 * @return
	 * @throws NoSuchSupplierException
	 * @throws ServiceExecutionFailedException
	 * @throws IOException
	 */
	@RequestMapping("/uploadPrcture")
	public Object uploadFile(Map<String, Object> map,HttpSession httpSession,HttpServletRequest request,
			@ModelAttribute("SupplierInfoExt") SupplierInfoExt supplierInfoExt,
			 @RequestParam("uploadFile") MultipartFile uploadFiles)
			throws NoSuchSupplierException, ServiceExecutionFailedException, IOException {
		String picture = uploadFiles.getOriginalFilename();
		String postfix = picture.substring(picture.lastIndexOf("."),picture.length());
		// �ϴ���ַ
		String rootPath = ConfigHolder.getInstance().getConfig("supplier_picture");
		//����ͼƬ��ַ
		String newFileName = String.valueOf(System.currentTimeMillis()) + postfix;
		String savePath = request.getSession().getServletContext().getRealPath(ConfigHolder.getInstance().getConfig("supplier_picture"));
		saveFile(savePath, newFileName, uploadFiles);
		supplierInfoExt.setSupImage(rootPath +  "/" + newFileName);
		map.put("supplierInfoExt", supplierInfoExt);
		map.put("ok", "2");
		return "goodsExt/supplier_info";
		
	}
	
	/**
	 * ���水ť����
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws RemoteException 
	 */
	@RequestMapping("/saveInfoExt")
	public String saveInfoExt(Map<String, Object> map,HttpSession httpSession,
			@ModelAttribute("SupplierInfoExt") SupplierInfoExt supplierInfoExt) throws UnsupportedEncodingException, RemoteException {
		String supId = (String)httpSession.getAttribute(SessionKeys.SUP_ID);
		supplierInfoExt.setSupId(supId);
		this.supplierInfoExtService.saveSupplierInfoExt(supplierInfoExt);
		// ����
		SupplierInfoExt supplierInfoExtParam = new SupplierInfoExt();
		supplierInfoExtParam.setSupId(supId);
		SupplierInfoExt supplierInfoExtBack = supplierInfoExtService.querySupplierInfoExt(supplierInfoExtParam);
		map.put("supplierInfoExt", supplierInfoExtBack);
		map.put("ok", "1");
		return "goodsExt/supplier_info";
	}
	 /**
     * 
     * ��������   ����ͼƬ
     * 
     * @author ��xiaoyu �������� ��2014��2��12�� ����7:37:45
     * 
     * @param newFileName
     *            �ϴ���Ƭ�ļ���
     * @param filedata
     *           �ļ�����
     * 
     *            �޸���ʷ ��(�޸��ˣ��޸�ʱ�䣬�޸�ԭ��/����)
     */
    private void saveFile(String saveFilePath ,String newFileName, MultipartFile filedata) {
        // TODO Auto-generated method stub
        // ���������ļ���ȡ������ͼƬ���·��

        /* �����ļ�Ŀ¼ */
        File fileDir = new File(saveFilePath);
        if (!fileDir.exists()) {
            fileDir.mkdirs();
        }
        try {
            FileOutputStream out = new FileOutputStream(saveFilePath +File.separator+ newFileName);
            // д���ļ�
            out.write(filedata.getBytes());
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	/**
	 * ҳ���ʼ������
	 * 
	 * @param map
	 * @return
	 * @throws UnsupportedEncodingException 
	 * @throws RemoteException 
	 */
	@RequestMapping("/changPassWord")
	public String account(Map<String, Object> map,HttpSession httpSession) throws UnsupportedEncodingException, RemoteException {
		return "goodsExt/changePassword";
	}
	/**
	 * ��Ӧ���޸�����
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/changePwd")
	public String changePwd(Map<String, Object> map,@RequestParam("oldPassword") String oldPassword,@RequestParam("newPassword") String newPassword,
			HttpSession httpSession) {
		String msg = "1";
		String supId = (String)httpSession.getAttribute(SessionKeys.SUP_ID);
		//�ж��û��������Ƿ����
		SupplierUser supplierUser = new SupplierUser();
    	supplierUser.setSupId(supId);
    	supplierUser.setSupPassword(oldPassword);
    	SupplierUser loginUser = supplierSupUserService.queryLoginUser(supplierUser);
    	if (loginUser == null) {
    		msg = "0";
        }else {
        	supplierSupUserService.updateSupPassWord(MD5.getMessageDigest(newPassword.getBytes()), supId);
		}
        	
		map.put("msg", msg);
		map.put("oldPassword", oldPassword);
		map.put("newPassword", newPassword);
		return "goodsExt/changePassword";
	}
}