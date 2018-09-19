package com.avic.passport.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.passport.mappers.MenuMapper;
import com.avic.passport.models.Menu;
import com.avic.passport.services.MenuService;

@Service
public class MenuServiceImpl implements MenuService {
    protected static final Log logger = LogFactory.getLog(MenuServiceImpl.class);
    
    @Autowired
    MenuMapper menuMapper;

	@Override
	public List<Menu> queryUserAuthMenu(Menu menu) {
		return menuMapper.queryUserAuthMenu(menu);
	}
    

}
