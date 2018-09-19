package com.avic.market.controllers;

import java.io.FileInputStream;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.constants.SmsContents;
import com.avic.common.shortMessage.ShortMessageUtils;
import com.avic.common.utils.MD5;
import com.avic.market.models.CompanyInfo;
import com.avic.market.models.SupInfo;
import com.avic.market.models.SupUsers;
import com.avic.market.models.Users;
import com.avic.market.services.RegisterService;


@Controller
@Transactional
@RequestMapping("/register")
public class RegisterController {
	
	@Autowired
	RegisterService registerService;
	
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     */
    @RequestMapping("")
    public String index(Map<String, Object> map,HttpSession httpSession) {
    	return "register/register";
    }
    
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     */
    @RequestMapping("insert")
    @ResponseBody
    public String insert(@RequestParam("insertType") String insertType,
    		@RequestParam("user") String user,
    		@RequestParam("password") String password,
    		@RequestParam("companyName") String companyName,
    		@RequestParam("companyDetail") String companyDetail,
    		@RequestParam("name") String name,
    		@RequestParam("poster") String poster,
    		@RequestParam("tel") String tel,
    		@RequestParam("code") String code,
    		HttpSession httpSession) {
    	//�������
    	password = MD5.getMessageDigest(password.getBytes());
    	CompanyInfo companyInfo = new CompanyInfo();
    	companyInfo.setCompanyDetail(companyDetail);

    	companyInfo.setCompanyName(companyName);
    	companyInfo.setParentCompanyId("system");
    	companyInfo.setContactEmail(poster);
    	companyInfo.setContactPerson(name);
    	companyInfo.setContactIphone(tel);
    	companyInfo.setCompanyType(insertType);
    	
    	//�ж���ҵ�Ƿ����
    	int companyCount = registerService.checkExCompanyInfo(companyInfo);
    	if (companyCount != 0) {
    		// ��ҵ�Ѵ���
			return "2";
		}
    	//�ж��ֻ���֤�� 
    	String verificationCode = httpSession.getAttribute("verificationCode") == null ? " ": httpSession.getAttribute("verificationCode").toString();
    	if (!code.equals(verificationCode)) {
    		// ��֤�����
			return "1";
		}
    	Date verificationTime = (Date) httpSession.getAttribute("verificationTime");
    	if ((new Date()).getTime() - verificationTime.getTime() > 60000) {
    		//��֤����ʧЧ
			return "4";
		}

    	// ���빩Ӧ��
    	if ("1".equals(insertType)) {
    		SupUsers supUsers = new SupUsers();
    		supUsers.setSupName(user);
    		//�ж��û��Ƿ����
    		int supCount = registerService.checkExSup(supUsers);
			if (supCount != 0) {
				// �û����Ѵ���
				return "3";
			}
			String companyIndex = registerService.queryRegisterIndex();
	    	companyInfo.setCompanyType("1");
			companyInfo.setId(companyIndex);
			companyInfo.setCompanyCode(companyIndex);
			//������ҵ
			registerService.insertCompanyInfo(companyInfo);
			// ���ù�Ӧ��
			String supIndex = registerService.querySupIndex();
			SupInfo supInfo = new SupInfo();
			supInfo.setSupId(supIndex);
			supInfo.setSupCode(supIndex);
			supInfo.setSupName(companyName);
			supInfo.setCompanyCode(companyIndex);
			supInfo.setContactNum(tel);
			supInfo.setContactPerson(name);
			supInfo.setEmail(poster);
			//���빩Ӧ����Ϣ
			registerService.insertSupInfo(supInfo);
			//���ù�Ӧ���˻���Ϣ
			supUsers.setSupPassword(password);
			supUsers.setSupUsernamecn(companyName);
			supUsers.setSupId(supIndex);
			supUsers.setSupEnabled("0");
			supUsers.setContactNum(tel);
			supUsers.setSupRegName(name);
			supUsers.setSupRegIphone(tel);
			supUsers.setSupRegEmail(poster);
			//���빩Ӧ���˻���Ϣ
			registerService.insertSupUser(supUsers);
    		//����ɹ���
		}else {
			Users users = new Users();
			users.setUserName(user);
    		//�ж��û��Ƿ����
    		int supCount = registerService.checkExUser(users);
			if (supCount != 0) {
				// �û����Ѵ���
				return "3";
			}
			String userIndex = registerService.queryRegisterUserIndex();
			String companyIndex = registerService.queryRegisterIndex();
			companyInfo.setCompanyType("2");
			companyInfo.setId(companyIndex);
			companyInfo.setCompanyCode(companyIndex);
			companyInfo.setCreateUser(userIndex);			
			//������ҵ
			registerService.insertCompanyInfo(companyInfo);
			//���òɹ���
			users.setPassword(password);
			users.setEnabled("0");
			users.setUserId(userIndex);
			users.setCompanyId(companyIndex);
			users.setCompanyName(companyName);
			users.setContactNum(tel);
			users.setContactPerson(name);
			users.setEmail(poster);
			users.setUserNameCN(name);
			registerService.insertUsers(users);
	        String path = RegisterController.class.getResource("/").getPath();
	        String file = (path.replace("/build/classes", "").replace("%20"," ").replace("classes/", "") + "defaultrole.properties");        
	        Properties prop =new Properties();
	        FileInputStream in = null;
	        try {
	            in = new FileInputStream(file);
	            prop.load(in);
	        } catch (Exception e) {
	            return null;
	        }
	        //�ɹ���λע��Ĭ�������ҵ�����ɫ
			String roleId = prop.getProperty("adminrole");
			registerService.defaultUserRole(companyIndex, roleId);
		}
    	
    	return "0";
    }
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     * @throws RemoteException 
     */
    @RequestMapping("sendVerificationCode")
    @ResponseBody
    public String sendVerificationCode(@RequestParam(value="insertType",required=false) String insertType,
    		@RequestParam(value="user",required=false) String user,
    		@RequestParam(value="password",required=false) String password,
    		@RequestParam(value="companyName",required=false) String companyName,
    		@RequestParam(value="companyDetail",required=false) String companyDetail,
    		@RequestParam(value="name",required=false) String name,
    		@RequestParam(value="poster",required=false) String poster,
    		@RequestParam("tel") String tel,
    		@RequestParam(value="code",required=false) String code,
    		HttpSession httpSession) throws RemoteException{
    	//�ж��ֻ��Ƿ�ע��
    	CompanyInfo companyInfo = new CompanyInfo();
    	companyInfo.setContactIphone(tel);
    	companyInfo.setCompanyType(insertType);
    	int telCount = registerService.checkIphone(companyInfo);
    	if (telCount !=0) {
			return "1";
		}
    	//�����ֻ���֤��
    	String fourRandom = getFourRandom();
    	String[] contactNums = tel.split(",");
    	String msg = SmsContents.SMS_VERIFICATION_CODE.replace("{projName}", fourRandom);
    	ShortMessageUtils.sendSMS(contactNums, msg.toString());
    	httpSession.setAttribute("verificationCode", fourRandom);
    	httpSession.setAttribute("verificationTime", new Date());
    	return "0";
    }
    /**
     * ����4λ�����(0000-9999)
     * @return 4λ�����
     */
    public String getFourRandom(){
        Random random = new Random();
        String fourRandom = random.nextInt(10000) + "";
        int randLength = fourRandom.length();
        if(randLength<4){
          for(int i=1; i<=4-randLength; i++)
              fourRandom = "0" + fourRandom  ;
      }
        return fourRandom;
    }
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     */
    @RequestMapping("findPassword")
    public String findPassword(Map<String, Object> map,@RequestParam("userType") String userType,HttpSession httpSession) {
    	map.put("userType", userType);
    	return "findPassword/find_password_step01";
    }
    
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     */
    @RequestMapping("findPassword2")
    public String findPassword2(Map<String, Object> map,HttpSession httpSession,
    		@RequestParam("userType") String userType
    		,@RequestParam("userName") String userName
    		,@RequestParam("telNumber") String telNumber) {
    	map.put("userType", userType);
    	map.put("telNumber", telNumber);
    	map.put("userName", userName);
    	//�ɹ��˻���ƽ̨
    	if ("1".equals(userType) || "3".equals(userType)) {
    		Users users = new Users();
			users.setUserName(userName);
    		//�ж��û��Ƿ����
    		int userCount = registerService.checkExUser(users);
			if (userCount == 0) {
				map.put("msg", ("1".equals(userType) ? "�ɹ���":"���ƽ̨")+"�û������ڣ�");
				return "findPassword/find_password_step01";
			}
			users.setContactNum(telNumber);
			userCount = registerService.checkExUser(users);
			if (userCount == 0) {
				map.put("msg", ("1".equals(userType) ? "�ɹ���":"���ƽ̨")+"�û��绰�������");
				return "findPassword/find_password_step01";
			}
    		//��Ӧ��
		}else if ("2".equals(userType)) {
			SupUsers supUsers = new SupUsers();
    		supUsers.setSupName(userName);
    		//�ж��û��Ƿ����
    		int supCount = registerService.checkExSup(supUsers);
			if (supCount == 0) {
				// �û���������
				map.put("msg", "��Ӧ���û���������!");
				return "findPassword/find_password_step01";
			}
			supUsers.setSupRegIphone(telNumber);
			//�жϵ绰�Ƿ����
			supCount = registerService.checkExSup(supUsers);
			if (supCount == 0) {
				// �û���������
				map.put("msg", "��Ӧ�̵绰�Ŵ���!");
				return "findPassword/find_password_step01";
			}
		}
    	String showTel = telNumber.substring(0,3) +"****"+telNumber.substring(7,11);
    	map.put("showTel", showTel);
    	return "findPassword/find_password_step02";
    }
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     * @throws RemoteException 
     */
    @RequestMapping("sendFindPasswordCode")
    @ResponseBody
    public String sendFindPasswordCode(
    		@RequestParam("telNumber") String telNumber,
    		HttpSession httpSession) throws RemoteException{
    	//�����ֻ���֤��
    	String fourRandom = getFourRandom();
    	String[] contactNums = telNumber.split(",");
    	String msg = SmsContents.SMS_FINDPASSWORD_CODE.replace("{projName}", fourRandom);
    	ShortMessageUtils.sendSMS(contactNums, msg.toString());
    	httpSession.setAttribute("findPasswordCode", fourRandom);
    	httpSession.setAttribute("findPasswordTime", new Date());
    	return "0";
    }
    
    /**
     * ҳ���ʼ������
     * @param mapr
     * @return
     */
    @RequestMapping("checkFindpassword")
    @ResponseBody
    public String checkFindpassword(HttpSession httpSession,
    		@RequestParam("userType") String userType
    		,@RequestParam("userName") String userName
    		,@RequestParam("findpasswordCode") String findpasswordCode
    		,@RequestParam("telNumber") String telNumber) {
    	//�ж��ֻ���֤�� 
    	String verificationCode = httpSession.getAttribute("findPasswordCode").toString();
    	if (!findpasswordCode.equals(verificationCode)) {
    		// ��֤�����
    		return "1";
		}
    	Date verificationTime = (Date) httpSession.getAttribute("findPasswordTime");
    	if ((new Date()).getTime() - verificationTime.getTime() > 60000) {
    		//��֤����ʧЧ
    		return "4";
		}
    	return "0";
    }
    /**
     * ҳ���ʼ������
     * @param mapr
     * @return
     */
    @RequestMapping("findPassword3")
    public String findPassword3(Map<String, Object> map,HttpSession httpSession,
    		@RequestParam("userType") String userType
    		,@RequestParam("userName") String userName
    		,@RequestParam("findpasswordCode") String findpasswordCode
    		,@RequestParam("telNumber") String telNumber) {
    	map.put("userType", userType);
    	map.put("userName", userName);
    	map.put("telNumber", telNumber);
    	return "findPassword/find_password_step03";
    }
    
    /**
     * ҳ���ʼ������
     * @param map
     * @return
     */
    @RequestMapping("findPassword4")
    public String findPassword4(Map<String, Object> map,HttpSession httpSession,
    		@RequestParam("userType") String userType,
    		@RequestParam("password") String password,
    		@RequestParam("userName") String userName) {
    	if ("1".equals(userType) || "3".equals(userType)) {
    		Users users = new Users();
			users.setUserName(userName);
			users.setPassword(MD5.getMessageDigest(password.getBytes()));
			registerService.updateUserPassword(users);
		}else if ("2".equals(userType)) {
			SupUsers supUsers = new SupUsers();
    		supUsers.setSupName(userName);
    		supUsers.setSupPassword(MD5.getMessageDigest(password.getBytes()));
    		registerService.updateSupUserPassword(supUsers);
		}
    	map.put("userType", userType);
    	return "findPassword/find_password_step04";
    }
}