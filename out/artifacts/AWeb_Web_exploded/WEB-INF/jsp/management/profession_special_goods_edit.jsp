<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>商品需求管理|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/profession_special_goods.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/professionSpecialGoods.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath}"/>
<input type="hidden" id="ID" name="ID" value="${offStandardRequire.ID}"/>
<div class="page-wrapper">
	<jsp:include page="header.jsp"/>
  
  <div id="contents">
    <div class="inner">
	  <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="offStandardRequire" />
	  </jsp:include>
	  
      <div id="matter_section">
      	<h2>发布商品需求</h2>
      	<div id="info_list">
          <div class="section_inner">
          	 <dl class="clearfix">
                  <dt>需求名称：</dt>
                  <dd>
					${offStandardRequire.goodsName}
                  </dd>
              </dl>
              <dl class="clearfix">
                  <dt>需求描述：</dt>
                  <dd>${offStandardRequire.goodsDescNew}</dd>
              </dl>
              <dl class="clearfix special">
                  <dt>商品附件：</dt>
                  <dd>
                  	<div class='up_img_list'>
	                  	<!-- 循环显示附件 -->
	                  	<c:forEach var="imageInfo" varStatus="status" items="${offStandardRequire.auditImageInfos}">
	                      	<ul class='clearfix'>	
	                      	
	                      		<li>
	                      			<c:choose>
	                      					<c:when test="${fn:contains(imageInfo.url.toLowerCase(),'.jpg')}">
	                      						<a href="javascript:void(0);" class='preview'><img src="${pageContext.request.contextPath}${imageInfo.url}"/></a>
	                      					</c:when>
	                      					<c:when test="${fn:contains(imageInfo.url.toLowerCase(),'.png')}">
	                      						<a href="javascript:void(0);" class='preview'><img src="${pageContext.request.contextPath}${imageInfo.url}"/></a>
	                      					</c:when>
	                      					<c:when test="${fn:contains(imageInfo.url.toLowerCase(),'.bmp')}">
	                      						<a href="javascript:void(0);" class='preview'><img src="${pageContext.request.contextPath}${imageInfo.url}"/></a>
	                      					</c:when>
	                      					<c:when test="${fn:contains(imageInfo.url.toLowerCase(),'.jpeg')}">
	                      						<a href="javascript:void(0);" class='preview'><img src="${pageContext.request.contextPath}${imageInfo.url}"/></a>
	                      					</c:when>
	                      					<c:when test="${fn:contains(imageInfo.url.toLowerCase(),'.gif')}">
	                      						<a href="javascript:void(0);" class='preview'><img src="${pageContext.request.contextPath}${imageInfo.url}"/></a>
	                      					</c:when>
	                      					<c:otherwise>
	                      						<a href="javascript:void(0);" class='preview'>${imageInfo.fileName}</a>
	                      					</c:otherwise>
	                      				</c:choose>
	                      		</li>
	                      	</ul>		
	                     </c:forEach>
                     </div>
                  </dd>
              </dl>
              <dl class="clearfix spectal_title">
                  <dt>是否公开：</dt>
                  <dd>
                    <input type="radio" name="isRelease" id="isRelease1" value="0" disabled <c:if test="${offStandardRequire.isRelease eq '0' || empty offStandardRequire.isRelease}">checked="checked"</c:if>  />不公开&nbsp;&nbsp;
					<input type="radio" name="isRelease" id="isRelease2" value="1" disabled <c:if test="${offStandardRequire.isRelease != '0' && !empty offStandardRequire.isRelease}">checked="checked"</c:if>/>公开
                  </dd>
                  <dt>截至日期：</dt>
                  <dd>
                      <div class="input-group">
                        <input class="form-control special_input" id="closeDate" name="closeDate" value="${offStandardRequire.closeDate}" type="text" readonly="readonly">
                        <span class="input-group-addon">
                          <i class="fa fa-calendar"></i>
                        </span>
                      </div>
                  </dd>
              </dl>
              
	              <dl class="clearfix" id="supDL">
                  <dt>选择供应商：</dt>
                  <dd>
                      <ul class="list_inner clearfix">
                      			<c:forEach var="supInfo" varStatus="status" items="${offStandardRequire.supInfos}">
                      				<li id="${supInfo.supID}">
										${supInfo.supName}</li>
                      			</c:forEach>
                      </ul>
                  </dd>
              </dl>
              <dl class="clearfix">
                  <dt>作废理由：</dt>
                  <dd><textarea id="cancelReason" name="cancelReason" class="form-control" rows="3"></textarea></dd>
              </dl>
              <div class="btn_list">
          <ul class="list-inline clearfix">
           	<li><button type="button" onclick="cancelReason('${pageContext.request.contextPath}');" class="btn btn-default add_btn">提交</button></li>
            
            <li><button type="button" onclick="window.location.href='${pageContext.request.contextPath}'+'/management/specialGoods/offStandardRequirePage';" class="btn btn-default add_btn">取消</button></li>
          </ul>
        </div>
          </div>
      </div>
      <!--#matter_section--></div>
    <!--.inner--></div>
  <!--#contents--></div>
  
  <jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>