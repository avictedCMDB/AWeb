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
<link href="${pageContext.request.contextPath}/static/css/bid_contract_purchaser.css" rel="stylesheet">
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

	queryList();
	
	$("#query_btn").click(function () {
		var projId = $.trim($("#proj_id").val());
		var projName = $.trim($("#proj_name").val());
		var contractStatus = $.trim($("#contract_status").val());
		var startTime = $.trim($("#startTime").val());
		var endTime = $.trim($("#endTime").val());
		
		param.projId = projId;
		param.projName = projName;
		param.contractStatus = contractStatus;
		param.startTime = startTime;
		param.endTime = endTime;
		
		param.page = 1;
		
		queryList();
	});
	
});

var param = {};

var queryList = function () {

	var page = $(this).attr("data-page");
	if ($(this).parent().hasClass("active")) {
		return false;
	}
	
	
	if (page) {
		param.page = page;
	} else {
		param.page = 1;
	}
	
	$("#contract_tbody").empty();
	
	async('${pageContext.request.contextPath}/management/bid/contract/data', param, function (msg) {
		var result = msg.result;

		if (result.data) {
			/*

              <tr>
                <td><a href="#">ZB-201702-121305</a></td>
                <td></td>
                <td>3000</td>
                <td>2017-03-17 15:00:00</td>
                <td>合同审核</td>
                <td><a href="#">查看</a><a href="#">浏览合同</a></td>
              </tr>
            */
             
			
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
	        	var tr = $("<tr>");
	            tr.append("<td><a href='${pageContext.request.contextPath}/management/bid/project/detail?projId=" + item.projId + "'>" + item.projId + "</a></td>");
	            tr.append("<td>" + item.projName + "</td>");
	            
	            tr.append("<td>" + item.realCurrentQuota + "</td>");
	            tr.append("<td>" + (item.contractTime > 0 ? new Date(item.contractTime).asString("yyyy-mm-dd hh:min") : "") + "</td>");
	            var status = "";
	            
	            
	            if (item.contractStatus == 1) {
	            	status = "待上传";
	            } else if (item.contractStatus == 2) {
	            	status = "待审核";
	            } else if (item.contractStatus == 3) {
	            	status = "已归档";
	            } else if (item.contractStatus == 4) {
	            	status = "已退回";
	            } 
	            
	            tr.append("<td>" + status + "</td>");
	            
	            var op = $("<td>");
	            if (item.contractStatus == 1) {
	            } else if (item.contractStatus == 2) {
	            	op.append("<a href='${pageContext.request.contextPath}/management/bid/contract/audit?projId=" + item.projId + "&supCode=" + item.supCode + "'>浏览合同</a>");
	            } else {
	            	op.append("<a href='${pageContext.request.contextPath}/management/bid/contract/audit?projId=" + item.projId + "&supCode=" + item.supCode + "'>查看</a>");
	            }
	            
	            tr.append(op);
	            $("#contract_tbody").append(tr);
        	   
           	}
             
             
		}
		
		paging("#contract_page", result.pages, param.page, queryList);
	});
}

</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  
  <div id="contents">
    <div class="inner">    	
      <jsp:include page="../left.jsp"/>
      <div id="matter_section">
          <h2>合同管理</h2>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
                  <div class="form-group">
                     <label class="title">项目编号：</label>
                     <div class="input_area">
                       <input type="text" class="form-control" id="proj_id">
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">项目名称：</label>
                     <div class="input_area">
                       <input type="text" class="form-control" id="proj_name">
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">合同状态：</label>
                     <div class="input_area">
                       <select class="form-control" id="contract_status">
                         <option value="0">全部</option>
                         <option value="1">待上传合同</option>
                         <option value="2">合同审核</option>
                         <option value="3">已归档</option>
                         <option value="4">退回合同</option>
                       </select>
                     </div>
                  </div>
                  <div class="form-group">
                     <label class="title">录入时间：</label>
                     <div class="input_area input-group">
                       <input type="text" class="form-control" id="startTime" readonly="readonly" style="background-color:#fff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                       <span class="input-group-addon border_right"><i class="fa fa-calendar"></i></span>
                       <span class="text">至</span>
                       <input type="text" class="form-control border_left" id="endTime" readonly="readonly" style="background-color:#fff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                       <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                     </div>
                  </div>
                  <div class="btn_list">
                      <button class="btn btn-default blue" id="query_btn">查询</button>
                  </div>
              </div>
          </div>
          <div class="search_result">
            <table class="table_area">
              <tr>
                <th width="150">项目编号</th>
                <th>项目名称</th>
                <th width="150">采购金额</th>
                <th width="200">录入时间</th>
                <th width="150">合同状态</th>
                <th class="last" width="140">操作</th>
              </tr>
              <tbody id="contract_tbody"></tbody>
            </table>
            <div class="page" id="contract_page">
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
