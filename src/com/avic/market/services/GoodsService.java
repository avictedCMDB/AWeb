package com.avic.market.services;

import java.util.List;

import com.avic.common.exceptions.ServiceException;
import com.avic.market.models.BrandAd;
import com.avic.market.models.Goods;
import com.avic.market.models.Price;
import com.avic.market.models.Supplier;
import com.avic.market.models.TradeRecord;

public interface GoodsService {
    public List<Goods> searchGoods(int cat, String brand, int sup, String kw, int priceStart, int priceEnd, int order, int page, int size) throws ServiceException;
    public int getGoodsCount(int cat, String brand, int sup, String kw, int priceStart, int priceEnd) throws ServiceException;
    public List<String> getGoodsBrand(int supId, int cat, String kw) throws ServiceException;
    public Goods getGoodsDetail(int supId, String supGoodsId) throws ServiceException;
    public Goods getGoodsSimple(int supId, String supGoodsId) throws ServiceException;
    public void updateGoodsPrice(Price price) throws ServiceException;
    public void updateGoodsStatus(int supId, String supGoodsId, int status) throws ServiceException;
    public List<Goods> getGoodsListByIds(int supId, List<String> ids) throws ServiceException;
    public void updateGoodsSaleNum(int supId, String supGoodsId, int num) throws ServiceException;
    public List<TradeRecord> getTradeRecordList(int supId, String supGoodsId, int page, int size) throws ServiceException;
    public int getTradeRecordCount(int supId, String supGoodsId) throws ServiceException;
    public List<Goods> getHotGoods(int cat, int size) throws ServiceException;
    
    public List<Goods> searchProfGoods(int sup, int priceStart, int priceEnd, String brand, String name, String desc, String model, String stuff, String cat1, String cat2, String cat3, String comp, int order, int page, int size) throws ServiceException;
    public int getProfGoodsCount(int sup, int priceStart, int priceEnd, String brand, String name, String desc, String model, String stuff, String cat1, String cat2, String cat3,String comp) throws ServiceException;
    public List<Goods> getProfHotGoods(String cat, int size,String comp) throws ServiceException;
       
    public List<BrandAd> getBrandAd() throws ServiceException;
    
    public List<String> getProfBrand(String cat1, String cat2, String cat3, int supId, String name, String model, String desc) throws ServiceException;
    public List<Supplier> getProfSup(String cat1, String cat2, String cat3, int supId, String name, String model, String brand, String desc, String comp) throws ServiceException;

    public double getEnquiryPrice(String userId, String supId, String goodsId);
    
    public List<Supplier> getAllProfSup(String comp, String cat);
    
    public List<Goods> getRandomGoods(int num);
}
