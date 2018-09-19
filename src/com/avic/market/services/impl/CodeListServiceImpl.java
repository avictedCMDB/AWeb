package com.avic.market.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.CodeListMapper;
import com.avic.market.models.CodeList;
import com.avic.market.services.CodeListService;

@Service
public class CodeListServiceImpl implements CodeListService {
    
    @Autowired
    CodeListMapper codeListMapper;

    @Override
    public List<CodeList> getCodeListByType(String type) {
        return codeListMapper.queryCodeListByType(type);
    }

    @Override
    public String getCodeText(String type, String val) {
        CodeList data = codeListMapper.queryCodeListByValue(type, val);
        if (data == null) {
            return "";
        }
        return data.getCodeText();
    }
}
