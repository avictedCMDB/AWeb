package com.avic.passport.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.ServiceException;
import com.avic.common.utils.MD5;
import com.avic.passport.mappers.MenuMapper;
import com.avic.passport.mappers.UserMapper;
import com.avic.passport.models.Menu;
import com.avic.passport.models.User;
import com.avic.passport.services.UserService;

@Service
public class UserServiceImpl implements UserService {
    protected static final Log logger = LogFactory.getLog(UserServiceImpl.class);
    
    @Autowired
    UserMapper userMapper;
    @Autowired
    MenuMapper menuMapper;

    @Override
    public User login(String username, String password) throws ServiceException {
        logger.info("用户登录Service-username["+username+"]");
        User user = userMapper.queryUserByName(username);
        User userCompany = userMapper.queryCompanyByName(username);      
        if (user == null) {
        	user = new User();
            user.setErrorMsg("采购平台无此账户，请确认账号是否正确。");
            return user;
            
        }
        if(userCompany == null){
        	user = new User();
            user.setErrorMsg("该采购用户尚未通过平台审核，请与平台负责人联系！");
            return user;
        }       
        if(!user.getPassword().equalsIgnoreCase(MD5.getMessageDigest(password.getBytes()))){
        	user = new User();
        	user.setErrorMsg("密码错误。");
        	return user;
        }
        logger.info("用户登录Service-获取用户角色-userId["+user.getUserId()+"]");
        List<String> auths = new ArrayList<String>();
        List<String> ifPayRoles = userMapper.queryAuthorityById(user.getUserId());
        if(ifPayRoles.contains("0")){
        	auths.add(UserRole.CLIENT.value());
        	auths.add(UserRole.BUY.value());
        }
        
        Menu menu = new Menu();
        menu.setUserId(user.getUserId());
        List<Menu> menus = menuMapper.queryUserAuthMenu(menu);
        List<Menu> realMenus = new ArrayList<Menu>();
        if(menus!=null && menus.size()>0){
        	 Menu m = recursiveTreeMenu("00000000",menus);
             for (Menu m2 : m.getChildMenus()) {
             	realMenus.add(m2);
     		}
        }
       
        user.setAuthorities(auths);
        user.setMenus(realMenus);
        return user;
    }
    
    
    /**
    * 递归算法解析成树形结构
    */
    public Menu recursiveTreeMenu(String menuID,List<Menu> menus) {
	    Menu menu = new Menu();
	    List<Menu> subMenus = new ArrayList<Menu>();
	    for (Menu parent : menus) {
			if(menuID.equals(parent.getMenuID())){
				menu = parent;
			}else if(menuID.equals(parent.getParentID())){
				subMenus.add(parent);
			}
		}
	    //遍历子节点
	    for(Menu subChild : subMenus){
		    Menu m = recursiveTreeMenu(subChild.getMenuID(),menus); //递归
		    menu.getChildMenus().add(m);
	    }
	    return menu;
    }

}
