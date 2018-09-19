<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>换货管理|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_exchange.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/exchange.js"></script>
</head>
<body>
<div class="page-wrapper">
<jsp:include page="header.jsp" />  
    <div id="contents">
    <div class="inner">
      <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="exchange" />
	  </jsp:include>
      <div id="matter_section">
      <input id="path" type="hidden" value="${pageContext.request.contextPath}">
      	<h2>换货管理</h2>
      	<form action="" method="post" id="exchangeForm">
      	<input type="hidden" id="searchExchangeStatus" name="searchExchangeStatus" value="${exchange.searchExchangeStatus}"/>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>换货日期：</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input id="startTime" name="startTime" type="text" class="form-control special_input" value="${exchange.startTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>至</li>
                <li class="last">
                  <div class="input-group">
                    <input id="endTime" name="endTime" type="text" class="form-control special_input" value="${exchange.endTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>换货单编号：</dt>
              <dd>
                <input id="searchExchangeID" name="searchExchangeID" type="text" class="form-control" value="${exchange.searchExchangeID}">
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>供应商名称：</dt>
              <dd>
                <input id="searchSupName" name="searchSupName" type="text" class="form-control" value="${exchange.searchSupName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>订单编号：</dt>
              <dd>
                <input id="searchOrderID" name="searchOrderID" type="text" class="form-control" value="${exchange.searchOrderID}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>换货单状态：</dt>
              <dd>
                <select id="selExchangeStatus" name="selExchangeStatus" class="form-control" onchange="selCode();">
                  <option value="" <c:if test="${empty exchange.searchExchangeStatus}">selected="selected"</c:if>>全部</option>
                  <c:forEach var="code" items="${codes}" varStatus="status">
                    <option <c:if test="${exchange.searchExchangeStatus == code.codeValue}">selected="selected"</c:if> value="${code.codeValue}">${code.codeText}</option>
                  </c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="searchExchangeOrders();">查询</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearSearch();">清空</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <div class="state_list">
            <ul id="allStatusLi">
               
               <li id="allLi"<c:if test="${empty exchange.searchExchangeStatus}">class="active"</c:if> onclick="searchByCode('');"><a href="javascript:void(0);">全部</a></li>
              <%-- <c:forEach var="code" items="${codes}" varStatus="status"> --%>
              	<li id="li0" <c:if test="${exchange.searchExchangeStatus == '0'}">class="active"</c:if> onclick="searchByCode('0');"><a href="javascript:void(0);">待审核</a></li>
              	<li id="li1" <c:if test="${exchange.searchExchangeStatus == '1'}">class="active"</c:if> onclick="searchByCode('1');"><a href="javascript:void(0);">待发货</a></li>
              	<li id="li2" <c:if test="${exchange.searchExchangeStatus == '2'}">class="active"</c:if> onclick="searchByCode('2');"><a href="javascript:void(0);">审核未通过</a></li>
              <%-- </c:forEach> --%>
              <li class="delete"><button type="button" class="btn btn-default gray" onclick="delExchangeOrders();">删除</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="40"><input id="checkAll" type="checkbox" onclick="checkAll();"></th>
              <th width="120">换货单编号</th>
              <th width="120">订单编号</th>
              <th>供应商名称</th>
              <th width="70">换货数量</th>
              <th width="70">金额(元)</th>
              <th width="70">申请时间</th>
              <th width="70">状态</th>
              <th width="150" class="last">操作</th>
            </tr>
            <c:forEach var="exchange" items="${exchanges}" varStatus="status">
            <tr>
              
              <td>
              	<c:choose>
              		<c:when test="${exchange.exchangeStatus == 0}">
              			<input name="checkExchangeIDs" type="checkbox" value="${exchange.exchangeID}">
              		</c:when>
              		<c:otherwise>
              			<input type="checkbox" disabled>
              		</c:otherwise>
              	</c:choose>
              </td>
              <td>${exchange.exchangeID}</td>
              <td>${exchange.orderID}</td>
              <td class="left_align">${exchange.supName}</td>
              <td>${exchange.exchangeAmount}</td>
              <td><fmt:formatNumber value="${exchange.exchangePrice}" pattern="#0.00#"/></td>
              <td>${exchange.exchangeTime}</td>
              <td>${exchange.exchangeStatusName}</td>
              <td>
              	<a href="${pageContext.request.contextPath}/management/exchange/check/${exchange.exchangeID}">查看</a>
                 <c:choose>
		        	<c:when test="${exchange.exchangeStatus == 1 and exchange.supID != '4'}">
		        		&nbsp;|&nbsp;<a href="${pageContext.request.contextPath}/management/exchange/send/${exchange.exchangeID}">发货</a>
		        	</c:when>
		        	<c:when test="${exchange.exchangeStatus == 0 and exchange.supID != '4'}">
		        		&nbsp;|&nbsp;<a href="${pageContext.request.contextPath}/management/exchange/del/${exchange.exchangeID}">取消</a>
		        	</c:when>
		        	<c:when test="${exchange.exchangeStatus == 5 and exchange.supID != '4'}">
		        		&nbsp;|&nbsp;<a href="javascript:void(0);" onclick="exchangeConfirm('${exchange.exchangeID}');">确认收货</a>
		        	</c:when>
		        	<c:when test="${exchange.supID == '4'}">
		        		&nbsp;|&nbsp;<a href="javascript:void(0);" onclick="services('${exchange.exchangeID}');">服务单</a>
		        	</c:when>
		        </c:choose>
              </td>
            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
        <jsp:include page="page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>