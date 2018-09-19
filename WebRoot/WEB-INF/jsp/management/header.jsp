<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
function top_search() {
	var kw = $.trim($("#search_keyword").val());
	window.location.href = "${pageContext.request.contextPath}/market/goods/search?q=" + kw;
}
function setCartNum(num) {
	$("#cart_num").text("("+num+")");
}
</script>
  <div id="header_top">
    <div class="inner">
       <ul class="social-links clearfix">
        <li><a href="javascript:void(0);"><span class="fa fa-user"></span>${sessionScope.login_user.userNameCN}</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/management/main">采购管理中心</a><span>|</span></li>
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