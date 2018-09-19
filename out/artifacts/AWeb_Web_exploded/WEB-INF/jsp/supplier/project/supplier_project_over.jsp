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
<title>�ѽ�������Ŀ|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_supplier.css" rel="stylesheet">
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
          <h2>������Ŀ</h2>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
                 <div class="form-group">
                     <label class="title">��Ŀ��ţ�</label>
                     <div class="input_area">
                       <input type="text" class="form-control" id="projId" value="${projId}">
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">�������ͣ�</label>
                     <div class="input_area">
                       <select class="form-control" id="projType">
                         <option value="">����</option>
                         <option value="2"<c:if test="${projType eq '2'}"> selected="selected"</c:if>>��������</option>
                         <option value="1"<c:if test="${projType == '1'}"> selected="selected"</c:if>>���뾺��</option>
                       </select>
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">�ɹ���֯��</label>
                     <div class="input_area">
                       <input type="text" class="form-control" id="compName" value="${compName}">
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">��Ŀ״̬��</label>
                     <div class="input_area">
                       <select class="form-control" id="projStatus">
                         <option value="">����</option>
                         <option value="4"<c:if test="${projStatus eq '4'}"> selected="selected"</c:if>>���ڱ�</option>
                         <option value="5"<c:if test="${projStatus eq '5'}"> selected="selected"</c:if>>���ڱ�</option>
                         <option value="6"<c:if test="${projStatus eq '6'}"> selected="selected"</c:if>>�ϱ�</option>
                         <option value="8"<c:if test="${projStatus eq '8'}"> selected="selected"</c:if>>�ѹ�ʾ</option>
                         <option value="7"<c:if test="${projStatus eq '7'}"> selected="selected"</c:if>>�Ѷ���</option>
                         <option value="9"<c:if test="${projStatus eq '9'}"> selected="selected"</c:if>>����ֹ</option>
                       </select>
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">���ۿ�ʼʱ�䣺</label>
                     <div class="input_area input-group">
                       <input type="text" class="form-control" value="${startTime}" id="startTime" readonly="readonly" onclick="WdatePicker({dataFmt:'yyyy-MM-dd'});">
                       <span class="input-group-addon border_right"><i class="fa fa-calendar"></i></span>
                       <span class="text">��</span>
                       <input type="text" class="form-control border_left" value="${endTime}" id="endTime" readonly="readonly" onclick="WdatePicker({dataFmt:'yyyy-MM-dd'});">
                       <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                     </div>
                  </div>
                  <div class="btn_list">
                      <button class="btn btn-default blue" id="search">��ѯ</button>
                  </div>
              </div>
          </div>
          <div class="search_result">
            <table class="table_area">
              <tr>
                <th width="150">��Ŀ���</th>
                <th>��Ŀ����</th>
                <th width="150">�ɹ���֯</th>
                <th width="120">��������</th>
                <th width="150">���ۿ�ʼʱ��</th>
                <th width="80">״̬</th>
                <th class="last" width="180">����</th>
              </tr>
              <c:forEach items="${data}" var="item">
	             	<tr>
		                <td><a target="_blank" href="${pageContext.request.contextPath}/supplier/project/detail?projId=${item.projId}">${item.projId}</a></td>
		                <td>${item.projName}</td>
		                <td>${item.compName}</td>
		                <td>
		                	<c:if test="${item.projType eq '1'}">
		                		���뾺��
		                	</c:if>
		                	<c:if test="${item.projType eq '2'}">
		                		��������
		                	</c:if>
		                </td>
		                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.bidStartTime}"/></td>
		                <td>
		                	<c:if test="${item.projStatus eq '4'}">���ڱ�</c:if>
		                	<c:if test="${item.projStatus eq '5'}">���ڱ�</c:if>
		                	<c:if test="${item.projStatus eq '6'}">�ϱ�</c:if>
		                	<c:if test="${item.projStatus eq '8'}">�ѹ�ʾ</c:if>
		                	<c:if test="${item.projStatus eq '7'}">�Ѷ���</c:if>
		                	<c:if test="${item.projStatus eq '9'}">����ֹ</c:if>
		                </td>
		                <td>
		                	
		                	<c:if test="${item.projStatus eq '5' or item.projStatus eq '6'}">
		                	<a href="${pageContext.request.contextPath}/supplier/project/query?projId=${item.projId}">�鿴</a>		  
		                	<c:if test="${item.contractStatus > 1 }">
		                	<a href="${pageContext.request.contextPath}/supplier/contract?projId=${item.projId}">��ͬ����</a>
		                	</c:if>		                	              	
		                	</c:if>
		                	<c:if test="${item.projStatus eq '7'}">
		                	<a href="${pageContext.request.contextPath}/supplier/project/query?projId=${item.projId}">�鿴</a>
		                	<c:if test="${item.contractStatus > 1 }">
		                	<a href="${pageContext.request.contextPath}/supplier/contract?projId=${item.projId}">��ͬ����</a>
		                	</c:if>		                	
		                	<c:if test="${item.bidResult eq '1' }">
		                	<a target="_blank" href="${pageContext.request.contextPath}/market/bid/result/show?projId=${item.projId}">����֪ͨ��</a>
		                	</c:if>
		                	</c:if>
		                	<c:if test="${item.projStatus eq '8'}">
		                	<a target="_blank" href="${pageContext.request.contextPath}/market/bid/publicity?projId=${item.projId}">�鿴</a>
		                	</c:if>
		                	<c:if test="${item.projStatus eq '9'}">
		                	<a href="${pageContext.request.contextPath}/supplier/project/query?projId=${item.projId}">�鿴</a>
		                	</c:if>
		                </td>
		            </tr>
		      </c:forEach>
            </table>
          </div>
      <!--#matter_section-->	
      	<jsp:include page="../page.jsp" />
      </div>
      
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper-->
<script type="text/javascript">
$(function () {
	$('#search').click(function () {
		/*
		String projType,
			String auditStatus,
			String compName,
			String projId,
			String startTime, 
			String endTime
		*/
		location.href = '${pageContext.request.contextPath}/supplier/project/over?projType=' + $('#projType').val()
				+ '&projStatus=' + $('#projStatus').val()
				+ '&compName=' + $('#compName').val()
				+ '&projId=' + $('#projId').val()
				+ '&startTime=' + $('#startTime').val()
				+ '&endTime=' + $('#endTime').val();
	});
});
</script>
</body>
</html>