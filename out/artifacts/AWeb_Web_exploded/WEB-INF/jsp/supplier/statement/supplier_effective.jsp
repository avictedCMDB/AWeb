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
<title>��Ӧ�̹�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	<h2>���㵥������Ϣ</h2>
    	<h3 class="title_h3">���㵥������Ϣ</h3>
        <div class="info_detail">
          <div class="txt_area">
            <div class="section_info">
              <label>���㵥��ţ�</label>
              <span>${supplierStatement.settleId}</span>
              <label>��Ӧ�̣�</label>
              <span>${sessionScope.supUsernamecn}</span>
              <label>�����</label>
              <span>${supplierStatement.settleAmount}Ԫ</span>
              <label>�������ڣ�</label>
              <span>${supplierStatement.dateStart}��${supplierStatement.dateEnd}</span>
            </div>
            
          </div>
      </div>
      <h3 class="title_h3">��Ʒ��ϸ��Ϣ</h3>
      <div class="search_result">
        <table class="details">
          <tr>
            <th width="120">ҵ����</th>
            <th width="120">ҵ������</th>
            <th width="120">�µ�����</th>
            <th>�ɹ���λ</th>
            <th width="90">������</th>
            <th width="90">�ܽ��</th>
          </tr>
          <c:forEach var="supplierStatementDetailed" items="${supplierStatementDetailedList}" varStatus="status">
				<tr>
	              <td>
	              <c:choose>
	              <c:when test="${supplierStatementDetailed.busiType == '1'}">  
					        <a href="${pageContext.request.contextPath}/supplier/order/detail?o=${supplierStatementDetailed.busiId}">${supplierStatementDetailed.busiId}</a>
					   </c:when>
					   <c:otherwise> 
					    	<a href="${pageContext.request.contextPath}/supplier/return/returnDetailedPage/${supplierStatementDetailed.busiId}">${supplierStatementDetailed.busiId}</a>
					   </c:otherwise>
					   </c:choose>
	              </td>
	             <c:choose>
					   <c:when test="${supplierStatementDetailed.busiType == '1'}">  
					        <td>����</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>�˿�</td>
					   </c:otherwise>
				  </c:choose>
	              <td>${supplierStatementDetailed.createTime}</td>
	              <td>${supplierStatementDetailed.companyName}</td>
	              <td>${supplierStatementDetailed.totalNum}</td>
	              <td><c:choose>
					   <c:when test="${supplierStatementDetailed.busiType == '1'}">  
					        
					   </c:when>
					   <c:otherwise> 
					    	-
					   </c:otherwise>
				  </c:choose>
	              ${supplierStatementDetailed.settleAmount}</td>
	            </tr>
			</c:forEach>
        </table>
        <p class="sum">�����ܽ�<span>${supplierStatement.settleAmount}Ԫ</span></p>
        <div class="btn_area"><button type="button" class="btn btn-default red" onclick="history.go(-1)">����</button></div>
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>