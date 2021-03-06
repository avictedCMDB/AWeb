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
<title>合同管理|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_contract_reviewed.css" rel="stylesheet">
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
	$(".submit-btn").click(function () {
		var contractRemark = $.trim($("#contract_remark").val());
		if (contractRemark == "") {
			alert("请填写意见");
			return false;
		}
		
		if (confirm("是否确认" + $(this).text() + "?")) {

			async('${pageContext.request.contextPath}/management/bid/contract/audit/submit', {projId:'${sup.projId}', supCode:'${sup.supCode}', contractStatus:$(this).attr("data-val"), contractRemark:contractRemark}, function (msg) {
				alert("提交成功");
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
      
      <jsp:include page="../left.jsp"/>
      <div id="matter_section">
          <h2>合同审核</h2>
          <div class="search_result">
              <table class="table_area">
                <tr>
                  <th width="70">序号</th>
                  <th width="250">类型</th>
                  <th width="150">文件编号</th>
                  <th width="150">文件名称</th>
                  <th class="last">上传时间</th>
                  <th class="last">版本</th>
                </tr>
                <c:forEach var="i" items="${files }" varStatus="sta">
                <tr>
                  <td>${sta.index + 1 }</td>
                  <td>合同</td>
                  <td>${i.fileId }</td>
                  <td><a target="_blank" href="${pageContext.request.contextPath}/management/bid/contract/downfile?projId=${i.projId}&supCode=${i.supCode}&fileId=${i.fileId}">${i.fileName }</a></td>
                  <td><fmt:formatDate value="${i.uploadTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                  <td>${i.fileVersion }</td>
                </tr>
                </c:forEach>
              </table>
          </div>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
                  <div class="form-group special_group01">
                     <label class="title">意见：</label>
                     <div class="input_area">
                       <textarea class="form-control" <c:if test="${sup.contractStatus != 2 }">readonly="readonly"</c:if> id="contract_remark">${sup.contractRemark }</textarea>
                     </div>
                  </div>
                  <div class="submit_btn">
                   <ul>
                  <c:if test="${sup.contractStatus == 2 }">
                       <li><button class="btn btn-default blue submit-btn" data-val="3">审核归档</button></li>
                       <li><button class="btn btn-default gray_cart submit-btn" data-val="4">退回供应商</button></li>
                  </c:if>
                  <c:if test="${sup.contractStatus != 2 }">
                       <li><button class="btn btn-default gray_cart" onclick="history.go(-1)">返回</button></li>
                  </c:if>
                </ul>
                </div>
              </div>
          </div>
      <!--#matter_section-->  
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>
