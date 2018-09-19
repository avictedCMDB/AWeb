package com.avic.market.services.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.mappers.AddressMapper;
import com.avic.market.models.Address;
import com.avic.market.models.SupArea;
import com.avic.market.services.AddressService;

@Service
public class AddressServiceImpl implements AddressService {
    protected static final Log logger = LogFactory.getLog(AddressServiceImpl.class);

    @Autowired
    AddressMapper addressMapper;
    
    @Override
    public Address getDefaultAddress(String userId, int supId) throws ServiceException {
        logger.info("��ȡĬ�ϵ�ַService-userId["+userId+"], supId["+supId+"]");
        return addressMapper.queryDefaultAddress(userId, String.valueOf(supId));
    }
    
    @Override
    public List<Address> getUserAddress(String userId, int supId) throws ServiceException {
        logger.info("��ȡ�û���ַService-userId["+userId+"], supId["+supId+"]");
        return addressMapper.queryUserAddress(userId, String.valueOf(supId));
    }
    @Override
    public List<Address> getProfUserAddress(String userId, int supId) throws ServiceException {
        return addressMapper.queryProfUserAddress(userId, String.valueOf(supId));
    }
    
    @Override
    public List<SupArea> getSupArea(int supId, int parent) throws ServiceException {
        logger.info("��ȡ����Service-parent["+parent+"], supId["+supId+"]");
        return addressMapper.querySupArea(supId, parent);
    }
    
    @Transactional
    @Override
    public void addAddress(Address address) throws ServiceException {
        logger.info("���ӵ�ַService");

        try {
            if (StringUtils.isEmpty(address.getAddressId())) {
                if (addressMapper.queryDefaultAddressCount(address.getUserId(), address.getSupId()) > 0) {
                    address.setIfDefault("0");
                } else {
                    address.setIfDefault("1");
                }
                address.setAddressId(addressMapper.queryAddressIndex());
                addressMapper.insertAddress(address);
            } else {
                addressMapper.updateAddress(address);
            }
        } catch (Exception e) {
            logger.error("���ӵ�ַʧ��", e);
            throw new ServiceException(e);
        }
        
    }

}