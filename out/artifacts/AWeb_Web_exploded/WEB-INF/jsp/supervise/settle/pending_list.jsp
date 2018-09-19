<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="待结算管理" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_statement.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
	$("#clear").click(function () {
		$("#timeStart").val("");
		$("#timeEnd").val("");
		$("#companyName").val("");
		$("#supId").val("");
	});
	
	$("#batch_btn").click(function () {
		if (confirm("是否确定将当前数据生成结算单？")) {
			var timeStart = $(this).attr("data-timeStart");
			var timeEnd = $(this).attr("data-timeEnd");
			var supId = $(this).attr("data-supId");
			var companyName = $(this).attr("data-companyName");
			
			async('${pageContext.request.contextPath}/supervise/settle/pending/submit', {companyName:companyName, timeStart:timeStart, timeEnd:timeEnd, supId:supId}, function (msg) {
				alert(msg.result);
				window.location.reload();
			});
		}
		
		return false;
	});
});

var form_check = function () {
	var timeStart = $("#timeStart").val();
	var timeEnd = $("#timeEnd").val();
	
	if (timeStart == "") {
		alert("请选择开始时间");
		return false;
	}
	if (timeEnd == "") {
		alert("请选择结束时间");
		return false;
	}
	
	if (timeStart != "" && timeEnd != "") {
		var a = parseInt(timeStart.replace("-", ""));
		var b = parseInt(timeEnd.replace("-", ""));
		
		if (a > b) {
			alert("开始时间不能大于结束时间");
			return false;
		}
	}

	if ($("#supId").val() == "") {
		alert("请选择供应商");
		return false;
	}
	return true;
}
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../left.jsp">
    		<jsp:param value="settle-pending" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>生成结算单</h2>
      	<div class="search_area section">
      	<form action="${pageContext.request.contextPath}/supervise/settle/pending/list" method="get" onsubmit="return form_check();">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt><span style="color:red;">*</span>订（退货）单日期：</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" class="form-control special_input" id="timeStart" name="timeStart" value="${timeStart}" readonly="readonly" style="cursor:pointer;background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeStart').focus()"></i></span>
                    </div>
                  </li>
                  <li>至</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" class="form-control special_input" id="timeEnd" name="timeEnd" value="${timeEnd}" readonly="readonly" style="cursor:pointer;background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeEnd').focus()"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>采购单位：</dt>
              <dd>
                <input type="text" class="form-control" id="companyName" name="companyName" value="${companyName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt><span style="color:red;">*</span>供应商名称：</dt>
              <dd>
                <select class="form-control" name="supId" id="supId">
					<c:forEach var="item" varStatus="sta" items="${sups}">
					<option value="${item.supId}" <c:if test="${supId == item.supId}">selected="selected"</c:if>>${item.supName }</option>
					</c:forEach>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="submit" class="btn btn-default red">查询</button></li>
              <li><button type="button" id="clear" class="btn btn-default gray">清空</button></li>
            </ul>
          </div>
          </form>
        </div>
        <div class="search_result">
          <div class="state_list">
            <ul>
        	  <c:if test="${!empty list}">
              <li class="delete"><button class="btn btn-default red" type="button" id="batch_btn" data-timeStart="${timeStart}" data-timeEnd="${timeEnd}" data-supId="${supId}" data-companyName="${companyName}">生成结算单</button></li>
              </c:if>
            </ul>
          </div>
          <table>
            <tr>
              <th width="70">业务编号</th>
              <th width="110">业务类型</th>
              <th width="200">下单日期</th>
              <th>采购单位</th>
              <th width="110">总数量</th>
              <th width="110">结算金额（元）</th>
              <th width="110" class="last">操作</th>
            </tr>
          	<c:forEach var="item" varStatus="sta" items="${list}">
            <tr>
              <td>
				<c:if test="${item.busiType == 1}">
              		<a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.busiId}&t=1">
              	</c:if>
				<c:if test="${item.busiType == 2}">
              		<a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.busiId}&t=1">
              	</c:if>
              	${item.busiId}</a>
              </td>
              <td>
				<c:if test="${item.busiType == 1}">订单</c:if>
				<c:if test="${item.busiType == 2}">退款</c:if>
			  </td>
              <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${item.createTime}" /></td>
              <td>${item.companyName }</td>
              <td>${item.totalNum}</td>
              <td><c:if test="${item.busiType == 2}">-</c:if><fmt:formatNumber value="${item.settleAmount}" pattern="#0.00#"></fmt:formatNumber></td>
              <td>
				<c:if test="${item.busiType == 1}">
              		<a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.busiId}&t=1">
              	</c:if>
				<c:if test="${item.busiType == 2}">
              		<a href="${pageContext.request.contextPath}/supervise/refund/detail?r=${item.busiId}&t=1">
              	</c:if>查看</a></td>
            </tr>
            </c:forEach>
          </table>
        </div>
        <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
