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
<link href="${pageContext.request.contextPath}/static/css/news_details.css" rel="stylesheet">

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
				<div class="path">
					<ul class="clearfix">
						<li><a href="${pageContext.request.contextPath}/">首页</a><span>></span></li>
						<li><a href="${pageContext.request.contextPath}/market/notice?type=${data.noticeType}">平台公告</a><span>></span></li>
						<li>${data.noticeSubject }</li>
					</ul>
				</div>
				<div class="main_inner">
					<h2>${data.noticeSubject }</h2>
					<p class="time">发布时间<span><fmt:formatDate value="${data.publishDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span><span> ${data.browseCount }次阅读</span></p>
					<div class="article" id="notice_content">
						
						${data.contentString }
					</div>
						<div class="bdsharebuttonbox" data-tag="share_1">
							<a class="bds_mshare" data-cmd="mshare"></a>
							<a class="bds_qzone" data-cmd="qzone" href="#"></a>
							<a class="bds_tsina" data-cmd="tsina"></a>
							<a class="bds_baidu" data-cmd="baidu"></a>
							<a class="bds_renren" data-cmd="renren"></a>
							<a class="bds_tqq" data-cmd="tqq"></a>
							<a class="bds_more" data-cmd="more">更多</a>
						</div>
						<script>
							window._bd_share_config = {
								common : {
									bdText : '${data.noticeSubject }',	
									bdDesc : '',	
									bdUrl : window.location.href, 	
									bdPic : ''
								},
								share : [{
									"bdSize" : 32
								}],
								slide : [{	   
									bdImg : 0,
									bdPos : "right",
									bdTop : 100
								}],
								image : [{
									viewType : 'list',
									viewPos : 'top',
									viewColor : 'black',
									viewSize : '16',
									viewList : ['qzone','tsina','huaban','tqq','renren']
								}],
								selectShare : [{
									"bdselectMiniList" : ['qzone','tqq','kaixin001','bdxc','tqf']
								}]
							}
							with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
						</script>
				</div>
			<!-- .inner --></div>
		
		<!-- #content --></div>
		<jsp:include page="../footer.jsp" />
		<!--.page-wrapper-->
	</div>
	
</body>
</html>
