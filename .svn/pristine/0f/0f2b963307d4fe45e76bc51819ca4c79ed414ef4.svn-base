<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>采购监管平台|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_recommend.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/brandRecommend.js"></script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../../header.jsp" />
  <div id="header">
    <%-- <div class="inner clearfix">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/supervise/logo-supervise.png" alt="中航招标网" />
      </div>
      <div class="search">
        <img src="${pageContext.request.contextPath}/static/img/supplier/bnr-supplier.jpg" />
      </div>
    <!--.inner--></div> --%>
  <!--#header--></div>
  
  <input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../../left.jsp">
    		<jsp:param value="brand" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>品牌推荐</h2>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <form action="${pageContext.request.contextPath}/business/brand" id="searchForm" method="post">
            <dl class="clearfix">
              <dt>品牌名称：</dt>
              <dd>
                <input type="text" id="brand_name" name="brand_name" class="form-control" value="${searchBrand.brand_name}"/>
              </dd>
            </dl>
            <dl class="clearfix date_list">
              <dt>推荐时间：</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" id="begin_date" name="begin_date" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${searchBrand.begin_date}"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>至</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" id="end_date" name="end_date" class="form-control special_input"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${searchBrand.end_date}"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>是否推荐：</dt>
              <dd>
                <select class="form-control" id="if_recommand" name="if_recommand">
                    <option <c:if test="${empty searchBrand.if_recommand}">selected="selected"</c:if> value="">全部</option>
                    <option <c:if test="${searchBrand.if_recommand == '0'}">selected="selected"</c:if>value="0">是</option>
                    <option <c:if test="${searchBrand.if_recommand == '1'}">selected="selected"</c:if>value="1">否</option>
                </select>
              </dd>
            </dl>
            </form>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="search();">查询</button></li>
              <li><button type="reset" class="btn btn-default gray" onclick="clrAllVal();">清空</button></li>
            </ul>
          </div>
        </div>
        <div class="search_result">
          <table>
            <tr>
              <th>品牌名称</th>
              <th width="200">推荐时间</th>
              <th>品牌图片</th>
              <th width="100" class="last">操作</th>
            </tr>
            <c:forEach var="brand" items="${brands}" varStatus="status">
	            <tr>
	              <td width="300">${brand.brand_name}</td>
	              <td width="200">
	                  <c:if test="${brand.begin_date!=null && brand.begin_date!='' && brand.end_date!=null && brand.end_date!=''}">
	                  	${brand.begin_date} 至 ${brand.end_date}
	                  </c:if>
	              	 <c:if test="${brand.begin_date==null || brand.begin_date==''||brand.end_date==null || brand.end_date==''}">
	                  	-- 至 --
	                  </c:if>
	              </td>
	              <c:choose>
	                <c:when  test="${brand.brand_image != null}">
	                	<td width="180"><img src="${pageContext.request.contextPath}${brand.brand_image}" width="129" height="92" alt="" /></td>
	                </c:when>
	              	<c:otherwise>
	              		<td width="180"></td>
	              	</c:otherwise>
	              </c:choose>
	              
	              
	              <c:choose>
	                <c:when  test="${brand.if_recommand == 1}">
	                	<td width="90" class="last"><a href="javascript:void(0);" onclick="setBrandPage('${brand.brand_name}');">推荐</a></td>
	                </c:when>
	              	<c:otherwise>
	              		<td width="90" class="last"><a href="javascript:void(0);" onclick="cancleBrand(${brand.bid});">取消推荐</a></td>
	              	</c:otherwise>
	              </c:choose>
	              
	            </tr>
            </c:forEach>
          </table>
        </div>
        <jsp:include page="../../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>