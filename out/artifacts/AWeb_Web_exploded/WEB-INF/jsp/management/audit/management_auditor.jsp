<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>订单审核|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_auditor.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<script type="text/javascript">
function top_search() {
	var kw = $.trim($("#search_keyword").val());
	window.location.href = "${pageContext.request.contextPath}/market/goods/search?q=" + kw;
}
function setCartNum(num) {
	$("#cart_num").text("("+num+")");
}
</script>
<body>
<div class="page-wrapper">
  <div id="header_top">
    <div class="inner">
       <ul class="social-links clearfix">
        <li><a href="javascript:void(0);"><span class="fa fa-user"></span>${sessionScope.login_user.userNameCN}</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/management/audit">采购管理中心</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/">平台首页 </a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/passport/login/logout">退出</a><span>|</span></li>
        <li><a href="#">客户服务</a><span>|</span></li>
        <li><a href="#">网站导航</a><span>|</span></li>
       </ul>
    <!--.inner--></div>
  <!--#header_top--></div>

  <div id="header">
    <div class="inner clearfix">
      <div class="logo">
         <img src="${pageContext.request.contextPath}/static/img/management/logo-management.png" alt="中航采购网" />    
      </div>
      <div class="search">
        <div class="input-group">
          <input type="text" class="form-control" id="search_keyword" value="${fn:escapeXml(searchKeyword)}"><span class="input-group-btn"><button class="btn btn-default" type="button" onclick="top_search();">搜索</button></span>
        </div>
      </div>
      <div class="buy">
        <button class="btn btn-default" type="button" onclick="window.location.href='${pageContext.request.contextPath}/market/cart/list';"><i class="fa fa-shopping-cart shopping"></i>我的购物车<i class="fa fa-angle-right arrow-right"></i></button></div>
    <!--.inner--></div>
  <!--#header--></div>
  
  
  <div id="contents">
    <div class="inner">
    	
    	<div id="side_navi">
    		<dl>
    			
    			<dt class="tlt_receipt">交易管理<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd class="last_child">
    				<ul>
    					<li><a href="${pageContext.request.contextPath}/management/audit/auditorAudit"><span class="fa fa-caret-right"></span>订单审核管理</a></li>
    				</ul>
    			</dd>
    		</dl>
    		<!--#side_navi-->
    	</div>
      
      <div id="matter_section">
      	<h2>待办事项</h2>
      	<div class="remind_area">
      		<ul>
      			<li>
      				<dl>
      					<dt>订单审核提醒</dt>
      					<dd><a href="${pageContext.request.contextPath}/management/audit/auditorAudit">待审核<span>（${orderCount}）</span></a></dd>
      				</dl>
      			</li>
      		</ul>
      	</div>
      	
      	<div class="manage_photo"><img src="${pageContext.request.contextPath}/static/img/management/img-manage_photo.jpg" alt="欢迎使用 welcome to 中航招采网采购人平台" /></div>
      	
      <!--#matter_section-->	
      </div>
      
      
      
      
     
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>