<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>资料管理|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_myinfo.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
		<jsp:include page="../left_menu.jsp">
    		<jsp:param name="menu" value="myinfo" />
    	</jsp:include>
      <div id="matter_section">
        <div id="step">
          <ul class="image_list clearfix">
            <li><a href="${pageContext.request.contextPath}/management/companyMyInfo"><span class="num">1</span><span class="text">完善企业基本信息</span></a></li>
            <li><a href="${pageContext.request.contextPath}/management/companyMyInfo?witchPage='2'"><span class="num">2</span><span class="text">上传企业证件</span></a></li>
            <li  class="selected"><a href="#"><span class="num">3</span><span class="text">查看审核状态</span></a></li>
          </ul>
                    <div class="line"></div> 
        </div>
        <div class="remind_title remind_title2">
          <p class="txt_title">您的企业资料保存失败，请检查资料填写是否正确。</p>
          	<p>您可以去完善企业信息，<a href="${pageContext.request.contextPath}/management/companyMyInfo">去完善</a></p>
        </div>
        <div class="btn_area">
          <button class="btn btn-default gray" type="button" onclick="window.location.href='${pageContext.request.contextPath}/management/companyMyInfo'">返回</button>
        </div>
      </div>
    </div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>