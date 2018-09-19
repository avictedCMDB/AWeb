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
<title>���۹�ʾ|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_publicity_input.css" rel="stylesheet">

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
<style>
#attach_field, #file_name {
	width:200px;
	display:inline-block;
}
</style>
<script type="text/javascript">

$(function () {
	$("#submit_btn").click(function () {
		var proj_id = $("#proj_id").val();
		var sup_id = $("#sup_id").val();
		var publicity_start = $("#publicity_start").val();
		var publicity_end = $("#publicity_end").val();
		var purchaser_name = $.trim($("#purchaser_name").val());
		var purchaser_addr = $.trim($("#purchaser_addr").val());
		var purchaser_contact = $.trim($("#purchaser_contact").val());
		
		if (purchaser_name == "") {
			alert("������ɹ���λ����");
			return false;
		}
		
		if (purchaser_addr == "") {
			alert("�ɹ���λ��ַ");
			return false;
		}
		
		if (purchaser_contact == "") {
			alert("�ɹ���λ��ϵ�˺���ϵ��ʽ");
			return false;
		}
		

		async('${pageContext.request.contextPath}/management/bid/project/publicity/submit', {
			proj_id:proj_id,
			sup_id:sup_id,
			publicity_start:publicity_start,
			publicity_end:publicity_end,
			purchaser_name:purchaser_name,
			purchaser_addr:purchaser_addr,
			purchaser_contact:purchaser_contact
		}, function (msg) {
			alert("�����ɹ�");
			history.go(-2);
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
          <h2>���۹�ʾ</h2>
          <div class="step_section section" id="step01">
              <div class="section step_section" id="myproject">
                  <h3>${proj.projName}<br>
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
                      <span>${psup.realCurrentQuota }</span>
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
                            <th class="last">˵��</th>
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
                          </tr>
                    </c:forEach>
                      </table>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h4>3���ɹ���λ�����ơ���ַ����ϵ��ʽ</h4>
                  <div class="notice_inner">
                    <div class="form-group clearfix">
                      <label class="title title_area">�ɹ���λ���ƣ�</label>
                      <span><input class="form-control input_area" id="purchaser_name" value="${user.companyName }"></span>
                    </div>
                    <div class="form-group clearfix">
                      <label class="title title_area">�ɹ���λ��ַ��</label>
                      <span><input class="form-control input_area" id="purchaser_addr" value="${user.address }"></span>
                    </div>
                    <div class="form-group clearfix">
                      <label class="title title_area">�ɹ���λ��ϵ�˺���ϵ��ʽ��</label>
                      <span><input class="form-control input_area" id="purchaser_contact" value="${user.responsibleName }��${user.responsibleMobile }��"></span>
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
                      <span>���꣨��ɽ�������Ĺ�ʾ����Ϊ${day}�������ա�</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
                          
          </div>
          <input type="hidden" id="sup_id" value="${sup.supCode }"/>
          <input type="hidden" id="proj_id" value="${proj.projId }"/>
          <input type="hidden" id="publicity_start" value="${publicityStart }"/>
          <input type="hidden" id="publicity_end" value="${publicityEnd }"/>
          <div class="submit_btn">
              <ul>
                  <li><button class="btn btn-default blue" id="submit_btn">����</button></li>
                  <li><button class="btn btn-default gray_cart" onclick="history.go(-1)">ȡ��</button></li>
              </ul>
          </div>
      <!--#matter_section-->  
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>

	
</body>
</html>