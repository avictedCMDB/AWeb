<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="���㵥�鿴" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
	
	$(".eff-btn").click(function () {
		var ids = [];
		ids.push($(this).attr("data-id"))
		submit_eff(ids);
		
		return false;
	});
});

var submit_eff = function (ids) {
	if (confirm("�Ƿ�ȷ����Ч��ǰѡ�����㵥��")) {
		
		async('${pageContext.request.contextPath}/supervise/settle/effective/submit', {ids:ids.join(",")}, function (msg) {
			alert(msg.result);
			window.location.reload();
		});
	}
}
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	<h2>���㵥������Ϣ</h2>
    	<h3 class="title_h3">���㵥������Ϣ</h3>
        <div class="info_detail">
          <div class="txt_area">
            <div class="section_info">
              <label>���㵥��ţ�</label>
              <span>${record.settleId}</span>
              <label>��Ӧ�̣�</label>
              <span>${record.supName}</span>
              <label>�����</label>
              <span><fmt:formatNumber value="${record.settleAmount}" pattern="#0.00#"></fmt:formatNumber>Ԫ</span>
              <label>�������ڣ�</label>
              <span>${record.dateStart}��${record.dateEnd}</span>
            </div>
            
          </div>
      </div>
      <h3 class="title_h3">��Ʒ��ϸ��Ϣ</h3>
      <div class="search_result">
        <table class="details">
          <tr>
            <th width="70">˳��</th>
            <th width="120">ҵ����</th>
            <th width="120">ҵ������</th>
            <th width="120">�µ�����</th>
            <th>�ɹ���λ</th>
            <th width="90">������</th>
            <th width="90">�ܽ��</th>
            <th class="last" width="90">����</th>
          </tr>
          <c:forEach varStatus="sta" var="item" items="${items}">
          <tr>
            <td>${sta.index + 1}</td>
            <td>
				<c:if test="${item.busiType == 1}">
              		<a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.busiId}&t=1">
              	</c:if>
				<c:if test="${item.busiType == 2}">
              		<a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.busiId}&t=1">
              	</c:if>
              	${item.busiId}</a>
            </td>
            <td>
				<c:if test="${item.busiType == 1}">����</c:if>
				<c:if test="${item.busiType == 2}">�˿�</c:if>
			</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.createTime}" /></td>
            <td>${item.companyName }</td>
            <td>${item.totalNum}</td><td><c:if test="${item.busiType == 2}">-</c:if><fmt:formatNumber value="${item.settleAmount}" pattern="#0.00#"></fmt:formatNumber></td>
              <td>
				<c:if test="${item.busiType == 1}">
              		<a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.busiId}&t=1">
              	</c:if>
				<c:if test="${item.busiType == 2}">
              		<a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.busiId}&t=1">
              	</c:if>�鿴</a></td>
          </tr>
          </c:forEach>
        </table>
        <p class="sum">�����ܽ�<span><fmt:formatNumber value="${record.settleAmount}" pattern="#0.00#"></fmt:formatNumber>Ԫ</span></p>
        <div class="btn_area">
        <c:if test="${record.settleStatus == 1}">
        <button type="button" class="btn btn-default red eff-btn" data-id="${record.settleId}">��Ч</button>
        </c:if>
        <button type="button" class="btn btn-default red" onclick="history.go(-1);">�ر�</button>
        </div>
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
