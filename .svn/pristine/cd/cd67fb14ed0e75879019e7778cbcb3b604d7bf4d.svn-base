<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="../meta.jsp">
	<jsp:param value="公告" name="title" />
</jsp:include>
<script src="${pageContext.request.contextPath}/static/js/index_top.js"></script>

<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/news_more.css" rel="stylesheet">

	<script type="text/javascript">
		$(function() {

		});
	</script>
</head>

<body>
	<div class="page-wrapper">
		<jsp:include page="../header.jsp"/>

		<div id="content">
			<div class="inner clearfix">
				<div id="side_navi">
					<dl>
						<dt class="tlt_merchandise">公告<span class="fa fa-caret-square-o-down"></span></dt>
						<dd class="last_child">
							<ul>
								<li <c:if test="${type == '0' }"> class="active"</c:if>><a href="${pageContext.request.contextPath}/market/notice?type=0"><span class="fa fa-caret-right"></span>公告信息</a></li>
								<li <c:if test="${type == '1' }"> class="active"</c:if>><a href="${pageContext.request.contextPath}/market/notice?type=1"><span class="fa fa-caret-right"></span>公司动态</a></li>
							</ul>
    			        </dd>
    			    </dl>
    	        </div>
    	        <div id="matter_section">
    	        	<div class="news_list">
    	        		<ul>
    	        		<c:forEach var="i" varStatus="sta" items="${list }">    	        		
    	        			<li <c:if test="${sta.last }"> class="last"</c:if>><a href="${pageContext.request.contextPath}/market/notice/detail?id=${i.id}">${i.noticeSubject }</a><c:if test="${i.isTop == '0' }"><i><img src="${pageContext.request.contextPath}/static/img/icon-stick.png" alt=""></i></c:if><span><fmt:formatDate value="${i.publishDate}" pattern="yyyy-MM-dd"/></span></li>
    	        		</c:forEach>
    	        		</ul>
    	        	</div>
					<jsp:include page="page.jsp" />
    	        </div>
			<!-- .inner --></div>
		<!-- #content --></div>
		<jsp:include page="../footer.jsp" />
		<!--.page-wrapper-->
	</div>
	
</body>
</html>
