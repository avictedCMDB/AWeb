<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��Ӧ�̹�������|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_delivery.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrderExchange.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
      <div class="order_section">
        <h2>������</h2>
          <h3>��Ӧ�̻�����Ϣ</h3>
          <div class="info_detail">
            <div class="txt_area">
              <label>��������ţ�</label>
              <span></span>
              <label>�������ƣ�</label>
              <span>���������</span>
              <label>���й�Ӧ�����ƣ�</label>
              <span>���������</span>
              <label>��ϵ�ˣ�</label>
              <span>���������</span>
              <label>��ϵ�绰��</label>
              <span>1234567</span>
            </div>
            <div class="form-group clearfix">
              <label>��ע��</label>
              <textarea class="form-control" rows="3"></textarea>
            </div>
          </div>
          <h3>������Ʒ��Ϣ</h3>
          <div class="search_result">
            <table class="details">
              <tr>
                <th colspan="2">��Ʒ��Ϣ</th>
                <th width="100">��������</th>
                <th width="100">�ѷ�������</th>
                <th width="100">����������</th>
                <th width="100">���η�������</th>
                <th class="last" width="100">����</th>
              </tr>
              <tr class="company">
                <td colspan="7" class="order_info order_num"><span>2016-03-18</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>�����ţ�<a href="#">D100003110000</a></span></td>
              </tr>
              <tr>
                <td width="77" class="right_none"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" /></a></p></td>
                <td class="left_none"><a href="#">���� M&G ��������ճ����ֽAS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
                <td>10</td>
                <td>10</td>
                <td>1</td>
                <td>
                  <div class="input-group input-group-num">
                    <span class="input-group-btn">
                      <button class="btn btn-default input-group-addon" type="button">-</button>
                    </span>
                    <input id="after" class="form-control" type="text" value="1" min="1" max="10">
                    <span class="input-group-btn">
                      <button class="btn btn-default input-group-addon" type="button">+</button>
                    </span>
                  </div>
                </td>
                <td><a href="#">ɾ��</a></td>
              </tr>
            </table>
          </div>
          <h3>������Ϣ</h3>
          <dl class="dl-horizontal">
            <dt>������Ϣ��</dt>
            <dd>���� ������ ������ ����������·5��Զ������B��20���к���ó</dd>
          </dl>
          <div class="info_list clearfix">
            <dl class="dl-horizontal">
              <dt><span>*</span>��ݹ�˾��</dt>
              <dd><input class="form-control" type="text"></dd>
            </dl>
            <dl class="dl-horizontal">
              <dt><span>*</span>��ݱ�ţ�</dt>
              <dd><input class="form-control" type="text"></dd>
            </dl>
            <div class="btn_add">
              <button type="button" class="btn btn-default red">����</button>
            </div>
          </div>
	      <div class="btn_area">
            <ul class="clearfix">
              <li><button type="button" class="btn btn-default red">�ݴ�</button></li>
              <li><button type="button" class="btn btn-default red">�ύ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="redirectPage('${pageContext.request.contextPath}/supplier/exchange/back')">����</button></li>
            </ul>
          </div>
	    	<!--.order_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>