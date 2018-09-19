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
<title>���Ϲ���|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/management_myinfo.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="header.jsp" />
  <div id="contents">
    <div class="inner">
 <jsp:include page="menu.jsp" >
    	<jsp:param name="menu" value="" />
    	</jsp:include>
      <div id="matter_section">
        <div class="remind_title">
          <p class="txt_title">������ҵ������δ���ͨ�����޷�ʹ�ô˹���</p>
          <p>������ȥ������ҵ��Ϣ��<a href="${pageContext.request.contextPath}/supplier/companyMyInfo">ȥ����</a></p>
        </div>
      </div>
    </div>
  <!--#contents--></div>
<jsp:include page="footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>