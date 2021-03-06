package com.avic.management.services.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.avic.management.mappers.MarketAddressMapper;
import com.avic.management.models.MarketAddress;
import com.avic.management.services.MarketAddressService;

@Service
public class MarketAddressServiceImpl implements MarketAddressService {
    protected static final Log logger = LogFactory.getLog(MarketAddressServiceImpl.class);

    @Autowired
    MarketAddressMapper marketAddressMapper;

    MarketAddress marketAddress;
	@Override
	public List<MarketAddress> queryMarketAddressList(MarketAddress marketAddress) {
		return marketAddressMapper.queryMarketAddressList(marketAddress);
	}

	@Override
	public void deleteMarketAddress(String addressID) {
		String [] addresses = addressID.split(",");
		for (int i = 0; i < addresses.length; i++) {
			marketAddress = new MarketAddress();
			marketAddress.setAddressID(addresses[i]);
			marketAddressMapper.deleteMarketAddress(marketAddress);
		}
	}

	@Override
	public void setDefault(MarketAddress marketAddress) {
		marketAddressMapper.setDefault(marketAddress);
	}

	@Override
	public void addMarketAddress(MarketAddress marketAddress) {
		marketAddressMapper.addMarketAddress(marketAddress);
	}

	@Override
	public void updateMarketAddress(MarketAddress marketAddress) {
		marketAddressMapper.updateMarketAddress(marketAddress);
	}

	@Override
	public void setOtherDefault(MarketAddress marketAddress) {
		marketAddressMapper.setOtherDefault(marketAddress);
	}

	@Override
	public int queryContantDefault() {
		return marketAddressMapper.queryContantDefault();
	}

	@Override
	public MarketAddress queryMarketAddressByAddressID(
			MarketAddress marketAddress) {
		return marketAddressMapper.queryMarketAddressByAddressID(marketAddress);
	}

	@Override
	public int queryMarketAddressCount(MarketAddress marketAddress) {
		return marketAddressMapper.queryMarketAddressCount(marketAddress);
	}
    

}
