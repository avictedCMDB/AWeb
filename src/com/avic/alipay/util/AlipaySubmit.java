package com.avic.alipay.util;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;

import com.avic.alipay.config.AlipayConfig;
import com.avic.alipay.sign.RSA;

/* *
 *������AlipaySubmit
 *���ܣ�֧�������ӿ������ύ��
 *��ϸ������֧�������ӿڱ���HTML�ı�����ȡԶ��HTTP����
 *�汾��3.3
 *���ڣ�2012-08-13
 *˵����
 *���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
 *�ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο���
 */

public class AlipaySubmit {
    
    /**
     * ֧�����ṩ���̻��ķ����������URL(��)
     */
    private static final String ALIPAY_GATEWAY_NEW = "https://mapi.alipay.com/gateway.do?";
	
    /**
     * ����ǩ�����
     * @param sPara Ҫǩ��������
     * @return ǩ������ַ���
     */
	public static String buildRequestMysign(Map<String, String> sPara,String private_key,String input_charset,String sign_type) {
    	String prestr = AlipayCore.createLinkString(sPara); //����������Ԫ�أ����ա�����=����ֵ����ģʽ�á�&���ַ�ƴ�ӳ��ַ���
        String mysign = "";
        if(sign_type.equals("RSA") ){
        	mysign = RSA.sign(prestr, private_key,input_charset);
        }
        return mysign;
    }
	
    /**
     * ����Ҫ�����֧�����Ĳ�������
     * @param sParaTemp ����ǰ�Ĳ�������
     * @return Ҫ����Ĳ�������
     */
    public static Map<String, String> buildRequestPara(Map<String, String> sParaTemp,String sign_type,String private_key,String input_charset) {
        //��ȥ�����еĿ�ֵ��ǩ������
        Map<String, String> sPara = AlipayCore.paraFilter(sParaTemp);
        //����ǩ�����
        String mysign = buildRequestMysign(sPara,private_key,input_charset,sign_type);

        //ǩ�������ǩ����ʽ���������ύ��������
        sPara.put("sign", mysign);
        sPara.put("sign_type", sign_type);

        return sPara;
    }

    /**
     * ���������Ա���HTML��ʽ���죨Ĭ�ϣ�
     * @param sParaTemp �����������
     * @param strMethod �ύ��ʽ������ֵ��ѡ��post��get
     * @param strButtonName ȷ�ϰ�ť��ʾ����
     * @return �ύ����HTML�ı�
     */
    public static String buildRequest(Map<String, String> sParaTemp, String strMethod, String strButtonName,String sign_type,String input_charset,String private_key) {
        //�������������
        Map<String, String> sPara = buildRequestPara(sParaTemp,sign_type,private_key,input_charset);
        List<String> keys = new ArrayList<String>(sPara.keySet());

        StringBuffer sbHtml = new StringBuffer();

        sbHtml.append("<form id=\"alipaysubmit\" name=\"alipaysubmit\" action=\"" + ALIPAY_GATEWAY_NEW
                      + "_input_charset=" +input_charset + "\" method=\"" + strMethod
                      + "\">");

        for (int i = 0; i < keys.size(); i++) {
            String name = (String) keys.get(i);
            String value = (String) sPara.get(name);

            sbHtml.append("<input type=\"hidden\" name=\"" + name + "\" value=\"" + value + "\"/>");
        }

        //submit��ť�ؼ��벻Ҫ����name����
        sbHtml.append("<input type=\"submit\" value=\"" + strButtonName + "\" style=\"display:none;\"></form>");
        sbHtml.append("<script>document.forms['alipaysubmit'].submit();</script>");

        return sbHtml.toString();
    }
    
 
    
    /**
     * ���ڷ����㣬���ýӿ�query_timestamp����ȡʱ����Ĵ�������
     * ע�⣺Զ�̽���XML��������������Ƿ�֧��SSL�������й�
     * @return ʱ����ַ���
     * @throws IOException
     * @throws DocumentException
     * @throws MalformedURLException
     */
	public static String query_timestamp() throws MalformedURLException,
                                                        DocumentException, IOException {

        //�������query_timestamp�ӿڵ�URL��
        String strUrl = ALIPAY_GATEWAY_NEW + "service=query_timestamp&partner=" + AlipayConfig.partner + "&_input_charset" +AlipayConfig.input_charset;
        StringBuffer result = new StringBuffer();

        SAXReader reader = new SAXReader();
        Document doc = reader.read(new URL(strUrl).openStream());

        List<Node> nodeList = doc.selectNodes("//alipay/*");

        for (Node node : nodeList) {
            // ��ȡ���ֲ���Ҫ��������Ϣ
            if (node.getName().equals("is_success") && node.getText().equals("T")) {
                // �ж��Ƿ��гɹ���ʾ
                List<Node> nodeList1 = doc.selectNodes("//response/timestamp/*");
                for (Node node1 : nodeList1) {
                    result.append(node1.getText());
                }
            }
        }

        return result.toString();
    }
}