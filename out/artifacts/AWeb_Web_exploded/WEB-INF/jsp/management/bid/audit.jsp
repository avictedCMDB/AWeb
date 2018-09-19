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
<title>发布竞价采购|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_project_list.css" rel="stylesheet">
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
		var supName = $.trim($("#sup_name").val());
		var publishTime = $.trim($("#publish_time").val());
		var projType = $.trim($("#proj_type").val());
		var auditStatus = $.trim($("#audit_status").val());
		
		param.projId = projId;
		param.projName = projName;
		param.supName = supName;
		param.publishTime = publishTime;
		param.projType = projType;
		param.auditStatus = auditStatus;
		
		param.page = 1;
		
		queryList();
	});
	
	$("#reset_btn").click(function () {
		$("#proj_id").val("");
		$("#proj_name").val("");
		$("#sup_name").val("");
		$("#publish_time").val("");
		$("#proj_type").val("");
		$("#audit_status").val("");
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
	
	$("#project_tbody").empty();
	
	async('${pageContext.request.contextPath}/management/bid/audit/data', param, function (msg) {
		var result = msg.result;

		if (result.data) {
			/*

                        <tr>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td>13000000000</td>
                          <td></td>
                          <td></td>
                          <td><a href="#">查看</a><a href="#">审核</a></td>
                        </tr>
            */
             
			
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
	        	var tr = $("<tr>");
	        	tr.append("<td><a href='${pageContext.request.contextPath}/management/bid/project/detail?projId=" + item.projId + "'>" + item.projId + "</a></td>");
	            tr.append("<td>" + item.projName + "</td>");
	            
	            var projStatus = "";
	            
	            if (item.projStatus == 2) {
	            	projStatus = "已发布";
	            } else if (item.projStatus == 3) {
	            	projStatus = "开始竞价";
	            } else if (item.projStatus == 4) {
	            	projStatus = "竞价结束";
	            } else if (item.projStatus == 5) {
	            	projStatus = "已授标";
	            } else if (item.projStatus == 6) {
	            	projStatus = "已废标";
	            } else if (item.projStatus == 7) {
	            	projStatus = "已定标";
	            } else if (item.projStatus == 8) {
	            	projStatus = "已公示";
	            }
	            tr.append("<td>" + projStatus + "</td>");
	            
	            tr.append("<td>" + item.supName + "</td>");
	            tr.append("<td>" + new Date(item.publishTime).asString("yyyy-mm-dd hh:min") + "</td>");
	            tr.append("<td>" + __(item.contactPerson) + "</td>");
	            tr.append("<td>" + __(item.contactNum) + "</td>");
	            tr.append("<td>" + __(item.email) + "</td>");
	            var status = "";
	            
	            
	            if (item.auditStatus == 1) {
	            	status = "待审核";
	            } else if (item.auditStatus == 2) {
	            	status = "审核通过";
	            } else if (item.auditStatus == 3) {
	            	status = "审核不通过";
	            } 
	            
	            tr.append("<td>" + status + "</td>");
	            var op = $("<td>");
	            if (item.auditStatus == 1) {
	            	op.append("<a target='_blank' href='${pageContext.request.contextPath}/management/bid/audit/sup?supId=" + item.supId + "'>查看</a>");
	            	op.append("<a href='${pageContext.request.contextPath}/management/bid/audit/op?projId=" + item.projId + "&supCode=" + item.supCode + "'>审核</a>");
	            } else {
	            	op.append("<a target='_blank' href='${pageContext.request.contextPath}/management/bid/audit/sup?supId=" + item.supId + "'>查看</a>");
	            	//op.append("<a href='javascript:;' onclick='alert(\"" + item.failReason + "\");'>审核意见</a>");
	            }
	            
	            tr.append(op);
	            $("#project_tbody").append(tr);
        	   
           	}
             
             
		}
		
		paging("#project_page", result.pages, param.page, queryList);
	});
}

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
                          <label class="title">项目编号：</label>
                          <div class="input_area">
                              <input type="text" class="form-control" id="proj_id">
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">项目名称：</label>
                          <div class="input_area">
                              <input type="text" class="form-control" id="proj_name">
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">投标单位：</label>
                          <div class="input_area">
                              <input type="text" class="form-control" id="sup_name">
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">发布日期：</label>
                          <div class="input_area input-group input-group_special">
                              <input type="text" class="form-control" id="publish_time" readonly="readonly" style="background-color:#fff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                              <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">竞价类型：</label>
                          <div class="input_area">
                              <select class="form-control" id="proj_type">
                                  <option value="">全部</option>
                                  <option value="1">邀请竞价</option>
                                  <option value="2">公开竞价</option>
                              </select>
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">状态：</label>
                          <div class="input_area">
                              <select class="form-control" id="audit_status">
                                  <option value="">全部</option>
                                  <option value="1">待审核</option>
                                  <option value="2">审核通过</option>
                                  <option value="3">审核不通过</option>
                              </select>
                          </div>
                      </div>
                      <div class="btn_list">
                         <ul>
                             <li><button class="btn btn-default blue" id="query_btn">查询</button></li>
                             <li><button class="btn btn-default gray_cart" id="reset_btn">重置</button></li>
                         </ul>
                      </div>
                  </div>
                  
              </div>
              <div class="result_section section">
                  <div class="result_inner">
                      <table class="table_area">
                        <tr>
                          <th width="140">项目编号</th>
                          <th>项目名称</th>
                          <th>项目状态</th>
                          <th width="120">投标单位</th>
                          <th width="120">发布时间</th>
                          <th width="70">联系人</th>
                          <th width="90">电话</th>
                          <th width="90">电子邮件</th>
                          <th width="90">状态</th>
                          <th class="last" width="70">操作</th>
                        </tr>
                        <tbody id="project_tbody">
                        </tbody>
                      </table>
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