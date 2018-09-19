
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
<link href="${pageContext.request.contextPath}/static/css/supplier_order.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrder.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../menu.jsp">
    	<jsp:param name="menu" value="order" />
    	</jsp:include>
      <div id="matter_section">
      	<h2>���ж�������</h2>
      	<div class="search_area section">
      	<form id="queryForm" method="post">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>�ɹ���λ</dt>
              <dd>
                <input type="text" class="form-control" name="companyName" value="${orderQuery.companyName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�������</dt>
              <dd>
                <input type="text" class="form-control" name="orderId" value="${orderQuery.orderId}"/>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>��Ʒ����</dt>
              <dd>
                <input type="text" class="form-control" name="goodsName" value="${orderQuery.goodsName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��Ʒ�ͺ�</dt>
              <dd>
                <input type="text" class="form-control" name="goodsModel" value="${orderQuery.goodsModel}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�µ�ʱ��</dt>
              <dd>
                <select class="form-control" name="orderTime">
                  <option value="" <c:if test="${orderQuery.orderTime == ''}"> selected="selected" </c:if>>ȫ��</option>
                  <option value="0" <c:if test="${orderQuery.orderTime == '0'}"> selected="selected" </c:if>>���һ����</option>
                  <option value="1" <c:if test="${orderQuery.orderTime == '1'}"> selected="selected" </c:if>>���������</option>
                  <option value="2" <c:if test="${orderQuery.orderTime == '2'}"> selected="selected" </c:if>>���һ��</option>
                </select>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>����״̬</dt>
              <dd>
                <select class="form-control" name="orderStatus" id="orderStatus">
                  <option value="">ȫ��</option>
                  <c:forEach var="ordersStatus" items="${ordersStatusList}" varStatus="status">
				      <option value="${ordersStatus.orderStatusCode}" <c:if test="${ordersStatus.orderStatusCode == orderQuery.orderStatus}"> selected="selected" </c:if>>${ordersStatus.orderStatus}</option>
				  </c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supplier/order')">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">���</button></li>
            </ul>
          </div>
          </form>
        <!--.search_area--></div>
      	<div class="search_result">
          <div class="state_list">
            <ul>
              <li<c:if test="${orderQuery.orderStatus == ''}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/order','')">ȫ��</a></li>
              <li <c:if test="${orderQuery.orderStatus == '18'}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/order','18')">�����</a></li>
              <li <c:if test="${orderQuery.orderStatus == '2'}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/order','2')">������</a></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th colspan="2">��Ʒ��Ϣ</th>
              <th width="85">����(Ԫ)</th>
              <th width="85">����</th>
              <th width="125">���(Ԫ)</th>
              <th width="170">����״̬</th>
              <c:if test="${sessionScope.loginSupType == '1'}">
              	<th width="140">����</th>
			  </c:if>
            </tr>
            <c:forEach var="ordersStatus" items="${ordersList}" varStatus="status">
	            <tr class="company">
	              <td colspan="6">
	                <ul>
	                <!-- <a href="${pageContext.request.contextPath}/supplier/order/detail?o=${ordersStatus.orderId}" target="_blank">${ordersStatus.orderId}</a> -->
	                  <li>������ţ�<a href="${pageContext.request.contextPath}/supplier/order/detail?o=${ordersStatus.orderId}">${ordersStatus.orderId}</a></li>
	                  
	                  <c:if test="${sessionScope.loginSupType != '1'}">
	                  	<li>��Ӧ�̶�����ţ�${ordersStatus.supOrderId}</li>
	                  </c:if>
	                  <li>��Ӧ�̣�<span>${ordersStatus.supName}</span></li>
	                  <li class="right_box">�µ�ʱ�䣺<span>${ordersStatus.orderTime}</span></li>
	                  <li class="right_box">�ϼƣ�<span class="price"><fmt:formatNumber value="${ordersStatus.orderAmount}" pattern="#0.00#"/></span></li>
	                </ul>
	              </td>
	            </tr>
	            <c:forEach var="subOrder" items="${ordersStatus.subOrderList}" varStatus="statusItem">
		            <tr>
		              <td class="right_none"><p class="img_pro"><a href="#"><img src="${subOrder.imagePath}" width="44px" height="44px"/></a></p></td>
		              <td width="387" class="left_none"><a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${subOrder.supGoodsId}" target="_blank">${subOrder.goodsName}<c:if test="${sessionScope.loginSupType == '1'}">(${subOrder.goodsModel})</c:if></a></td>
		              <td class="price"><fmt:formatNumber value="${subOrder.goodsPrice}" pattern="#0.00#"/></td>
		              <td class="num">${subOrder.buyNum}</td>
		              <td class="price"><fmt:formatNumber value="${subOrder.totalprice}" pattern="#0.00#"/></td>
		              <c:if test="${statusItem.index == 0}">	
			              <td rowspan="${ordersStatus.subCount}">
			              	<c:if test="${subOrder.orderStatusName != '1' and subOrder.orderStatusName != '2' and subOrder.orderStatusName != '3'}">${subOrder.orderStatusName} </c:if>
			              	<c:if test="${subOrder.orderStatusName == '1'}">������� <br/>��  <a href="${pageContext.request.contextPath}/supplier/exchange?orderId=${subOrder.orderId}">�л���</a>��</c:if>
			              	<c:if test="${subOrder.orderStatusName == '2'}">�������  <br/>��<a href="${pageContext.request.contextPath}/supplier/return?orderId=${subOrder.orderId}">���˻�</a>��</c:if>
			              	<c:if test="${subOrder.orderStatusName == '3'}">�������  <br/>��<a href="${pageContext.request.contextPath}/supplier/exchange?orderId=${subOrder.orderId}">�л���</a>�� <a href="${pageContext.request.contextPath}/supplier/return?orderId=${subOrder.orderId}">���˻�</a>��</c:if>
			              </td>
		              </c:if>
		              <c:if test="${sessionScope.loginSupType == '1' and statusItem.index == 0}">
		              	<td rowspan="${ordersStatus.subCount}">
		              		<a href="${pageContext.request.contextPath}/supplier/order/detail?o=${ordersStatus.orderId}">�鿴</a> 
		              		<c:if test="${subOrder.orderStatus == '18'}">
			              		<a href="${pageContext.request.contextPath}/supplier/order/detailReviewed?o=${ordersStatus.orderId}&authority=${ordersStatus.authority}"> ���</a> ����
			              	</c:if>
			              	<c:if test="${subOrder.orderStatus == '23'}">
			              		<a href="${pageContext.request.contextPath}/supplier/order/upload?orderId=${ordersStatus.orderId}"> �ϴ���ͬ</a> 
			              	</c:if>
			              	<c:if test="${subOrder.orderStatus != '23' and subOrder.orderStatus != '22' and subOrder.orderStatus != '19' and subOrder.orderStatus != '18' and subOrder.orderStatus != '17'}">
			              		<c:if test="${subOrder.contractCode != '' && subOrder.contractCode != null}">
			              			<a href="${pageContext.request.contextPath}/supplier/order/upload?orderId=${ordersStatus.orderId}"> �鿴��ͬ</a> 
			              		</c:if>
			              	</c:if>
			              	<c:if test="${subOrder.orderStatus == '2' || subOrder.orderStatus == '21'}">
			              		<!-- ��� <a href="javascript:void(0)" onclick="doSend('${pageContext.request.contextPath}/supplier/order/doSend','${ordersStatus.orderId}')"> ����</a>  -->
			              		��� <a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supplier/order/doSendPage/${ordersStatus.orderId}','900px','250px')"> ����</a> 
			              	</c:if>
			              	<c:if test="${subOrder.orderStatus != '2' and subOrder.orderStatus != '23' and subOrder.orderStatus != '18' and subOrder.orderStatus != '21'}">
			              		��� ����
			              	</c:if>
		              	</td>
					  </c:if>
		            </tr>
	            </c:forEach>
            </c:forEach>
          </table>
        <!--.search_result--></div>
      	<jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>