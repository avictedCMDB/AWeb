package com.avic.supervise.services.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.supervise.mappers.CodeListMapper;
import com.avic.supervise.models.CodeList;
import com.avic.supervise.services.CodeListService;

@Service
public class CodeListServiceImpl implements CodeListService {
    
    @Autowired
    CodeListMapper codeListMapper;
    
    private static Map<String, List<CodeList>> map = new HashMap<String, List<CodeList>>();
    
    @Override
    public List<CodeList> getCodeList(String type) {
        if (!map.containsKey(map)) {
            map.put(type, codeListMapper.queryCodeList(type));
        }
        return map.get(type);
    }

}
