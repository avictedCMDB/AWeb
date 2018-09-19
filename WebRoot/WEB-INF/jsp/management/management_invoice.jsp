<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��ַ����|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_invoice.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/managementInvoice.js"></script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}">
<div class="page-wrapper">
  <jsp:include page="header.jsp" />  
  <div id="contents">
    <div class="inner">
      <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="invoice" />
	  </jsp:include>	
      <div id="matter_section">
      	<h2>��Ʊ����</h2>
      	<div class="btn-list section clearfix btn_add">
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="window.location.href = '${pageContext.request.contextPath}/management/invoice/addInvoicePage'">������Ʊ</button></li>
          </ul>
        <!--.search_area--></div>
      	<div class="search_result">
          <table border="0">
          	<tr>
              <th width="205">���λ����</th>
              <th width="225">��˰��ʶ���</th>
              <th width="205">��Ʊ����</th>
              <th>�Ƿ�Ĭ��</th>
              <th width="170">����</th>
            </tr>
           <c:forEach var="invoice" items="${invoices}" varStatus="status">
            <tr>
              <td class="address">${invoice.companyName}</td>
              <td>${invoice.invoiceNum}</td>
              <td>${invoice.invoiceContent}</td>
              <c:choose>
				<c:when test="${invoice.ifDefault == '1'}">  
					 <td>��</td>
				</c:when>
				<c:otherwise> 
					 <td>��</td>
				</c:otherwise>
			  </c:choose>
              <td>
              	<a href="${pageContext.request.contextPath}/management/invoice/udpateInvoicePage/${invoice.invoiceID}">�޸�</a>&nbsp;|&nbsp;
              	<a href="javascript:void(0);" onclick="deleteInv('${pageContext.request.contextPath}/management/invoice/delete/${invoice.invoiceID}')">ɾ��</a>
              	<c:if test="${invoice.ifDefault == '0'}">
              		&nbsp;|&nbsp;<a href="${pageContext.request.contextPath}/management/invoice/setDefault/${invoice.invoiceID}">����Ĭ��</a>
              	</c:if> 
              </td>
            </tr>
           </c:forEach>
          </table>
        <!--.search_result--></div>
      	<!-- <div class="page">
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
        </div> -->
        
        <jsp:include page="page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>