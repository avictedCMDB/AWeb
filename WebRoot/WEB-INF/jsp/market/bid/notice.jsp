<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="../meta.jsp">
	<jsp:param value="���۲ɹ�" name="title" />
</jsp:include>

<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_announcement_form.css" rel="stylesheet">
</head>

<body>

  <div id="contents">
      <div class="inner">
          <div id="matter_section">
              <h2>���۹���</h2>
              <div class="section step_section" id="myproject">
                  <div class="list_inner clearfix">
                      <div class="form-group">
                          <label class="title">��Ŀ��ţ�</label>
                          <span>${proj.projId}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">��Ŀ���ƣ�</label>
                          <span>${proj.projName}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">�������ͣ�</label>
                          <span>${proj.projType == 2 ? '��������' : '���뾺��'}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">�������</label>
                          <span>�۸�����</span>
                      </div>
                      <div class="form-group">
                          <label class="title">���֣�</label>
                          <span>${proj.currencyName}</span>
                          <label class="title">���ʣ�</label>
                          <span>${proj.exchangeRate}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">�ɹ����</label>
                          <span>${proj.bidCatName}</span>
                      </div>
                  </div>
              </div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list01.png" alt="1">����ϸ�ľ�Ͷ��ͨ�����Ͼ���ƽ̨�μ����л���ľ���</h3>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list02.png" alt="2">���۵ı�ģ��ڱ��ּ�����Ҫ��</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">�������ޣ�</label>
                          <span>
                          <c:if test="${proj.quotaLimitType == 1}">����</c:if>
                          <c:if test="${proj.quotaLimitType == 2}">${proj.quotaLimitNum}</c:if>
                          </span>
                      </div>
                      <div class="form-group">
                          <label class="title">�������ͣ�</label>
                          <span>${proj.quotaType == 1 ? '������ı���' : '�����ı��ܼ�'}</span>
                      </div>
                      <table>
                      	  <tr>
                      	  	<th width="60">���</th>
                      	  	<th width="150">��ı��</th>
                      	  	<th width="200">�������</th>
                      	  	<th width="70">������λ</th>
                      	  	<th width="70">��������</th>
                      	  	<th >˵��</th>
                      	  	<th width="70" class="last">�����Ʒ</th>
                      	  </tr>
                      	  <c:forEach var="i" items="${subjects}" varStatus="sta">
                      	  <tr>
                      	  	<td>${sta.index + 1}</td>
                      	  	<td>${i.subjectId}</td>
                      	  	<td class="left">${i.subjectName}</td>
                      	  	<td>${i.subjectUnit}</td>
                      	  	<td>${i.subjectNum}</td>
                      	  	<td class="left">${i.intro}</td>
                      	  	<td ><a href="${pageContext.request.contextPath}/market/bid/notice/export/mtr?projId=${proj.projId}&subjectId=${i.subjectId}" target="_blank">�����Ʒ</a></td>
                      	  </tr>
                      	  </c:forEach>
                      </table>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list03.png" alt="3">����Ѻ�Ͷ�걣֤��</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">���۱�����ã�</label>
                          <span>${proj.tenderPrice}����ң��ۺ�Ų���</span>
                      </div>
                      <div class="form-group">
                          <label class="title">���۱�֤����ã�</label>
                          <span>${proj.bidBond}�����</span>
                      </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list04.png" alt="4">����۵���ֹ���ں�ʱ�����£�</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">��������ʱ�䣺</label>
                          <span><fmt:formatDate value="${proj.joinEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                      </div>
                      <div class="form-group">
                          <label class="title">���ۿ�ʼʱ�䣺</label>
                          <span><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                      </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list05.png" alt="5">���ξ�����Ŀ������Ҫ��</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">���߾���ʱ�䳤�ȣ�</label>
                          <span>${proj.bidDuration}����</span>
                      </div>
                      <div class="form-group">
                          <label class="title">��ʱ����ʱ������</label>
                          <span>${proj.timeoutInterval}��</span>
                      </div>
                      <div class="form-group">
                          <label class="title">��ͽ���ֵ��</label>
                          <span>
                          <c:if test="${proj.minIncrType == 1}">����</c:if>
                          <c:if test="${proj.minIncrType == 2}">${proj.minIncrVal}</c:if>
                          <c:if test="${proj.minIncrType == 3}">${proj.minIncrVal}%</c:if>
                          </span>
                      </div>
                      <div class="form-group">
                          <label class="title">��󽵼۷��Ȱٷֱ����ƣ�</label>
                          <span>${proj.quotaDecrLimit}%</span>
                      </div>
                      <div class="form-group">
                          <label class="title">���۴������ƣ�</label>
                          <span>
                          
                          <c:if test="${proj.timesLimitType == 1}">����</c:if>
                          <c:if test="${proj.timesLimitType == 2}">${proj.timesLimitNum}</c:if>
                          </span>
                      </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <div class="other">
                  	<h3>�����������ѯ����ϵ��</h3>
                  	<p>${user.companyName}<span>${user.contactPerson}</span></p>
                  	<div class="form-group">
                  	    <label class="title">�绰��</label>
                  	    <span>${user.contactNum}</span>
                  	</div>
                  	<div class="form-group">
                  	    <label class="title">���棺</label>
                  	    <span>${user.contactFax}</span>
                  	</div>
                  	<div class="form-group">
                  	    <label class="title">�����ʼ�</label>
                  	    <span><a href="mailto:${user.email}">${user.email}</a></span>
                  	</div>
                  </div>
              	
              <!--.list_notice--></div>
              
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>