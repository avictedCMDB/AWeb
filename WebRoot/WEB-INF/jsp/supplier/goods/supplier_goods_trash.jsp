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
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_trash.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierGoodsTrash.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	 <jsp:include page="../menu.jsp">
    <jsp:param name="menu" value="trash" />
    </jsp:include>
      <div id="matter_section">
      	<h2>商品回收站</h2>
      	<form id="queryForm" method="post">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>商品名称</dt>
              <dd>
                <input type="text" class="form-control" name="goodsName" value="${queryParam.goodsName}"/>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>商品品牌</dt>
              <dd>
                <select class="form-control" name="brandName">
                  <option value="">所有品牌</option>
                  <c:forEach var="bankNameBean" items="${bankNameList}" varStatus="status">
				      <option value="${bankNameBean.brandName}" <c:if test="${bankNameBean.brandName == queryParam.brandName}"> selected="selected" </c:if>>${bankNameBean.brandName}</option>
				  </c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>商品描述</dt>
              <dd>
                  <input type="text" class="form-control" name="goodsDesc" value="${queryParam.goodsDesc}"/>
              </dd>
            </dl>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result">
          <div class="btn_list">
            <ul class="clearfix">
            <li><button type="button" class="btn btn-default red" onclick="returnGoodsDelete('${pageContext.request.contextPath}/supplier/goodsTrash/updateGoodsReturnDelete')">还原</button></li>
              <li><button class="btn btn-default red" type="button" onclick="query('${pageContext.request.contextPath}/supplier/goodsTrash')">查询</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th width="90"><input type="checkbox" onclick="checkAll();" id="checkAll"/></th>
              <th width="200">商品编号</th>
              <th>商品名称</th>
              <th width="150" class="last">商品品牌</th>
            </tr>
			<c:forEach var="supplierGoodsInfo" items="${supplierGoodsInfoList}" varStatus="status">
	            <tr>
	             <td><input name="checkGoodsInfo" type="checkbox" value="${supplierGoodsInfo.supGoodsId}"/></td>
	              <td>${supplierGoodsInfo.supGoodsId}</td>
	              <td>${supplierGoodsInfo.goodsName}</td>
	              <td>${supplierGoodsInfo.brandName}</td>
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
