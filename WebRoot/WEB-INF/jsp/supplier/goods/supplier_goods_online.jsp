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
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_online.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierGoodsOnline.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	 <jsp:include page="../menu.jsp">
    <jsp:param name="menu" value="online" />
    </jsp:include>
      <div id="matter_section">
      	<h2>�Զ����¼�</h2>
      	<form id="queryForm" method="post">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>��Ʒ����</dt>
              <dd>
                  <input type="text" class="form-control" name="goodsName" value="${queryParam.goodsName}"/>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>��Ʒ״̬</dt>
              <dd>
                <select class="form-control" name="goodsStatus">
                  <option value="" <c:if test="${queryParam.goodsStatus == ''}"> selected="selected" </c:if>>����״̬</option>
                  <option value="1" <c:if test="${queryParam.goodsStatus == '1'}"> selected="selected" </c:if>>���ϼ�</option>
                  <option value="0" <c:if test="${queryParam.goodsStatus == '0'}"> selected="selected" </c:if>>���¼�</option>
                </select>
              </dd>
            </dl>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result">
      	<div class="btn_list">
            <ul class="clearfix">
              <li><button type="button" class="btn btn-default red" onclick="updateGoodsStatus('${pageContext.request.contextPath}/supplier/goodsOnline/updateGoodsStatus','1')">�ϼ�</button></li>
              <li><button type="button" class="btn btn-default red" onclick="updateGoodsStatus('${pageContext.request.contextPath}/supplier/goodsOnline/updateGoodsStatus','0')">�¼�</button></li>
              <li><button class="btn btn-default red" type="button" onclick="query('${pageContext.request.contextPath}/supplier/goodsOnline')">��ѯ</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="40"><input type="checkbox" onclick="checkAll();" id="checkAll"/></th>
              <th width="150">��Ʒ���</th>
              <th>��Ʒ����</th>
              <th width="150">��Ʒ����ʱ��</th>
              <th width="100" class="last">��Ʒ״̬</th>
            </tr>
            <c:forEach var="supplierGoodsInfo" items="${supplierGoodsInfoList}" varStatus="status">
	            <tr>
	             <td><input name="checkGoodsInfo" type="checkbox" value="${supplierGoodsInfo.supGoodsId}"/></td>
	              <td>${supplierGoodsInfo.supGoodsId}</td>
	              <td>${supplierGoodsInfo.goodsName}</td>
	              <td>${supplierGoodsInfo.createDate}</td>
	              <c:choose>
					   <c:when test="${supplierGoodsInfo.goodsStatus == '1'}">  
					        <td>���ϼ�</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>���¼�</td>
					   </c:otherwise>
				  </c:choose>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
      	<jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>