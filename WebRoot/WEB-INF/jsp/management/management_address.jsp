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
<title>��ַ����|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_address.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/managementAddress.js"></script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
 <jsp:include page="header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
      <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="address" />
	  </jsp:include>
      <div id="matter_section">
      	<h2>��ַ����</h2>
      	<div class="btn-list section clearfix btn_add">
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="addMarketAddress();">������ַ</button></li>
            <li><button type="button" class="btn btn-default gray" onclick="delSomeAddress();">ɾ����ַ</button></li>
          </ul>
        <!--.search_area--></div>
      	<div class="search_result">
          <table border="0">
            <tr>
              <th width="30"><input id="checkAll" type="checkbox" onclick="checkAll();"></th>
              <th width="80">�ջ�������</th>
              <th width="320">�ջ��˵�ַ</th>
              <th width="120">��ϵ�绰</th>
              <th width="140">��Ӧ��</th>
              <th width="80">�Ƿ�Ĭ��</th>
              <th width="180">����</th>
            </tr>
            <c:forEach var="marketAddress" items="${marketAddresses}" varStatus="status">
	            <tr>
	              <td><input name="checkAddressIDs" type="checkbox" value="${marketAddress.addressID}"></td>
	              <td>${marketAddress.name}</td>
	              <td class="address">${marketAddress.areaLevelOneName}${marketAddress.areaLevelTwoName}${marketAddress.areaLevelThreeName}${marketAddress.areaLevelFourName}${marketAddress.addressDetail}</td>
	              <td>${marketAddress.phone}</td>
	              <td>${marketAddress.supName}</td>
	              <c:choose>
					   <c:when test="${marketAddress.ifDefault == '1'}">  
					        <td>��</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>��</td>
					   </c:otherwise>
				  </c:choose>
	              <td>
	              	  <a href="${pageContext.request.contextPath}/management/address/updAddressPage/${marketAddress.addressID}">�޸�</a>
	                  &nbsp;|&nbsp;
	                  <a href="${pageContext.request.contextPath}/management/address/delete/${marketAddress.addressID}">ɾ��</a>
	                  <c:if test="${marketAddress.ifDefault == '0'}">
					      &nbsp;|&nbsp;<a href="${pageContext.request.contextPath}/management/address/setDefault/${marketAddress.addressID}">����Ĭ��</a> 
					  </c:if>
				  </td>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
      	<!-- <div class="page">
          <ul class="pagination">
            <li><a href="#">&laquo;</a></li>
            <li class="active"><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
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