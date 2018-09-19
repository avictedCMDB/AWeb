package com.avic.market.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.market.mappers.OffStandardRequireMapper;
import com.avic.market.models.OffStandardRequire;
import com.avic.market.services.OffStandardRequireService;

@Service
public class OffStandardRequireServiceImpl implements OffStandardRequireService {
    
    @Autowired
    OffStandardRequireMapper offStandardRequireMapper;

    @Override
    public List<OffStandardRequire> queryLastestRequires(int num) {
        return offStandardRequireMapper.queryLastestRequires(num);
    }

}
