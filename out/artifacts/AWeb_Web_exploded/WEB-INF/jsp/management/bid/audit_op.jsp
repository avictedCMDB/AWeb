<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��Ӧ�̱������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_project_check.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/common.js"></script>
<script type="text/javascript">
$(function () {
	$("#audit_pass, #audit_fail").click(function () {
		var failReason = $.trim($("#fail_reason").val());
		if (failReason == "") {
			alert("������������");
			return false;
		}
		
		if (confirm("ȷ��" + $(this).text() + "�˹�Ӧ�̵ı�����Ϣ��")) {
			
			async('${pageContext.request.contextPath}/management/bid/audit/submit', {
				projId:'${proj.projId}',
				supCode:'${sup.supCode}',
				failReason:failReason,
				result:$(this).attr("id") == "audit_pass" ? 2 : 3
			}, function (msg) {
				alert("�����ɹ�");
				history.go(-1);
			});
		}
	});
});
</script>

</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  

  <div id="contents">
      <div class="inner">
      <jsp:include page="../left_menu.jsp"/>
          <div id="matter_section">
              <div class="result_section section">
                  <div class="result_inner">
                      <table class="table_area">
                        <tr>
                          <td colspan="6" class="name">${proj.projName}</td>
                        </tr>
                        <tr>
                          <th>Ͷ�굥λ</th>
                          <td colspan="5">${supInfo.supName}</td>
                        </tr>
                        <tr>
                          <th>����ʱ��</th>
                          <td colspan="3"><fmt:formatDate value="${sup.joinTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                          <th>��ϵ��</th>
                          <td>${supInfo.contactPerson}</td>
                        </tr>
                        <tr>
                          <th>�绰</th>
                          <td colspan="3">${supInfo.contactNum}</td>
                          <th>����</th>
                          <td>${supInfo.email}</td>
                        </tr>
                        <tr>
                          <th>������</th>
                          <td>${proj.tenderPrice > 0 ? proj.tenderPrice : '�޲���ɷ�'}</td>
                          <th>�ɷ�����</th>
                          <td>��</td>
                          <th>״��</th>
                          <td>��</td>
                        </tr>
                         <tr>
                          <th>��֤��</th>
                          <td>${proj.bidBond > 0 ? proj.bidBond : '�޲���ɷ�'}</td>
                          <th class="last">�ɷ�����</th>
                          <td class="last">��</td>
                          <th class="last">״��</th>
                          <td class="last">��</td>
                        </tr>
                        <tr>
                           <th>���״̬</th>
                           <td colspan="5">
                           <c:if test="${sup.auditStatus == 1}">�����</c:if>
                           <c:if test="${sup.auditStatus == 2}">���ͨ��</c:if>
                           <c:if test="${sup.auditStatus == 3}">��˲�ͨ��</c:if>
                           </td>
                        </tr>
                        <tr>
                           <th class="last">������</th>
                           <td colspan="5" class="last"><textarea class="form-control" id="fail_reason" rows="3" <c:if test="${sup.auditStatus > 1}">disabled="disabled"</c:if>>${sup.failReason}</textarea></td>
                        </tr>
                      </table>
                           <c:if test="${sup.auditStatus == 1}">
                      <div class="submit_btn">
                          <ul>
                              <li><button class="btn btn-default gray_cart" id="audit_pass">ͨ��</button></li>
                              <li><button class="btn btn-default blue" id="audit_fail">�ܾ�</button></li>
                          </ul>
                      </div>
                      </c:if>
                  </div>
                  
              </div>
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>