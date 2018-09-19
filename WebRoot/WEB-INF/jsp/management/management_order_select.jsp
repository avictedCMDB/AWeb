<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%
	String path = request.getContextPath();
	String goods_name = (String) request.getAttribute("goods_name");
	String order_id = (String) request.getAttribute("order_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>选择商品</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_select.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/managementOrderSelect.js"></script>
<base target="_self">
</head>

<body>
	<div class="select_pro">
	  <h3>选择商品</h3>
	  <input type="hidden" id="order_id" name="order_id" value="<%=order_id %>">
	  <input type="hidden" id="path" name="path" value="<%=path %>">
	  <div class="search_area">
	    <dl>
	      <dt>商品名称</dt>
	      <dd>
	        <ul>
	          <li><input type="text" id="goods_name" name="goods_name" value="<%=goods_name==null?"":goods_name %>" class="form-control"></li>
	          <li><button type="button" onclick="doInit();" class="btn btn-default red">查询</button></li>
	        </ul>
	      </dd>
	    </dl>
	  </div>
	  <div class="search_table">
	  <table border="0">
	    <tr id="title_tr">
	      <th width="40"><input type="checkbox" id="allchecked" value=""></th>
	      <th width="40">序号</th>
	      <th colspan="2">商品名称</th>
	      <th width="110">可选择数量</th>
	       <th width="110">单价(元)</th>
	    </tr>
	    <c:forEach var="og" items="${oglist}" varStatus="status">
	    <tr>
	      <td><input type="checkbox" name="subCheckbox" value="${og.sup_goods_id}"></td>
	      <td>${status.count}</td>
	      <td class="right_none" width="57"><p class="img_pro"><img style="height: 55px;width: 55px;" src="${og.image_path}" /></p></td>
	      <td class="left_none">${og.goods_name}</td>
	      <td>${og.buy_num}</td>
	      <td class="price"><fmt:formatNumber value="${og.goods_price}" pattern="#0.00#"></fmt:formatNumber></td>
	    </tr>
	    </c:forEach>
	  </table>
	  </div>
	  <div class="btn_list">
	    <ul>
	      <li><button type="button" onclick="doConfirm();" class="btn btn-default red">确定</button></li>
	      <li><button type="button" onclick="window.close();" class="btn btn-default gray">取消</button></li>
	    </ul>
	  </div>
	</div>
</body>
</html>