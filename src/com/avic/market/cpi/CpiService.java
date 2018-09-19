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
        logger.info("CpiService ���� ...");

        try {
            List<Supplier> sups = supplierMapper.querySupplierList();

            if (sups == null || sups.size() == 0) {
                logger.error("ϵͳ�޹�Ӧ������");
                return;
            }

            for (Supplier s : sups) {
                if (s.getSupType() != 0) {
                    continue;
                }
                logger.info("��ʼ���ع�Ӧ�̷��� [ID:" + s.getSupId() + " CODE:" + s.getSupCode() + "]...");
                Class<?> clazz = Class.forName("com.avic.market.cpi.adapters." + s.getSupCode().substring(0, 1).toUpperCase()
                        + s.getSupCode().substring(1) + "ServiceAdapter");

                if (ServiceAdapter.class.isAssignableFrom(clazz)) {
                    ServiceAdapter adapter = (ServiceAdapter) clazz.newInstance();
                    adapter.setSupplier(s);
                    adapters.put(s.getSupId(), adapter);
                    adapter.init();

                    syncToken(adapter);

                } else {
                    throw new Exception("��Ӧ�̷��񲻴��� [ID:" + s.getSupId() + " CODE:" + s.getSupCode() + "]");
                }
                logger.info("���ع�Ӧ�̳ɹ� [ID:" + s.getSupId() + " CODE:" + s.getSupCode() + "]");

            }
        } catch (Exception e) {
            logger.error("���ع�Ӧ���쳣", e);
        }

        instance = this;

        logger.info("CpiService ������ɣ���Ӧ������ [" + adapters.size() + "]");
    }

    private synchronized void syncToken(ServiceAdapter adapter) {
        if (!adapter.isTokenValid()) {
            Supplier s = supplierMapper.querySupplierById(adapter.getSupplier().getSupId());
            
            if (s.getAccessToken() != null && adapter.getSupplier().getAccessToken() != null && !s.getAccessToken().equals(adapter.getSupplier().getAccessToken())) {
                // �������ʱ������token�ѱ�����
                adapter.setSupplier(s);
            } else {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] token ��Ч, ˢ�� ...");
                try {
                    adapter.fetchToken();
                } catch (ServiceExecutionFailedException e) {
                    logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] token ˢ��ʧ��", e);
                    return;
                }
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] token ��ˢ�� [access:" + adapter.getSupplier().getAccessToken()
                        + " refresh:" + adapter.getSupplier().getRefreshToken() + "]");
                supplierMapper.updateSupplierToken(adapter.getSupplier());
            }
        }
    }

    public List<SupCategory> getCategory(int supId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchCategory();
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���ط���ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼��ط���");
                return adapter.fetchCategory();
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���ط����쳣", e1);
                throw new ServiceExecutionFailedException("���ط���ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public Goods getGoodsDetail(int supId, String sku) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchGoods(sku, 0);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ��Ϣʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�����Ʒ��Ϣ");
                return adapter.fetchGoods(sku, 0);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ��Ϣ�쳣", e1);
                throw new ServiceExecutionFailedException("������Ʒ��Ϣˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public Price getGoodsPrice(int supId, String sku) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        List<String> skus = new ArrayList<String>();
        skus.add(sku);
        try {
            return adapter.fetchPrice(skus).get(sku);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ�۸�ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�����Ʒ�۸�");
                return adapter.fetchPrice(skus).get(sku);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ�۸��쳣", e1);
                throw new ServiceExecutionFailedException("������Ʒ�۸�ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public Map<String, Price> getGoodsPrice(int supId, List<String> skus) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchPrice(skus);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ�۸�ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�����Ʒ�۸�");
                return adapter.fetchPrice(skus);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ�۸��쳣", e1);
                throw new ServiceExecutionFailedException("������Ʒ�۸�ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public Map<String, Integer> getGoodsStock(int supId, List<String> skus, List<Integer> nums, List<String> area) throws NoSuchSupplierException,
            ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);

        try {
            return adapter.fetchStock(skus, nums, area);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ���ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�����Ʒ���");
                return adapter.fetchStock(skus, nums, area);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ����쳣", e1);
                throw new ServiceExecutionFailedException("������Ʒ���ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public Map<String, Integer> getGoodsStatus(int supId, List<String> skus) throws NoSuchSupplierException,
            ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);

        try {
            return adapter.fetchStatus(skus);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ���¼�״̬ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�����Ʒ���¼�״̬");
                return adapter.fetchStatus(skus);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������Ʒ���¼�״̬�쳣", e1);
                throw new ServiceExecutionFailedException("������Ʒ���¼�״̬ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public GoodsImage getGoodsImage(int supId, String sku) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        ServiceAdapter adapter = adapters.get(supId);
        List<String> skus = new ArrayList<String>();
        skus.add(sku);
        try {
            return adapter.fetchGoodsImage(skus).get(0);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������ƷͼƬʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�����ƷͼƬ");
                return adapter.fetchGoodsImage(skus).get(0);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ������ƷͼƬ�쳣", e1);
                throw new ServiceExecutionFailedException("������ƷͼƬˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public void syncGoods() {
        logger.info("CpiService ͬ����Ʒ����, [" + adapters.size() + "] ��Ӧ����Ҫͬ��");
        List<SupCategory> cats = null;
        for (ServiceAdapter i : adapters.values()) {
            if (i.syncType() == ServiceAdapter.SYNC_TYPE.SYNC_INCR) {
                continue;
            }
            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ʼͬ������");
            try {
                cats = i.fetchCategory();
            } catch (TokenInvalidException e) {
                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���ط���ʧ�� [token invalid]");
                i.invalidToken();
                syncToken(i);
                try {
                    logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���¼��ط���");
                    // �й�Ӧ���Ƿ��࣬�й�Ӧ������Ʒ��
                    cats = i.fetchCategory();
                } catch (Exception e1) {
                    logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���ط���ˢ��token��������Ȼ�쳣.", e1);
                }
            } catch (ServiceExecutionFailedException e) {
                logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���ط����쳣", e);
            }
            if (cats != null) {
                /*
                 * ����ֱ���ṩ���ݣ����ﲻ��ͬ�� logger.info("��Ӧ�̷��� [" +
                 * i.getSupplier().getSupCode() + "] ����׼��д�����ݿ⣬����[" +
                 * cats.size() + "]");
                 * categoryMapper.deleteAllSupCat(i.getSupplier().getSupId());
                 * categoryMapper.batchInsertSupCat(cats); logger.info("��Ӧ�̷��� ["
                 * + i.getSupplier().getSupCode() + "] ����д�����");
                 */
                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ʼͬ����Ʒ");
                List<String> skus = null;
                List<String> skuAll = null;
                Map<String, Price> price = null;
                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] �����ƷͼƬ");
                goodsMapper.deleteSupGoodsImage(i.getSupplier().getSupId());
                for (SupCategory c : cats) {
                    logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ͬ����Ʒ������ [" + c.getSupCatName() + "]");
                    try {
                        skuAll = i.fetchSku(c.getSupCatId());
                    } catch (Exception e) {
                        logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ����SKU�쳣 ���� [" + c.getSupCatName() + "]", e);
                        continue;
                    }
                    goodsMapper.deleteSupCatGoods(i.getSupplier().getSupId(), c.getSupCatId());
                    int pos = 0;
                    // 100��ִ��һ��
                    while (skuAll.size() > pos) {

                        int count = 0;
                        int end = pos + 100;
                        if (end > skuAll.size()) {
                            end = skuAll.size();
                        }
                        skus = skuAll.subList(pos, end);
                        pos = end;

                        try {
                            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ�۸� ���� [" + c.getSupCatName() + "] SKU [" + skus
                                    + "]");
                            price = i.fetchPrice(skus);
                        } catch (Exception e) {
                            logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ�۸��쳣 ���� [" + c.getSupCatName() + "] SKU [" + skus
                                    + "]", e);
                            continue;
                        }

                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] SKU POS [" + end + "]");
                        for (String s : skus) {
                            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ��������Ʒ��Ϣ ���� [" + c.getSupCatName() + "] SKU [" + s
                                    + "]");
                            try {
                                Goods g = i.fetchGoods(s, c.getSupCatId());
                                Price p = price.get(g.getSupGoodsId());
                                g.setAgreePrice(p.getAgreePrice());
                                g.setCountPrice(p.getCountPrice());
                                g.setSalePrice(p.getSalePrice());
                                g.setBusinessPrice(p.getBusinessPrice());
                                // g.setSupCatId(c.getSupCatId());
                                // ͳһΪ�ر�ţ������ŷ���adapter�ڲ�����
                                g.setPoolId(c.getSupCatId());
                                goodsMapper.insertSupGoods(g);
                                count++;

                            } catch (Exception e) {
                                logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ��������Ʒ�쳣 ���� [" + c.getSupCatName() + "] SKU ["
                                        + s + "]", e);
                                continue;
                            }
                        }
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] ��Ʒ [" + pos
                                + "] ͬ����� �ɹ����� [" + count + "] ʧ������ [" + (skus.size() - count) + "]");

                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] ͬ����ƷͼƬ SKU [" + skus + "]");
                        try {
                            List<GoodsImage> images = i.fetchGoodsImage(skus);
                            goodsMapper.batchInsertGoodsImage(images);
                        } catch (Exception e) {
                            logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ͬ����ƷͼƬ�쳣 ���� [" + c.getSupCatName() + "] SKU ["
                                    + skus + "]", e);
                            continue;
                        }
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] ��Ʒ [" + pos + "] ͼƬͬ�����");

                    }

                }
                cats = null;
            }
            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒͬ�����");

        }

        /*
         * Ʒ�Ʋ������ɣ�����ʱ������Ʒ����ʵʱ��ѯ logger.info("CpiService ���Ʒ�ƶ�Ӧ��ϵ");
         * categoryMapper.deleteCatBrand(); logger.info("CpiService ����Ʒ�ƶ�Ӧ��ϵ");
         * categoryMapper.insertCatBrand();
         */

    }
    
    


    public void syncJdGoods() {
        JdServiceAdapter i = (JdServiceAdapter)adapters.get(4);
            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ʼͬ������");
            List<SupCategory> cats = null;
            try {
                cats = i.fetchCategory();
            } catch (TokenInvalidException e) {
                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���ط���ʧ�� [token invalid]");
                i.invalidToken();
                syncToken(i);
                try {
                    logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���¼��ط���");
                    // �й�Ӧ���Ƿ��࣬�й�Ӧ������Ʒ��
                    cats = i.fetchCategory();
                } catch (Exception e1) {
                    logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���ط���ˢ��token��������Ȼ�쳣.", e1);
                }
            } catch (ServiceExecutionFailedException e) {
                logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���ط����쳣", e);
            }
            try {
                i.fetchBizToken();
            } catch (Exception e) {
                logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] BizToken ��ȡ�쳣", e);
                return;
            }
            if (cats != null) {
                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ʼͬ����Ʒ");
                List<String> skus = null;
                List<String> skuAll = null;
                Map<String, Price> price = null;
                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] �����ƷͼƬ");
                //goodsMapper.deleteSupGoodsImage(i.getSupplier().getSupId());
                for (SupCategory c : cats) {
                    logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ͬ����Ʒ������ [" + c.getSupCatName() + "]");
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
                            logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ����SKU�쳣 ���� [" + c.getSupCatName() + "]", e);
                            more = false;
                            continue;
                        }
                        //goodsMapper.deleteSupCatGoods(i.getSupplier().getSupId(), c.getSupCatId());
                        int pos = 0;
                        // 100��ִ��һ��
                        while (skuAll.size() > pos) {
    
                            int count = 0;
                            int end = pos + 100;
                            if (end > skuAll.size()) {
                                end = skuAll.size();
                            }
                            skus = skuAll.subList(pos, end);
                            pos = end;
    
                            try {
                                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ�۸� ���� [" + c.getSupCatName() + "] SKU [" + skus
                                        + "]");
                                price = i.fetchPrice(skus);
                            } catch (Exception e) {
                                logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ�۸��쳣 ���� [" + c.getSupCatName() + "] SKU [" + skus
                                        + "]", e);
                                continue;
                            }
    
                            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] SKU POS [" + end + "]");
                            for (String s : skus) {
                                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ��������Ʒ��Ϣ ���� [" + c.getSupCatName() + "] SKU [" + s
                                        + "]");
                                try {
                                    Goods g = i.fetchGoods(s, c.getSupCatId());
                                    Price p = price.get(g.getSupGoodsId());
                                    g.setAgreePrice(p.getAgreePrice());
                                    g.setCountPrice(p.getCountPrice());
                                    g.setSalePrice(p.getSalePrice());
                                    g.setBusinessPrice(p.getBusinessPrice());
                                    // g.setSupCatId(c.getSupCatId());
                                    // ͳһΪ�ر�ţ������ŷ���adapter�ڲ�����
                                    g.setPoolId(c.getSupCatId());
                                    goodsMapper.insertSupGoods(g);
                                    count++;
    
                                } catch (Exception e) {
                                    logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ��������Ʒ�쳣 ���� [" + c.getSupCatName() + "] SKU ["
                                            + s + "]", e);
                                    continue;
                                }
                            }
                            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] ��Ʒ [" + pos
                                    + "] ͬ����� �ɹ����� [" + count + "] ʧ������ [" + (skus.size() - count) + "]");
    
                            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] ͬ����ƷͼƬ SKU [" + skus + "]");
                            try {
                                List<GoodsImage> images = i.fetchGoodsImage(skus);
                                goodsMapper.batchInsertGoodsImage(images);
                            } catch (Exception e) {
                                logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ͬ����ƷͼƬ�쳣 ���� [" + c.getSupCatName() + "] SKU ["
                                        + skus + "]", e);
                                continue;
                            }
                            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���� [" + c.getSupCatName() + "] ��Ʒ [" + pos + "] ͼƬͬ�����");
                        }
                    }

                }
                cats = null;
            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒͬ�����");

        }

        /*
         * Ʒ�Ʋ������ɣ�����ʱ������Ʒ����ʵʱ��ѯ logger.info("CpiService ���Ʒ�ƶ�Ӧ��ϵ");
         * categoryMapper.deleteCatBrand(); logger.info("CpiService ����Ʒ�ƶ�Ӧ��ϵ");
         * categoryMapper.insertCatBrand();
         */

    }
    
    public void syncIncrGoods() throws Exception {

        logger.info("CpiService ͬ����Ʒ��������");
        for (ServiceAdapter i : adapters.values()) {
            if (i.syncType() == ServiceAdapter.SYNC_TYPE.SYNC_FULL) {
                continue;
            }
            
            syncIncrByAdapter(i);
        }

        logger.info("CpiService ͬ����Ʒ�����������");
    }
    
    private void syncIncrByAdapter(ServiceAdapter i) throws Exception {
        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ʼͬ������");
        int maxExecTimes = 500;
        while(maxExecTimes-- > 0) {
            logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ʼ��ȡ������Ϣ");
            List<GoodsMessage> msgs = null;
            try {
                msgs = i.getMessage();
            } catch (TokenInvalidException e) {
                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���ػ�ȡ������Ϣʧ�� [token invalid]");
                i.invalidToken();
                syncToken(i);
                try {
                    logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ���»�ȡ������Ϣ");
                    msgs = i.getMessage();
                } catch (Exception e1) {
                    logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ������Ϣˢ��token��������Ȼ�쳣.", e1);
                }
            } catch (ServiceExecutionFailedException e) {
                logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��ȡ������Ϣ�쳣", e);
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
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ�м۸�ͬ��");
                        try {
                            Map<String, Price> price = i.fetchPrice(skuParam);
                            Price p = price.get(m.getSku());
                            p.setSupId(i.getSupplier().getSupId());
                            p.setSupGoodsId(m.getSku());
                            goodsMapper.updateGoodsPrice(p);
                        } catch (Exception e) {
                            log.setStatus("0");
                            log.setErrorMsg(e.getMessage());
                            logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ�м۸�ͬ��ʧ��", e);
                        }
                        
                        break;
                    case GoodsMessage.Operation.STATE_CHANGE:
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ��ȡ���¼�״̬");
                        try {
                            Map<String, Integer> status = i.fetchStatus(skuParam);
                            goodsMapper.updateGoodsStatus(i.getSupplier().getSupId(), m.getSku(), status.get(m.getSku()));
                        } catch (Exception e) {
                            log.setStatus("0");
                            log.setErrorMsg(e.getMessage());
                            logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ�����¼�ͬ��ʧ��", e);
                        }
                        break;
                    case GoodsMessage.Operation.STATE_ON:
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ���ϼ�");
                        goodsMapper.updateGoodsStatus(i.getSupplier().getSupId(), m.getSku(), 1);
                        break;
                    case GoodsMessage.Operation.STATE_OFF:
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ���¼�");
                        goodsMapper.updateGoodsStatus(i.getSupplier().getSupId(), m.getSku(), 0);
                        break;
                    case GoodsMessage.Operation.GOODS_ADD:
                    case GoodsMessage.Operation.GOODS_UPDATE:
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ����Ϣͬ��");
                        try {
                            syncSingleGoods(i.getSupplier().getSupId(), 0, m.getSku());
                        } catch (Exception e) {
                            log.setStatus("0");
                            log.setErrorMsg(e.getMessage());
                            logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ����Ϣͬ��ʧ��", e);
                        }
                        break;
                    case GoodsMessage.Operation.GOODS_DELETE:
                        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ [" + m.getSku() + "] ִ��ɾ��");
                        goodsMapper.deleteGoodsById(i.getSupplier().getSupId(), m.getSku());
                        goodsMapper.deleteGoodsImages(i.getSupplier().getSupId(), m.getSku());
                        break;
                    default:
                        break;
                }

                logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ɾ��������Ϣ [" + m.getMsgId() + "]");
                try {
                    i.delMessage(m.getMsgId());
                } catch (Exception e) {
                    logger.error("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ɾ��������Ϣ [" + m.getMsgId() + "] ʧ��", e);
                }
                syncLogMapper.insertSyncLog(log);
            }
        }
        
        logger.info("��Ӧ�̷��� [" + i.getSupplier().getSupCode() + "] ��Ʒ����ͬ�����");
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
                    throw new Exception ("ͬ���۸�ʧ�ܣ�" + e1.getMessage());
                }
            } catch (Exception ex) {
                throw new Exception ("ͬ���۸�ʧ�ܣ�" + ex.getMessage());
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
                throw new Exception ("ͬ����Ʒʧ�ܣ�" + e.getMessage());
            }

            try {
                List<GoodsImage> images = i.fetchGoodsImage(skus);
                goodsMapper.deleteGoodsImages(sup, sku);
                goodsMapper.batchInsertGoodsImage(images);
            } catch (Exception e) {
                throw new Exception ("ͬ����ƷͼƬʧ�ܣ�" + e.getMessage());
            }


    }

    public List<SupArea> getProvince(int supId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchProvince();
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ʡ��ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼���ʡ��");
                return adapter.fetchProvince();
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ʡ���쳣", e1);
                throw new ServiceExecutionFailedException("����ʡ��ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public List<SupArea> getCity(int supId, int prov) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchCity(prov);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���س���ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼��س���");
                return adapter.fetchCity(prov);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���س����쳣", e1);
                throw new ServiceExecutionFailedException("���س���ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public List<SupArea> getCountry(int supId, int city) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchCountry(city);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ��������ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�������");
                return adapter.fetchCountry(city);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���������쳣", e1);
                throw new ServiceExecutionFailedException("��������ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public List<SupArea> getTown(int supId, int country) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchTown(country);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ��������ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼�������");
                return adapter.fetchTown(country);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���������쳣", e1);
                throw new ServiceExecutionFailedException("��������ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public List<String> getSku(int supId, int cat) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.fetchSku(cat);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����SKUʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¼���SKU");
                return adapter.fetchSku(cat);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����SKU�쳣", e1);
                throw new ServiceExecutionFailedException("����SKUˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public String orderSubmit(int supId, Order order) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            return adapter.orderSubmit(order);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����Ԥռʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¶���Ԥռ");
                return adapter.orderSubmit(order);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����Ԥռ�쳣", e1);
                throw new ServiceExecutionFailedException("����Ԥռˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public void orderConfirm(int supId, String orderId, String supOrderId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            adapter.orderConfirm(orderId, supOrderId);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ȷ��ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¶���ȷ��");
                adapter.orderConfirm(orderId, supOrderId);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ȷ���쳣", e1);
                throw new ServiceExecutionFailedException("����ȷ��ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public void orderCancel(int supId, String orderId, String supOrderId) throws NoSuchSupplierException, ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }

        ServiceAdapter adapter = adapters.get(supId);
        try {
            adapter.orderCancel(orderId, supOrderId);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ȡ��ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¶���ȡ��");
                adapter.orderCancel(orderId, supOrderId);
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ȡ���ɹ�");
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ȡ���쳣", e1);
                throw new ServiceExecutionFailedException("����ȡ��ˢ��token��������Ȼ�쳣", e1);
            }
        }
    }

    public Map<String, Object> trackInfo(int supId, String orderId, String supOrderId) throws NoSuchSupplierException,
            ServiceExecutionFailedException {
        if (!adapters.containsKey(supId)) {
            throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
        }
        Map<String, Object> result = null;
        ServiceAdapter adapter = adapters.get(supId);
        try {
            result = adapter.trackInfo(orderId, supOrderId);
        } catch (TokenInvalidException e) {
            logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ȡ��ʧ�� [token invalid]");
            adapter.invalidToken();
            syncToken(adapter);
            try {
                logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ���¶���ȡ��");
                adapter.trackInfo(orderId, supOrderId);
            } catch (TokenInvalidException e1) {
                logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode() + "] ����ȡ���쳣", e1);
                throw new ServiceExecutionFailedException("����ȡ��ˢ��token��������Ȼ�쳣", e1);
            }
        }
        return result;
    }

	public Map<String, Object> selectOrder(int supId,
			String supOrderId) throws NoSuchSupplierException,
			ServiceExecutionFailedException {
		if (!adapters.containsKey(supId)) {
			throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.selectOrder(supOrderId);
		} catch (TokenInvalidException e) {
			logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
					+ "] ����ȡ��ʧ�� [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ���¶���ȡ��");
				adapter.selectOrder(supOrderId);
			} catch (TokenInvalidException e1) {
				logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ����ȡ���쳣", e1);
				throw new ServiceExecutionFailedException("����ȡ��ˢ��token��������Ȼ�쳣",
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
     * �˻���������񶩵�
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
			throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.afterSaleAfsApplyCreate(afsApplyCreate);
		} catch (TokenInvalidException e) {
			logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
					+ "] ������񶩵�ʧ�� [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ����������񶩵�");
				adapter.afterSaleAfsApplyCreate(afsApplyCreate);
			} catch (TokenInvalidException e1) {
				logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ������񶩵��쳣", e1);
				throw new ServiceExecutionFailedException("����ȡ��ˢ��token��������Ȼ�쳣",
						e1);
			}
		}
		return result;
	}
    
    /**
     * �˻���������񶩵�
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
			throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.serviceListPage(jdOrderId,pageIndex,pageSize);
		} catch (TokenInvalidException e) {
			logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
					+ "] ������񶩵�ʧ�� [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ����������񶩵�");
				adapter.serviceListPage(jdOrderId,pageIndex,pageSize);
			} catch (TokenInvalidException e1) {
				logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ������񶩵��쳣", e1);
				throw new ServiceExecutionFailedException("����ȡ��ˢ��token��������Ȼ�쳣",
						e1);
			}
		}
		return result;
	}
    
    
    
    
    
    /**
     * ��ȡ��������״̬ ���¶���
     * @throws ServiceExecutionFailedException 
     * @throws NoSuchSupplierException 
     */
    public void runUPDJDOrderStatus(String exchangeOrRefound) throws NoSuchSupplierException, ServiceExecutionFailedException {
        logger.info("CpiService ��ȡ��������״̬ ���¶�����ʼ");
        int pageIndex = 1;
        int pageSize = 10;
        String jdOrderId = "";
        int supId = 4;
        Map<String, Object> result = new HashMap<String, Object>();
        //�Ȼ�ȡ�����˻������� ��ȡjdorderid
        List<Order> orders  = new ArrayList<Order>(); 
        Order order = new Order();
        order.setSupId(4); //4Ϊ����supid
        if("1".equals(exchangeOrRefound)){
        	 orders = orderMapper.queryJDOrderForExchangeInfos(order);
        }else{
        	 orders = orderMapper.queryJDOrderForRefoundInfos(order);
        }
        if(orders == null || orders.size()<=0){
        	logger.info("----��ȡ��������״̬ ���¶������,����Ҫ�����˻�������----");
        	return;
        }
        //ѭ���˻���
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
        	//����ҳ��
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
        		//����3.6���ݿͻ��˺źͶ����ŷ�ҳ��ѯ���񵥸�Ҫ��Ϣ ��ȡ1�����񵥺�
            	result = this.serviceListPage(supId, jdOrderId, pageIndex, pageSize);
            	logger.info("���ؽ����"+result.get("success")+result.get("resultMessage"));
            	if(!(Boolean) result.get("success")){//�ж�jd�ӿ��Ƿ񷵻���ȷ���
            		logger.debug("-----���ش�����Ϣ,����ʧ�ܣ�supOrderID"+orders.get(i).getSupId());
            		continue;
            	}
            	JSONObject jsonObj = JSONObject.fromObject(result.get("result"));
            	JSONArray json =JSONArray.fromObject(jsonObj.get("serviceInfoList"));
            	List<AfsServicebyCustomerPinDto> afsServiceByCustomerPins = JSONArray.toList(json,AfsServicebyCustomerPinDto.class);
            	 if(afsServiceByCustomerPins!=null && afsServiceByCustomerPins.size()>0){
            		 for (AfsServicebyCustomerPinDto afsServicebyCustomerPinDto : afsServiceByCustomerPins) {
            			 //���ݾ����ӿڷ��ط���״̬ ���¶���״̬
                         int jdStatus = afsServicebyCustomerPinDto.getAfsServiceStep();
                         if(jdStatus == 20){
	              	        	un += 1;                //��˲�ͨ��                       	 
                         }else if(jdStatus >= 40){
	              	        	done += 1;				//���                       	 
                         }else if(jdStatus == 60){
	              	        	cancle += 1;            //ȡ��
                         }
                        //���ӻ���·��񵥵����� merge���� û�в��� �и��·���״̬
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
            		 logger.info("��ѯ�޷���ȡ���񵥣�û�з��񵥣����˳�����������");
            		 break;
            	 }
        		}catch(ServiceExecutionFailedException se){
        			se.printStackTrace();
        			break;
        		}
			}        	
           //���ݾ����ӿڷ��ط���״̬ ���¶���״̬
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
        logger.info("��ȡ��������״̬ ���¶������");

   }
    
    
    
    /**
     * �˻���������񶩵�
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
			throw new NoSuchSupplierException("��Ӧ�̲����� [" + supId + "]");
		}
		Map<String, Object> result = null;
		ServiceAdapter adapter = adapters.get(supId);
		try {
			result = adapter.auditCancel(auditCancel);
		} catch (TokenInvalidException e) {
			logger.warn("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
					+ "] ������񶩵�ʧ�� [token invalid]");
			adapter.invalidToken();
			syncToken(adapter);
			try {
				logger.info("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ����������񶩵�");
				adapter.auditCancel(auditCancel);
			} catch (TokenInvalidException e1) {
				logger.error("��Ӧ�̷��� [" + adapter.getSupplier().getSupCode()
						+ "] ������񶩵��쳣", e1);
				throw new ServiceExecutionFailedException("����ȡ��ˢ��token��������Ȼ�쳣",
						e1);
			}
		}
		return result;
	} 
}