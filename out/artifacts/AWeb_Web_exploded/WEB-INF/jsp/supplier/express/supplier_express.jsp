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
<title>��Ӧ�̹�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_express.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp">
    	<jsp:param name="menu" value="express" />
    	</jsp:include>
      <div id="matter_section">
      	<h2>��ݹ�˾����</h2>
      	<div class="search_result">
          <div class="state_list">
            <ul>
              <li><button class="btn btn-default red" type="button" onclick="redirectPage('${pageContext.request.contextPath}/supplier/express/insertPage')">����</button></li>
              <li><button class="btn btn-default gray" type="button" onclick="deleteList('${pageContext.request.contextPath}/supplier/express/delete/')">ɾ��</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="40"><input type="checkbox" onclick="checkAll();" id="checkAll"></th>
              <th width="200">��ݹ�˾����</th>
              <th>��ݹ�˾����</th>
              <th width="200">�Ƿ�Ĭ�ϵ�ַ</th>
              <th width="200" class="last">����</th>
            </tr>
            <c:forEach var="supplierExpress" items="${supplierExpressList}" varStatus="status">
	            <tr>
	              <td><input name="checkIDs" type="checkbox" value="${supplierExpress.expressId}" ></td>
	              <td>${supplierExpress.expressCode}</td>
	              <td>${supplierExpress.expressName}</td>
	              <c:choose>
					   <c:when test="${supplierExpress.ifDefault == '1'}">  
					        <td>��</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>��</td>
					   </c:otherwise>
				  </c:choose>
	              <td><a href="javascript:void(0)" onclick="redirectPage('${pageContext.request.contextPath}/supplier/express/updatePage/${supplierExpress.expressId}')">�޸�</a>
	              <a href="javascript:void(0)" onclick="deleteData('${pageContext.request.contextPath}/supplier/express/delete/${supplierExpress.expressId}')">ɾ��</a></td>
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