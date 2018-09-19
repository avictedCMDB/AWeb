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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrderExchange.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    <form id="exchaneSendForm" method="post">
      <div class="order_section">
        <h2>������</h2>
          <h3>��Ӧ�̻�����Ϣ</h3>
          <div class="info_detail">
            <div class="txt_area">
              <label>�������ţ�</label>
              <span>${supplierExchangeDetailed.exchangeId}</span>
              <label>������ţ�</label>
              <span>${supplierExchangeDetailed.orderId}</span>
              <label>��Ӧ�����ƣ�</label>
              <span>${sessionScope.supUsernamecn}</span>
              <label>��ϵ�ˣ�</label>
              <span>${supplierExchangeDetailed.addrName}</span>
              <label>��ϵ�绰��</label>
              <span>${supplierExchangeDetailed.addrPhone}</span>
            </div>
            <div class="form-group clearfix">
              <label>��ע��</label>
              <textarea class="form-control" rows="3" name="supRemark"></textarea>
            </div>
          </div>
          <h3>������Ʒ��Ϣ</h3>
          <div class="search_result">
            <table class="details">
              <tr>
              	<th width="100">���</th>
                <th colspan="2">��Ʒ��Ϣ</th>
                <th width="100">����</th>
                <th width="100">��������</th>
                <th width="100">�˻����</th>
                <th width="100">����ԭ��</th>
                <th class="last" width="100">����</th>
              </tr>
              <c:forEach var="supplierExchange" items="${supplierExchangeList}" varStatus="status">
          <tr>
	          <td>${supplierExchange.rn}</td>
	          <td width="77" class="right_none"><p class="img_pro"><a href="#"><img src="${supplierExchange.imagePath}" width="44px" height="44px"/></a></p></td>
	          <td class="left_none"><a href="#">${supplierExchange.goodsName}</a></td>
	          <td class="price">${supplierExchange.agreePrice}</td>
	          <td>${supplierExchange.exchangeNum}</td>
	          <td class="price">${supplierExchange.sumChangePrice}</td>
	          <td>${supplierExchange.exchangeReason}</td>
	          <td><a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${supplierExchange.supGoodsId}" target="_blank">�鿴</a></td>
          </tr>
        </c:forEach>
            </table>
          </div>
          <h3>������Ϣ</h3>
          <dl class="dl-horizontal">
            <dt>������Ϣ��</dt>
            <dd>${supplierExchangeDetailed.addrAll}</dd>
          </dl>
          <div class="info_list clearfix">
          	<dl class="dl-horizontal">
              <dt>������</dt>
              <dd><label>
	              <input type="radio" name="optionsRadios" value="0" checked onchange="exchangeExpress()"/> ��Ӫ���
	        </label>
	        <label>
	              <input type="radio" name="optionsRadios" value="1" onchange="exchangeExpress()"/> ���������
	        </label></dd>
            </dl>
          </div>
          <div class="info_list clearfix" id="expressDiv" style="display:none">
            <dl class="dl-horizontal">
              <dt><span>*</span>��ݹ�˾��</dt>
              <dd><input class="form-control" type="text" name="exchangeExpressNameSupOther"/></dd>
            </dl>
            <dl class="dl-horizontal">
              <dt><span>*</span>��ݱ�ţ�</dt>
              <dd><input class="form-control" type="text" name="exchangeExpressCodeSupOther"/></dd>
            </dl>  
            <div class="btn_add">
            <!--   <button type="button" class="btn btn-default red" onclick="addExpress()">����</button> -->
            </div>
          </div>
	      <div class="btn_area">
            <ul class="clearfix">
              <li><button type="button" class="btn btn-default red" onclick="exchaneGoodsSend('${pageContext.request.contextPath}/supplier/exchange/exchaneGoodsSend/${exchangeId}')">�ύ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="history.go(-1)">����</button></li>
            </ul>
          </div>
	    	<!--.order_section-->	
      </div>
      <input type="hidden" name="exchangeExpressCodeSup" id="exchangeExpressCodeSup"/>
      <input type="hidden" name="exchangeExpressNameSup" id="exchangeExpressNameSup"/>
      </form>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>