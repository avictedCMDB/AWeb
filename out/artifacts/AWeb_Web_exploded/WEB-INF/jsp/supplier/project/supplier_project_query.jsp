<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��Ŀ�鿴|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_get.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_lose.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script></link>
<style type="text/css">
.form-control[readonly]{
	background-color: #fff;
	cursor: pointer;
}
</style>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  
  
  
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../menu.jsp">
    	<jsp:param name="menu" value="project_over" />
    	</jsp:include>
      <div id="matter_section">
          <h2>��Ŀ�鿴</h2>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
                  <div class="form-group">
                     <label class="title">��Ŀ���ƣ�</label>
                     <span>${proj.projName }</span>
                  </div>
                  <div class="form-group">
                     <label class="title">��Ŀ��ţ�</label>
                     <span>${proj.projId }</span>
                  </div>
                  <div class="form-group">
                     <label class="title">�������ڣ�</label>
                     <span><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/> �� <fmt:formatDate value="${proj.timeoutEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                  </div>
                 
                  <div class="form-group">
                     <label class="title">��Ŀ״̬��</label>
                     <span>
                     <c:if test="${proj.projStatus == 5}">���ڱ�</c:if>
                     <c:if test="${proj.projStatus == 6}">�ѷϱ�</c:if>
                     <c:if test="${proj.projStatus == 7}">�Ѷ���</c:if>
                     <c:if test="${proj.projStatus == 9}">����ֹ</c:if>
                     </span>
                  </div>
                  <c:if test="${proj.projStatus == 6}">
                  <div class="form-group special_group01">
                     <label class="title">�ϱ����ɣ�</label>
                     <span>${proj.obsoleteReason }</span>
                  </div>
                  </c:if>
                  <c:if test="${proj.projStatus == 9}">
                  <div class="form-group special_group01">
                     <label class="title">��ֹ���ɣ�</label>
                     <span>${proj.terminateReason }</span>
                  </div>
                  </c:if>
              </div>
          </div>
          <div class="search_result">
            <table class="table_area">
              <tr>
                <th>��Ӧ������</th>
                <th width="150">���ձ���</th>
                <th width="120">�ɹ�Ԥ��</th>
                <th width="150">��֧���</th>
                <th width="120">�ۿ���</th>
              </tr>
              <c:forEach var="i" items="${list}">
              
              <tr <c:if test="${i.bidResult == 1}">class="red"</c:if>>
                <td>${i.supName}</td>
                <c:if test="${i.supCode == supCode }">
                <td>${i.realCurrentQuota }</td>
                <td>${proj.budget > 0 ? proj.budget : '��' }</td>
                <td>${proj.budget > 0 ? (proj.budget - i.realCurrentQuota) : '��' }</td>
                <td>
                <c:if test="${proj.budget > 0}">
				<fmt:formatNumber type="percent" value="${(proj.budget - i.realCurrentQuota) / proj.budget}" />
                </c:if>
                <c:if test="${proj.budget == 0}">
                ��
                </c:if>
                </td>
                </c:if>
                
                <c:if test="${i.supCode != supCode }">
                <td>***</td>
                <td>***</td>
                <td>***</td>
                <td>***</td>
                </c:if>
              </tr>
              </c:forEach>
            </table>
            <c:if test="${proj.projStatus != 6 and proj.projStatus != 9}">
            <p class="red">��ܰ��ʾ����ɫ��עΪ���굥λ�����˽⣡��</p>
            </c:if>
          </div>
          <div class="submit_btn">
              <ul>
                  <li><button class="btn btn-default gray_cart" onclick="history.go(-1);">����</button></li>
              </ul>
          </div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>

<iframe width="0" height="0" border="0" style="display: none;" name="upload_target" id="upload_target"></iframe>
	
</body>
</html>