package com.avic.market.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.GoodsMapper;
import com.avic.market.mappers.HelpInfoMapper;
import com.avic.market.models.HelpInfo;
import com.avic.market.services.HelpInfoService;
@Service
public class HelpInfoServiceImpl implements HelpInfoService{
	
	@Autowired
    HelpInfoMapper helpInfoMapper;

	@Override
	public List<HelpInfo> queryHelpInfoList(HelpInfo helpInfo) {
		return helpInfoMapper.queryHelpInfoList(helpInfo);
	}

	@Override
	public Integer queryHelpInfoCount(HelpInfo helpInfo) {
		return helpInfoMapper.queryHelpInfoCount(helpInfo);
	}

}
