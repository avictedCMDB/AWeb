package com.avic.market.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.avic.market.models.HelpInfo;

@Repository
public interface HelpInfoMapper {
	
	
	public List<HelpInfo> queryHelpInfoList(HelpInfo helpInfo);
	
	public Integer queryHelpInfoCount(HelpInfo helpInfo);

}
