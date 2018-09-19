package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.ImageInfoMapper;
import com.avic.management.models.AuditImageInfo;
import com.avic.management.models.AuditOrder;
import com.avic.management.services.ImageInfoService;

@Service
public class ImageInfoServiceImpl implements ImageInfoService {
    protected static final Log logger = LogFactory.getLog(ImageInfoServiceImpl.class);

    @Autowired
    ImageInfoMapper imageInfoMapper;

	@Override
	public List<AuditImageInfo> queryImages(AuditImageInfo auditImageInfo) {
		return imageInfoMapper.queryImages(auditImageInfo);
	}

	@Override
	public void addVatImage(AuditImageInfo auditImageInfo) {
		imageInfoMapper.addVatImage(auditImageInfo);
	}

	@Override
	public void deleteVatImage(AuditImageInfo auditImageInfo) {
		imageInfoMapper.deleteVatImage(auditImageInfo);
	}

}
