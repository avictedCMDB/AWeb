package com.avic.management.services.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.mappers.SpecialGoodsMapper;
import com.avic.management.models.SpecialGoodsBean;
import com.avic.management.services.SpecialGoodsService;

@Service
public class SpecialGoodsServiceImpl implements SpecialGoodsService {
    protected static final Log logger = LogFactory.getLog(SpecialGoodsServiceImpl.class);

    @Autowired
    SpecialGoodsMapper specialGoodsMapper;

	@Override
	public List<SpecialGoodsBean> supSelectDoInitData(SpecialGoodsBean sgBean) {
		return specialGoodsMapper.supSelectDoInitData(sgBean);
	}

	@Override
	@Transactional
	public String doSaveInTables(Map<String, String> paramMap,String[] auditImages) throws ServiceException {
		SpecialGoodsBean sgBean = new SpecialGoodsBean();
		String result = "ok";
		try {
			//1.插入非标准件需求表
			String isRelease = paramMap.get("isRelease");
			String sup_id = (String) paramMap.get("sup_id");
			if("0".equals(isRelease)){
				int supIdLen = sup_id.length();
				if (sup_id.lastIndexOf(",") == supIdLen-1) {
					sup_id = sup_id.substring(0, supIdLen-1);//截掉最后一个逗号
				}
			}
			sgBean.setSup_id(sup_id);
			sgBean.setGoods_desc_new(paramMap.get("goods_desc_new"));
			sgBean.setUser_id(paramMap.get("user_id"));
			sgBean.setIsRelease(paramMap.get("isRelease"));
			sgBean.setGoodsName(paramMap.get("goodsName"));
			sgBean.setCloseDate(paramMap.get("closeDate"));
			specialGoodsMapper.InsertT_OFF_STANDARD_REQUIRE(sgBean);
			
			//2.插入附件图片表(如果上传了图片)
			int imgCount = NumberUtils.toInt(paramMap.get("imgCount"));
			if(imgCount>0){
				for(int i=0;i<auditImages.length;i++){
					sgBean.setUrl(auditImages[i]);
					specialGoodsMapper.InsertT_IMAGE_INFO(sgBean);
				}
			}
		} catch (Exception e) {
			result="error";
			throw new ServiceException(e);
		}
		return result;
	}
	
	@Override
	public int getRelationShipSupCount(SpecialGoodsBean sgBean) {
		return specialGoodsMapper.getRelationShipSupCount(sgBean);
	}
}