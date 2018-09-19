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
<title>�һ�����|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/find_password.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript">
<c:if test="${msg != null}">
alert("${msg}");
</c:if>
function goToPass(action){
	if ($('#userName').val() == '') {
		alert('�������û�����');
		return false;
	}
	if ($('#telNumber').val() == '') {
		alert('�������û�ע��ʱ�ֻ����룡');
		return false;
	}
	regex = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
	if (!regex.exec($('#telNumber').val())) {
		alert('�ֻ������ʽ����');
		return false;
	}
	document.getElementById("nextPage").action=action;
	document.getElementById("nextPage").submit();
}
</script>
</head>

<body>
<div class="page-wrapper">
  <div id="header_login">
    <div class="inner clearfix">
      <div class="logo">
        <h1><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���" style="cursor:pointer;" onclick="window.location.href='${pageContext.request.contextPath}/';"/><span>�һ�����</span></h1>
      </div>
      <div class="login_area">
        <a href="${pageContext.request.contextPath}/market/register">ע��</a>
        <c:if test="${userType == '1'}">
			<a href="${pageContext.request.contextPath}/passport/login">��¼</a>
		</c:if>
        <c:if test="${userType == '2'}">
			<a href="${pageContext.request.contextPath}/supplier/login">��¼</a>
		</c:if>
		<c:if test="${userType == '3'}">
			<a href="${pageContext.request.contextPath}/supervise/login">��¼</a>
		</c:if>
        <a href="${pageContext.request.contextPath}/market/help/indexHelpInfo?type=1">��������</a>
      </div>
      
    </div>
  </div>
  <div id="contents">
    <div class="inner clearfix">
      <div id="step">
          <ul class="image_list clearfix">
            <li class="selected"><a href="#"><span class="num">1</span><span class="text">��д�û���</span></a></li>
            <li><a href="#"><span class="num">2</span><span class="text">��֤����</span></a></li>
            <li><a href="#"><span class="num">3</span><span class="text">����������</span></a></li>
            <li class="finish"><a href="#"><span class="num"><img src="${pageContext.request.contextPath}/static/img/login/icon-finish.png"/></span><span class="text">���</span></a></li>
          </ul>
          <div class="line"></div>
        </div>
        <div class="input_area">
        <form id="nextPage">
          <dl class="clearfix special">
            <dt>�û�����</dt>
            <dd>
            <input class="form-control" type="hidden" name="userType" value="${userType}"/>
              <input class="form-control" placeholder="����дע��ʱ���û���" id="userName" type="text" name="userName" value="${userName}"/>
            </dd>
          </dl>
          <dl class="clearfix special">
            <dt>�ֻ����룺</dt>
            <dd>
              <input class="form-control" name="telNumber" id="telNumber" type="text" value="${telNumber}"/>
            </dd>
          </dl>
          </form>
          <button class="btn blue" onclick="goToPass('${pageContext.request.contextPath}/market/register/findPassword2')">��һ��</button>
        </div>
    </div>
  </div>
<!--.page-wrapper--></div>
</body>
</html>