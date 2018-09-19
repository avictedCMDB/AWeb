<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="����֪ͨ��" name="title" />
</jsp:include>

<link href="${pageContext.request.contextPath}/static/css/bid_notice.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/date.js"></script>

<script type="text/javascript">
    
</script>
</head>

<body>
<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
	<div id="nav_area">
    <div class="inner clearfix">
				<jsp:include page="../categorys.jsp" />
    </div>
	  <!--#nav_area--></div>
    <div id="contents">
        <div class="inner">
            <h2>����֪ͨ��</h2>
            <div class="article">
              <p class="txt txt01"><span>${sup.supName }</span></p>
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
              <p class="name">�к������ʾ�ó��չ���޹�˾</p>
              <div class="result_area clearfix">
                  <dl class="special clearfix">
                    <dt>��ַ : </dt>
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
                  <li><a class="btn btn-default blue" target="_blank" href="${pageContext.request.contextPath}/market/bid/result/print?projId=${proj.projId}">��ӡ</a></li>
                  <li><button class="btn btn-default gray_cart" onclick="window.close()">����</button></li>
               </ul>
            </div>
        </div>
    </div>
		<jsp:include page="../footer.jsp" />
</div>
</body>
</html>