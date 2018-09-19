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
<link href="${pageContext.request.contextPath}/static/css/supplier_address.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierAddress.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp" >
    	<jsp:param name="menu" value="address" />
    	</jsp:include>
      <div id="matter_section">
      	<h2>地址库管理</h2>
      	<div class="search_result">
          <div class="state_list">
            <ul>
              <li><button class="btn btn-default red" type="button" onclick="redirectAddress('${pageContext.request.contextPath}/supplier/address/insertPage')">增加</button></li>
              <li><button class="btn btn-default gray" type="button" onclick="deleteAddressList('${pageContext.request.contextPath}/supplier/address/delete/')">删除</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="40"><input type="checkbox" onclick="checkAll();" id="checkAll"></th>
              <th width="200">收货人姓名</th>
              <th>收货地址</th>
              <th width="150">联系电话</th>
              <th width="100">是否默认地址</th>
              <th width="110" class="last">操作</th>
            </tr>
            <c:forEach var="supplierAddress" items="${supplierAddressList}" varStatus="status">
	            <tr>
	              <td><input name="checkAddressIDs" type="checkbox" value="${supplierAddress.supAddressId}"></td>
	              <td>${supplierAddress.supName}</td>
	              <td class="address">${supplierAddress.supAreaLevelOne}${supplierAddress.supAreaLevelTwo}${supplierAddress.supAreaLevelThree}${supplierAddress.supAddressDetail}</td>
	              <td>${supplierAddress.supIphone}</td>
	              <c:choose>
					   <c:when test="${supplierAddress.ifDefault == '1'}">  
					        <td>是</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>否</td>
					   </c:otherwise>
				  </c:choose>
	              <td>
	              	  <a href="javascript:void(0)" onclick="redirectAddress('${pageContext.request.contextPath}/supplier/address/updatePage/${supplierAddress.supAddressId}')">修改</a>
	                  <a href="javascript:void(0)" onclick="deleteAddress('${pageContext.request.contextPath}/supplier/address/delete/${supplierAddress.supAddressId}')">删除</a>
	                  <a href="javascript:void(0)" onclick="setDefault('${pageContext.request.contextPath}/supplier/address/setDefault/${supplierAddress.supAddressId}')">设置默认地址</a> 
				  </td>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
        <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
