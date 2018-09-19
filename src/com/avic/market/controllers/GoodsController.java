package com.avic.market.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.PageNotFoundException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.common.utils.Permission;
import com.avic.market.cpi.CpiService;
import com.avic.market.models.Address;
import com.avic.market.models.CompareItem;
import com.avic.market.models.EnquiryGoods;
import com.avic.market.models.Goods;
import com.avic.market.models.MarketCategory;
import com.avic.market.models.Supplier;
import com.avic.market.models.TradeRecord;
import com.avic.market.services.AddressService;
import com.avic.market.services.CategoryService;
import com.avic.market.services.EnquiryGoodsService;
import com.avic.market.services.GoodsService;
import com.avic.market.services.SupplierService;
import com.avic.market.utils.DataCache;
import com.avic.passport.models.User;

@Controller
@RequestMapping("/goods")
public class GoodsController {
    protected static final Log logger = LogFactory.getLog(GoodsController.class);

    private static final int PAGE_SIZE = 20;

    @Autowired
    GoodsService goodsService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    SupplierService supplierService;
    @Autowired
    EnquiryGoodsService enquiryGoodsService;
    @Autowired
    AddressService addressService;
    @Autowired
    CpiService cpiService;
    
    @Autowired
    DataCache dataCache;

    @RequestMapping("/cate")
    public String cate(String q, Model m){
    	m.addAttribute("q", q);
    	return "categorys";
    }
    
    @RequestMapping("/search")
    public String search(HttpServletRequest req, Map<String, Object> map) {
        // �ؼ���
        String q = req.getParameter("q");
        // ����
        String cat = req.getParameter("cat");
        // Ʒ��
        String brand = req.getParameter("brand");
        // ��Ӧ��
        String sup = req.getParameter("sup");
        // �۸�
        String price = req.getParameter("price");
        // ҳ��
        String page = req.getParameter("p");
        // ����
        String o = req.getParameter("o");
        // ��Сͼ
        String view = req.getParameter("view");

        logger.info("��Ʒ����Controller-q[" + q + "], cat[" + cat + "], brand[" + brand + "], sup[" + sup + "], price[" + price + "], p["
                + page + "], o[" + o + "]");

        int catId = 0, supId = 0;

        if (StringUtils.isNumeric(cat)) {
            catId = Integer.parseInt(cat);
        }
        if (StringUtils.isNumeric(sup)) {
            supId = Integer.parseInt(sup);
        }

        int pageNum = 1;

        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }

        if (brand == null) {
            brand = "";
        }

        if (q == null) {
            q = "";
        }

        int order = 0;

        if (StringUtils.isNumeric(o)) {
            order = Integer.parseInt(o);
        }

        int priceStart = 0, priceEnd = 0;

        if (!StringUtils.isEmpty(price) && price.contains(",")) {
            String[] sep = price.split(",", 2);
            if (StringUtils.isNumeric(sep[0])) {
                priceStart = Integer.parseInt(sep[0]);
            }

            if (StringUtils.isNumeric(sep[1])) {
                priceEnd = Integer.parseInt(sep[1]);
            }
        }

        int total = goodsService.getGoodsCount(catId, brand, supId, q.toUpperCase().replaceAll(" ", ""), priceStart, priceEnd);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (pageNum > pages) {
            pageNum = pages;
        }
        if (total > 0) {
            map.put("list", goodsService.searchGoods(catId, brand, supId, q.toUpperCase().replaceAll(" ", ""), priceStart, priceEnd, order, pageNum, PAGE_SIZE));
            if (catId > 0) {
                map.put("hot", goodsService.getHotGoods(catId, 3));
            }
        }

        if (!"list".equals(view)) {
            view = "pic";
        }

        map.put("searchBrand", brand);
        map.put("cat", catId);
        int cat1 = 0, cat2 = 0, cat3 = 0;
        if (catId < 100) {
            cat1 = catId;
        } else if (catId < 10000) {
            cat1 = catId / 100;
            cat2 = catId;
        } else {
            cat1 = catId / 10000;
            cat2 = catId / 100;
            cat3 = catId;
        }
        map.put("cat1", cat1);
        map.put("cat2", cat2);
        map.put("cat3", cat3);
        map.put("sup", supId);
        map.put("brandList", goodsService.getGoodsBrand(supId, catId, q.toUpperCase()));
        map.put("supList", dataCache.getSupplierList());
        map.put("price", priceStart + "," + priceEnd);
        map.put("price1", priceStart);
        map.put("price2", priceEnd);
        map.put("total", total);
        map.put("order", order);
        map.put("view", view);
        map.put("page", pageNum);
        try {
            map.put("pageAction", "market/goods/search?cat=" + catId + "&brand=" + URLEncoder.encode(brand, "GBK") + "&sup=" + supId
                    + "&q=" + URLEncoder.encode(q, "GBK") + "&price=" + priceStart + "," + priceEnd + "&o=" + order + "&view=" + view
                    + "&p=%PAGE%");
        } catch (UnsupportedEncodingException e) {
        }

        map.put("pages", pages);
        map.put("searchKeyword", q);

        return "goods/list";
    }
    
    @RequestMapping("/search/ajax")
    @ResponseBody
    public ResultObject searchAjax(HttpServletRequest req, Map<String, Object> map) {
        // �ؼ���
        String q = req.getParameter("q");
        // ����
        String cat = req.getParameter("cat");
        // Ʒ��
        String brand = req.getParameter("brand");
        // ��Ӧ��
        String sup = req.getParameter("sup");
        // �۸�
        String price = req.getParameter("price");
        // ҳ��
        String page = req.getParameter("p");

        logger.info("��Ʒ����Controller-q[" + q + "], cat[" + cat + "], brand[" + brand + "], sup[" + sup + "], price[" + price + "], p["
                + page + "]");

        int catId = 0, supId = 0;

        if (StringUtils.isNumeric(cat)) {
            catId = Integer.parseInt(cat);
        }
        if (StringUtils.isNumeric(sup)) {
            supId = Integer.parseInt(sup);
        }

        int pageNum = 1;

        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }

        if (brand == null) {
            brand = "";
        }

        if (q == null) {
            q = "";
        }


        int priceStart = 0, priceEnd = 0;

        if (!StringUtils.isEmpty(price) && price.contains(",")) {
            String[] sep = price.split(",", 2);
            if (StringUtils.isNumeric(sep[0])) {
                priceStart = Integer.parseInt(sep[0]);
            }

            if (StringUtils.isNumeric(sep[1])) {
                priceEnd = Integer.parseInt(sep[1]);
            }
        }

        int total = goodsService.getGoodsCount(catId, brand, supId, q.toUpperCase().replaceAll(" ", ""), priceStart, priceEnd);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (pageNum > pages) {
            pageNum = pages;
        }
        if (total > 0) {
        	List<Goods> list = goodsService.searchGoods(catId, brand, supId, q.toUpperCase().replaceAll(" ", ""), priceStart, priceEnd, 0, pageNum, PAGE_SIZE);
        	for (Goods g : list) {
				g.setBrandName(dataCache.getSupplierName(g.getSupId()));
			}
        	map.put("list", list);
        }

        map.put("searchBrand", brand);
        map.put("cat", catId);
        map.put("page", pageNum);
        map.put("pages", pages);
        map.put("searchKeyword", q);

        return new ResultObject(ResultObject.OK, map);
    }

    @RequestMapping("/prof/index")
    public String profIndex(HttpServletRequest req, HttpSession sess, Map<String, Object> map) {
        User user = null;
        try {
            user = (User)sess.getAttribute(SessionKeys.LOGIN_USER);
        } catch (Exception e){

        }
        
        List<MarketCategory> cats = categoryService.getMarketCatTree();
        
        /*
        List<MarketCategory> p1 = new ArrayList<MarketCategory>();
        List<MarketCategory> p2 = new ArrayList<MarketCategory>();
        
        for (MarketCategory i : cats) {
            if (i.getMarketCatId().equals("P1")) {
                p1 = i.getSubs();
            } else if (i.getMarketCatId().equals("P2")) {
                p2 = i.getSubs();
            }
        }
        
        map.put("p1", p1);
        map.put("p2", p2);
        */
        
        if (user != null) {
            map.put("my", supplierService.getMyTraSup(user.getCompanyId()));
        }
        map.put("cats", cats);
        map.put("newSup", supplierService.getNewTraSup());
        map.put("recSup", supplierService.getRecommandTraSup());
        map.put("brands", goodsService.getBrandAd());
        
        return "goods/prof_index";
    }

    @RequestMapping("/prof")
    public String prof(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        // �ؼ���
        String q = req.getParameter("q");
        // ����
        String desc = req.getParameter("desc");
        // ��Ӧ��
        String sup = req.getParameter("sup");
        // ����
        String cat1 = req.getParameter("cat1");
        // ����
        String cat2 = req.getParameter("cat2");
        // ����
        String cat3 = req.getParameter("cat3");
        // �۸�
        String price1 = req.getParameter("price1");
        String price2 = req.getParameter("price2");
        // Ʒ��
        String brand = req.getParameter("brand");
        // ���
        String model = req.getParameter("model");
        // ����
        String stuff = req.getParameter("stuff");
        // ҳ��
        String page = req.getParameter("p");
        // ����
        String o = req.getParameter("o");
        // ����
        String from = req.getParameter("from");

        int supId = 0;

        if (StringUtils.isNumeric(sup)) {
            supId = Integer.parseInt(sup);
        }

        int pageNum = 1;

        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }

        int order = 0;

        if (StringUtils.isNumeric(o)) {
            order = Integer.parseInt(o);
        }
        
        if (brand == null) {
            brand = "";
        }

        if (model == null) {
            model = "";
        }
        
        if (stuff == null) {
            stuff = "";
        }

        if (q == null) {
            q = "";
        }
        int priceStart = 0, priceEnd = 0;

            if (StringUtils.isNumeric(price1)) {
                priceStart = Integer.parseInt(price1);
            }

            if (StringUtils.isNumeric(price2)) {
                priceEnd = Integer.parseInt(price2);
            }
        User user = (User)session.getAttribute(SessionKeys.LOGIN_USER);
        int total = goodsService.getProfGoodsCount(supId, priceStart, priceEnd, brand, q.toUpperCase().replaceAll(" ", ""), desc, model.toUpperCase().replaceAll(" ", ""), stuff.toUpperCase().replaceAll(" ", ""), cat1, cat2, cat3,user == null ? null : user.getCompanyId());

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (pageNum > pages) {
            pageNum = pages;
        }

        if (total > 0) {

            map.put("list", goodsService.searchProfGoods(supId, priceStart, priceEnd, brand, q.toUpperCase().replaceAll(" ", ""), desc, model.toUpperCase().replaceAll(" ", ""), stuff.toUpperCase().replaceAll(" ", ""), cat1, cat2, cat3, user == null ? null : user.getCompanyId(), order, pageNum, PAGE_SIZE));
            map.put("hot", goodsService.getProfHotGoods(cat1, 3,user == null ? null : user.getCompanyId()));
        }
        if (desc == null) {
            desc = "";
        }
        map.put("searchBrand", brand);
        map.put("sup", supId);
        /*
        if ("sup".equals(from)) {
            map.put("supList", goodsService.getProfSup(null, null, null, supId, null, null, null, null, user == null ? null : user.getCompanyId()));
        } else {

            map.put("supList", goodsService.getProfSup(cat1, cat2, cat3, 0, q, model, brand, desc, user == null ? null : user.getCompanyId()));
        }
        */
        
        String cat = "";
        
        if (!StringUtils.isEmpty(cat3)) {
            cat = cat3;
        } else if (!StringUtils.isEmpty(cat2)) {
            cat = cat2;
        } else if (!StringUtils.isEmpty(cat1)) {
            cat = cat1;
        }

        map.put("supList", goodsService.getAllProfSup(user == null ? null : user.getCompanyId(), cat));

        map.put("catList1", categoryService.getMarketCatByParent("0"));
        if (StringUtils.isNotEmpty(cat1)) {
            map.put("catList2", categoryService.getMarketCatByParent(cat1));
        }
        if (StringUtils.isNotEmpty(cat2)) {
            map.put("catList3", categoryService.getMarketCatByParent(cat2));
        }
        

        if (cat1 == null) {
            cat1 = "";
        }

        if (cat2 == null) {
            cat2 = "";
        }

        if (cat3 == null) {
            cat3 = "";
        }
        
        map.put("price1", priceStart);
        map.put("price2", priceEnd);
        map.put("cat1", cat1);
        map.put("cat2", cat2);
        map.put("cat3", cat3);
        map.put("model", model);
        map.put("stuff", stuff);
        map.put("desc", desc);
        map.put("total", total);
        map.put("order", order);
        map.put("page", pageNum);
        map.put("searchType", 1);
        map.put("searchKeyword", q);
        /*
        if ("brand".equals(from)) {
            List<String> brands = new ArrayList<String>();
            brands.add(brand);
        } else {
            map.put("brandList", goodsService.getProfBrand(cat1, cat2, cat3, supId, q, model, desc));
        }
        */
        map.put("brandList", goodsService.getProfBrand(cat1, cat2, cat3, 0, null, null, null));
        try {
            map.put("pageAction", "market/goods/prof?sup=" + supId + "&cat1=" + cat1 + "&cat2=" + cat2 + "&cat3=" + cat3 + "&price1=" + priceStart + "&price2=" + priceEnd + "&brand=" + URLEncoder.encode(brand, "GBK") + "&stuff=" + URLEncoder.encode(stuff, "GBK") + "&q=" + URLEncoder.encode(q, "GBK") + "&model=" + URLEncoder.encode(model, "GBK") + "&desc=" + URLEncoder.encode(desc, "GBK") + "&from=" + from + "&o=" + order + "&p=%PAGE%");
        } catch (UnsupportedEncodingException e) {
        }
        map.put("pages", pages);

        return "goods/prof";
    }
    
    @RequestMapping("/prof/brand")
    @ResponseBody
    public ResultObject profBrand(@RequestParam("cat") String cat) {
        return new ResultObject(ResultObject.OK, goodsService.getProfBrand(null, null, cat, 0, null, null, null));
    }

    @RequestMapping("/prof/sup")
    @ResponseBody
    public ResultObject profSup(HttpServletRequest req) {
        String cat = req.getParameter("cat");
        String brand = req.getParameter("brand");
        return new ResultObject(ResultObject.OK, goodsService.getProfSup(null, null, cat, 0, null, null, brand, null, null));
    }

    @RequestMapping("/show")
    public String show(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        // ��Ӧ�̱��
        String sid = req.getParameter("sid");
        // ��Ʒ���
        String gid = req.getParameter("gid");

        if (!StringUtils.isNumeric(sid) || StringUtils.isEmpty(gid)) {
            throw new PageNotFoundException();
        }

        logger.info("��Ʒ����Controller-sid[" + sid + "], gid[" + gid + "]");

        Goods goods = goodsService.getGoodsDetail(Integer.parseInt(sid), gid);
        if (goods == null) {
            return "goods/fail";
        }
        User user = (User)session.getAttribute(SessionKeys.LOGIN_USER);
        int supId = Integer.parseInt(sid);
        

        Supplier s = dataCache.getSupplier(supId);
        
        if (s.getSupType() == 0) {

            
            String areaOne = "";
            String areaOneName = "";
            String areaTwo = "";
            String areaTwoName = "";
            String areaThree = "";
            String areaThreeName = "";
            String areaFour = "";
            String areaFourName = "";
            
            if (user != null) {
                Address addr = addressService.getDefaultAddress(user.getUserId(), supId);
                if (addr != null) {
                    areaOne = addr.getAreaLevelOne();
                    areaOneName = addr.getAreaLevelOneName();
                    areaTwo = addr.getAreaLevelTwo();
                    areaTwoName = addr.getAreaLevelTwoName();
                    areaThree = addr.getAreaLevelThree();
                    areaThreeName = addr.getAreaLevelThreeName();
                    areaFour = addr.getAreaLevelFour();
                    areaFourName = addr.getAreaLevelFourName();
                }
            }

            
            if (StringUtils.isEmpty(areaOne)) {
                
                if (supId == 1) {
                    areaOne = "23";
                    areaOneName = "����";
                    areaTwo = "274";
                    areaTwoName = "������";
                    areaThree = "275";
                    areaThreeName = "������";
                } else {
                    areaOne = "1";
                    areaOneName = "����";
                    areaTwo = "72";
                    areaTwoName = "������";
                    areaThree = "2799";
                    areaThreeName = "��������";
                }
                
            }

            map.put("areaOne", areaOne);
            map.put("areaTwo", areaTwo);
            map.put("areaThree", areaThree);
            map.put("areaFour", areaFour);
            map.put("areaOneName", areaOneName);
            map.put("areaTwoName", areaTwoName);
            map.put("areaThreeName", areaThreeName);
            map.put("areaFourName", areaFourName);
            
            map.put("provs", addressService.getSupArea(supId, 0));
            
            if (!StringUtils.isEmpty(areaOne)) {
                map.put("citys", addressService.getSupArea(supId, Integer.parseInt(areaOne)));
            }
            

            if (!StringUtils.isEmpty(areaTwo)) {
                map.put("dists", addressService.getSupArea(supId, Integer.parseInt(areaTwo)));
            }

            if (!StringUtils.isEmpty(areaThree)) {
                map.put("countrys", addressService.getSupArea(supId, Integer.parseInt(areaThree)));
            }
        }

        map.put("goods", goods);
        int catId = dataCache.getSysCatId(goods.getSupId(), goods.getSupCatId());
        int cat1 = 0, cat2 = 0, cat3 = 0;
        cat1 = catId / 10000;
        cat2 = catId / 100;
        cat3 = catId;
        map.put("cat1", cat1);
        map.put("cat2", cat2);
        map.put("cat3", cat3);
        map.put("sup", s);

        return "goods/detail";
    }
    
    @RequestMapping("/area")
    @ResponseBody
    public ResultObject area(HttpServletRequest req) {
        // �ϼ�����
        String parent = req.getParameter("parent");
        // ��Ӧ�̱��
        String supId = req.getParameter("sid");
        logger.info("��ȡ����Controller-parent[" + parent + "]�� supId[" + supId + "]");

        if (!StringUtils.isNumeric(supId) || !StringUtils.isNumeric(parent)) {
            logger.info("��ȡ����Controller-������Ч-parent[" + parent + "]�� supId[" + supId + "]");

            return new ResultObject(ResultObject.FAIL, "������Ч");
        }
        
        Supplier s = dataCache.getSupplier(Integer.parseInt(supId));
        

        return new ResultObject(ResultObject.OK, addressService.getSupArea(s.getSupType() == 1 ? 1 : s.getSupId(), Integer.parseInt(parent)));

    }

    @RequestMapping("/stock")
    @ResponseBody
    public ResultObject stock(HttpServletRequest req, HttpSession session) {
        
        String sid = req.getParameter("sid");
        String gid = req.getParameter("gid");
        String areaOne = req.getParameter("one");
        String areaTwo = req.getParameter("two");
        String areaThree = req.getParameter("three");
        String areaFour = req.getParameter("four");
        
        List<String> area = new ArrayList<String>();
        area.add(areaOne);
        area.add(areaTwo);
        area.add(areaThree);
        if (!StringUtils.isEmpty(areaFour)) {
            area.add(areaFour);
        }
        Map<String, Integer> stocks = null;
        List<String> skus = new ArrayList<String>();
        skus.add(gid);
        try {
            stocks = cpiService.getGoodsStock(Integer.parseInt(sid), skus, null, area);
        } catch (Exception e) {
            logger.info("��Ʒ����-����ѯʧ��");
            return new ResultObject(ResultObject.FAIL, "����ѯʧ��");
        }
        
        int stock = stocks.get(gid);
        
        return new ResultObject(ResultObject.OK, stock);
    }

    @RequestMapping("/compare/add")
    @ResponseBody
    public ResultObject compareAdd(HttpServletRequest req, HttpSession session) {
        Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��Ӧ�̱��
        String sid = req.getParameter("sid");
        // ��Ʒ���
        String gid = req.getParameter("gid");

        logger.info("���ӱȶ�-sid[" + sid + "], gid[" + gid + "]");

        if (!StringUtils.isNumeric(sid) || StringUtils.isEmpty(gid)) {
            logger.error("���ӱȶ�-������Ч-sid[" + sid + "], gid[" + gid + "]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        Goods goods = goodsService.getGoodsSimple(Integer.parseInt(sid), gid);

        if (goods == null) {
            return new ResultObject(ResultObject.FAIL, "��Ʒ��Ч�����¼�");
        }
        Supplier s = dataCache.getSupplier(goods.getSupId());
        if (s.getSupType() == 0) {
        goods.setSysCatId(dataCache.getSysCatId(goods.getSupId(), goods.getSupCatId()));
        }

        List<CompareItem> items = (List<CompareItem>) session.getAttribute(SessionKeys.MARKET_COMPARE);

        if (items != null && items.size() > 0) {
            // �Ѵ���
            for (CompareItem i : items) {
                if (i.getSupId() == goods.getSupId() && i.getSupGoodsId().equals(goods.getSupGoodsId())) {
                    return new ResultObject(ResultObject.OK, items);
                }
            }
            /*
             * // ��ͬ�� if (items.get(0).getSysCatId() != goods.getSysCatId()) {
             * return new ResultObject(10, items); }
             */
            // ����
            if (items.size() > 3) {
                return new ResultObject(20, items);
            }
        } else {
            items = new ArrayList<CompareItem>();
        }

        CompareItem item = new CompareItem();
        item.setAgreePrice(goods.getAgreePrice());
        item.setGoodsName(goods.getGoodsName());
        item.setImagePath(goods.getImagePath());
        item.setSupGoodsId(goods.getSupGoodsId());
        item.setSupId(goods.getSupId());
        item.setSysCatId(goods.getSysCatId());
        item.setSupType(s.getSupType());
        items.add(item);
        
        session.setAttribute(SessionKeys.MARKET_COMPARE, items);

        return new ResultObject(ResultObject.OK, items);
    }

    @RequestMapping("/compare/clear")
    @ResponseBody
    public ResultObject compareClear(HttpSession session) {
        Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        logger.info("��ձȶ�");

        session.removeAttribute(SessionKeys.MARKET_COMPARE);

        return new ResultObject(ResultObject.OK, "");
    }

    @RequestMapping("/compare/remove")
    @ResponseBody
    public ResultObject compareRemove(HttpServletRequest req, HttpSession session) {
        Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        logger.info("ɾ���ȶ�");

        // ��Ӧ�̱��
        String sid = req.getParameter("sid");
        // ��Ʒ���
        String gid = req.getParameter("gid");

        List<CompareItem> items = (List<CompareItem>) session.getAttribute(SessionKeys.MARKET_COMPARE);
        
        if (items != null) {
            for (CompareItem i : items) {
                if (i.getSupGoodsId().equals(gid) && i.getSupId() == Integer.parseInt(sid)) {
                    items.remove(i);
                    break;
                }
            }
        }
        
        if (items.size() == 0) {
            session.removeAttribute(SessionKeys.MARKET_COMPARE);
        } else {
            session.setAttribute(SessionKeys.MARKET_COMPARE, items);
        }
        


        return new ResultObject(ResultObject.OK, items);
    }

    @RequestMapping("/trade")
    public String trade(HttpServletRequest req, Map<String, Object> map) {
        // ��Ӧ�̱��
        String sid = req.getParameter("sid");
        // ��Ʒ���
        String gid = req.getParameter("gid");
        // ҳ��
        String page = req.getParameter("page");

        logger.info("��Ʒ���׼�¼Controller-sid[" + sid + "], gid[" + gid + "], page[" + page + "]");

        if (StringUtils.isEmpty(gid) || !StringUtils.isNumeric(sid)) {
            logger.info("��Ʒ���׼�¼Controller-������Ч-sid[" + sid + "], gid[" + gid + "], page[" + page + "]");
            return "goods/trade";
        }

        int pageNum = 1;

        if (StringUtils.isNumeric(page)) {
            pageNum = Integer.parseInt(page);
        }

        int total = goodsService.getTradeRecordCount(Integer.parseInt(sid), gid);

        int pages = (int) Math.ceil((double) total / PAGE_SIZE);

        if (pageNum > pages) {
            pageNum = pages;
        }
        if (total > 0) {
            List<TradeRecord> list = goodsService.getTradeRecordList(Integer.parseInt(sid), gid, pageNum, PAGE_SIZE);
            for (TradeRecord i : list) {
                int len = i.getUserName().length();
                i.setUserName(i.getUserName().substring(0, 1) + StringUtils.repeat("*", len - 1));
            }
            map.put("list", list);
        }

        map.put("total", total);
        map.put("page", pageNum);
        map.put("pageAction", "market/goods/trade?sid=" + sid + "&gid=" + gid + "&page=%PAGE%");
        map.put("pages", pages);

        return "goods/trade";
    }
    
    /**
     *����û��Ƿ��¼
     * @param supplierRecommend
     * @param req
     * @param map
     * @param httpSession
     * @return
     */
    @RequestMapping("/prof/isLogin")
    @ResponseBody
    public Object isLogin(@ModelAttribute("enquiryGoods")EnquiryGoods enquiryGoods,HttpServletRequest req,HttpSession httpSession) {
    	User user = null;
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		user = Permission.check(httpSession, UserRole.BUY, UserRole.CLIENT);
    	} catch (UserNotLoginException e) {
    		map.put("isLogin", "0");
    		return map;
		} catch (NoPermissionException e){
			map.put("isLogin", "0");
    		return map;
		}
    	enquiryGoods.setUserID(user.getUserId());
    	int canEnquiry = enquiryGoodsService.canEnquiry(enquiryGoods);
    	if(canEnquiry>0){
    		map.put("canEnquiry", "0");
    	}else{
    		map.put("canEnquiry", "1");
    	}
    	
    	return map;
    }
    /**
     * ��תѯ��ҳ��
     * @param supplierRecommend
     * @param req
     * @param map
     * @param httpSession
     * @return
     */
    @RequestMapping("/prof/professionEnquiryPage")
    public Object professionEnquiryPage(@ModelAttribute("enquiryGoods")EnquiryGoods enquiryGoods,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
    	/*String goodsName  = "";
    	try {
    		goodsName = new String(req.getParameter("goodsName").getBytes("iso-8859-1"));
    		enquiryGoods.setGoodsName(goodsName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}*/
    	  
    	String goodsName  = req.getParameter("goodsName");
    	enquiryGoods.setGoodsName(goodsName);
    	map.put("enquiryGoods", enquiryGoods);
    	return "goods/professionEnquiry";
    }
    /**
     * ����ѯ����Ϣ
     * @param supplierRecommend
     * @param req
     * @param map
     * @param httpSession
     * @return
     */
    @RequestMapping("/prof/professionEnquiry")
    @ResponseBody
    public Object professionEnquiry(@ModelAttribute("enquiryGoods")EnquiryGoods enquiryGoods,HttpServletRequest req,Map<String, Object> map,HttpSession httpSession) {
    	User user = Permission.check(httpSession, UserRole.BUY, UserRole.CLIENT);
    	enquiryGoods.setUserID(user.getUserId());
    	enquiryGoodsService.addEnquiryGoods(enquiryGoods);
    	return "success";
    }
}