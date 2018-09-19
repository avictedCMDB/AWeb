package com.avic.management.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.management.models.CodeList;

@Repository
public interface CodeListMapper {
	/**
	 * ≤È—Øcode¡–±Ì
	 * @return 
	 */
	public List<CodeList> queryCodes(CodeList codeList);
	
	public CodeList queryCodeListByValue(@Param("type") String type, @Param("val") String val);
}

