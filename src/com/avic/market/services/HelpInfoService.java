package com.avic.market.services;

import java.util.List;

import com.avic.market.models.HelpInfo;

public interface HelpInfoService {
	
	public List<HelpInfo> queryHelpInfoList(HelpInfo helpInfo);
	
	public Integer queryHelpInfoCount(HelpInfo helpInfo);
}
