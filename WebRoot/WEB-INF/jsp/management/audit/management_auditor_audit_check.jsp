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
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}">
<div class="page-wrapper">
	<jsp:include page="../header.jsp"/>  
  
  <div id="contents">
    <div class="inner">
    	
    	
    	<div class="order_section"> 
	    	<h2>订单明细</h2>
	    	<h3>商品详细</h3>
	    	<div class="search_result">
	    		<table>
	    			<tr>
		    			<th width="592" colspan="2">商品名称</th>
		    			<th width="200">单价（元）</th>
		    			<th width="190">数量（个）</th>
		    			<th>总价（元）</th>
	    			</tr>
	    			<tr class="company">
			        <td colspan="6">商品目录：本册/便签</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="${pageContext.request.contextPath}/static/img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
	    			<tr class="company">
			        <td colspan="6">商品目录：本册/便签</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">晨光 M&amp;G 优事贴自粘便条纸<br />AS32A10110 3"*2" 76mm*51mm 100页/本（黄色）40本/盒</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
	    		</table>
	      	
	      <!--.search_result-->	
	      </div>
	    	
	    	<h3>地址信息</h3>
	    	<div class="addrss_section">
		    	<div class="icon_action">
		    			<span class="icon_need">配送要求</span>
		    			<span class="icon_logist">配送要求</span>
		    			<span class="icon_self">上门自取</span>	    			
		    		<!--.icon_action-->	
		    	</div>
		    	
		    	<div class="infor_top">
		    		<div class="infor_bottom">
		    			<div class="infor_area">
		    				<p class="cus_name">北京 <span><b>北京市</b></span> （ 李先生 收 ）</p>
		    				<p>朝阳区 <span>朝阳区惠中路5号远大中心B座20层中航经贸</span> 13811189077</p>
		    				<span class="icon_addr"><img src="${pageContext.request.contextPath}/static/img/management/icon-addr.png" /></span>
		    	    </div>
		    	  </div>
		    	</div>
		    	
		    	<!--.addrss_section-->	
	    	</div>
	    	
	    	
	    	<h3>地址信息</h3>
	    	<div class="addrss_section">
		    	<div class="icon_action">
		    			<span class="icon_need">发票类型</span>
		    			<span class="icon_logist">普通发票</span>
		    			<span class="icon_self">增值税发票</span>	
		    			<span class="icon_need">发票内容</span>
		    			<span class="icon_logist">明细</span>
		    			<span class="icon_self">自定义</span>    			
		    		<!--.icon_action-->	
		    	</div>
		    	
		    	<div class="infor_top">
		    		<div class="infor_bottom">
		    			<div class="infor_area">
		    				<dl>
		    					<dt>付款单位名称</dt>
		    					<dd>中航技国际经贸发展有限公司</dd>
		    					<dt>税务登记号</dt>
		    				</dl>
		    				<span class="icon_addr"><img src="${pageContext.request.contextPath}/static/img/management/icon-addr.png" /></span>
		    	    </div>
		    	  </div>
		    	</div>
		    	
		    	<!--.addrss_section-->	
	    	</div>    	
	    	
	    	
	    	
	    	<h3>其他信息</h3>
	      <div class="other_area">决策理由：价格合适</div>
	      
	      <div class="gather_box">
	      	<div class="gather_inner">
	      		<p><span>实付款：</span><span class="symbol">￥</span><span class="price">84.91</span></p>
	      		<p><span>寄送至：</span>北京 北京市 朝阳区 朝阳区惠中路5号远大中心B座20层中航经贸</p>
	      		<p><span>收货人：</span>李先生 13811189077</p>
	      	</div>
	      </div>
	      
	      <div class="btn_area"><button type="button" class="btn btn-default gray">关闭</button></div>
	      
	      
	    	<!--.order_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>