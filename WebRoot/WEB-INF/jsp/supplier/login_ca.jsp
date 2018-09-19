<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>登录|中航采购网</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/login.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/bjca/date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bjca/SecX_Common.js"></script>

<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
var strServerSignedData = "${sign}";
var strServerRan = "${random}";
var strServerCert = "${cert}";
function LoginForm_onsubmit() {
	var ret;
	var strContainerName = LoginForm.UserList.value;
	var strPin = LoginForm.UserPwd.value;

	ret = Login(LoginForm,strContainerName,strPin);
	LoginForm.UserPwd.value = "";
	if(!ret)
	{
		return false;
	}
	else
		return true;

}


<c:if test="${error != null}">
	alert("${error}");
</c:if>
<c:if test="${href != null}">
	<c:if test="${href == '0'}">
	window.location.href = "${pageContext.request.contextPath}/supplier/index";
	</c:if>
	<c:if test="${href != '0'}">
	window.location.href = "${pageContext.request.contextPath}${href}";
	</c:if>
</c:if>
</script>
</head>
<body>
<div class="page-wrapper">
  <div id="header_login">
    <div class="inner">
      <h1>      
        <img src="${pageContext.request.contextPath}/static/img/index_top/img-logo.png" alt="中航招标网" style="cursor:pointer;" onclick="window.location.href='${pageContext.request.contextPath}/';"/>
      </h1>
    </div>
  </div>
  <div id="contents">
    <div class="inner clearfix">
      <div class="img_left"><img src="${pageContext.request.contextPath}/static/img/login/bg-login.png" /></div>
      <div class="login_box">
        <h2><img src="${pageContext.request.contextPath}/static/img/login/title-login_gys.png" alt="用户登录" /></h2>
        <div class="login_inner">
          <div class="inner_bottom">
			<form method="post" ID="LoginForm" name="LoginForm" action="${pageContext.request.contextPath}/supplier/login/ca/submit"
									onsubmit="return LoginForm_onsubmit()">
				<div class="input-group">
					<span class="input-group-addon"><i class="fa fa-user"></i></span> 
					<select id="UserList" name="UserList" class="form-control">
					</select>
				</div>
				<div class="input-group">
					<span class="input-group-addon"><i class="fa fa-lock" style="margin-left:2px;"></i></span> 
					<input type="password" name="UserPwd" id="UserPwd" class="form-control"
						maxlength="16">
				</div>
				<div class="btn_area">
					<button type="submit" class="btn btn_login" id="ca_login" style="margin-top:20px;">CA登录</button>
				</div>
									<input type="hidden" ID="UserSignedData" name="UserSignedData">
									<input type="hidden" ID="UserCert" name="UserCert">
									<input type="hidden" ID="ContainerName" name="ContainerName">
									<input type="hidden" name="redirect" value="${redirect}"/>
			</form>
		</div>
        </div>
      </div>
    </div>
  </div>
<!--.page-wrapper--></div>
<SCRIPT LANGUAGE=JAVASCRIPT event=OnLoad for=window>
		GetList("LoginForm.UserList");
		LoginForm.UserPwd.focus();
</SCRIPT>
		
<SCRIPT FOR=XTXAPP EVENT=OnUsbkeyChange LANGUAGE=javascript>
	
  ChangeUserList("LoginForm.UserList");
  LoginForm.UserPwd.focus();
</SCRIPT>
</body>
</html>
