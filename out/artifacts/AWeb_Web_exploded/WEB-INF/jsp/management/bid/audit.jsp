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
                          <td><a href="#">�鿴</a><a href="#">���</a></td>
                        </tr>
            */
             
			
          	for (var i = 0; i < result.data.length; i++) {
          		var item = result.data[i];
	        	var tr = $("<tr>");
	        	tr.append("<td><a href='${pageContext.request.contextPath}/management/bid/project/detail?projId=" + item.projId + "'>" + item.projId + "</a></td>");
	            tr.append("<td>" + item.projName + "</td>");
	            
	            var projStatus = "";
	            
	            if (item.projStatus == 2) {
	            	projStatus = "�ѷ���";
	            } else if (item.projStatus == 3) {
	            	projStatus = "��ʼ����";
	            } else if (item.projStatus == 4) {
	            	projStatus = "���۽���";
	            } else if (item.projStatus == 5) {
	            	projStatus = "���ڱ�";
	            } else if (item.projStatus == 6) {
	            	projStatus = "�ѷϱ�";
	            } else if (item.projStatus == 7) {
	            	projStatus = "�Ѷ���";
	            } else if (item.projStatus == 8) {
	            	projStatus = "�ѹ�ʾ";
	            }
	            tr.append("<td>" + projStatus + "</td>");
	            
	            tr.append("<td>" + item.supName + "</td>");
	            tr.append("<td>" + new Date(item.publishTime).asString("yyyy-mm-dd hh:min") + "</td>");
	            tr.append("<td>" + __(item.contactPerson) + "</td>");
	            tr.append("<td>" + __(item.contactNum) + "</td>");
	            tr.append("<td>" + __(item.email) + "</td>");
	            var status = "";
	            
	            
	            if (item.auditStatus == 1) {
	            	status = "�����";
	            } else if (item.auditStatus == 2) {
	            	status = "���ͨ��";
	            } else if (item.auditStatus == 3) {
	            	status = "��˲�ͨ��";
	            } 
	            
	            tr.append("<td>" + status + "</td>");
	            var op = $("<td>");
	            if (item.auditStatus == 1) {
	            	op.append("<a target='_blank' href='${pageContext.request.contextPath}/management/bid/audit/sup?supId=" + item.supId + "'>�鿴</a>");
	            	op.append("<a href='${pageContext.request.contextPath}/management/bid/audit/op?projId=" + item.projId + "&supCode=" + item.supCode + "'>���</a>");
	            } else {
	            	op.append("<a target='_blank' href='${pageContext.request.contextPath}/management/bid/audit/sup?supId=" + item.supId + "'>�鿴</a>");
	            	//op.append("<a href='javascript:;' onclick='alert(\"" + item.failReason + "\");'>������</a>");
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
                          <label class="title">Ͷ�굥λ��</label>
                          <div class="input_area">
                              <input type="text" class="form-control" id="sup_name">
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">�������ڣ�</label>
                          <div class="input_area input-group input-group_special">
                              <input type="text" class="form-control" id="publish_time" readonly="readonly" style="background-color:#fff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                              <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">�������ͣ�</label>
                          <div class="input_area">
                              <select class="form-control" id="proj_type">
                                  <option value="">ȫ��</option>
                                  <option value="1">���뾺��</option>
                                  <option value="2">��������</option>
                              </select>
                          </div>
                      </div>
                      <div class="form-group form-group_project">
                          <label class="title">״̬��</label>
                          <div class="input_area">
                              <select class="form-control" id="audit_status">
                                  <option value="">ȫ��</option>
                                  <option value="1">�����</option>
                                  <option value="2">���ͨ��</option>
                                  <option value="3">��˲�ͨ��</option>
                              </select>
                          </div>
                      </div>
                      <div class="btn_list">
                         <ul>
                             <li><button class="btn btn-default blue" id="query_btn">��ѯ</button></li>
                             <li><button class="btn btn-default gray_cart" id="reset_btn">����</button></li>
                         </ul>
                      </div>
                  </div>
                  
              </div>
              <div class="result_section section">
                  <div class="result_inner">
                      <table class="table_area">
                        <tr>
                          <th width="140">��Ŀ���</th>
                          <th>��Ŀ����</th>
                          <th>��Ŀ״̬</th>
                          <th width="120">Ͷ�굥λ</th>
                          <th width="120">����ʱ��</th>
                          <th width="70">��ϵ��</th>
                          <th width="90">�绰</th>
                          <th width="90">�����ʼ�</th>
                          <th width="90">״̬</th>
                          <th class="last" width="70">����</th>
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