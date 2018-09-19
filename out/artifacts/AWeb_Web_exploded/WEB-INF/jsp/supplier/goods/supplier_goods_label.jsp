<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>供应商管理中心|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_label.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="page-wrapper">
  <div id="header_top">
    <div class="inner">
       <ul class="social-links clearfix">
        <li class="first"><a href="#"><span class="fa fa-user"></span>晨光科力普</a><span>|</span></li>
        <li><a href="#">管理中心 </a><span>|</span></li>
        <li><a href="#">退出</a><span>|</span></li>
        <li><a href="#">帮助</a><span>|</span></li>
       </ul>
    <!--.inner--></div>
  <!--#header_top--></div>
  <div id="header">
    <div class="inner clearfix">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/supplier/logo_supplier.png" alt="中航招标网" />
      </div>
      <div class="search">
        <img src="${pageContext.request.contextPath}/static/img/supplier/bnr-supplier.jpg" />
      </div>
    <!--.inner--></div>
  <!--#header--></div>
  
  
  <div id="contents">
    <div class="inner">
    	
    	<div id="side_navi">
    		<dl>
    			<dt class="tlt_merchandise">交易管理<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li><a href="#"><span class="fa fa-caret-right"></span>超市订单管理</a></li>
                        <li><a href="#"><span class="fa fa-caret-right"></span>发货管理</a></li>
                        <li><a href="#"><span class="fa fa-caret-right"></span>退货管理</a></li>
                        <li><a href="#"><span class="fa fa-caret-right"></span>换货管理</a></li>
    				</ul>
    			</dd>
    			<dt class="tlt_transaction">信息维护<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li><a href="#"><span class="fa fa-caret-right"></span>联系人信息</a></li>
    					<li><a href="#"><span class="fa fa-caret-right"></span>地址库管理</a></li>
                        <li><a href="#"><span class="fa fa-caret-right"></span>快递公司管理</a></li>
    				</ul>
    			</dd>
    			<dt class="tlt_reeturns ">结算管理<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li><a href="#"><span class="fa fa-caret-right"></span>结算单管理</a></li>
    				</ul>
    			</dd>
    			<dt class="tlt_receipt">我的超市<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd class="last_child">
    				<ul>
    					<li><a href="#"><span class="fa fa-caret-right"></span>商品信息管理</a></li>
    					<li><a href="#"><span class="fa fa-caret-right"></span>自动上下架</a></li>
                        <li class="active"><a href="#"><span class="fa fa-caret-right"></span>商品标签管理</a></li>
                        <li><a href="#"><span class="fa fa-caret-right"></span>商品回收站</a></li>
    				</ul>
    			</dd>
    		</dl>
    		<!--#side_navi-->
    	</div>
      <div id="matter_section">
      	<h2>商品标签管理</h2>
      	<div class="search_result">
          <div class="btn_list">
            <ul class="clearfix">
              <li><button type="button" class="btn btn-default red">添加新标签</button></li>
              <li><button type="button" class="btn btn-default gray">批量删除</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="40"><input type="checkbox"></th>
              <th width="150">标签名称</th>
              <th>商品名称</th>
              <th width="100" class="last">操作</th>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>10645962</td>
              <td class="name">远生#US-618远生 Usign 三联组合式杂志筐 #US-618 （黑色）</td>
              <td><a href="#">编辑</a><a href="#">删除</a></td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>10645962</td>
              <td class="name">远生#US-618远生 Usign 三联组合式杂志筐 #US-618 （黑色）</td>
              <td><a href="#">编辑</a><a href="#">删除</a></td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>10645962</td>
              <td class="name">远生#US-618远生 Usign 三联组合式杂志筐 #US-618 （黑色）</td>
              <td><a href="#">编辑</a><a href="#">删除</a></td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>10645962</td>
              <td class="name">远生#US-618远生 Usign 三联组合式杂志筐 #US-618 （黑色）</td>
              <td><a href="#">编辑</a><a href="#">删除</a></td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>10645962</td>
              <td class="name">远生#US-618远生 Usign 三联组合式杂志筐 #US-618 （黑色）</td>
              <td><a href="#">编辑</a><a href="#">删除</a></td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>10645962</td>
              <td class="name">远生#US-618远生 Usign 三联组合式杂志筐 #US-618 （黑色）</td>
              <td><a href="#">编辑</a><a href="#">删除</a></td>
            </tr>
            <tr>
              <td><input type="checkbox"></td>
              <td>10645962</td>
              <td class="name">远生#US-618远生 Usign 三联组合式杂志筐 #US-618 （黑色）</td>
              <td><a href="#">编辑</a><a href="#">删除</a></td>
            </tr>
            
            
            
          </table>
        <!--.search_result--></div>
      	<div class="page">
          <ul class="pagination">
            <li><a href="#">&laquo;</a></li>
            <li><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li class="active"><a href="#">3</a></li>
            <li>...</li>
            <li><a href="#">99</a></li>
            <li><a href="#">100</a></li>
            <li><a href="#">&raquo;</a></li>
          </ul>
        </div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <div id="footer">
    <div class="inner">
      <div class="section clearfix">
        <div class="tel"><img src="${pageContext.request.contextPath}/static/img/img-tel.png" alt="" /></div>
        <div class="customer_service clearfix">
          <dl>
            <dt class="icon_shopping">购物指南</dt>
            <dd>
              <ul>
                <li><a href="#">网上竞价采购</a></li>
                <li><a href="#">网上直接采购</a></li>
                <li><a href="#">支付帮助</a></li>
              </ul>
            </dd>
          </dl>
          <dl>
            <dt class="icon-delivery">配送帮助</dt>
            <dd>
              <ul>
                <li><a href="#">配送进度查询</a></li>
                <li><a href="#">配送范围及运费</a></li>
              </ul>
            </dd>
          </dl>
          <dl>
            <dt class="icon-other">其他帮助</dt>
            <dd>
              <ul>
                <li><a href="#">地图导航</a></li>
                <li><a href="#">客户服务</a></li>
                <li><a href="#">常见问题</a></li>
              </ul>
            </dd>
          </dl>
        </div>
      </div>
    </div>
  <!--#footer--></div>
  <div id="copy_right">
    <div class="inner">
      <p>版权信息：显示版权信息内容文字</p>
    </div>
  </div>
<!--.page-wrapper--></div>
</body>
</html>
