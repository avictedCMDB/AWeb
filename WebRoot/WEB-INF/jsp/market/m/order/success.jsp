<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">


	<c:if test="${buyType == 1}">
		<c:if test="${success == true}">
			alert('提交成功！自采订单号为：${orderId}，该订单已生成，请注意签收');
		</c:if>
	</c:if>
	
	<c:if test="${buyType == 0}">
		<c:if test="${success == true}">
			<c:if test="${supType == 0}">alert('提交成功！您的订单号为：${orderId}该订单已预占成功请到网站端进行支付！')</c:if>
			<c:if test="${supType == 1}">alert('提交成功！您的订单号为：${orderId}该订单已提交到供应商进行审核操作！')</c:if>
			location.href = '${pageContext.request.contextPath}/management/order?order_status=99';
		</c:if>
	</c:if>
	
	<c:if test="${not success}">
		alert('下单失败：${msg}');
		history.go(-1);
	</c:if>
	
</script>