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
<title>�������۲ɹ�|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_myproject.css" rel="stylesheet">

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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/project.js"></script>

<script type="text/javascript">
var CONTEXT = "${pageContext.request.contextPath}";
</script>

</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  

  <div id="contents">
      <div class="inner">
      <jsp:include page="../left_menu.jsp"/>
          <div id="matter_section">
              <div class="section step_section" id="myproject">
                  <div class="list_inner clearfix">
                      <div class="form-group form-group_project">
                          <label class="title">��Ŀ��ţ�</label>
                          <div class="input_area">
                              <input type="text" class="form-control" id="proj_id">
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">��Ŀ���ƣ�</label>
                          <div class="input_area">
                              <input type="text" class="form-control" id="proj_name">
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">�������ͣ�</label>
                          <div class="input_area">
                              <select class="form-control" id="bid_cat">
                              	<option value="">ȫ��</option>
                                   <c:forEach var="i" items="${cats}">
                                   <option value="${i.codeValue }">${i.codeText }</option>
                                   </c:forEach>
                              </select>
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">�������ڣ�</label>
                          <div class="input_area input-group input-group_special">
                              <input type="text" class="form-control" id="create_time" readonly="readonly" style="background-color:#fff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                              <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                          </div>
                      </div>
                  </div>
                  <div class="submit_btn">
                      <ul>
                          <li><button class="btn btn-default blue" id="query_btn">��ѯ</button></li>
                          <li><button class="btn btn-default gray_cart" id="reset_btn">����</button></li>
                      </ul>
                   </div>
              </div>
              <div class="result_section section">
                  <div class="tab">
                      <ul id="myTab" class="nav nav-tabs">
                          <li class="proj_status active" data-status="1"><a href="javascript:;" data-toggle="tab">�����е���Ŀ</a></li>
                          <li class="proj_status" data-status="2"><a href="javascript:;" data-toggle="tab">������ʼ����Ŀ</a></li>
                          <li class="proj_status" data-status="3"><a href="javascript:;" data-toggle="tab">�ѽ�������Ŀ</a></li>
                      </ul>
                  </div>
                  <div id="myTabContent" class="tab-content add_inner">
                      <div class="tab-pane fade in active" id="current">
                      	 <table>
                      	 	<tr>
                      	 		<th width="150">��Ŀ���</th>
                      	 		<th>��Ŀ����</th>
                      	 		<th width="100">��������</th>
                      	 		<th width="150">���ۿ�ʼʱ��</th>
                      	 		<th width="90">״̬</th>
                      	 		<th class="last" width="130">����</th>
                      	 	</tr>
                      	 	<tbody id="project_tbody"></tbody>
                      	 	<!-- 
                      	 	<tr>
                      	 		<td></td>
                      	 		<td></td>
                      	 		<td></td>
                      	 		<td>2017-02-24 15:00:00</td>
                      	 		<td>������</td>
                      	 		<td><a href="#">���۴���</a><a href="#">�������Ӧ</a></td>
                      	 	</tr>
                      	 	 -->
                      	 </table>
                      </div>
                      
                       <div class="page" id="project_page">
                       </div>
                  </div>
              </div>
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>
