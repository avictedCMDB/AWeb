package com.avic.market.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.rmi.RemoteException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.avic.alipay.util.AlipaySubmit;
import com.avic.common.beans.ResultObject;
import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.SmsContents;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.PageNotFoundException;
import com.avic.common.shortMessage.ShortMessageUtils;
import com.avic.common.utils.CommonFileUtils;
import com.avic.common.utils.ConfigHolder;
import com.avic.common.utils.Permission;
import com.avic.market.cpi.CpiService;
import com.avic.market.cpi.exceptions.NoSuchSupplierException;
import com.avic.market.cpi.exceptions.ServiceExecutionFailedException;
import com.avic.market.models.Address;
import com.avic.market.models.CartItem;
import com.avic.market.models.Contract;
import com.avic.market.models.Goods;
import com.avic.market.models.Invoice;
import com.avic.market.models.Order;
import com.avic.market.models.OrderSnapshot;
import com.avic.market.models.PayFlow;
import com.avic.market.models.Price;
import com.avic.market.models.SettleData;
import com.avic.market.models.Supplier;
import com.avic.market.models.UPDQuiteInfo;
import com.avic.market.models.VatInfo;
import com.avic.market.services.AddressService;
import com.avic.market.services.CartService;
import com.avic.market.services.GoodsService;
import com.avic.market.services.InvoiceService;
import com.avic.market.services.OrderService;
import com.avic.market.services.PayFlowService;
import com.avic.market.services.SettleService;
import com.avic.market.utils.DataCache;
import com.avic.passport.models.User;
import com.chinapay.secss.SecssUtil;

@Controller
@RequestMapping("/order")
public class OrderController {
    protected static final Log logger = LogFactory.getLog(OrderController.class);

    @Autowired
    OrderService orderService;

    @Autowired
    CpiService cpiService;

    @Autowired
    AddressService addressService;

    @Autowired
    GoodsService goodsService;

    @Autowired
    CartService cartService;

    @Autowired
    InvoiceService invoiceService;

    @Autowired
    ConfigHolder configHolder;

    @Autowired
    PayFlowService payFlowService;

    @Autowired
    SettleService settleService;

    @Autowired
    DataCache dataCache;

    @RequestMapping("/confirm")
    public String confirm(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��ţ�supId_supGoodsId_num, ...
        String ids = req.getParameter("ids");
        String type = req.getParameter("type");
        // ����Ԥ����Ʒ�����µ�
        String warning  = req.getParameter("warning");
        if (StringUtils.isEmpty(warning)) {
        	warning = "0";
        }
       
        logger.info("���ɶ���Controller-ids[" + ids + "],type[" + type + "]");

        if (StringUtils.isEmpty(ids)) {
            logger.info("���ɶ���Controller-������Ч-ids[" + ids + "],type[" + type + "]");
            map.put("error", "������Ч");
            return "forward:/market/cart/list";
        }

        if (StringUtils.isEmpty(type)) {
            type = "0";
        }

        int supId = 0;

        Map<String, Integer> skuNum = new HashMap<String, Integer>();

        List<String> errors = new ArrayList<String>();
        
        List<String> warningList = new ArrayList<String>();

        for (String i : ids.split(",")) {
            String[] seg = i.split("_");
            if (seg.length != 3 || !StringUtils.isNumeric(seg[0]) || !StringUtils.isNumeric(seg[2])) {
                logger.info("���ɶ���Controller-������Ч-ids[" + ids + "]");
                return "forward:/market/cart/list";
            }

            if (supId == 0) {
                supId = Integer.parseInt(seg[0]);
            } else if (supId != Integer.parseInt(seg[0])) {
                map.put("error", "��ѡ��ͬһ����Ӧ�̵���Ʒ�µ�");
                return "forward:/market/cart/list";
            }

            skuNum.put(seg[1], Integer.parseInt(seg[2]));
        }

        List<String> skus = new ArrayList<String>(skuNum.keySet());
        List<Integer> nums = new ArrayList<Integer>(skuNum.values());

        List<CartItem> goods = cartService.getCartGoodsByIds(user.getUserId(), supId, skus);

        Supplier s = dataCache.getSupplier(supId);
        if (s.getSupType() == 0) {

            logger.info("���ɶ���-״̬У��");

            Map<String, Integer> status = null;
            try {
                status = cpiService.getGoodsStatus(supId, skus);
            } catch (Exception e) {
                logger.info("���ɶ���-״̬У���쳣");
                map.put("error", "��Ӧ�������쳣���޷������Ʒ״̬��Ϣ");
                if ("1".equals(type)) {
                    return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                } else {
                    return "forward:/market/cart/list";
                }
            }

            for (CartItem i : goods) {
            	try{
                    if (status.get(i.getSupGoodsId()) != 1) {
                        errors.add("��Ʒ��" + i.getGoodsName() + "�����¼�");
                        goodsService.updateGoodsStatus(supId, i.getSupGoodsId(), 0);
                    }

                    // ��������
                    i.setBuyNum(skuNum.get(i.getSupGoodsId()));            		
            	}catch (Exception e){
                    logger.info("���ɶ���-״̬У���쳣");
                    map.put("error", "��Ӧ�������쳣���޷������Ʒ״̬��Ϣ");
                    if ("1".equals(type)) {
                        return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                    } else {
                        return "forward:/market/cart/list";
                    }            		
            	}

            }

            if (errors.size() > 0) {
                logger.info("���ɶ���-״̬У��ʧ��");
                map.put("error", "�µ�ʧ�ܣ�\\n" + StringUtils.join(errors, "\\n"));
                if ("1".equals(type)) {
                    return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                } else {
                    return "forward:/market/cart/list";
                }
            }

            logger.info("���ɶ���-���У��");

            Address addr = addressService.getDefaultAddress(user.getUserId(), supId);
            List<String> area = null;
            if (addr != null) {
                area = new ArrayList<String>();
                area.add(addr.getAreaLevelOne());
                area.add(addr.getAreaLevelTwo());
                area.add(addr.getAreaLevelThree());
                if (!StringUtils.isEmpty(addr.getAreaLevelFour())) {
                    area.add(addr.getAreaLevelFour());
                }
            }
            Map<String, Integer> stocks = null;
            try {
                stocks = cpiService.getGoodsStock(supId, skus, nums, area);
            } catch (Exception e) {
                logger.info("���ɶ���-���У��ʧ��");
                map.put("error", "��Ӧ�������쳣���޷���ÿ����Ϣ");
                if ("1".equals(type)) {
                    return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                } else {
                    return "forward:/market/cart/list";
                }
            }
            //�����һ�����ɶ�����û���ж���Ʒ�Ƿ����Ԥ�������Ԥ����warning�� Ϊ1 ����Ҫ�ڴ��ж�
            if("0".equals(warning)){
                for (CartItem i : goods) {
                	//�����Ԥ��
                	if(stocks.get(i.getSupGoodsId()) == -1){
                		warningList.add("��Ʒ��" + i.getGoodsName() + "����Ԥ�����ͻ�������7~15�죬��ȷ���Ƿ���");
                	    map.put("warning", "Ԥ����\\n" + StringUtils.join(warningList, "\\n"));
                        return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                	}
                	else if (stocks.get(i.getSupGoodsId()) == null || i.getBuyNum() > stocks.get(i.getSupGoodsId())) {
                        errors.add("��Ʒ��" + i.getGoodsName() + "����治��");
                    } else if (i.getCompare() < 1) {
                        // errors.add("��Ʒ��" + i.getGoodsName() + "��δ�Ա�");
                    }
                }            	
            }
            if (errors.size() > 0) {
                logger.info("���ɶ���-���У��ʧ��");
                map.put("error", "�µ�ʧ�ܣ�\\n" + StringUtils.join(errors, "\\n"));
                if ("1".equals(type)) {
                    return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                } else {
                    return "forward:/market/cart/list";
                }
            }

            logger.info("���ɶ���-�۸�У��");

            Map<String, Price> prices = null;
            try {
                prices = cpiService.getGoodsPrice(supId, skus);
            } catch (Exception e) {
                logger.info("���ɶ���-�۸�У���쳣");
                map.put("error", "��Ӧ�������쳣���޷������Ʒ�۸���Ϣ");
                if ("1".equals(type)) {
                    return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                } else {
                    return "forward:/market/cart/list";
                }
            }

            double total = 0;

            for (CartItem i : goods) {
                Price p = prices.get(i.getSupGoodsId());
                if (p == null || p.getAgreePrice() != i.getAgreePrice()) {
                    errors.add("��Ʒ��" + i.getGoodsName() + "���۸����仯");
                    p.setSupId(supId);
                    p.setSupGoodsId(i.getSupGoodsId());
                    goodsService.updateGoodsPrice(p);
                    total += p.getAgreePrice() * i.getBuyNum();
                } else {
                    total += p.getAgreePrice() * i.getBuyNum();
                }
            }

            if (supId == 4 && total <= 99) {
                errors.add("���򡾾���������Ʒ��������������99Ԫ");
            }

            if (errors.size() > 0) {
                logger.info("���ɶ���-�۸�У��ʧ��");
                map.put("error", "�µ�ʧ�ܣ�\\n" + StringUtils.join(errors, "\\n"));
                if ("1".equals(type)) {
                    return "forward:/market/goods/show?sid=" + supId + "&gid=" + skus.get(0);
                } else {
                    return "forward:/market/cart/list";
                }
            }
        } else {

            for (CartItem i : goods) {
                
                double d = goodsService.getEnquiryPrice(user.getUserId(), String.valueOf(i.getSupId()), i.getSupGoodsId());
                if (d > 0) {
                    i.setAgreePrice(d);
                }
                i.setSupType(s.getSupType());
                // ��������
                i.setBuyNum(skuNum.get(i.getSupGoodsId()));
            }
        }
        VatInfo vat = invoiceService.getUserVat(user.getUserId());
        if (s.getSupType() == 0) {
            map.put("address", addressService.getUserAddress(user.getUserId(), supId));
        } else {
            map.put("address", addressService.getProfUserAddress(user.getUserId(), supId));
        }
        map.put("invoice", invoiceService.getDefaultUserInvoice(user.getUserId()));
        map.put("vat", vat);
        map.put("goods", goods);
        map.put("supId", supId);
        map.put("supType", s.getSupType());
        map.put("ids", ids);
        map.put("prov", addressService.getSupArea(s.getSupType() == 1 ? 1 : supId, 0));
        map.put("vatProv", addressService.getSupArea(1, 0));
        if (vat != null && vat.getVatReceiveProv() > 0) {
            map.put("vatCity", addressService.getSupArea(1, vat.getVatReceiveProv()));
        }
        if (vat != null && vat.getVatReceiveCity() > 0) {
            map.put("vatDist", addressService.getSupArea(1, vat.getVatReceiveCity()));
        }

        if (s.getSupType() == 1 || (s.getSupType() == 0 && user.getAuthorities().contains(UserRole.CLIENT.value()) && user.getNopay() == 0)) {
            map.put("showPay", 1);
        }

        return "order/order";
    }

    @RequestMapping("/area")
    @ResponseBody
    public ResultObject area(HttpServletRequest req) {
        // �ϼ�����
        String parent = req.getParameter("parent");
        // ��Ӧ�̱��
        String supId = req.getParameter("supId");
        logger.info("��ȡ����Controller-parent[" + parent + "]�� supId[" + supId + "]");

        if (!StringUtils.isNumeric(supId) || !StringUtils.isNumeric(parent)) {
            logger.info("��ȡ����Controller-������Ч-parent[" + parent + "]�� supId[" + supId + "]");

            return new ResultObject(ResultObject.FAIL, "������Ч");
        }
        
        Supplier s = dataCache.getSupplier(Integer.parseInt(supId));
        

        return new ResultObject(ResultObject.OK, addressService.getSupArea(s.getSupType() == 1 ? 1 : s.getSupId(), Integer.parseInt(parent)));

    }

    @RequestMapping("/address")
    @ResponseBody
    public ResultObject address(HttpServletRequest req, HttpSession session) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);

        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
        }
        // ���
        String aid = req.getParameter("aid");
        // ʡ
        String prov = req.getParameter("prov");
        // ��
        String city = req.getParameter("city");
        // ��
        String dist = req.getParameter("dist");
        // ��
        String town = req.getParameter("town");
        // ��ϸ
        String detail = req.getParameter("detail");
        // �ջ���
        String name = req.getParameter("name");
        // �ʱ�
        String zip = req.getParameter("zip");
        // �ֻ�
        String phone = req.getParameter("phone");
        // �绰
        String tel = req.getParameter("tel");
        // ����
        String email = req.getParameter("email");
        // ��Ӧ�̱��
        String supId = req.getParameter("supId");
        // ����
        String alias = req.getParameter("alias");

        logger.info("���ӵ�ַController-aid[" + aid + "], alias[" + alias + "], prov[" + prov + "], city[" + city + "], dist[" + dist
                + "], town[" + town + "], detail[" + detail + "], name[" + name + "], zip[" + zip + "], phone[" + phone + "], tel[" + tel
                + "], email[" + email + "], supId[" + supId + "]");

        if (StringUtils.isEmpty(prov) || StringUtils.isEmpty(city) || StringUtils.isEmpty(dist) || StringUtils.isEmpty(detail)
                || StringUtils.isEmpty(name) || StringUtils.isEmpty(email)) {

            logger.info("���ӵ�ַController-������Ч-prov[" + prov + "], city[" + city + "], dist[" + dist + "], town[" + town + "], detail["
                    + detail + "], name[" + name + "], zip[" + zip + "], phone[" + phone + "], tel[" + tel + "], email[" + email
                    + "], supId[" + supId + "]");

            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        Address address = new Address();
        if (!StringUtils.isEmpty(aid)) {
            address.setAddressId(aid);
        }
        address.setAddressDetail(detail);
        address.setAreaLevelFour(town);
        address.setAreaLevelOne(prov);
        address.setAreaLevelThree(dist);
        address.setAreaLevelTwo(city);
        address.setName(name);
        address.setPhone(phone);
        address.setSupId(supId);
        address.setTel(tel);
        address.setEmail(email);
        address.setUserId(user.getUserId());
        address.setZipCode(zip);
        address.setAlias(alias);

        addressService.addAddress(address);

        return new ResultObject(ResultObject.OK, address.getAddressId());
    }

    @RequestMapping("/check")
    @ResponseBody
    public ResultObject check(HttpServletRequest req, HttpSession session) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);

        // ��Ӧ�̱��
        String supId = req.getParameter("supId");
        // ��Ʒ:gid#num,...
        String goods = req.getParameter("goods");
        // ʡ
        String prov = req.getParameter("prov");
        // ��
        String city = req.getParameter("city");
        // ��
        String dist = req.getParameter("dist");
        // ��
        String town = req.getParameter("town");

        logger.info("���ɶ���-���У��-prov[" + prov + "], city[" + city + "], dist[" + dist + "], town[" + town + "], goods[" + goods
                + "], supId[" + supId + "]");

        if (!StringUtils.isNumeric(supId) || StringUtils.isEmpty(goods) || !StringUtils.isNumeric(prov) || !StringUtils.isNumeric(city)
                || !StringUtils.isNumeric(dist)) {
            logger.info("���ɶ���-������Ч-���У��-prov[" + prov + "], city[" + city + "], dist[" + dist + "], town[" + town + "], goods[" + goods
                    + "], supId[" + supId + "]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        Map<String, Integer> map = new HashMap<String, Integer>();

        try {
            for (String i : goods.split(",")) {
                map.put(i.split("_")[1], Integer.parseInt(i.split("_")[2]));
            }
        } catch (Exception e) {
            logger.info("���ɶ���-������Ч-���У��-prov[" + prov + "], city[" + city + "], dist[" + dist + "], town[" + town + "], goods[" + goods
                    + "], supId[" + supId + "]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        List<String> area = new ArrayList<String>();
        area.add(prov);
        area.add(city);
        area.add(dist);
        area.add(town == null ? "" : town);

        Map<String, Integer> stocks = null;
        try {
            stocks = cpiService.getGoodsStock(Integer.parseInt(supId), new ArrayList<String>(map.keySet()), new ArrayList<Integer>(map.values()), area);
        } catch (Exception e) {
            logger.info("���ɶ���-���У��ʧ��");
            return new ResultObject(ResultObject.FAIL, "��Ӧ�������쳣���޷���ÿ����Ϣ");
        }

        for (Entry<String, Integer> i : map.entrySet()) {
        	if(stocks.get(i.getKey()) != -1){
                if (stocks.get(i.getKey()) == null || i.getValue() > stocks.get(i.getKey())) {
                    return new ResultObject(ResultObject.FAIL, "���͵���ѡ��ַ����Ʒ��治�㣬��ѡ��������ַ");
                }        		
        	}
        }

        return new ResultObject(ResultObject.OK, "");
    }

    @RequestMapping("/invoice")
    @ResponseBody
    public ResultObject invoice(HttpServletRequest req, HttpSession session) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);

        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
        }

        // ��Ʊ��������
        String flag = req.getParameter("flag");
        // ��Ʊ����
        String content = req.getParameter("content");
        // ���λ
        String company = req.getParameter("company");
        // ˰��ǼǺ�
        String num = req.getParameter("num");

        logger.info("���ɶ���-���ӷ�Ʊ-flag[" + flag + "], content[" + content + "], company[" + company + "], num[" + num + "]");

        if (!StringUtils.isNumeric(flag) || StringUtils.isEmpty(company)) {
            logger.info("���ɶ���-������Ч-���ӷ�Ʊ-flag[" + flag + "], content[" + content + "], company[" + company + "], num[" + num + "]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        Invoice invoice = new Invoice();
        invoice.setCompanyName(company);
        invoice.setInvoiceContent(content);
        invoice.setInvoiceFlag(flag);
        invoice.setInvoiceNum(num);
        invoice.setUserId(user.getUserId());

        invoiceService.addInvoice(invoice);
        return new ResultObject(ResultObject.OK, "���ӳɹ�");

    }

    @RequestMapping("/vat")
    @ResponseBody
    public ResultObject vat(HttpServletRequest req, HttpSession session) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);

        try {
            req.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
        }
        // ��Ʊ������
        String name = req.getParameter("name");
        // ��Ʊ���ֻ�
        String phone = req.getParameter("phone");
        // ʡ
        String prov = req.getParameter("prov");
        // ��
        String city = req.getParameter("city");
        // ��
        String dist = req.getParameter("dist");
        // ��ϸ��ַ
        String addr = req.getParameter("addr");

        logger.info("���ɶ���-������Ʊ-name[" + name + "], phone[" + phone + "], prov[" + prov + "], city[" + city + "], dist[" + dist + "], addr["
                + addr + "]");

        if (!StringUtils.isNumeric(prov) || StringUtils.isEmpty(name) || !StringUtils.isNumeric(city) || !StringUtils.isNumeric(dist)
                || StringUtils.isEmpty(phone) || StringUtils.isEmpty(addr)) {
            logger.info("���ɶ���-������Ч-���ӷ�Ʊ-name[" + name + "], phone[" + phone + "], prov[" + prov + "], city[" + city + "], dist[" + dist
                    + "], addr[" + addr + "]");
            return new ResultObject(ResultObject.FAIL, "������Ч");
        }

        VatInfo vat = new VatInfo();
        vat.setVatReceiveCity(Integer.parseInt(city));
        vat.setVatReceiveDetail(addr);
        vat.setVatReceiveDist(Integer.parseInt(dist));
        vat.setVatReceiveName(name);
        vat.setVatReceiveProv(Integer.parseInt(prov));
        vat.setVatReceiveTel(phone);

        vat.setUserId(user.getUserId());

        invoiceService.updateVat(vat);
        return new ResultObject(ResultObject.OK, "���ӳɹ�");

    }

    @RequestMapping("/submit")
    public String submit(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��ţ�supId_supGoodsId_num, ...
        String ids = req.getParameter("ids");
        // ���ͷ�ʽ
        String expressType = req.getParameter("express_type");
        // ʡ
        String addrProv = req.getParameter("addr_prov");
        // ��
        String addrCity = req.getParameter("addr_city");
        // ��
        String addrDist = req.getParameter("addr_dist");
        // ��
        String addrTown = req.getParameter("addr_town");
        // ��ϸ
        String addrDetail = req.getParameter("addr_detail");
        // ����
        String addrName = req.getParameter("addr_name");
        // �ʱ�
        String addrZip = req.getParameter("addr_zip");
        // �ֻ���
        String addrPhone = req.getParameter("addr_phone");
        // �绰
        String addrTel = req.getParameter("addr_tel");
        // ����
        String addrEmail = req.getParameter("addr_email");
        // ��ַ
        String addrAll = req.getParameter("addr_all");
        // ��Ʊ����
        String invoiceType = req.getParameter("invoice_type");
        // ��Ʊ��������
        String invoiceFlag = req.getParameter("invoice_flag");
        // ��Ʊ������ϸ
        String invoiceContent = req.getParameter("invoice_content");
        // ��λ
        String invoiceCompany = req.getParameter("invoice_company");
        // ˰��
        String invoiceNum = req.getParameter("invoice_num");
        // ��������
        String decideReason = req.getParameter("decide_reason");
        // ��Ʊ��ַ
        String vatReceiveName = req.getParameter("vat_receive_name");
        String vatReceiveTel = req.getParameter("vat_receive_tel");
        String vatReceiveProv = req.getParameter("vat_receive_prov");
        String vatReceiveCity = req.getParameter("vat_receive_city");
        String vatReceiveDist = req.getParameter("vat_receive_dist");
        String vatReceiveDetail = req.getParameter("vat_receive_detail");
        
        // ��ͬ
        String ifContract = req.getParameter("if_contract");
        String contractName = req.getParameter("contract_name");
        String supName = req.getParameter("sup_name");
        String signDate = req.getParameter("sign_date");
        String contractPrice = req.getParameter("contract_price");
        String buyType = req.getParameter("buy_type");
        String remark = req.getParameter("remark");

        // ͼƬ������ʱΪ������רҵ�г�ʱΪ��ͬ������
        String imgs = req.getParameter("imgs");

        // ֧����ʽ
        String payGate = req.getParameter("pay_gate");

        logger.info("���ɶ���-�ύ-ids[" + ids + "], expressType[" + expressType + "], addrProv[" + addrProv + "], addrCity[" + addrCity
                + "], addrDist[" + addrDist + "], addrTown[" + addrTown + "], addrDetail[" + addrDetail + "]," + " addrName[" + addrName
                + "], addrZip[" + addrZip + "], addrPhone[" + addrPhone + "], addrTel[" + addrTel + "], addrEmail[" + addrEmail
                + "], addrAll[" + addrAll + "], invoiceType[" + invoiceType + "], invoiceFlag[" + invoiceFlag + "]," + " invoiceContent["
                + invoiceContent + "], invoiceCompany[" + invoiceCompany + "], invoiceNum[" + invoiceNum + "], decideReason["
                + decideReason + "]" + ", vatReceiveName[" + vatReceiveName + "], vatReceiveTel[" + vatReceiveTel + "], vatReceiveProv["
                + vatReceiveProv + "], vatReceiveCity[" + vatReceiveCity + "], " + "vatReceiveDist[" + vatReceiveDist
                + "], vatReceiveDetail[" + vatReceiveDetail + "]");

        if (StringUtils.isEmpty(addrTown)) {
            addrTown = "0";
        }

        if (StringUtils.isEmpty(ids) || !StringUtils.isNumeric(expressType) || !StringUtils.isNumeric(addrProv)
                || !StringUtils.isNumeric(addrCity) || !StringUtils.isNumeric(addrDist) || !StringUtils.isNumeric(addrTown)
                || StringUtils.isEmpty(addrDetail) || StringUtils.isEmpty(addrName)) {
            map.put("success", false);
            map.put("msg", "������Ч");
            return "order/success";
        }

        int supId = 0;

        Map<String, Integer> skuNum = new HashMap<String, Integer>();

        List<String> errors = new ArrayList<String>();


        for (String i : ids.split(",")) {
            String[] seg = i.split("_");
            if (seg.length != 3 || !StringUtils.isNumeric(seg[0]) || !StringUtils.isNumeric(seg[2])) {
                logger.info("���ɶ���-�ύ-������Ч-ids[" + ids + "]");
                map.put("success", false);
                map.put("msg", "������Ч");
                return "order/success";
            }

            if (supId == 0) {
                supId = Integer.parseInt(seg[0]);
            }

            skuNum.put(seg[1], Integer.parseInt(seg[2]));
        }

        Supplier sup = dataCache.getSupplier(supId);

        if (sup.getSupType() == 0 && user.getNopay() == 1) {
            map.put("buyType", 1);
        } else {
            map.put("buyType", 0);
        }
        
        List<Goods> goods = goodsService.getGoodsListByIds(supId, new ArrayList<String>(skuNum.keySet()));
        

        List<OrderSnapshot> list = new ArrayList<OrderSnapshot>();

        double total = 0;
        double totalInit = 0;

        String orderId = orderService.getOrderIndex();
        //���۵�ID����
        List<String> quiteIDS = new ArrayList<String>();
        
        for (Goods i : goods) {
            OrderSnapshot s = new OrderSnapshot();
            s.setBuyNum(skuNum.get(i.getSupGoodsId()));
            s.setGoodsName(i.getGoodsName());
            s.setGoodsPrice(i.getAgreePrice());
            s.setGoodsPriceInit(i.getBusinessPrice());
            s.setQuoteId(cartService.getQuoteId(user.getUserId(), supId, i.getSupGoodsId()));
            if (sup.getSupType() == 1) {
                double d = goodsService.getEnquiryPrice(user.getUserId(), String.valueOf(i.getSupId()), i.getSupGoodsId());
                if (d > 0) {
                    s.setGoodsPrice(d);
                    s.setGoodsPriceInit(d);
                }
            }
            s.setImagePath(i.getImagePath());
            s.setSupGoodsId(i.getSupGoodsId());
            s.setSupId(i.getSupId());
            s.setOrderId(orderId);
            s.setGoodsModel(i.getGoodsModel());
            list.add(s);

            total += s.getBuyNum() * s.getGoodsPrice();
            totalInit += s.getBuyNum() * s.getGoodsPriceInit();
            
            //���ӱ�����ID ȥ�ظ�
            String quiteID = cartService.getQuoteId(user.getUserId(), supId, i.getSupGoodsId());
            if(!quiteIDS.contains(quiteID) && quiteID != null && !"".equals(quiteID)){
            	quiteIDS.add(quiteID);
            	//�޸Ķ���ID������۵�����
            	UPDQuiteInfo uqi = new UPDQuiteInfo();
            	uqi.setOrderId(orderId);
            	uqi.setQuiteID(quiteID);
            	orderService.updateOrderIDForQuiteInfo(uqi);
            }
        }

        
        Order order = new Order();
        order.setAddrAll(addrAll);
        order.setAddrCity(Integer.parseInt(addrCity));
        order.setAddrDetail(addrDetail);
        order.setAddrDist(Integer.parseInt(addrDist));
        order.setAddrName(addrName);
        order.setAddrPhone(addrPhone);
        order.setAddrProv(Integer.parseInt(addrProv));
        order.setAddrTel(addrTel);
        order.setAddrTown(Integer.parseInt(addrTown));
        order.setAddrZip(addrZip);
        order.setDecideReason(decideReason);
        order.setExpressType(Integer.parseInt(expressType));
        order.setOrderAmount(total);
        order.setOrderAmountInit(totalInit);
        order.setSupId(supId);
        order.setUserId(user.getUserId());
        order.setOrderId(orderId);
        order.setSnapshots(list);
        order.setAddrEmail(addrEmail);
        order.setCompanyId(user.getCompanyId());
        
        if (sup.getSupType() == 0 && user.getNopay() == 1) {
            order.setBuyType(1);
        } else {
            order.setBuyType(0);
        }

        if (sup.getSupType() == 0) {
            if (!StringUtils.isEmpty(imgs)) {
                order.setImgs(Arrays.asList(imgs.split(",")));
            }
        }

        if (sup.getSupType() == 0) {
            if (user.getAuthorities().contains(UserRole.CLIENT.value())) {
                order.setOrderStatus(15);
            } else {
                order.setOrderStatus(1);
            }
        } else {
            if ("0000".equals(payGate)) {
                order.setOrderStatus(18);
            } else {
                order.setOrderStatus(1);
            }
        }

        if (sup.getSupType() == 0 || !"0000".equals(payGate)) {
            order.setInvoiceType(Integer.parseInt(invoiceType));
            if ("2".equals(invoiceType)) {
                order.setInvoiceFlag(1);
                order.setVatReceiveCity(Integer.parseInt(vatReceiveCity));
                order.setVatReceiveDetail(vatReceiveDetail);
                order.setVatReceiveDist(Integer.parseInt(vatReceiveDist));
                order.setVatReceiveName(vatReceiveName);
                order.setVatReceiveProv(Integer.parseInt(vatReceiveProv));
                order.setVatReceiveTel(vatReceiveTel);
            } else {
                order.setInvoiceCompany(invoiceCompany);
                order.setInvoiceContent(invoiceContent);
                if("".equals(invoiceFlag)){
                	 order.setInvoiceFlag(1);
                }else{
                    order.setInvoiceFlag(Integer.parseInt(invoiceFlag));
                }
                order.setInvoiceNum(invoiceNum);
            }
        } else {
            if ("1".equals(ifContract)) {
                Contract contract = new Contract();
                contract.setContractName(contractName);
                if ("1".equals(buyType)) {
                    contract.setBuyType(1);
                } else {
                    contract.setBuyType(0);
                }
                if (!StringUtils.isEmpty(imgs)) {
                    contract.setContractAttachmentPath(imgs.split(",")[0]);
                }
                contract.setContractPrice(Double.parseDouble(contractPrice));
                contract.setRemark(remark);
                contract.setSupName(supName);
                try {
                    contract.setSignDate(new SimpleDateFormat("yyyy-MM-dd").parse(signDate));
                } catch (ParseException e) {
                }
                
                order.setContract(contract);
            } 
        }

        if (sup.getSupType() == 0) {
            try {
                order.setSupOrderId(cpiService.orderSubmit(order.getSupId(), order));
            } catch (NoSuchSupplierException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            } catch (ServiceExecutionFailedException e) {
                logger.error("���ɶ���-�ύʧ��", e);
    
                map.put("success", false);
                map.put("msg", e.getMessage().replace("java.lang.Exception:", ""));
                return "order/success";
            }
        }

        try {
            orderService.addOrder(order);
            map.put("success", true);
            map.put("orderId", orderId);
        } catch (Exception e) {
            logger.error("���ɶ���-�ύʧ��", e);
            map.put("success", false);
            map.put("msg", "��������ʧ��");
            return "order/success";
        }

        try {
            logger.info("���ɶ���-�ύ-������Ʒ����");
            for (OrderSnapshot i : list) {
                goodsService.updateGoodsSaleNum(i.getSupId(), i.getSupGoodsId(), i.getBuyNum());
            }
        } catch (Exception e) {
            logger.warn("���ɶ���-������Ʒ����ʧ��", e);
            // ��Ӱ���µ�������
        }

        try {
            logger.info("���ɶ���-�ύ-ɾ�����ﳵ��Ʒ");
            List<CartItem> items = new ArrayList<CartItem>();

            for (OrderSnapshot i : list) {
                CartItem c = new CartItem();
                c.setUserId(user.getUserId());
                c.setSupGoodsId(i.getSupGoodsId());
                c.setSupId(i.getSupId());
                items.add(c);
            }
            
            List<String> cids = cartService.getCartCompare(items);
            
            orderService.updateCompareOrderId(cids, orderId);

            cartService.deleteCartGoods(items);

            int cartNum = cartService.countGoodsNum(user.getUserId());
            session.setAttribute(SessionKeys.CART_NUM, cartNum);
            
        } catch (Exception e) {
            logger.warn("���ɶ���--ɾ�����ﳵ��Ʒʧ��", e);
            // ��Ӱ���µ�������
        }
        //supTypeΪ1�Ĵ�ͳ��Ӧ�� ���Ͷ���
        if(sup.getSupType()==1){
        	String []mobiles = {sup.getContactNum()};
            StringBuffer buffer = new StringBuffer();
            buffer.append(SmsContents.SMS_ORDER_HEAD);
            buffer.append(orderId);
            buffer.append(SmsContents.SMS_ORDER_FOOT);
            buffer.append("("+user.getCompanyName()+")��");
            try {
    			ShortMessageUtils.sendSMS(mobiles, buffer.toString());
    		} catch (RemoteException e2) {
    			logger.warn("���Ͷ���ʧ��",e2);
    		}
        }
        
        
        if ((sup.getSupType() == 1 && !"0000".equals(payGate)) || (sup.getSupType() == 0 && user.getAuthorities().contains(UserRole.CLIENT.value()) && user.getNopay() == 0 && !"0005".equals(payGate) )) {

            if (!"0001".equals(payGate) && !"0002".equals(payGate) && !"0004".equals(payGate)) {
                payGate = "0001";
            }

            Map<String, String> param = new HashMap<String, String>();
            param.put("MerId", configHolder.getConfig("chinapay.mer.id." + payGate));
            String date = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
            String payFlowNo = null;
            if (!"1".equals(configHolder.getConfig("chinapay.prod"))) {
                // ������D20+11���
                payFlowNo = order.getOrderId() + RandomStringUtils.random(11, "0123456789");
                param.put("Version", "20140728");
                param.put("MerOrderNo", payFlowNo);
                param.put("OrderAmt", String.valueOf((int) (order.getOrderAmount() * 100)));
                param.put("TranDate", date.substring(0, 8));
                param.put("TranTime", date.substring(8));
                param.put("TranType", payGate);
                param.put("BusiType", "0001");
                param.put("MerPageUrl", configHolder.getConfig("chinapay.callback.page").replace("${module}", "market/order"));
                param.put("MerBgUrl", configHolder.getConfig("chinapay.callback.notify").replace("${module}", "market/order"));
                param.put("MerResv", order.getOrderId());

                SecssUtil s = new SecssUtil();
                Properties p = new Properties();
                InputStream in = getClass().getClassLoader().getResourceAsStream("chinapay" + payGate + ".properties");
                try {
                    p.load(in);
                    in.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
                s.init(p);
                s.sign(param);
                param.put("Signature", s.getSign());

            } else {
                payFlowNo = order.getOrderId().substring(11) + RandomStringUtils.random(6, "0123456789");
                param.put("Version", "20141120");
                param.put("OrdId", payFlowNo);
                param.put("TransAmt", StringUtils.leftPad(String.valueOf((int) (order.getOrderAmount() * 100)), 12, '0'));
                param.put("CuryId", "156");
                param.put("TransDate", date.substring(0, 8));
                param.put("TransType", "0001");
                param.put("PageRetUrl", configHolder.getConfig("chinapay.callback.page").replace("${module}", "market/order"));
                param.put("BgRetUrl", configHolder.getConfig("chinapay.callback.notify").replace("${module}", "market/order"));
                // param.put("GateId", payGate);
                param.put("Priv1", order.getOrderId());

                chinapay.PrivateKey key1 = new chinapay.PrivateKey();
                chinapay.SecureLink t;
                boolean flag;
                flag = key1.buildKey(configHolder.getConfig("chinapay.mer.id." + payGate), 0,
                        configHolder.getConfig("chinapay.mer.prk." + payGate));
                if (flag == false) {
                    System.out.println("build key error!");
                }
                t = new chinapay.SecureLink(key1);
                String cv = t.Sign(param.get("MerId") + param.get("OrdId") + param.get("TransAmt") + param.get("CuryId")
                        + param.get("TransDate") + param.get("TransType") + param.get("Version") + param.get("BgRetUrl")
                        + param.get("PageRetUrl") + param.get("Priv1"));
                param.put("ChkValue", cv);

            }

            PayFlow payFlow = new PayFlow();
            payFlow.setOrderId(order.getOrderId());
            payFlow.setPayAmount(order.getOrderAmount());
            payFlow.setPayFlow(payFlowNo);
            payFlow.setPayStatus(0);
            payFlow.setPayType(1);
            payFlow.setProcStatus(0);
            payFlow.setRemark("���𶩵�֧��");
            payFlow.setPayGate(payGate);
            try {
                payFlow.setReqParam(new ObjectMapper().writeValueAsString(param));
            } catch (Exception e) {
            }

            payFlowService.insertPayFlow(payFlow);

            map.put("error", "");
            map.put("form", param);
            map.put("action", configHolder.getConfig("chinapay.url.pay"));

            return "order/pay";
        }else if("0005".equals(payGate)){//֧����֧��
        	//��װ֧��������
        	String payFlowNo = order.getOrderId().substring(11) + RandomStringUtils.random(6, "0123456789");
        	Map<String, String> sPara = new HashMap<String, String>();
        	sPara.put("service", configHolder.getConfig("alipay.param.service"));
        	sPara.put("partner",configHolder.getConfig("alipay.param.partner"));
        	sPara.put("seller_id", configHolder.getConfig("alipay.param.seller_id"));
        	sPara.put("_input_charset", configHolder.getConfig("alipay.param.input_charset"));
        	sPara.put("payment_type", configHolder.getConfig("alipay.param.payment_type"));
        	sPara.put("notify_url", configHolder.getConfig("alipay.callback.notify_url").replace("${module}", "market/alipay/alipayNotify"));
        	sPara.put("return_url",configHolder.getConfig("alipay.callback.return_url").replace("${module}", "market/alipay/alipayNotify"));
//        	alipayMap.put("anti_phishing_key","");
//    		alipayMap.put("exter_invoke_ip", "");
        	sPara.put("out_trade_no", payFlowNo);
        	String fullStr=user.getCompanyName()+"�ɹ���Ʒ";
        	sPara.put("subject", fullStr);
        	DecimalFormat df = new DecimalFormat("0.00");
        	sPara.put("total_fee", df.format(order.getOrderAmount()));
//    		map.put("body", body);
        	String sign_type = configHolder.getConfig("alipay.param.sign_type");
        	String private_key = configHolder.getConfig("alipay.param.private_key");
        	String input_charset = configHolder.getConfig("alipay.param.input_charset");
        	 Map<String, String> alipayMap = AlipaySubmit.buildRequestPara(sPara,sign_type,private_key,input_charset);
        	//֧����ˮ
        	PayFlow payFlow = new PayFlow();
            payFlow.setOrderId(order.getOrderId());
            payFlow.setPayAmount(new Double(df.format(order.getOrderAmount())));
            payFlow.setPayFlow(payFlowNo);
            payFlow.setPayStatus(0);
            payFlow.setPayType(1);//TODO ֧������ δȷ��
            payFlow.setProcStatus(0);
            payFlow.setRemark("���𶩵�֧��");
            payFlow.setPayGate(payGate);
            try {
                payFlow.setReqParam(new ObjectMapper().writeValueAsString(alipayMap));
            } catch (Exception e) {
            
            }
            String action = configHolder.getConfig("alipay.param.url")+ "_input_charset=" + configHolder.getConfig("alipay.param.input_charset");
            map.put("form", alipayMap);
            map.put("action", action);
            payFlowService.insertPayFlow(payFlow);
            return "order/alipay";
        } else {
            if (sup.getSupType() == 0 && user.getNopay() == 1) {
                orderService.updateOrderStatus(order.getOrderId(), 2);

                SettleData settle = new SettleData();
                settle.setBusiId(order.getOrderId());
                settle.setBusiType(1);
                settle.setCompanyName(orderService.getUserCompanyName(order.getUserId()));
                settle.setSettleAmount(order.getOrderAmountInit());
                settle.setSupId(order.getSupId());
                settle.setTotalNum(orderService.getGoodsSum(order.getOrderId()));
                
                settleService.insertSettleData(settle);
                String error = "";
                if (sup.getSupType() == 0) {
                    
                    try {
                        CpiService.getInstance().orderConfirm(order.getSupId(), order.getOrderId(), order.getSupOrderId());
                    } catch (Exception e) {
                        logger.error("��Ӧ��ȷ�϶���ʧ��", e);
                        map.put("success", false);
                        map.put("msg", "֧���ɹ�������Ӧ��ȷ�϶���ʧ��");
                        return "order/success";
                    }
                    
                }
                map.put("supType", sup.getSupType());
                return "order/success";
            } else {
                map.put("supType", sup.getSupType());
                return "order/success";
            }
        }
    }
    
    @RequestMapping("/submitMob")
    public String submitMob(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.BUY, UserRole.CLIENT);
        // ��ţ�supId_supGoodsId_num, ...
        String ids = req.getParameter("ids");
        // ���ͷ�ʽ
        String expressType = req.getParameter("express_type");
        // ʡ
        String addrProv = req.getParameter("addr_prov");
        // ��
        String addrCity = req.getParameter("addr_city");
        // ��
        String addrDist = req.getParameter("addr_dist");
        // ��
        String addrTown = req.getParameter("addr_town");
        // ��ϸ
        String addrDetail = req.getParameter("addr_detail");
        // ����
        String addrName = req.getParameter("addr_name");
        // �ʱ�
        String addrZip = req.getParameter("addr_zip");
        // �ֻ���
        String addrPhone = req.getParameter("addr_phone");
        // �绰
        String addrTel = req.getParameter("addr_tel");
        // ����
        String addrEmail = req.getParameter("addr_email");
        // ��ַ
        String addrAll = req.getParameter("addr_all");
        // ��Ʊ����
        String invoiceType = req.getParameter("invoice_type");
        // ��Ʊ��������
        String invoiceFlag = req.getParameter("invoice_flag");
        // ��Ʊ������ϸ
        String invoiceContent = req.getParameter("invoice_content");
        // ��λ
        String invoiceCompany = req.getParameter("invoice_company");
        // ˰��
        String invoiceNum = req.getParameter("invoice_num");
        // ��������
        String decideReason = req.getParameter("decide_reason");
        // ��Ʊ��ַ
        String vatReceiveName = req.getParameter("vat_receive_name");
        String vatReceiveTel = req.getParameter("vat_receive_tel");
        String vatReceiveProv = req.getParameter("vat_receive_prov");
        String vatReceiveCity = req.getParameter("vat_receive_city");
        String vatReceiveDist = req.getParameter("vat_receive_dist");
        String vatReceiveDetail = req.getParameter("vat_receive_detail");
        
        // ��ͬ
        String ifContract = req.getParameter("if_contract");
        String contractName = req.getParameter("contract_name");
        String supName = req.getParameter("sup_name");
        String signDate = req.getParameter("sign_date");
        String contractPrice = req.getParameter("contract_price");
        String buyType = req.getParameter("buy_type");
        String remark = req.getParameter("remark");

        // ͼƬ������ʱΪ������רҵ�г�ʱΪ��ͬ������
        String imgs = req.getParameter("imgs");

        // ֧����ʽ
        String payGate = req.getParameter("pay_gate");

        logger.info("���ɶ���-�ύ-ids[" + ids + "], expressType[" + expressType + "], addrProv[" + addrProv + "], addrCity[" + addrCity
                + "], addrDist[" + addrDist + "], addrTown[" + addrTown + "], addrDetail[" + addrDetail + "]," + " addrName[" + addrName
                + "], addrZip[" + addrZip + "], addrPhone[" + addrPhone + "], addrTel[" + addrTel + "], addrEmail[" + addrEmail
                + "], addrAll[" + addrAll + "], invoiceType[" + invoiceType + "], invoiceFlag[" + invoiceFlag + "]," + " invoiceContent["
                + invoiceContent + "], invoiceCompany[" + invoiceCompany + "], invoiceNum[" + invoiceNum + "], decideReason["
                + decideReason + "]" + ", vatReceiveName[" + vatReceiveName + "], vatReceiveTel[" + vatReceiveTel + "], vatReceiveProv["
                + vatReceiveProv + "], vatReceiveCity[" + vatReceiveCity + "], " + "vatReceiveDist[" + vatReceiveDist
                + "], vatReceiveDetail[" + vatReceiveDetail + "]");

        if (StringUtils.isEmpty(addrTown)) {
            addrTown = "0";
        }

        if (StringUtils.isEmpty(ids) || !StringUtils.isNumeric(expressType) || !StringUtils.isNumeric(addrProv)
                || !StringUtils.isNumeric(addrCity) || !StringUtils.isNumeric(addrDist) || !StringUtils.isNumeric(addrTown)
                || StringUtils.isEmpty(addrDetail) || StringUtils.isEmpty(addrName)) {
            map.put("success", false);
            map.put("msg", "������Ч");
            return "order/success";
        }

        int supId = 0;

        Map<String, Integer> skuNum = new HashMap<String, Integer>();

        List<String> errors = new ArrayList<String>();


        for (String i : ids.split(",")) {
            String[] seg = i.split("_");
            if (seg.length != 3 || !StringUtils.isNumeric(seg[0]) || !StringUtils.isNumeric(seg[2])) {
                logger.info("���ɶ���-�ύ-������Ч-ids[" + ids + "]");
                map.put("success", false);
                map.put("msg", "������Ч");
                return "order/success";
            }

            if (supId == 0) {
                supId = Integer.parseInt(seg[0]);
            }

            skuNum.put(seg[1], Integer.parseInt(seg[2]));
        }

        Supplier sup = dataCache.getSupplier(supId);

        if (sup.getSupType() == 0 && user.getNopay() == 1) {
            map.put("buyType", 1);
        } else {
            map.put("buyType", 0);
        }
        
        List<Goods> goods = goodsService.getGoodsListByIds(supId, new ArrayList<String>(skuNum.keySet()));
        

        List<OrderSnapshot> list = new ArrayList<OrderSnapshot>();

        double total = 0;
        double totalInit = 0;

        String orderId = orderService.getOrderIndex();
        //���۵�ID����
        List<String> quiteIDS = new ArrayList<String>();
        
        for (Goods i : goods) {
            OrderSnapshot s = new OrderSnapshot();
            s.setBuyNum(skuNum.get(i.getSupGoodsId()));
            s.setGoodsName(i.getGoodsName());
            s.setGoodsPrice(i.getAgreePrice());
            s.setGoodsPriceInit(i.getBusinessPrice());
            s.setQuoteId(cartService.getQuoteId(user.getUserId(), supId, i.getSupGoodsId()));
            if (sup.getSupType() == 1) {
                double d = goodsService.getEnquiryPrice(user.getUserId(), String.valueOf(i.getSupId()), i.getSupGoodsId());
                if (d > 0) {
                    s.setGoodsPrice(d);
                    s.setGoodsPriceInit(d);
                }
            }
            s.setImagePath(i.getImagePath());
            s.setSupGoodsId(i.getSupGoodsId());
            s.setSupId(i.getSupId());
            s.setOrderId(orderId);
            s.setGoodsModel(i.getGoodsModel());
            list.add(s);

            total += s.getBuyNum() * s.getGoodsPrice();
            totalInit += s.getBuyNum() * s.getGoodsPriceInit();
            
            //���ӱ�����ID ȥ�ظ�
            String quiteID = cartService.getQuoteId(user.getUserId(), supId, i.getSupGoodsId());
            if(!quiteIDS.contains(quiteID) && quiteID != null && !"".equals(quiteID)){
            	quiteIDS.add(quiteID);
            	//�޸Ķ���ID������۵�����
            	UPDQuiteInfo uqi = new UPDQuiteInfo();
            	uqi.setOrderId(orderId);
            	uqi.setQuiteID(quiteID);
            	orderService.updateOrderIDForQuiteInfo(uqi);
            }
        }

        
        Order order = new Order();
        order.setAddrAll(addrAll);
        order.setAddrCity(Integer.parseInt(addrCity));
        order.setAddrDetail(addrDetail);
        order.setAddrDist(Integer.parseInt(addrDist));
        order.setAddrName(addrName);
        order.setAddrPhone(addrPhone);
        order.setAddrProv(Integer.parseInt(addrProv));
        order.setAddrTel(addrTel);
        order.setAddrTown(Integer.parseInt(addrTown));
        order.setAddrZip(addrZip);
        order.setDecideReason(decideReason);
        order.setExpressType(Integer.parseInt(expressType));
        order.setOrderAmount(total);
        order.setOrderAmountInit(totalInit);
        order.setSupId(supId);
        order.setUserId(user.getUserId());
        order.setOrderId(orderId);
        order.setSnapshots(list);
        order.setAddrEmail(addrEmail);
        order.setCompanyId(user.getCompanyId());
        
        if (sup.getSupType() == 0 && user.getNopay() == 1) {
            order.setBuyType(1);
        } else {
            order.setBuyType(0);
        }

        if (sup.getSupType() == 0) {
            if (!StringUtils.isEmpty(imgs)) {
                order.setImgs(Arrays.asList(imgs.split(",")));
            }
        }

        if (sup.getSupType() == 0) {
            if (user.getAuthorities().contains(UserRole.CLIENT.value())) {
                order.setOrderStatus(15);
            } else {
                order.setOrderStatus(1);
            }
        } else {
            if ("0000".equals(payGate)) {
                order.setOrderStatus(18);
            } else {
                order.setOrderStatus(1);
            }
        }

        if (sup.getSupType() == 0 || !"0000".equals(payGate)) {
            order.setInvoiceType(Integer.parseInt(invoiceType));
            if ("2".equals(invoiceType)) {
                order.setInvoiceFlag(1);
                order.setVatReceiveCity(Integer.parseInt(vatReceiveCity));
                order.setVatReceiveDetail(vatReceiveDetail);
                order.setVatReceiveDist(Integer.parseInt(vatReceiveDist));
                order.setVatReceiveName(vatReceiveName);
                order.setVatReceiveProv(Integer.parseInt(vatReceiveProv));
                order.setVatReceiveTel(vatReceiveTel);
            } else {
                order.setInvoiceCompany(invoiceCompany);
                order.setInvoiceContent(invoiceContent);
                if("".equals(invoiceFlag)){
                	 order.setInvoiceFlag(1);
                }else{
                    order.setInvoiceFlag(Integer.parseInt(invoiceFlag));
                }
                order.setInvoiceNum(invoiceNum);
            }
        } else {
            if ("1".equals(ifContract)) {
                Contract contract = new Contract();
                contract.setContractName(contractName);
                if ("1".equals(buyType)) {
                    contract.setBuyType(1);
                } else {
                    contract.setBuyType(0);
                }
                if (!StringUtils.isEmpty(imgs)) {
                    contract.setContractAttachmentPath(imgs.split(",")[0]);
                }
                contract.setContractPrice(Double.parseDouble(contractPrice));
                contract.setRemark(remark);
                contract.setSupName(supName);
                try {
                    contract.setSignDate(new SimpleDateFormat("yyyy-MM-dd").parse(signDate));
                } catch (ParseException e) {
                }
                
                order.setContract(contract);
            } 
        }

        if (sup.getSupType() == 0) {
            try {
                order.setSupOrderId(cpiService.orderSubmit(order.getSupId(), order));
            } catch (NoSuchSupplierException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            } catch (ServiceExecutionFailedException e) {
                logger.error("���ɶ���-�ύʧ��", e);
    
                map.put("success", false);
                map.put("msg", e.getMessage().replace("java.lang.Exception:", ""));
                return "order/success";
            }
        }

        try {
            orderService.addOrder(order);
            map.put("success", true);
            map.put("orderId", orderId);
        } catch (Exception e) {
            logger.error("���ɶ���-�ύʧ��", e);
            map.put("success", false);
            map.put("msg", "��������ʧ��");
            return "order/success";
        }

        try {
            logger.info("���ɶ���-�ύ-������Ʒ����");
            for (OrderSnapshot i : list) {
                goodsService.updateGoodsSaleNum(i.getSupId(), i.getSupGoodsId(), i.getBuyNum());
            }
        } catch (Exception e) {
            logger.warn("���ɶ���-������Ʒ����ʧ��", e);
            // ��Ӱ���µ�������
        }

        try {
            logger.info("���ɶ���-�ύ-ɾ�����ﳵ��Ʒ");
            List<CartItem> items = new ArrayList<CartItem>();

            for (OrderSnapshot i : list) {
                CartItem c = new CartItem();
                c.setUserId(user.getUserId());
                c.setSupGoodsId(i.getSupGoodsId());
                c.setSupId(i.getSupId());
                items.add(c);
            }
            
            List<String> cids = cartService.getCartCompare(items);
            
            orderService.updateCompareOrderId(cids, orderId);

            cartService.deleteCartGoods(items);

            int cartNum = cartService.countGoodsNum(user.getUserId());
            session.setAttribute(SessionKeys.CART_NUM, cartNum);
            
        } catch (Exception e) {
            logger.warn("���ɶ���--ɾ�����ﳵ��Ʒʧ��", e);
            // ��Ӱ���µ�������
        }
        //supTypeΪ1�Ĵ�ͳ��Ӧ�� ���Ͷ���
        if(sup.getSupType()==1){
        	String []mobiles = {sup.getContactNum()};
            StringBuffer buffer = new StringBuffer();
            buffer.append(SmsContents.SMS_ORDER_HEAD);
            buffer.append(orderId);
            buffer.append(SmsContents.SMS_ORDER_FOOT);
            buffer.append("("+user.getCompanyName()+")��");
            try {
    			ShortMessageUtils.sendSMS(mobiles, buffer.toString());
    		} catch (RemoteException e2) {
    			logger.warn("���Ͷ���ʧ��",e2);
    		}
        }
        
        map.put("supType", sup.getSupType());
        return "order/success";
    }

    @RequestMapping("/callback/{type:.*}")
    public String callback(@PathVariable("type") String type, HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> map) {
        try {
            request.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e) {
        }
        // response.setCharacterEncoding("utf-8");

        Enumeration<String> requestNames = request.getParameterNames();
        Map<String, String> resultMap = new HashMap<String, String>();
        while (requestNames.hasMoreElements()) {
            String name = requestNames.nextElement();
            String value = request.getParameter(name);
            if ("page".equals(type)) {
                resultMap.put(name, value);
            } else {
                try {
                    resultMap.put(name, URLDecoder.decode(value, "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                }
            }
        }
        boolean verify = false;
        boolean transStatus = false;
        String payFlowNo = null;
        if (!"1".equals(configHolder.getConfig("chinapay.prod"))) {
            SecssUtil s = new SecssUtil();
            s.init();

            s.verify(resultMap);
            verify = "00".equals(s.getErrCode());
            payFlowNo = resultMap.get("MerOrderNo");
            transStatus = "0000".equals(resultMap.get("OrderStatus"));
        } else {
            if (type.equals("refund")) {
                verify = true;
                transStatus = "3".equals(resultMap.get("status"));
            } else {
                chinapay.PrivateKey key1 = new chinapay.PrivateKey();
                chinapay.SecureLink s;
                boolean flag;
                String t = resultMap.get("Priv1").split("-")[0];
                flag = key1.buildKey("999999999999999", 0, configHolder.getConfig("chinapay.mer.pbk"));
                if (flag == false) {
                    System.out.println("build key error!");
                }
                s = new chinapay.SecureLink(key1);
                verify = s.verifyTransResponse(resultMap.get("merid"), resultMap.get("orderno"), resultMap.get("amount"),
                        resultMap.get("currencycode"), resultMap.get("transdate"), resultMap.get("transtype"), resultMap.get("status"),
                        resultMap.get("checkvalue"));
                payFlowNo = resultMap.get("orderno");
                transStatus = "1001".equals(resultMap.get("status"));
            }
        }

        SecssUtil s = new SecssUtil();
        s.init();

        s.verify(resultMap);

        String error = null;

        if (verify) {
            PayFlow payFlow = null;
            if (check(payFlowNo)) {
                payFlow = payFlowService.getPayFlowByNo(payFlowNo);

                if (payFlow != null) {

                    if (payFlow.getPayStatus() != 1) {

                        payFlow.setPayStatus(1);
                        try {
                            payFlow.setResParam(new ObjectMapper().writeValueAsString(resultMap));
                        } catch (Exception e) {
                        }

                        Order order = orderService.getOrderDetail(payFlow.getOrderId());
                        if (transStatus) {
                            if (order.getOrderStatus() != 15) {
                                payFlow.setProcStatus(2);
                                payFlow.setRemark("�������Ǵ�֧��״̬[" + order.getOrderStatus() + "]");
                                error = "�������Ǵ�֧��״̬[" + order.getOrderStatus() + "]";
                            } else {
                                orderService.updateOrderStatus(order.getOrderId(), 2);

                                SettleData settle = new SettleData();
                                settle.setBusiId(order.getOrderId());
                                settle.setBusiType(1);
                                settle.setCompanyName(orderService.getUserCompanyName(order.getUserId()));
                                settle.setSettleAmount(order.getOrderAmountInit());
                                settle.setSupId(order.getSupId());
                                settle.setTotalNum(orderService.getGoodsSum(order.getOrderId()));

                                settleService.insertSettleData(settle);

                                payFlow.setProcStatus(1);
                                payFlow.setRemark("����֧���ɹ�");
                                Supplier sup = dataCache.getSupplier(order.getSupId());
                                if (sup.getSupType() == 0) {
                                    try {
                                        CpiService.getInstance().orderConfirm(order.getSupId(), order.getOrderId(), order.getSupOrderId());
                                    } catch (Exception e) {
                                        payFlow.setProcStatus(2);
                                        payFlow.setRemark("֧���ɹ�������Ӧ��ȷ�϶���ʧ��");
                                        error = "֧���ɹ�������Ӧ��ȷ�϶���ʧ��";
                                        logger.error("��Ӧ��ȷ�϶���ʧ��", e);
                                    }
                                    
                                    }
                                try {
                                    String path = OrderController.class.getResource("/").getPath();
                                    String websiteURL = (path.replace("/build/classes", "").replace("%20"," ").replace("classes/", "") + "message.properties");
                                    StringBuffer msg = new StringBuffer();
                                    String subMsg1 = CommonFileUtils.getMsg(websiteURL,"pay1");
                                    String subMsg2 = CommonFileUtils.getMsg(websiteURL,"pay2");
                                    msg.append(subMsg1).append(order.getOrderId()).append(subMsg2);
                                    ShortMessageUtils.sendSMS(new String[]{orderService.getUserContactNum(order.getUserId())}, msg.toString()); 
                                } catch (Exception e) {
                                    logger.error("���ŷ���ʧ��", e);
                                }
                            }
                        } else {
                            payFlow.setProcStatus(2);
                            payFlow.setRemark("����֧��ʧ��");
                            error = "����֧��ʧ��";
                        }

                        payFlowService.updatePayFlow(payFlow);
                    } else {
                        if (payFlow.getProcStatus() == 2) {
                            error = payFlow.getRemark();
                        }
                    }
                } else {
                    error = "֧����ˮ��Ч";
                }

                release(payFlowNo);
            } else {
                payFlow = payFlowService.getPayFlowByNo(payFlowNo);
                if (payFlow.getProcStatus() == 2) {
                    error = payFlow.getRemark();
                }
            }

            try {
                if (type.equals("notify") || type.equals("refund")) {
                    response.getWriter().write("success");
                } else {
                    if (error != null) {
                        map.put("error", error);
                        return "order/pay_fail";
                    } else {
                        map.put("orderId", payFlow.getOrderId());
                        map.put("payAmount", payFlow.getPayAmount());
                        map.put("payGate", payFlow.getPayGate());
                        return "order/pay_success";
                    }
                }
            } catch (IOException e) {
            }
        } else {
            try {
                if (type.equals("notify") || type.equals("refund")) {
                    response.getWriter().write("fail");
                } else {
                    map.put("error", "֧��ʧ��");
                    return "order/pay_fail";
                }
            } catch (IOException e) {
            }
        }

        return null;
    }

    @RequestMapping("/detail")
    public String detail(HttpServletRequest req, HttpSession session, Map<String, Object> map) {
        User user = Permission.check(session, UserRole.NONE);
        // �������
        String o = req.getParameter("o");

        logger.info("��������-o[" + o + "]");

        if (StringUtils.isEmpty(o)) {
            throw new PageNotFoundException();
        }

        Order order = orderService.getOrderDetail(o);

        if (o == null) {
            throw new PageNotFoundException();
        }

        map.put("order", order);

        return "order/detail";
    }

    private List<String> locks = new ArrayList<String>();

    private synchronized boolean check(String payFlow) {
        if (locks.contains(payFlow)) {
            return false;
        }

        locks.add(payFlow);
        return true;
    }

    private synchronized void release(String payFlow) {
        locks.remove(payFlow);
    }

}