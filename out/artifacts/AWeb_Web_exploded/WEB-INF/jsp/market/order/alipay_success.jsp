<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="֧���ɹ�" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/payment_online.css" rel="stylesheet">
</head>

<body>
<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
  <div id="nav_area">
    <div class="inner clearfix">
				<jsp:include page="../categorys.jsp" />
    </div>
    <!--#nav_area--></div>
  
  <div id="contents">
    <div class="inner">
      <div id="payment_details">
        <p class="success">
          <span class="img"><img src="${pageContext.request.contextPath}/static/img/order/icon-success.png" /></span>
          <span>${error}</span>
        </p>
        <div class="section_details">
          <ul>
            <li>�����ţ�<span>${orderId}</span></li>
            <li>֧����<span>��<fmt:formatNumber value="${payAmount}" pattern="#0.00#"></fmt:formatNumber></span></li>
            <li>֧����ʽ��
				<c:choose>
					<c:when test="${payGate == '0001'}">����֧��</c:when>
					<c:when test="${payGate == '0002'}">��ҵ֧��</c:when>
					<c:when test="${payGate == '0004'}">�޿�֧��</c:when>
					<c:when test="${payGate == '0005'}">֧����</c:when>
				</c:choose>
			</li>
          </ul>
        </div>
        <div class="section_details btn_list">
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="window.location.href='${pageContext.request.contextPath}/management/order'">���ض����б�</button></li>
          </ul>
        </div>
      <!--.order_details--></div>
      
      
      
      <!--.inner--> 
    </div>
    <!--#contents--> 
  </div>
 
		<jsp:include page="../footer.jsp" />
  <!--.page-wrapper--> 
</div>
</body>
</html>