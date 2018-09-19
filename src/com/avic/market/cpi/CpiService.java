package com.avic.market.cpi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.avic.market.cpi.adapters.JdServiceAdapter;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.market.cpi.exceptions.TokenInvalidException;
import com.avic.market.mappers.AddressMapper;
import com.avic.market.mappers.CategoryMapper;
import com.avic.market.mappers.GoodsMapper;
import com.avic.market.mappers.OrderMapper;
import com.avic.market.mappers.ServicesMapper;
import com.avic.market.mappers.SupplierMapper;
import com.avic.market.mappers.SyncLogMapper;
import com.avic.market.models.AfsServicebyCustomerPinDto;
import com.avic.market.models.Goods;
import com.avic.market.models.GoodsImage;
import com.avic.market.models.GoodsMessage;
import com.avic.market.models.Order;
import com.avic.market.models.Price;
import com.avic.market.models.Services;
import com.avic.market.models.SupArea;
import com.avic.market.models.SupCategory;
import com.avic.market.models.Supplier;
import com.avic.market.models.SyncLog;

@Component
public class CpiService {
    protected static final Log logger = LogFactory.getLog(CpiService.class);

    private Map<Integer, ServiceAdapter> adapters = new HashMap<Integer, ServiceAdapter>();

    private static CpiService instance;

    @Autowired
    SupplierMapper supplierMapper;

    @Autowired
    CategoryMapper categoryMapper;

    @Autowired
    GoodsMapper goodsMapper;

    @Autowired
    AddressMapper addressMapper;
    
    @Autowired
    OrderMapper orderMapper;
    
    @Autowired
    ServicesMapper servicesMapper;
    
    @Autowired
    SyncLogMapper syncLogMapper;

    public ServiceAdapter getServiceAdapter(int supId) {
        return adapters.get(supId);
    }

    public static CpiService getInstance() {
        return instance;
    }

    @PostConstruct
    public void init() {
        logger.info("CpiService 加载 ...");

        try {
            List<Supplier> sups = supplierMapper.querySupplierList();

            if (sups == null || sups.size() == 0) {
                logger.error("系统无供应商数据");
                return;
            }

            for (Supplier s : sups) {
                if (s.getSupType() != 0) {
                    continue;
                }
                logger.info("开始加载供应商服务 [ID:" + s.getSupId() + " CODE:" + s.getSupCode() + "]...");
                Class<?> clazz = Class.forName("com.avic.market.cpi.adapters." + s.getSupCode().substring(0, 1).toUpperCase()
                        + s.getSupCode().substring(1) + "ServiceAdapter");

                if (ServiceAdapter.class.isAssignableFrom(clazz)) {
                    ServiceAdapter adapter = (ServiceAdapter) clazz.newInstance();
                    adapter.setSupplier(s);
                    adapters.put(s.getSupId(), adapter);
                    adapter.init();

                    syncToken(adapter);

                } else {
                    throw new Exception("供应商服务不存在 [ID:" + s.getSupId() + " CODE:" + s.getSupCode() + "]");
                }
                logger.info("加载供应商成功 [ID:" + s.getSupId() + " CODE:" + s.getSupCode() + "]");

            }
        } catch (Exception e) {
            logger.error("加载供应商异常", e);
        }

        instance = this;

        logger.info("CpiService 加载完成，供应商数量 [" + adapters.size() + "]");
    }

    private synchronized void syncToken(ServiceAdapter adapter) {
        if (!adapter.isTokenValid()) {
            Supplier s = supplierMapper.querySupplierById(adapter.getSupplier().getSupId());
            
            if (s.getAccessToken() != null && adapter.getSupplier().getAccessToken() != null && !s.getAccessToken().equals(adapter.getSupplier().getAccessToken())) {
                // 多机环境时，可能token已被更新
                adapter.setSupplier(s);
            } else {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] token 无效, 刷新 ...");
                try {
                    adapter.fetchToken();
                } catch (ServiceExecutionFailedException e) {
                    logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] token 刷新失败", e);
                    return;
                }
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] token 已刷新 [access:" + adapter.getSupplier().getAccessToken()
                        + " refresh:" + adapter.getSupplier().getRefreshToken() + "]");
                supplierMapper.updateSupplierToken(adapter.getSupplier());
            }
        }
    }

    public List<SupCategory> getCategory(int supId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchCategory();
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载分类失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载分类");
                return adapter.fetchCategory();
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载分类异常", e1);
                throw new ServiceExecutionFailedException("加载分类刷新token后重试仍然异常", e1);
            }
        }
    }

    public Goods getGoodsDetail(int supId, String sku) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchGoods(sku, 0);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品信息失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载商品信息");
                return adapter.fetchGoods(sku, 0);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品信息异常", e1);
                throw new ServiceExecutionFailedException("加载商品信息刷新token后重试仍然异常", e1);
            }
        }
    }

    public Price getGoodsPrice(int supId, String sku) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        List<String> skus = new ArrayList<String>();
        skus.add(sku);
        try {
            return adapter.fetchPrice(skus).get(sku);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品价格失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载商品价格");
                return adapter.fetchPrice(skus).get(sku);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品价格异常", e1);
                throw new ServiceExecutionFailedException("加载商品价格刷新token后重试仍然异常", e1);
            }
        }
    }

    public Map<String, Price> getGoodsPrice(int supId, List<String> skus) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchPrice(skus);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品价格失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载商品价格");
                return adapter.fetchPrice(skus);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品价格异常", e1);
                throw new ServiceExecutionFailedException("加载商品价格刷新token后重试仍然异常", e1);
            }
        }
    }

    public Map<String, Integer> getGoodsStock(int supId, List<String> skus, List<Integer> nums, List<String> area) throws NoSuchSupplierException,
            ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);

        try {
            return adapter.fetchStock(skus, nums, area);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品库存失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载商品库存");
                return adapter.fetchStock(skus, nums, area);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品库存异常", e1);
                throw new ServiceExecutionFailedException("加载商品库存刷新token后重试仍然异常", e1);
            }
        }
    }

    public Map<String, Integer> getGoodsStatus(int supId, List<String> skus) throws NoSuchSupplierException,
            ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);

        try {
            return adapter.fetchStatus(skus);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品上下架状态失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载商品上下架状态");
                return adapter.fetchStatus(skus);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品上下架状态异常", e1);
                throw new ServiceExecutionFailedException("加载商品上下架状态刷新token后重试仍然异常", e1);
            }
        }
    }

    public GoodsImage getGoodsImage(int supId, String sku) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        List<String> skus = new ArrayList<String>();
        skus.add(sku);
        try {
            return adapter.fetchGoodsImage(skus).get(0);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品图片失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载商品图片");
                return adapter.fetchGoodsImage(skus).get(0);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载商品图片异常", e1);
                throw new ServiceExecutionFailedException("加载商品图片刷新token后重试仍然异常", e1);
            }
        }
    }

    public void syncGoods() {
        logger.info("CpiService 同步商品数据, [" + adapters.size() + "] 供应商需要同步");
        List<SupCategory> cats = null;
        for (ServiceAdapter i : adapters.values()) {
            if (i.syncType() == ServiceAdapter.SYNC_TYPE.SYNC_INCR) {
                continue;
            }
            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 开始同步分类");
            try {
                cats = i.fetchCategory();
            } catch (TokenInvalidException e) {
                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载分类失败 [token invalid]");
                i.invalidToken();
                syncToken(i);
                try {
                    logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 重新加载分类");
                    // 有供应商是分类，有供应商是商品池
                    cats = i.fetchCategory();
                } catch (Exception e1) {
                    logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载分类刷新token后重试仍然异常.", e1);
                }
            } catch (ServiceExecutionFailedException e) {
                logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载分类异常", e);
            }
            if (cats != null) {
                /*
                 * 分类直接提供数据，这里不再同步 logger.info("供应商服务 [" +
                 * i.getSupplier().getSupCode() + "] 分类准备写入数据库，数量[" +
                 * cats.size() + "]");
                 * categoryMapper.deleteAllSupCat(i.getSupplier().getSupId());
                 * categoryMapper.batchInsertSupCat(cats); logger.info("供应商服务 ["
                 * + i.getSupplier().getSupCode() + "] 分类写入完成");
                 */
                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 开始同步商品");
                List<String> skus = null;
                List<String> skuAll = null;
                Map<String, Price> price = null;
                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 清除商品图片");
                goodsMapper.deleteSupGoodsImage(i.getSupplier().getSupId());
                for (SupCategory c : cats) {
                    logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 同步商品，分类 [" + c.getSupCatName() + "]");
                    try {
                        skuAll = i.fetchSku(c.getSupCatId());
                    } catch (Exception e) {
                        logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载SKU异常 分类 [" + c.getSupCatName() + "]", e);
                        continue;
                    }
                    goodsMapper.deleteSupCatGoods(i.getSupplier().getSupId(), c.getSupCatId());
                    int pos = 0;
                    // 100个执行一次
                    while (skuAll.size() > pos) {

                        int count = 0;
                        int end = pos + 100;
                        if (end > skuAll.size()) {
                            end = skuAll.size();
                        }
                        skus = skuAll.subList(pos, end);
                        pos = end;

                        try {
                            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取价格 分类 [" + c.getSupCatName() + "] SKU [" + skus
                                    + "]");
                            price = i.fetchPrice(skus);
                        } catch (Exception e) {
                            logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取价格异常 分类 [" + c.getSupCatName() + "] SKU [" + skus
                                    + "]", e);
                            continue;
                        }

                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] SKU POS [" + end + "]");
                        for (String s : skus) {
                            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取并保存商品信息 分类 [" + c.getSupCatName() + "] SKU [" + s
                                    + "]");
                            try {
                                Goods g = i.fetchGoods(s, c.getSupCatId());
                                Price p = price.get(g.getSupGoodsId());
                                g.setAgreePrice(p.getAgreePrice());
                                g.setCountPrice(p.getCountPrice());
                                g.setSalePrice(p.getSalePrice());
                                g.setBusinessPrice(p.getBusinessPrice());
                                // g.setSupCatId(c.getSupCatId());
                                // 统一为池编号，分类编号放在adapter内部处理
                                g.setPoolId(c.getSupCatId());
                                goodsMapper.insertSupGoods(g);
                                count++;

                            } catch (Exception e) {
                                logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取并保存商品异常 分类 [" + c.getSupCatName() + "] SKU ["
                                        + s + "]", e);
                                continue;
                            }
                        }
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] 商品 [" + pos
                                + "] 同步完成 成功数量 [" + count + "] 失败数量 [" + (skus.size() - count) + "]");

                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] 同步商品图片 SKU [" + skus + "]");
                        try {
                            List<GoodsImage> images = i.fetchGoodsImage(skus);
                            goodsMapper.batchInsertGoodsImage(images);
                        } catch (Exception e) {
                            logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 同步商品图片异常 分类 [" + c.getSupCatName() + "] SKU ["
                                    + skus + "]", e);
                            continue;
                        }
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] 商品 [" + pos + "] 图片同步完成");

                    }

                }
                cats = null;
            }
            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品同步完成");

        }

        /*
         * 品牌不再生成，搜索时根据商品条件实时查询 logger.info("CpiService 清除品牌对应关系");
         * categoryMapper.deleteCatBrand(); logger.info("CpiService 生成品牌对应关系");
         * categoryMapper.insertCatBrand();
         */

    }
    
    


    public void syncJdGoods() {
        JdServiceAdapter i = (JdServiceAdapter)adapters.get(4);
            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 开始同步分类");
            List<SupCategory> cats = null;
            try {
                cats = i.fetchCategory();
            } catch (TokenInvalidException e) {
                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载分类失败 [token invalid]");
                i.invalidToken();
                syncToken(i);
                try {
                    logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 重新加载分类");
                    // 有供应商是分类，有供应商是商品池
                    cats = i.fetchCategory();
                } catch (Exception e1) {
                    logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载分类刷新token后重试仍然异常.", e1);
                }
            } catch (ServiceExecutionFailedException e) {
                logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载分类异常", e);
            }
            try {
                i.fetchBizToken();
            } catch (Exception e) {
                logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] BizToken 获取异常", e);
                return;
            }
            if (cats != null) {
                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 开始同步商品");
                List<String> skus = null;
                List<String> skuAll = null;
                Map<String, Price> price = null;
                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 清除商品图片");
                //goodsMapper.deleteSupGoodsImage(i.getSupplier().getSupId());
                for (SupCategory c : cats) {
                    logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 同步商品，分类 [" + c.getSupCatName() + "]");
                    int page = 1;
                    Map<String, Object> rtn = null;
                    boolean more = true;
                    int poolCount = goodsMapper.querySupGoodsPoolId(i.getSupplier().getSupId(),c.getSupCatId());
                    if(poolCount > 0){
                    	more = false;
                    }
                    while (more) {
                            
                        try {
                        	
                            rtn = i.fetchSku(c.getSupCatId(), page++);
                            skuAll = (List<String>)rtn.get("list");
                            more = (Boolean)rtn.get("more");
                            //skuAll = i.fetchSku(c.getSupCatId());
                        } catch (Exception e) {
                            logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载SKU异常 分类 [" + c.getSupCatName() + "]", e);
                            more = false;
                            continue;
                        }
                        //goodsMapper.deleteSupCatGoods(i.getSupplier().getSupId(), c.getSupCatId());
                        int pos = 0;
                        // 100个执行一次
                        while (skuAll.size() > pos) {
    
                            int count = 0;
                            int end = pos + 100;
                            if (end > skuAll.size()) {
                                end = skuAll.size();
                            }
                            skus = skuAll.subList(pos, end);
                            pos = end;
    
                            try {
                                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取价格 分类 [" + c.getSupCatName() + "] SKU [" + skus
                                        + "]");
                                price = i.fetchPrice(skus);
                            } catch (Exception e) {
                                logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取价格异常 分类 [" + c.getSupCatName() + "] SKU [" + skus
                                        + "]", e);
                                continue;
                            }
    
                            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] SKU POS [" + end + "]");
                            for (String s : skus) {
                                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取并保存商品信息 分类 [" + c.getSupCatName() + "] SKU [" + s
                                        + "]");
                                try {
                                    Goods g = i.fetchGoods(s, c.getSupCatId());
                                    Price p = price.get(g.getSupGoodsId());
                                    g.setAgreePrice(p.getAgreePrice());
                                    g.setCountPrice(p.getCountPrice());
                                    g.setSalePrice(p.getSalePrice());
                                    g.setBusinessPrice(p.getBusinessPrice());
                                    // g.setSupCatId(c.getSupCatId());
                                    // 统一为池编号，分类编号放在adapter内部处理
                                    g.setPoolId(c.getSupCatId());
                                    goodsMapper.insertSupGoods(g);
                                    count++;
    
                                } catch (Exception e) {
                                    logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取并保存商品异常 分类 [" + c.getSupCatName() + "] SKU ["
                                            + s + "]", e);
                                    continue;
                                }
                            }
                            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] 商品 [" + pos
                                    + "] 同步完成 成功数量 [" + count + "] 失败数量 [" + (skus.size() - count) + "]");
    
                            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] 同步商品图片 SKU [" + skus + "]");
                            try {
                                List<GoodsImage> images = i.fetchGoodsImage(skus);
                                goodsMapper.batchInsertGoodsImage(images);
                            } catch (Exception e) {
                                logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 同步商品图片异常 分类 [" + c.getSupCatName() + "] SKU ["
                                        + skus + "]", e);
                                continue;
                            }
                            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 分类 [" + c.getSupCatName() + "] 商品 [" + pos + "] 图片同步完成");
                        }
                    }

                }
                cats = null;
            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品同步完成");

        }

        /*
         * 品牌不再生成，搜索时根据商品条件实时查询 logger.info("CpiService 清除品牌对应关系");
         * categoryMapper.deleteCatBrand(); logger.info("CpiService 生成品牌对应关系");
         * categoryMapper.insertCatBrand();
         */

    }
    
    public void syncIncrGoods() throws Exception {

        logger.info("CpiService 同步商品增量数据");
        for (ServiceAdapter i : adapters.values()) {
            if (i.syncType() == ServiceAdapter.SYNC_TYPE.SYNC_FULL) {
                continue;
            }
            
            syncIncrByAdapter(i);
        }

        logger.info("CpiService 同步商品增量数据完成");
    }
    
    private void syncIncrByAdapter(ServiceAdapter i) throws Exception {
        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 开始同步程序");
        int maxExecTimes = 500;
        while(maxExecTimes-- > 0) {
            logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 开始获取推送消息");
            List<GoodsMessage> msgs = null;
            try {
                msgs = i.getMessage();
            } catch (TokenInvalidException e) {
                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 加载获取推送消息失败 [token invalid]");
                i.invalidToken();
                syncToken(i);
                try {
                    logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 重新获取推送消息");
                    msgs = i.getMessage();
                } catch (Exception e1) {
                    logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取推送消息刷新token后重试仍然异常.", e1);
                }
            } catch (ServiceExecutionFailedException e) {
                logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 获取推送消息异常", e);
            }
    
            if (msgs == null || msgs.size() == 0) {
                break ;
            }
            
            for (GoodsMessage m : msgs) {
                List<String> skuParam = new ArrayList<String>();
                skuParam.add(m.getSku());
                SyncLog log = new SyncLog();
                log.setSupId(String.valueOf(i.getSupplier().getSupId()));
                log.setSupGoodsId(m.getSku());
                log.setType(String.valueOf(m.getOperation()));
                log.setStatus("1");
                
                switch (m.getOperation()) {
                    case GoodsMessage.Operation.PRICE:
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行价格同步");
                        try {
                            Map<String, Price> price = i.fetchPrice(skuParam);
                            Price p = price.get(m.getSku());
                            p.setSupId(i.getSupplier().getSupId());
                            p.setSupGoodsId(m.getSku());
                            goodsMapper.updateGoodsPrice(p);
                        } catch (Exception e) {
                            log.setStatus("0");
                            log.setErrorMsg(e.getMessage());
                            logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行价格同步失败", e);
                        }
                        
                        break;
                    case GoodsMessage.Operation.STATE_CHANGE:
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 获取上下架状态");
                        try {
                            Map<String, Integer> status = i.fetchStatus(skuParam);
                            goodsMapper.updateGoodsStatus(i.getSupplier().getSupId(), m.getSku(), status.get(m.getSku()));
                        } catch (Exception e) {
                            log.setStatus("0");
                            log.setErrorMsg(e.getMessage());
                            logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行上下架同步失败", e);
                        }
                        break;
                    case GoodsMessage.Operation.STATE_ON:
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行上架");
                        goodsMapper.updateGoodsStatus(i.getSupplier().getSupId(), m.getSku(), 1);
                        break;
                    case GoodsMessage.Operation.STATE_OFF:
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行下架");
                        goodsMapper.updateGoodsStatus(i.getSupplier().getSupId(), m.getSku(), 0);
                        break;
                    case GoodsMessage.Operation.GOODS_ADD:
                    case GoodsMessage.Operation.GOODS_UPDATE:
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行信息同步");
                        try {
                            syncSingleGoods(i.getSupplier().getSupId(), 0, m.getSku());
                        } catch (Exception e) {
                            log.setStatus("0");
                            log.setErrorMsg(e.getMessage());
                            logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行信息同步失败", e);
                        }
                        break;
                    case GoodsMessage.Operation.GOODS_DELETE:
                        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品 [" + m.getSku() + "] 执行删除");
                        goodsMapper.deleteGoodsById(i.getSupplier().getSupId(), m.getSku());
                        goodsMapper.deleteGoodsImages(i.getSupplier().getSupId(), m.getSku());
                        break;
                    default:
                        break;
                }

                logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 删除推送消息 [" + m.getMsgId() + "]");
                try {
                    i.delMessage(m.getMsgId());
                } catch (Exception e) {
                    logger.error("供应商服务 [" + i.getSupplier().getSupCode() + "] 删除推送消息 [" + m.getMsgId() + "] 失败", e);
                }
                syncLogMapper.insertSyncLog(log);
            }
        }
        
        logger.info("供应商服务 [" + i.getSupplier().getSupCode() + "] 商品增量同步完成");
    }
    

    public void syncSingleGoods(int sup, int pool, String sku) throws Exception {
        ServiceAdapter i = getServiceAdapter(sup);
            List<String> skus = new ArrayList<String>();
            skus.add(sku);
            Map<String, Price> price = null;
            try {
                price = i.fetchPrice(skus);
            } catch (TokenInvalidException e) {
                i.invalidToken();
                syncToken(i);
                try {
                    price = i.fetchPrice(skus);
                } catch (Exception e1) {
                    throw new Exception ("同步价格失败：" + e1.getMessage());
                }
            } catch (Exception ex) {
                throw new Exception ("同步价格失败：" + ex.getMessage());
            }

            try {
                Goods g = i.fetchGoods(sku, pool);
                Price p = price.get(g.getSupGoodsId());
                g.setAgreePrice(p.getAgreePrice());
                g.setCountPrice(p.getCountPrice());
                g.setSalePrice(p.getSalePrice());
                g.setBusinessPrice(p.getBusinessPrice());
                g.setPoolId(pool);
                goodsMapper.deleteGoodsById(sup, sku);
                goodsMapper.insertSupGoods(g);

            } catch (Exception e) {
                throw new Exception ("同步商品失败：" + e.getMessage());
            }

            try {
                List<GoodsImage> images = i.fetchGoodsImage(skus);
                goodsMapper.deleteGoodsImages(sup, sku);
                goodsMapper.batchInsertGoodsImage(images);
            } catch (Exception e) {
                throw new Exception ("同步商品图片失败：" + e.getMessage());
            }


    }

    public List<SupArea> getProvince(int supId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchProvince();
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载省份失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载省份");
                return adapter.fetchProvince();
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载省份异常", e1);
                throw new ServiceExecutionFailedException("加载省份刷新token后重试仍然异常", e1);
            }
        }
    }

    public List<SupArea> getCity(int supId, int prov) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchCity(prov);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载城市失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载城市");
                return adapter.fetchCity(prov);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载城市异常", e1);
                throw new ServiceExecutionFailedException("加载城市刷新token后重试仍然异常", e1);
            }
        }
    }

    public List<SupArea> getCountry(int supId, int city) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchCountry(city);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载区县失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载区县");
                return adapter.fetchCountry(city);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载区县异常", e1);
                throw new ServiceExecutionFailedException("加载区县刷新token后重试仍然异常", e1);
            }
        }
    }

    public List<SupArea> getTown(int supId, int country) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchTown(country);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载乡镇失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载乡镇");
                return adapter.fetchTown(country);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载乡镇异常", e1);
                throw new ServiceExecutionFailedException("加载乡镇刷新token后重试仍然异常", e1);
            }
        }
    }

    public List<String> getSku(int supId, int cat) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchSku(cat);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载SKU失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新加载SKU");
                return adapter.fetchSku(cat);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 加载SKU异常", e1);
                throw new ServiceExecutionFailedException("加载SKU刷新token后重试仍然异常", e1);
            }
        }
    }

    public String orderSubmit(int supId, Order order) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.orderSubmit(order);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单预占失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新订单预占");
                return adapter.orderSubmit(order);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单预占异常", e1);
                throw new ServiceExecutionFailedException("订单预占刷新token后重试仍然异常", e1);
            }
        }
    }

    public void orderConfirm(int supId, String orderId, String supOrderId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            adapter.orderConfirm(orderId, supOrderId);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单确认失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新订单确认");
                adapter.orderConfirm(orderId, supOrderId);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单确认异常", e1);
                throw new ServiceExecutionFailedException("订单确认刷新token后重试仍然异常", e1);
            }
        }
    }

    public void orderCancel(int supId, String orderId, String supOrderId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            adapter.orderCancel(orderId, supOrderId);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单取消失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新订单取消");
                adapter.orderCancel(orderId, supOrderId);
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单取消成功");
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单取消异常", e1);
                throw new ServiceExecutionFailedException("订单取消刷新token后重试仍然异常", e1);
            }
        }
    }

    public Map<String, Object> trackInfo(int supId, String orderId, String supOrderId) throws NoSuchSupplierException,
            ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
        }
        Map<String, Object> result = null;
        ServiceAdapter adapter = adapters.get(supId);
        try {
            result = adapter.trackInfo(orderId, supOrderId);
        } catch (TokenInvalidException e) {
            logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单取消失败 [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 重新订单取消");
                adapter.trackInfo(orderId, supOrderId);
            } catch (TokenInvalidException e1) {
                logger.error("供应商服务 [" + adapter.getSupplier().getSupCode() + "] 订单取消异常", e1);
                throw new ServiceExecutionFailedException("订单取消刷新token后重试仍然异常", e1);
            }
        }
        return result;
    }

	public Map<String, Object> selectOrder(int supId,
			String supOrderId) throws NoSuchSupplierException,
			ServiceExecutionFailedException {
		if (!adapters.containsKey(supId)) {
			throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.selectOrder(supOrderId);
		} catch (TokenInvalidException e) {
			logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode()
					+ "] 订单取消失败 [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 重新订单取消");
				adapter.selectOrder(supOrderId);
			} catch (TokenInvalidException e1) {
				logger.error("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 订单取消异常", e1);
				throw new ServiceExecutionFailedException("订单取消刷新token后重试仍然异常",
						e1);
			}
		}
		return result;
	}
    public void syncArea(int supId) throws NoSuchSupplierException, ServiceExecutionFailedException {

        List<SupArea> provs = getProvince(supId);

        addressMapper.deleteSupArea(supId);
        addressMapper.batchInsertArea(provs);

        for (SupArea i : provs) {
            List<SupArea> citys = null;
            try {
                citys = getCity(supId, i.getSupAreaId());
            } catch (Exception e) {
            }
            if (citys != null && citys.size() > 0) {
                addressMapper.batchInsertArea(citys);
                for (SupArea j : citys) {
                    List<SupArea> coutrys = null;
                    try {
                        coutrys = getCountry(supId, j.getSupAreaId());
                    } catch (Exception e) {
                    }
                    if (coutrys != null && coutrys.size() > 0) {
                        addressMapper.batchInsertArea(coutrys);
                        for (SupArea k : coutrys) {
                            List<SupArea> towns = null;
                            try {
                                towns = getTown(supId, k.getSupAreaId());
                            } catch (Exception e) {
                            }
                            if (towns != null && towns.size() > 0) {
                                addressMapper.batchInsertArea(towns);
                                
                            }
                        }
                    }
                }
            }
        }

    }
    /**
     * 退换货申请服务订单
     * @param supId
     * @param afsApplyCreate
     * @param asCustomerDto
     * @param asDetailDto
     * @param asPickwareDto
     * @param asReturnwareDto
     * @return
     * @throws NoSuchSupplierException
     * @throws ServiceExecutionFailedException
     */
    
    public Map<String, Object> afterSaleAfsApplyCreate(int supId,
    		Map afsApplyCreate) throws NoSuchSupplierException,
			ServiceExecutionFailedException {
		if (!adapters.containsKey(supId)) {
			throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.afterSaleAfsApplyCreate(afsApplyCreate);
		} catch (TokenInvalidException e) {
			logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode()
					+ "] 申请服务订单失败 [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 重新申请服务订单");
				adapter.afterSaleAfsApplyCreate(afsApplyCreate);
			} catch (TokenInvalidException e1) {
				logger.error("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 申请服务订单异常", e1);
				throw new ServiceExecutionFailedException("订单取消刷新token后重试仍然异常",
						e1);
			}
		}
		return result;
	}
    
    /**
     * 退换货申请服务订单
     * @param supId
     * @param jdOrderId
     * @param pageIndex
     * @param pageSize
     * @return
     * @throws NoSuchSupplierException
     * @throws ServiceExecutionFailedException
     */
    
    public Map<String, Object> serviceListPage(int supId,String jdOrderId,int pageIndex,int pageSize) throws NoSuchSupplierException,
			ServiceExecutionFailedException {
		if (!adapters.containsKey(4)) {
			throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.serviceListPage(jdOrderId,pageIndex,pageSize);
		} catch (TokenInvalidException e) {
			logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode()
					+ "] 申请服务订单失败 [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 重新申请服务订单");
				adapter.serviceListPage(jdOrderId,pageIndex,pageSize);
			} catch (TokenInvalidException e1) {
				logger.error("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 申请服务订单异常", e1);
				throw new ServiceExecutionFailedException("订单取消刷新token后重试仍然异常",
						e1);
			}
		}
		return result;
	}
    
    
    
    
    
    /**
     * 获取京东服务单状态 更新订单
     * @throws ServiceExecutionFailedException 
     * @throws NoSuchSupplierException 
     */
    public void runUPDJDOrderStatus(String exchangeOrRefound) throws NoSuchSupplierException, ServiceExecutionFailedException {
        logger.info("CpiService 获取京东服务单状态 更新订单开始");
        int pageIndex = 1;
        int pageSize = 10;
        String jdOrderId = "";
        int supId = 4;
        Map<String, Object> result = new HashMap<String, Object>();
        //先获取京东退换货订单 获取jdorderid
        List<Order> orders  = new ArrayList<Order>(); 
        Order order = new Order();
        order.setSupId(4); //4为京东supid
        if("1".equals(exchangeOrRefound)){
        	 orders = orderMapper.queryJDOrderForExchangeInfos(order);
        }else{
        	 orders = orderMapper.queryJDOrderForRefoundInfos(order);
        }
        if(orders == null || orders.size()<=0){
        	logger.info("----获取京东服务单状态 更新订单完成,无需要更新退换货单。----");
        	return;
        }
        //循环退货单
        for (int i = 0; i < orders.size(); i++) {
        	jdOrderId = orders.get(i).getSupOrderId();
        	if(jdOrderId == null || "".equals(jdOrderId)){
        		continue;
        	}
        	int goodsCount = 0;
        	if("1".equals(exchangeOrRefound)){
        		goodsCount = Integer.parseInt(orders.get(0).getExchangeAmount());
           }else{
        	    goodsCount = Integer.parseInt(orders.get(0).getRefoundAmount());
           }
        	int done = 0;
            int un = 0;
            int cancle = 0;
        	//计算页码
        	int pages = goodsCount%pageSize==0?goodsCount/pageSize:goodsCount/pageSize+1;
        	String orderStatus = "";
        	
        	Services services = new Services();
            services.setOrderID(orders.get(i).getOrderId());
            services.setSupID(orders.get(i).getSupId()+"");
            if("1".equals(exchangeOrRefound)){
            	services.setTypeID(orders.get(i).getExchangeID());
            }else{
            	services.setTypeID(orders.get(i).getRefoundID());
            }
            
            
        	for (int j = 0; j < pages; j++) {
        		try{       			       		
        		//请求3.6根据客户账号和订单号分页查询服务单概要信息 获取1个服务单号
            	result = this.serviceListPage(supId, jdOrderId, pageIndex, pageSize);
            	logger.info("返回结果："+result.get("success")+result.get("resultMessage"));
            	if(!(Boolean) result.get("success")){//判断jd接口是否返回正确结果
            		logger.debug("-----返回错误信息,更新失败：supOrderID"+orders.get(i).getSupId());
            		continue;
            	}
            	JSONObject jsonObj = JSONObject.fromObject(result.get("result"));
            	JSONArray json =JSONArray.fromObject(jsonObj.get("serviceInfoList"));
            	List<AfsServicebyCustomerPinDto> afsServiceByCustomerPins = JSONArray.toList(json,AfsServicebyCustomerPinDto.class);
            	 if(afsServiceByCustomerPins!=null && afsServiceByCustomerPins.size()>0){
            		 for (AfsServicebyCustomerPinDto afsServicebyCustomerPinDto : afsServiceByCustomerPins) {
            			 //根据京东接口返回服务单状态 更新订单状态
                         int jdStatus = afsServicebyCustomerPinDto.getAfsServiceStep();
                         if(jdStatus == 20){
	              	        	un += 1;                //审核不通过                       	 
                         }else if(jdStatus >= 40){
	              	        	done += 1;				//完成                       	 
                         }else if(jdStatus == 60){
	              	        	cancle += 1;            //取消
                         }
                        //添加或更新服务单到表中 merge操作 没有插入 有更新服务单状态
                         services.setServicesID(afsServicebyCustomerPinDto.getAfsServiceId()+"");
                         services.setServicesStatus(afsServicebyCustomerPinDto.getAfsServiceStep()+"");
                         services.setServicesType(afsServicebyCustomerPinDto.getCustomerExpect()+"");
                         services.setSupOrderID(afsServicebyCustomerPinDto.getOrderId()+"");
                         services.setSupGoodsID(afsServicebyCustomerPinDto.getWareId()+"");
                         if(jdStatus>=33){
                        	 services.setIfCancel("1");
                         }else{
                        	 services.setIfCancel("0");
                         }                         
                         servicesMapper.mergeServices(services);
            		 }
            		 pageIndex++;
            	 }else{
            		 logger.info("轮询无法获取服务单（没有服务单），退出操作。。。");
            		 break;
            	 }
        		}catch(ServiceExecutionFailedException se){
        			se.printStackTrace();
        			break;
        		}
			}        	
           //根据京东接口返回服务单状态 更新订单状态
        	if(done == goodsCount){
        		orderStatus = "4";
        	}else if(un > 0){
        		orderStatus = "2";
        	}else if(cancle == goodsCount){
        		if("1".equals(exchangeOrRefound)){
    	        	orderStatus = "7";
    	        }else{
    	        	orderStatus = "6";
    	        }
        	}
        	
            Order updOrder = new Order();
            
            if("1".equals(exchangeOrRefound)&& !"".equals(orderStatus)){
            	 updOrder.setExchangeStatus(orderStatus);
            	 updOrder.setSupOrderId(jdOrderId);
            	 orderMapper.updExchangeStatusByJDStatus(updOrder);
            }else if("2".equals(exchangeOrRefound)&& !"".equals(orderStatus)){
            	updOrder.setRefoundStatus(orderStatus);
            	updOrder.setSupOrderId(jdOrderId);
            	orderMapper.updRefoundStatusByJDStatus(updOrder);
            }
        }
        logger.info("获取京东服务单状态 更新订单完成");

   }
    
    
    
    /**
     * 退换货申请服务订单
     * @param supId
     * @param afsApplyCreate
     * @param asCustomerDto
     * @param asDetailDto
     * @param asPickwareDto
     * @param asReturnwareDto
     * @return
     * @throws NoSuchSupplierException
     * @throws ServiceExecutionFailedException
     */
    
    public Map<String, Object> auditCancel(int supId,Map auditCancel) throws NoSuchSupplierException,
			ServiceExecutionFailedException {
		if (!adapters.containsKey(supId)) {
			throw new NoSuchSupplierException("供应商不存在 [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.auditCancel(auditCancel);
		} catch (TokenInvalidException e) {
			logger.warn("供应商服务 [" + adapter.getSupplier().getSupCode()
					+ "] 申请服务订单失败 [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 重新申请服务订单");
				adapter.auditCancel(auditCancel);
			} catch (TokenInvalidException e1) {
				logger.error("供应商服务 [" + adapter.getSupplier().getSupCode()
						+ "] 申请服务订单异常", e1);
				throw new ServiceExecutionFailedException("订单取消刷新token后重试仍然异常",
						e1);
			}
		}
		return result;
	} 
}
