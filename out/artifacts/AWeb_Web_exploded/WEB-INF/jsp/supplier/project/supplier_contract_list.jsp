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
<title>合同管理|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_contract_supplier.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script></link>


</head>


<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp">
    	<jsp:param name="menu" value="contract" />
    	</jsp:include>
      <div id="matter_section">
          <h2>合同管理</h2>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
                  <div class="form-group">
                     <label class="title">项目编号：</label>
                     <div class="input_area">
                       <input type="text" class="form-control" id="projId" value="${projId}">
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">项目名称：</label>
                     <div class="input_area">
                       <input type="text" class="form-control" id="projName" value="${projName }">
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">缴费情况：</label>
                     <div class="input_area">
                       <select class="form-control" id="feeStatus">
                         <option value="">不限</option>
                         <option value="1"<c:if test="${feeStatus eq '1'}"> selected="selected"</c:if>>未交费</option>
                         <option value="2"<c:if test="${feeStatus eq '2'}"> selected="selected"</c:if>>暂缓缴费</option>
                         <option value="3"<c:if test="${feeStatus eq '3'}"> selected="selected"</c:if>>已缴费</option>
                       </select>
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">合同状态：</label>
                     <div class="input_area">
                       <select class="form-control" id="contractStatus">
                         <option value="">不限</option>
                         <option value="5"<c:if test="${contractStatus eq '5'}"> selected="selected"</c:if>>待上传合同</option>
                         <option value="2"<c:if test="${contractStatus eq '2'}"> selected="selected"</c:if>>合同审核</option>
                         <option value="3"<c:if test="${contractStatus eq '3'}"> selected="selected"</c:if>>已归档</option>
                         <option value="4"<c:if test="${contractStatus eq '4'}"> selected="selected"</c:if>>退回合同</option>
                       </select>
                     </div>
                  </div>
                  <div class="btn_list">
                      <button class="btn btn-default blue" id="search">查询</button>
                  </div>
              </div>
          </div>
          <div class="search_result">
            <table class="table_area">
              <tr>
                <th width="150">项目编号</th>
                <th>项目名称</th>
                <th width="150">完成时间</th>
                <th width="120">缴费状态</th>
                <th width="150">服务费</th>
                <th width="120">合同状态</th>
                <th class="last" width="140">操作</th>
              </tr>
              <c:forEach items="${data}" var="item">
              <tr>
                <td><a target="_blank" href="${pageContext.request.contextPath}/supplier/project/detail?projId=${item.projId}">${item.projId }</a></td>
                <td>${item.projName }</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.contractTime}"/></td>
                <td>
                	<c:if test="${item.feeStatus eq '1'}">未交费</c:if>
                	<c:if test="${item.feeStatus eq '2'}">暂缓缴费</c:if>
                	<c:if test="${item.feeStatus eq '3'}">已缴费</c:if>
                </td>
                <td>0</td>
                <td>
                	<c:if test="${item.contractStatus eq '5'}">待上传合同</c:if>
                	<c:if test="${item.contractStatus eq '2'}">合同审核</c:if>
                	<c:if test="${item.contractStatus eq '3'}">已归档</c:if>
                	<c:if test="${item.contractStatus eq '4'}">退回合同</c:if>
                </td>
                <td>
                <c:if test="${item.contractStatus eq '5'}">
                	<a href="${pageContext.request.contextPath}/supplier/contract/upload?projId=${item.projId}">上传合同</a>
                </c:if>
                <c:if test="${item.contractStatus eq '2'}">
                	<a href="${pageContext.request.contextPath}/supplier/contract/upload?projId=${item.projId}">查看</a>
                </c:if>
                <c:if test="${item.contractStatus eq '4'}">
                	<a href="${pageContext.request.contextPath}/supplier/contract/upload?projId=${item.projId}">上传合同</a>
                </c:if>
                <c:if test="${item.contractStatus eq '3'}">
                	<a href="${pageContext.request.contextPath}/supplier/contract/detail?projId=${item.projId}" target="_blank">浏览合同</a>
                	<!-- 
                	<a href="${pageContext.request.contextPath}/market/bid/result/show?projId=${item.projId}" target="_blank">定标通知书</a>
                	 -->
                </c:if>
                </td>
              </tr>
              </c:forEach>
            </table>
          </div>
      <!--#matter_section-->	
      	<jsp:include page="../page.jsp" />
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper-->
<script type="text/javascript">
$(function () {
	$('#search').click(function () {
		location.href = '${pageContext.request.contextPath}/supplier/contract?projId=' + $('#projId').val()
				+ '&projName=' + $('#projName').val()
				+ '&feeStatus=' + $('#feeStatus').val()
				+ '&contractStatus=' + $('#contractStatus').val()
	});
});
</script>
</body>
</html>
