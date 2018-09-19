package com.avic.passport.services;

import java.util.List;

import com.avic.passport.models.Menu;

public interface MenuService {
	public List<Menu> queryUserAuthMenu(Menu menu);
}
