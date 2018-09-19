<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<%
	String path = request.getContextPath();
	String order_id = (String) request.getAttribute("order_id");
	String sup_id = (String) request.getAttribute("sup_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>退货申请|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_replace.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/managementOrderRefound.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/imgUpload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
</head>

<body>
<input type="hidden" id="order_id" name="order_id" value="<%=order_id %>"/>
<input type="hidden" id="sup_id" name="sup_id" value="<%=sup_id %>"/>
<input type="hidden" id="sup_goods_id" name="sup_goods_id" value=""/>
<input type="hidden" id="path" name="path" value="<%=path %>"/>
<div class="page-wrapper">
  <jsp:include page="header.jsp"/>
  
  <div id="contents">
    <div class="inner">
    	<h2>退货明细</h2>
    	<div class="replace_step"> 
	    	<ul class="image_list">
	    		<li><img src="${pageContext.request.contextPath}/static/img/management/img-step01.gif" alt="1" /></li>
	    		<li><img src="${pageContext.request.contextPath}/static/img/management/img-step02.gif" alt="2" /></li>
	    		<li><img src="${pageContext.request.contextPath}/static/img/management/img-step03.gif" alt="3" /></li>
	    		<li><img src="${pageContext.request.contextPath}/static/img/management/img-step04.gif" alt="4" /></li>
	    	</ul>
	    	
	    	<ul class="text_step">
	    		<li>采购人退货</li>
	    		<li class="confirm_step">供应商确认</li>
	    		<li class="sale_step">采购人发货</li>
	    		<li class="receipt_step">供应商收货确认</li>
	    	</ul>	      
	    	<!--.replace_step-->	
      </div>
      
      <h3>退货单基本信息</h3>
      <div class="order_details">
      	<div class="order_row">
	      	<label>订单编号：</label>
	      	<span class="order_name"><a href="<%=path %>/market/order/detail?o=${order.order_id}">${order.order_id}</a></span>
	      	<label>供应商名称：</label>
	      	<span class="order_name"><a href="#">${order.sup_name}</a></span>
	      	<label>采购人联系人：</label>
	      	<span>${order.addr_name}</span>
	      	<label>采购人联系电话：</label>
	      	<span>${order.addr_phone}</span>
      	</div>
      	<dl>
	      	<dt>备注：</dt>
	      	<dd><textarea type="text" id="remark" name="remark" class="form-control"></textarea></dd>
      	</dl>
      	<dl>
	      	<dt>附件：</dt>
	      	<dd>
	      		<mc:ImgUploadTag mark='buy'></mc:ImgUploadTag>
	      		支持的图片格式为jpg/jpeg/png/gif/bmp/pdf，单个图片需小于2M。
	      	</dd>
      	</dl>
      	<!--.order_details-->		
      </div>
      
      <h3>商品信息</h3>
      <div class="search_result">
      	<table>
   			<tr>
    			<th width="40"><input type="checkbox" id="allchecked" value=""></th>
    			<th width="390" colspan="2">商品名称</th>
    			<th width="110">采购数量</th>
    			<th width="110">可退货数量</th>
    			<th width="120" style="display: none;">原价hidden</th>
    			<th width="120">单价（元）</th>
    			<th width="110">退货数量</th>
    			<th width="120">退货金额(元)</th>
    			<th width="120" style="display: none;">退货原价金额(元)hidden</th>
    			<th width="200">退货原因</th>
    			<th width="80">操作</th>
   			</tr>
   			<tr id="btn_tr" class="company">
    			<td colspan="9"><button type="button" onclick="gotoSelectGoodsPage('${pageContext.request.contextPath}','${order.order_id}');" class="btn btn-default red">选择商品</button></td>
   			</tr>
   			<tr class="company">
    			<td colspan="9"><label>退货总数量：</label><span id='hhzsl'>0</span><label>退货总金额：</label><span id='hhzje'>0.00</span><span id='hhzje_o' style="display: none;">0.00</span></td>
   			</tr>
	    	</table>
	    	
	    	<div class="confirm_area">
   				<ul>
		            <li><button type="button" onclick="doSave('${pageContext.request.contextPath}');" class="btn btn-default red">提交</button></li>
		            <li><button type="button" onclick="window.location.href='${pageContext.request.contextPath}'+'/management/order';" class="btn btn-default gray">返回</button></li>
	          	</ul>
	    	</div>
      <!--.search_result-->			
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  
  <jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>