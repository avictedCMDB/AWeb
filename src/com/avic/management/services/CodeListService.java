package com.avic.management.services;

import java.util.List;

import com.avic.management.models.CodeList;
import com.avic.management.models.Invoice;

public interface CodeListService {
	/**
	 * ��ѯcode�б�
	 * @return 
	 */
	public List<CodeList> queryCodes(CodeList codeList);
	
	public CodeList queryCodeListByValue(String type, String val);
}
