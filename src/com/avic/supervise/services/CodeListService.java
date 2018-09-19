package com.avic.supervise.services;

import java.util.List;

import com.avic.supervise.models.CodeList;

public interface CodeListService {
    public List<CodeList> getCodeList(String type);
}
