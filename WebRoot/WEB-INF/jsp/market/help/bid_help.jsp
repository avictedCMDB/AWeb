<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��ҳ|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_help.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
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
    <!--#nav_area-->
  </div>
  <div id="contents">
    <div class="inner">
      <div id="side_navi">
          <dl>
              <dt class="tlt_merchandise">��������<span class="fa fa-caret-square-o-down"></span></dt>
              <dd class="last_child">
                <ul>
                  <li <c:if test="${type == '1'}"> class="active" </c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1"><span class="fa fa-caret-right"></span>��Ӧ�̰���</a></li>
                  <li <c:if test="${type == '0'}"> class="active" </c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=0"><span class="fa fa-caret-right"></span>�ɹ�����</a></li>
                  <li <c:if test="${type == '2'}"> class="active" </c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfoDownload?type=2"><span class="fa fa-caret-right"></span>��������</a></li>
                </ul>
              </dd>
            </dl>
        <!--#side_navi--></div>
        <div id="matter_section">
          <h2>��������</h2>
          <form action="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=${type}" id="queryFrom">
	          <div class="search_area">
	            <div class="search_inner">
	              <div class="input_area input-group">
	              	  <input name="type" value="${type}" type="hidden">
	                  <input type="text" class="form-control" name="title" value="${helpInfo.title}">
	                  <span class="input-group-btn">
	                    <button class="btn btn-default blue" type="button" onclick="document.getElementById('queryFrom').submit();">����</button>
	                  </span>
	              </div>
	            </div>
	          </div>
          </form>
          <div class="quick_search">
            <ul class="clearfix">
            	<c:forEach var="helpType" items="${helpTypeList}" varStatus="sta2">
              			<c:if test="${type == '0'}">
              			<li <c:if test="${helpInfo.helpTypeBuyer == helpType.codeValue}">class="active"</c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=${type}&helpTypeBuyer=${helpType.codeValue}">${helpType.codeText}</a></li>
              			</c:if>
              			<c:if test="${type == '1'}">
              			<li <c:if test="${helpInfo.helpTypeSup == helpType.codeValue}">class="active"</c:if>><a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=${type}&helpTypeSup=${helpType.codeValue}">${helpType.codeText}</a></li>
              			</c:if>
              </c:forEach>
            </ul>
          </div>
          <div class="question_list">
            <ul>
              <c:forEach var="helpInfo" items="${helpList}" varStatus="sta2">
              	<li><a href="${pageContext.request.contextPath}/market/help/helpInfoDetails?type=${type}&id=${helpInfo.id}">${helpInfo.title}</a></li>
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