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
	function nextPage3(action){
		if ($('#password').val() == '') {
			alert('���������룡');
			return false;
		}
		
		regex=/^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*]+$)[a-zA-Z\d!@#$%^&*]{6,15}$/;
		if (!regex.exec($('#password').val())) {
			alert('�����ʽ���󣬸�ʽΪ��ĸ+���֡���ĸ+�����ַ�������+�����ַ�������Ϊ6-15');
			return false;
		}
		
		if ($('#password').val() != $('#confirm').val()) {
			alert('������ȷ�����벻һ�£�');
			return false;
		}
		document.getElementById("nextPage3").action='${pageContext.request.contextPath}/market/register/findPassword4';
		document.getElementById("nextPage3").submit();
	}
</script>
</head>

<body>
<div class="page-wrapper">
  <div id="header_login">
    <div class="inner clearfix">
      <div class="logo">
        <h1><img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="�к��б���" style="cursor:pointer;" onclick="window.location.href='${pageContext.request.contextPath}/';" /><span>�һ�����</span></h1>
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
            <li class="selected"><a href="#"><span class="num">2</span><span class="text">��֤����</span></a></li>
            <li class="selected"><a href="#"><span class="num">3</span><span class="text">����������</span></a></li>
            <li class="finish"><a href="#"><span class="num"><img src="${pageContext.request.contextPath}/static/img/login/icon-finish.png"/></span><span class="text">���</span></a></li>
          </ul>
          <div class="line"></div>
        </div>
        <div class="input_area">
        <form id="nextPage3">
          <dl class="clearfix">
            <dt>�µ�¼���룺</dt>
            <dd>
              <input name="userType" type="hidden" value="${userType}"/>
               <input name="userName" type="hidden" value="${userName}"/>
              <input class="form-control code" type="password" name="password" id="password"/>
              <span>6-15λ�ַ���������ĸ�����ֺͷ������</span>
            </dd>
          </dl>
          <dl class="clearfix">
            <dt>��ȷ�����룺</dt>
            <dd>
              <input class="form-control code" type="password" name="confirm" id="confirm"/>
            </dd>
          </dl>
        </form>
          <button class="btn blue" onclick="nextPage3('${pageContext.request.contextPath}/market/register/findPassword3')">��һ��</button>
        </div>
    </div>
  </div>
<!--.page-wrapper--></div>
</body>
</html>

