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
<title>�������|�к��б���</title>
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
	    	<h2>������ϸ</h2>
	    	<h3>��Ʒ��ϸ</h3>
	    	<div class="search_result">
	    		<table>
	    			<tr>
		    			<th width="592" colspan="2">��Ʒ����</th>
		    			<th width="200">���ۣ�Ԫ��</th>
		    			<th width="190">����������</th>
		    			<th>�ܼۣ�Ԫ��</th>
	    			</tr>
	    			<tr class="company">
			        <td colspan="6">��ƷĿ¼������/��ǩ</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="${pageContext.request.contextPath}/static/img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
	    			<tr class="company">
			        <td colspan="6">��ƷĿ¼������/��ǩ</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
			      <tr>
			        <td width="77" class="left_line"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" alt="" /></a></p></td>
			        <td width="335" class="link_area"><a href="#">���� M&amp;G ��������ճ����ֽ<br />AS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
			        		        
	            <td width="200" class="price">1.54</td>
	            <td width="190">10</td>
	            <td class="right_line price">15.4</td>
			      </tr>
	    		</table>
	      	
	      <!--.search_result-->	
	      </div>
	    	
	    	<h3>��ַ��Ϣ</h3>
	    	<div class="addrss_section">
		    	<div class="icon_action">
		    			<span class="icon_need">����Ҫ��</span>
		    			<span class="icon_logist">����Ҫ��</span>
		    			<span class="icon_self">������ȡ</span>	    			
		    		<!--.icon_action-->	
		    	</div>
		    	
		    	<div class="infor_top">
		    		<div class="infor_bottom">
		    			<div class="infor_area">
		    				<p class="cus_name">���� <span><b>������</b></span> �� ������ �� ��</p>
		    				<p>������ <span>����������·5��Զ������B��20���к���ó</span> 13811189077</p>
		    				<span class="icon_addr"><img src="${pageContext.request.contextPath}/static/img/management/icon-addr.png" /></span>
		    	    </div>
		    	  </div>
		    	</div>
		    	
		    	<!--.addrss_section-->	
	    	</div>
	    	
	    	
	    	<h3>��ַ��Ϣ</h3>
	    	<div class="addrss_section">
		    	<div class="icon_action">
		    			<span class="icon_need">��Ʊ����</span>
		    			<span class="icon_logist">��ͨ��Ʊ</span>
		    			<span class="icon_self">��ֵ˰��Ʊ</span>	
		    			<span class="icon_need">��Ʊ����</span>
		    			<span class="icon_logist">��ϸ</span>
		    			<span class="icon_self">�Զ���</span>    			
		    		<!--.icon_action-->	
		    	</div>
		    	
		    	<div class="infor_top">
		    		<div class="infor_bottom">
		    			<div class="infor_area">
		    				<dl>
		    					<dt>���λ����</dt>
		    					<dd>�к������ʾ�ó��չ���޹�˾</dd>
		    					<dt>˰��ǼǺ�</dt>
		    				</dl>
		    				<span class="icon_addr"><img src="${pageContext.request.contextPath}/static/img/management/icon-addr.png" /></span>
		    	    </div>
		    	  </div>
		    	</div>
		    	
		    	<!--.addrss_section-->	
	    	</div>    	
	    	
	    	
	    	
	    	<h3>������Ϣ</h3>
	      <div class="other_area">�������ɣ��۸����</div>
	      
	      <div class="gather_box">
	      	<div class="gather_inner">
	      		<p><span>ʵ���</span><span class="symbol">��</span><span class="price">84.91</span></p>
	      		<p><span>��������</span>���� ������ ������ ����������·5��Զ������B��20���к���ó</p>
	      		<p><span>�ջ��ˣ�</span>������ 13811189077</p>
	      	</div>
	      </div>
	      
	      <div class="btn_area"><button type="button" class="btn btn-default gray">�ر�</button></div>
	      
	      
	    	<!--.order_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>