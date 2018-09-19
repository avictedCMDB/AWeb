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
<link href="${pageContext.request.contextPath}/static/css/supplier_exchange.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrderExchange.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp">
    		<jsp:param name="menu" value="exchange" />
    	</jsp:include>
      <div id="matter_section">
      	<h2>��������</h2>
      	<form id="queryForm" method="post">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>��������</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" name="exchangeTimeStar" value="${orderQuery.exchangeTimeStar}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>��</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" name="exchangeTimeEnd" value="${orderQuery.exchangeTimeEnd}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��������</dt>
              <dd>
                <input type="text" class="form-control" name="exchangeId" value="${orderQuery.exchangeId}"/>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>�ɹ���λ</dt>
              <dd>
                <input type="text" class="form-control" name="companyname" value="${orderQuery.companyname}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�������</dt>
              <dd>
                <input type="text" class="form-control" name="orderId" value="${orderQuery.orderId}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>����״̬</dt>
              <dd>
                <select class="form-control" name="exchangeStatus" id="exchangeStatus">
                  <option value="">ȫ��</option>
                  <c:forEach var="ordersStatus" items="${ordersStatusList}" varStatus="status">
				      <option value="${ordersStatus.codevalue}" <c:if test="${ordersStatus.codevalue == orderQuery.exchangeStatus}"> selected="selected" </c:if>>${ordersStatus.codetext}</option>
				  </c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supplier/exchange')">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">���</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result">
          <div class="state_list">
            <ul>
              <li <c:if test="${orderQuery.exchangeStatus == ''}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/exchange','')">ȫ��</a></li>
              <li <c:if test="${orderQuery.exchangeStatus == '0'}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/exchange','0')">�����</a></li>
              <li <c:if test="${orderQuery.exchangeStatus == '3'}"> class="active" </c:if>><a href="javascript:void(0)" onclick="queryFast('${pageContext.request.contextPath}/supplier/exchange','3')">���ջ�</a></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="100">��������</th>
              <th width="100">�������</th>
              <th>�ɹ���λ</th>
              <th width="70">��������</th>
              <th width="70">���(Ԫ)</th>
              <th width="120">��������</th>
              <th width="80">������״̬</th>
              <th width="180" class="last">����</th>
            </tr>
            <c:forEach var="exchangeOrder" items="${ordersList}" varStatus="status">
	            <tr>
	              <td>${exchangeOrder.exchangeId}</td>
	              <td>${exchangeOrder.orderId}</td>
	              <td class="company">${exchangeOrder.companyname}</td>
	              <td>${exchangeOrder.exchangeAmount}</td>
	              <td class="price">${exchangeOrder.exchangePrice}</td>
	              <td>${exchangeOrder.exchangeTime}</td>
	              <td>${exchangeOrder.exchangeStatusName}</td>
	              <c:if test="${exchangeOrder.exchangeStatus == '0'}"> <td><a href="javascript:void(0)" onclick="confirmExchangeStatus('${exchangeOrder.exchangeStatus}','${pageContext.request.contextPath}/supplier/exchange/exchangeConfirmPage/${exchangeOrder.exchangeId}')">���</a> <a href="javascript:void(0)" onclick="openDetailed('${pageContext.request.contextPath}/supplier/exchange/queryDetailed/${exchangeOrder.exchangeId}')">�鿴����</a></td> </c:if>
	              <c:if test="${exchangeOrder.exchangeStatus == '3'}"> <td><a href="javascript:void(0)" onclick="confirmDeliveryStatus('${pageContext.request.contextPath}/supplier/exchange/exchangeConfirm','${exchangeOrder.exchangeStatus}','${exchangeOrder.exchangeId}')">ȷ���ջ�</a><a href="javascript:void(0)" onclick="openDetailed('${pageContext.request.contextPath}/supplier/exchange/queryDetailed/${exchangeOrder.exchangeId}')">�鿴����</a></td> </c:if>
	              <c:if test="${exchangeOrder.exchangeStatus == '4'}"> <td><a href="javascript:void(0)" onclick="redirectPage('${pageContext.request.contextPath}/supplier/exchange/exchangeSendPage/${exchangeOrder.exchangeId}')">����</a><a href="javascript:void(0)" onclick="openDetailed('${pageContext.request.contextPath}/supplier/exchange/queryDetailed/${exchangeOrder.exchangeId}')">�鿴����</a></td> </c:if>
	              <c:if test="${exchangeOrder.exchangeStatus != '0' and exchangeOrder.exchangeStatus != '4' and exchangeOrder.exchangeStatus != '3'}"> <td><a href="javascript:void(0)" onclick="openDetailed('${pageContext.request.contextPath}/supplier/exchange/queryDetailed/${exchangeOrder.exchangeId}')">�鿴����</a></td> </c:if>
	            </tr>
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