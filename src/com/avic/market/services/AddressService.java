package com.avic.market.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.models.Address;
import com.avic.market.models.SupArea;

public interface AddressService {
    public Address getDefaultAddress(String userId, int supId) throws ServiceException;
    public List<Address> getUserAddress(String userId, int supId) throws ServiceException;
    public List<SupArea> getSupArea(int supId, int parent) throws ServiceException;
    public void addAddress(Address address) throws ServiceException;
    public List<Address> getProfUserAddress(String userId, int supId) throws ServiceException;
}
