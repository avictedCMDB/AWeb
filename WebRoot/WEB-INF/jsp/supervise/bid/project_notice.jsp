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
<title>����֪ͨ��|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_get_notice.css" rel="stylesheet">

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
	$("#submit_btn").click(function () {

		async('${pageContext.request.contextPath}/management/bid/project/notice/submit', {
			projId:'${proj.projId}'
		}, function (msg) {
			alert("�����ɹ�");
			history.go(-1);
		});
	});
});
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  
    
    <div id="contents">
        <div class="inner">
      <jsp:include page="../left.jsp"/>
            <div id="matter_section">
              <h2>����֪ͨ��</h2>
              <div class="article">
                <p class="txt txt01"><span>${sup.supName}</span>��˾</p>
                <p class="txt">�㷽��<span><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy"/></span>��<span><fmt:formatDate value="${proj.bidStartTime}" pattern="MM"/></span>��<span><fmt:formatDate value="${proj.bidStartTime}" pattern="dd"/></span>�գ��μӡ�<span>${proj.projName }</span>�����Ӿ��ۣ���ȷ��Ϊ�ɽ��ˣ����βɹ����̷���&laquo;�л����񹲺͹���Ͷ�귨&raquo;��&laquo;�����б귨&raquo;��&laquo;�����ɹ���&raquo;���йط��ɷ���Ĺ涨��</p>
                <div class="info">
                  <p class="txt01">�����������</p>
                  <table class="table_area">
                    <tr>
                      <th width="150">�����</th>
                      <th>Ʒ��</th>
                      <th width="90">��������</th>
                      <th width="90">���굥λ</th>
                      <th width="90">��֤��</th>
                      <th width="90">���׷�</th>
                      <th class="last" width="150">�ɽ���</th>
                    </tr>
                    <c:forEach var="i" items="${subs}" varStatus="sta">
                    <tr>
                      <td>${i.subjectId }</td>
                      <td>${i.subjectName }</td>
                      <td>${i.subjectNum }</td>
                      <td>${sup.supName }</td>
                      <td>${proj.bidBond }</td>
                      <td>0</td>
                      <c:if test="${sta.index == 0}">
                      <td rowspan="${fn:length(subs)}">${sup.realCurrentQuota}</td>
                      </c:if>
                    </tr>
                    </c:forEach>
                  </table>
                </div>
                <p class="txt02">�ش�֪ͨ��</p>
                <div class="img_seal">
                   <img src="${pageContext.request.contextPath}/static/img/bid/img_seal_sample02.jpg" alt="" />
                   <p class="right"><fmt:formatDate value="${proj.noticeTime}" pattern="yyyy��MM��dd��"/></p>
                </div>
              </div>
              <div class="saler">
                <p class="name">${user.companyName }</p>
                <div class="result_area clearfix">
                    <dl class="special clearfix">
                      <dt>��ַ��</dt>
                      <dd>${user.address }</dd>
                    </dl>
                    <dl class="clearfix">
                      <dt>�绰��</dt>
                      <dd>${user.contactNum }</dd>
                    </dl>
                    <dl class="clearfix">
                      <dt>���棺</dt>
                      <dd>${user.contactFax }</dd>
                    </dl>
                </div>
              </div>
              <div class="saler">
                <p class="name">�к������ʾ�ó��չ���޹�˾</p>
                <div class="result_area clearfix">
                    <dl class="special clearfix">
                      <dt>��ַ��</dt>
                      <dd>�����г���������·5�ţ�Զ������B��14��</dd>
                    </dl>
                    <dl class="clearfix">
                      <dt>�绰��</dt>
                      <dd>��+86-10��84892588</dd>
                    </dl>
                    <dl class="clearfix">
                      <dt>���棺</dt>
                      <dd>��+86-10��84892589��84892590</dd>
                    </dl>
                </div>
              </div>
              <div class="submit_btn">
                 <ul>
                 <c:if test="${proj.projStatus == 5}">
                    <li><button class="btn btn-default blue" id="submit_btn">����</button></li>
                 </c:if>
                    <li><button class="btn btn-default gray_cart" onclick="history.go(-1)">����</button></li>
                 </ul>
              </div>
            </div>
        </div>
    </div>
  <jsp:include page="../footer.jsp"/>
</div>
</body>
</html>