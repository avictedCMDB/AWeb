package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.common.exceptions.ServiceException;
import com.avic.management.mappers.OffStandardRequireMapper;
import com.avic.management.mappers.SpecialGoodsMapper;
import com.avic.management.models.OffStandardRequire;
import com.avic.management.models.SpecialGoodsBean;
import com.avic.management.models.SupGoods;
import com.avic.management.models.SupInfo;
import com.avic.management.services.OffStandardRequireService;

@Service
public class OffStandardRequireServiceImpl implements OffStandardRequireService {
    protected static final Log logger = LogFactory.getLog(OffStandardRequireServiceImpl.class);

    @Autowired
    OffStandardRequireMapper offStandardRequireMapper;
    @Autowired
    SpecialGoodsMapper specialGoodsMapper;

	@Override
	public List<OffStandardRequire> queryOffStandardRequires(
			OffStandardRequire offStandardRequire) {
		return offStandardRequireMapper.queryOffStandardRequires(offStandardRequire);
	}

	@Override
	public List<SupGoods> queryGoodsByGoodsIDS(
			OffStandardRequire offStandardRequire) {
		return offStandardRequireMapper.queryGoodsByGoodsIDS(offStandardRequire);
	}

	@Override
	public List<SupInfo> querySupInfosBySupIDS(
			OffStandardRequire offStandardRequire) {
		return offStandardRequireMapper.querySupInfosBySupIDS(offStandardRequire);
	}

	@Override
	public int queryOffStandardRequiresCount(
			OffStandardRequire offStandardRequire) {
		return offStandardRequireMapper.queryOffStandardRequiresCount(offStandardRequire);
	}

	@Override 
	public int queryFileEx(OffStandardRequire offStandardRequire) {
		return offStandardRequireMapper.queryFileEx(offStandardRequire);
	}

	@Override
	public int checkGoodsName(String goodsName) {
		return offStandardRequireMapper.checkGoodsName(goodsName);
	}

	@Override
	public void deleteSpecial(OffStandardRequire offStandardRequire) {
		offStandardRequireMapper.deleteSpecial(offStandardRequire);
	}

	@Override
	public String updateSpecial(OffStandardRequire offStandardRequire,String[] auditImages) {
		SpecialGoodsBean sgBean = new SpecialGoodsBean();
		String result = "ok";
		try {
			//1.����Ǳ�׼�������
			String isRelease = offStandardRequire.getIsRelease();
			String sup_id = (String) offStandardRequire.getSupID();
			if("0".equals(isRelease)){
				int supIdLen = sup_id.length();
				int lastIndex = sup_id.lastIndexOf(",");
				int firstIndex = sup_id.indexOf(",");
				if(lastIndex == (supIdLen-1)){
					sup_id = sup_id.substring(0, supIdLen-1);//�ص����һ������
				}
				if(firstIndex==0){
					sup_id = sup_id.substring(1);			 //�ص���һ������
				}
			}
			offStandardRequire.setSupID(sup_id);
			offStandardRequireMapper.updateSpecial(offStandardRequire);
			
			//2.���븽��ͼƬ��(����ϴ���ͼƬ)
			int imgCount = auditImages.length;
			if(imgCount>0){
				if(auditImages!=null){
					sgBean.setId(offStandardRequire.getID());
					specialGoodsMapper.deleteSpecialImage(sgBean);
					for(int i=0;i<auditImages.length;i++){
						sgBean.setUrl(auditImages[i]);
						specialGoodsMapper.InsertT_IMAGE_INFO(sgBean);
					}
				}
			}
			
		} catch (Exception e) {
			result="error";
			throw new ServiceException(e);
		}
		return result;
	}

	@Override
	public void cancleReason(OffStandardRequire offStandardRequire) {
		offStandardRequireMapper.cancleReason(offStandardRequire);
	}

	@Override
	public OffStandardRequire getOffStandardRequireByID(
			OffStandardRequire offStandardRequire) {
		return offStandardRequireMapper.getOffStandardRequireByID(offStandardRequire);
	}



}