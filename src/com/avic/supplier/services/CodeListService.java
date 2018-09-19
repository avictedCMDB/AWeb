package com.avic.supplier.services;

import java.util.List;

import com.avic.supplier.models.CodeList;


public interface CodeListService {
	/**
	 * ≤È—Øcode¡–±Ì
	 * @return 
	 */
	public List<CodeList> queryCodes(CodeList codeList);
	
	public CodeList queryCodeListByValue(String type, String val);
}
