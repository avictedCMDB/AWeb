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
<link href="${pageContext.request.contextPath}/static/css/supplier_return.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	<c:forEach var="image" items="${imageList}" varStatus="status">
		$("#img_${status.index}").imgbox();
	</c:forEach>

	});
</script>
</head>

<body>
<div class="page-wrapper">
 <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
	  <h2>�˻��鿴</h2>
      <div id="step"> 
    	<ul class="image_list clearfix">
    	  <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" /></li>
          <c:if test="${supplierReturn.refoundStatus >= '1' and supplierReturn.refoundStatus != '6'}"> <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" /></li> </c:if>
          <c:if test="${supplierReturn.refoundStatus < '1' or supplierReturn.refoundStatus == '6'}"> <li>2</li> </c:if>
          <c:if test="${supplierReturn.refoundStatus >= '3' and supplierReturn.refoundStatus != '6'}"> <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" /></li> </c:if>
          <c:if test="${supplierReturn.refoundStatus < '3' or supplierReturn.refoundStatus == '6'}"> <li>3</li> </c:if>
          <c:if test="${supplierReturn.refoundStatus >= '4' and supplierReturn.refoundStatus != '6'}"> <li class="selected"><img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" /></li> </c:if>
          <c:if test="${supplierReturn.refoundStatus < '4' or supplierReturn.refoundStatus == '6'}"> <li>4</li> </c:if>
    	</ul>
    	
    	<ul class="text_step clearfix">
    		<li>�ɹ����˻�����</li>
    		<li>��Ӧ��ȷ�����</li>
    		<li>�ɹ��˷������</li>
    		<li>��Ӧ���ջ����</li>
    	</ul>	      
    	<!--.replace_step-->	
      </div>
      <h3>�˻���������Ϣ</h3>
      <div class="info_detail">
        <div class="txt_area">
          <label>�˻����ţ�</label>
          <span>${supplierReturn.refoundId}</span>
          <label>�ɹ���λ��</label>
          <span>${supplierReturn.companyname}</span>
          <label>������ţ�</label>
          <span>${supplierReturn.orderId}</span>
          <label>��ϵ�ˣ�</label>
          <span>${supplierReturn.addrName}</span>
          <label>��ϵ�绰��</label>
          <span>${supplierReturn.addrPhone}</span>
          <label>������</label>
          <span></span>
        </div>
        <div class="txt_area">
          <label>��ע��</label>
          <span>${supplierReturn.remark}</span>
        </div>
        <div class="txt_area">
          <label>������</label>
          <span class="up_load_img">
          	<c:forEach var="image" items="${imageList}" varStatus="status">
          		<a id="img_${status.index}" href="${pageContext.request.contextPath}${image.url}"><img src="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></a>
          	</c:forEach>
          </span>
        </div>
      </div>
      <h3>�˻�����ϸ��Ϣ</h3>
      <div class="search_result">
        <table class="details">
          <tr>
            <th width="40">���</th>
            <th colspan="2">��Ʒ����</th>
            <th width="80">����(Ԫ)</th>
            <th width="80">�ɹ�����</th>
            <th width="80">�˻�����</th>
            <th width="80">�ܽ��(Ԫ)</th>
            <th width="180" class="last">�˻�ԭ��</th>
          </tr>
          <c:forEach var="supplierReturn" items="${supplierReturnList}" varStatus="status">
          <tr>
	          <td>${supplierReturn.rn}</td>
	          <td width="77" class="right_none"><p class="img_pro"><a href="#"><img src="${supplierReturn.imagePath}" width="44px" height="44px"/></a></p></td>
	          <td class="left_none"><a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${supplierReturn.supGoodsId}" target="_blank">${supplierReturn.goodsName}</a></td>
	          <td class="price"><fmt:formatNumber value="${supplierReturn.agreePrice}" pattern="#0.00#"/></td>
	          <td>${supplierReturn.buyNum}</td>
	          <td>${supplierReturn.refoundNum}</td>
	          <td class="price"><fmt:formatNumber value="${supplierReturn.sumRefoundPrice}" pattern="#0.00#"/></td>
	          <td>${supplierReturn.refoundReason}</td>
          </tr>
        </c:forEach>
        </table>
      </div>
      <div class="btn_area"><button type="button" class="btn btn-default gray" onclick="history.go(-1)">����</button></div>
    <!--.inner--></div>
  <!--#contents--></div>
 <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>