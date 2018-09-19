<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>支付|中航招标网</title>
</head>
<body>
<c:if test="${error == ''}">
正在跳转到支付平台......
<form action="${action}" method="post" id="pay_form">
<c:forEach items="${form}" var="item">
<input type="hidden" name="${item.key}" value="${item.value}"/>
</c:forEach>
</form>
<script type="text/javascript">
document.getElementById("pay_form").submit();
</script>
</c:if>
<c:if test="${error != ''}">
${error}
</c:if>
</body>
</html>