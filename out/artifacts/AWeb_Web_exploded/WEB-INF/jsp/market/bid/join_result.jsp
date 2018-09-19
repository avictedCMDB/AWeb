<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="½á¹û" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/order.css" rel="stylesheet">
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
      <div id="order_details">
        <p class="success"><span class="img">
	      <c:if test="${success == true}">
      <img src="${pageContext.request.contextPath}/static/img/order/icon-success.png" /></span>${msg}   
	      </c:if>
      <c:if test="${success == false}">
      <img src="${pageContext.request.contextPath}/static/img/order/icon-fail.png" /></span>${msg}      
      </c:if>
      </p>
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