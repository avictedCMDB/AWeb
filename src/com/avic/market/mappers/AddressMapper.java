package com.avic.market.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.avic.market.models.Address;
import com.avic.market.models.SupArea;

@Repository
public interface AddressMapper {
    public Address queryDefaultAddress(@Param("userId") String userId, @Param("supId") String supId);
    public List<Address> queryUserAddress(@Param("userId") String userId, @Param("supId") String supId);
    public List<SupArea> querySupArea(@Param("supId") int supId, @Param("parent") int parent);
    public int queryDefaultAddressCount(@Param("userId") String userId, @Param("supId") String supId);
    public void insertAddress(Address address);
    public void batchInsertArea(List<SupArea> list);
    public void deleteSupArea(@Param("supId")int supId);
    public String queryAddressIndex();
    public void updateAddress(Address address);
    public List<Address> queryProfUserAddress(@Param("userId") String userId, @Param("supId") String supId);
}
