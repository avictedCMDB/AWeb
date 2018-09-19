<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%
	String path = request.getContextPath();
	String sup_name = (String) request.getAttribute("sup_name");
	String sup_type = (String) request.getAttribute("sup_type");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>选择供应商</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_select.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/managementSupSelect.js"></script>
<base target="_self">
</head>

<body>
	<div class="select_pro select_pro_special">
	  <h3>选择供应商</h3>
	  <input type="hidden" id="sup_type" name="sup_type" value="<%=sup_type %>">
	  <input type="hidden" id="path" name="path" value="<%=path %>">
	  <div class="search_area">
	    <dl>
	      <dt>供应商名称</dt>
	      <dd>
	        <ul>
	          <li><input type="text" id="sup_name" name="sup_name" value="<%=sup_name==null?"":sup_name %>" class="form-control"></li>
	          <li><button type="button" onclick="doInit();" class="btn btn-default red">查询</button></li>
	        </ul>
	      </dd>
	    </dl>
	  </div>
	  <div class="search_table search_table_special">
	  <table border="0">
	    <tr id="title_tr">
	      <th width="40"><input type="checkbox" id="allchecked" value=""></th>
	      <th width="40">序号</th>
	      <th>供应商名称</th>
	    </tr>
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