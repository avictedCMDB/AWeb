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
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_info.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierInfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  <div id="contents">
    <div class="inner">
    	
    <jsp:include page="../menu.jsp">
    <jsp:param name="menu" value="goods" />
    </jsp:include>
      <div id="matter_section">
      	<h2>商品信息管理</h2>
      	<form id="supplierGoodsInfoQueryForm" method="post" enctype="multipart/form-data">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>商品名称</dt>
              <dd>
                <input type="text" class="form-control" name="goodsName" value="${queryParam.goodsName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
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
              <dt>商品状态</dt>
              <dd>
                <select class="form-control" name="goodsStatus">
                  <option value="" <c:if test="${queryParam.goodsStatus == ''}"> selected="selected" </c:if>>所有状态</option>
                  <option value="1" <c:if test="${queryParam.goodsStatus == '1'}"> selected="selected" </c:if>>已上架</option>
                  <option value="0" <c:if test="${queryParam.goodsStatus == '0'}"> selected="selected" </c:if>>已下架</option>
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>商品描述</dt>
              <dd>
                <input type="text" class="form-control" name="goodsDesc" value="${queryParam.goodsDesc}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>商品型号</dt>
              <dd>
                <input type="text" class="form-control" name="goodsModel" value="${queryParam.goodsModel}"/>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>创建时间</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" name="createDateStar" value="${queryParam.createDateStar}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>至</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" name="createDateEnd" value="${queryParam.createDateEnd}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supplier/goodsInfo')">查询</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">清空</button></li>
            </ul>
          </div>
          </form>
        <!--.search_area--></div>
      	<div class="search_result">
      	<c:if test="${sessionScope.loginSupType == '1'}">
          <div class="state_list">
             <ul>
              <li class="delete"><button class="btn btn-default red" type="button" onclick="opDialog('${pageContext.request.contextPath}/supplier/goodsInfo/uploadPage','850px','300px')">添加新商品</button></li>
            </ul>
          </div>
          </c:if>
           <table border="0">
            <tr>
              <th width="80">商品编号</th>
              <th>商品名称</th>
              <th width="120">商品品牌</th>
              <th width="120">协议价格</th>
              <th width="60">商品价格</th>
              <th width="60">商品状态</th>
              <th width="150" class="last">操作</th>
            </tr>
            <c:forEach var="supplierGoodsInfo" items="${supplierGoodsInfoList}" varStatus="status">
	            <tr>
	              <td>${supplierGoodsInfo.supGoodsId}</td>
	              <td>${supplierGoodsInfo.goodsName}<c:if test="${sessionScope.loginSupType == '1'}">(${supplierGoodsInfo.goodsModel})</c:if></td>
	              <td>${supplierGoodsInfo.brandName}</td>
	              <td>${supplierGoodsInfo.salePrice}</td>
	              <td>${supplierGoodsInfo.agreePrice}</td>
	              <c:choose>
					   <c:when test="${supplierGoodsInfo.goodsStatus == '1'}">  
					        <td>已上架</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>已下架</td>
					   </c:otherwise>
				  </c:choose>
	              <td>
	              	  <a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${supplierGoodsInfo.supGoodsId}" target="_blank">查看</a>
	                 <!--  <a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supplier/goodsInfo/queryPrice/${supplierGoodsInfo.supGoodsId}')">价格</a> -->
	                 <c:if test="${sessionScope.loginSupType == '1'}">
	                 	<a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supplier/goodsInfo/updatePage/${supplierGoodsInfo.supGoodsId}','750px','700px')">修改</a> 
	                 </c:if>
	                 <c:if test="${sessionScope.loginSupType != '1'}">
	                 	<a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supplier/goodsInfo/queryStore/${supplierGoodsInfo.supGoodsId}','900px','200px')">库存</a> 
	                 </c:if>
	                  <a href="javascript:void(0)" onclick="deleteGoods('${pageContext.request.contextPath}/supplier/goodsInfo/updateDeleteFlag/${supplierGoodsInfo.supGoodsId}','${supplierGoodsInfo.goodsStatus}')">删除</a> 
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
<!--.page-wrapper--></div>
<jsp:include page="../footer.jsp" />
</body>
</html>
