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
<title>首页|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/bid_help.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>
 
<body>
<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
			<div id="nav_area">
			<div class="inner clearfix" style="z-index:999;">
				<jsp:include page="../categorys.jsp" />
			</div>
    <!--#nav_area--></div>
  <div id="contents">
    <div class="inner">
      <div id="side_navi">
          <dl>
              <dt class="tlt_merchandise">帮助中心<span class="fa fa-caret-square-o-down"></span></dt>
              <dd class="last_child">
                <ul>
                  <li <c:if test="${type == '1'}"> class="active" </c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1"><span class="fa fa-caret-right"></span>供应商帮助</a></li>
                  <li <c:if test="${type == '0'}"> class="active" </c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=0"><span class="fa fa-caret-right"></span>采购帮助</a></li>
                  <li <c:if test="${type == '2'}"> class="active" </c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfoDownload?type=2"><span class="fa fa-caret-right"></span>资料下载</a></li>
                </ul>
              </dd>
            </dl>
        <!--#side_navi--></div>
        <div id="matter_section">
          <h2>资料下载</h2>
          <div class="question_list">
            <ul>
              <c:forEach var="helpInfo" items="${helpList}" varStatus="sta2">
              	<li><a href="${pageContext.request.contextPath}/market/help/downloadHelp?downFile=${helpInfo.filePath}&fileName=${helpInfo.fileName}">${helpInfo.title}</a></li>
              </c:forEach>
            </ul>
          </div>
          <jsp:include page="helpPage.jsp" />
        <!--#matter_section--></div>
    <!--.inner--></div>
  <!--#contents--></div>
		<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>