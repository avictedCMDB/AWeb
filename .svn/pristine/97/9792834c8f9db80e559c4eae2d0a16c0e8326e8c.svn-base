package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.CodeListMapper;
import com.avic.management.models.CodeList;
import com.avic.management.services.CodeListService;

@Service
public class CodeListServiceImpl implements CodeListService {
    protected static final Log logger = LogFactory.getLog(CodeListServiceImpl.class);

    @Autowired
    CodeListMapper codeListMapper;

	@Override
	public List<CodeList> queryCodes(CodeList codeList) {
		return codeListMapper.queryCodes(codeList);
	}
	
	@Override
	public CodeList queryCodeListByValue(String type, String val) {
	    return codeListMapper.queryCodeListByValue(type, val);
	}
}
