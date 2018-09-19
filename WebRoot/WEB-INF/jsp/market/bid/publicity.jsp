<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="���۹�ʾ" name="title" />
</jsp:include>

<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_publicity.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/date.js"></script>

<script type="text/javascript">
    
</script>
</head>

<body>

  <div id="contents">
      <div class="inner">
          <div id="matter_section">
              <h2>���۹�ʾ</h2>
              <div class="section step_section" id="myproject">
                  <h3>${proj.projName }<br>
                  <span>����Ŀ��ţ�</span><span>${proj.projId }</span><span>����������ʾ</span>
                  </h3>
                  <p>
                    ��<span class="underline">${user.companyName }</span>ί�У�<span class="underline">�к��б���</span>�����Ͼ��۷�ʽ����<span class="underline">${proj.projName }</span>ʵʩ���۲ɹ����ֽ����۽����ʾ���£�
                  </p>
              </div>
              <div class="section list_notice">
                  <h4>1������ϸ�ľ�Ͷ��ͨ�����Ͼ���ƽ̨�μ����л���ľ���</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">��Ŀ���ƣ�</label>
                      <span>${proj.projName }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">��Ŀ��ţ�</label>
                      <span>${proj.projId }</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h4>2�����꣨��ɽ�����Ϣ</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">���깩Ӧ�����ƣ�</label>
                      <span>${sup.supName }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">���깩Ӧ�̵�ַ��</label>
                      <span>${sup.address }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">�����</label>
                      <span>${sup.realCurrentQuota }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">��Ҫ�����ɽ�������ơ�����ͺš����������ۡ�����Ҫ����߱�Ļ����ſ���</label>
                    </div>
                    <table>
                          <tr>
                            <th width="60">���</th>
                            <th width="150">��ı��</th>
                            <th width="200">�������</th>
                            <th width="70">������λ</th>
                            <th width="70">���۵�λ</th>
                            <th width="70">��������</th>
                            <th>˵��</th>
                            <th width="70" class="last">�����Ʒ</th>
                          </tr>
                    <c:forEach var="i" items="${subs}" varStatus="sta">
                          <tr>
                            <td>${sta.index + 1}</td>
                            <td>${i.subjectId }</td>
                            <td class="left">${i.subjectName }</td>
                            <td>${i.subjectUnit }</td>
                            <td>${i.subjectUnit }</td>
                            <td>${i.subjectNum }</td>
                            <td class="left">${i.intro }</td>
                            <td ><a href="${pageContext.request.contextPath}/market/bid/notice/export/mtr?projId=${proj.projId}&subjectId=${i.subjectId}" target="_blank">�����Ʒ</a></td>
                          </tr>
                    </c:forEach>
                      </table>
                  </div>
              <!--.list_notice--></div>

              <div class="section list_notice">
                  <h4>3���ɹ���λ�����ơ���ַ����ϵ��ʽ</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">�ɹ���λ���ƣ�</label>
                      <span>${proj.purchaserName }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">�ɹ���λ��ַ��</label>
                      <span>${proj.purchaserAddr }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">�ɹ���λ��ϵ�˺���ϵ��ʽ��</label>
                      <span>${proj.purchaserContact }</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h4>4���ɹ��������������ơ���ַ����ϵ��ʽ</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">�ɹ������������ƣ�</label>
                      <span>�к������ʾ�ó��չ���޹�˾</span>
                    </div>
                    <div class="form-group">
                      <label class="title">�ɹ�����������ַ��</label>
                      <span>�����г���������·5�ţ�Զ������B��14��</span>
                    </div>
                    <div class="form-group">
                      <label class="title">�ɹ�����������ϵ��ʽ��</label>
                      <span>��+86-10��84892588</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h4>5�����꣨��ɽ��������������</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <span>���꣨��ɽ�������Ĺ�ʾ����Ϊ${diff }�������ա�</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="img_seal">
                 <img src="${pageContext.request.contextPath}/static/img/bid/img_seal_sample02.jpg" alt="" />
                 <p class="right"><fmt:formatDate value="${proj.publicityDate}" pattern="yyyy��MM��dd��"/></p>
              </div>
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>