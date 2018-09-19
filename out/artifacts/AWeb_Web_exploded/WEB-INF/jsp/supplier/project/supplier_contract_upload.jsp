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
<link href="${pageContext.request.contextPath}/static/css/bid_contract_up.css" rel="stylesheet">
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
          <h2>合同上传</h2>
          <div class="search_result">
              <table class="table_area">
                <tr>
                  <th width="250">合同类型</th>
                  <th width="250">文件名称</th>
                  <th width="150">上传时间</th>
                  <th width="150">版本</th>
                  <th class="last">操作</th>
                </tr>
                <tbody id="contract_list">
                <c:forEach var="item" items="${contracts}">
	                <tr fileId="${item.fileId }" fileName="${item.fileName }" filePath="${item.filePath }" uploadTime="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.uploadTime}"/>" fileVersion=${item.fileVersion }>
	                  <td>合同</td>
	                  <td>${item.fileName}</td>
	                  <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.uploadTime}"/></td>
	                  <td>${item.fileVersion }</td>
	                  <td><a href="javascript:;" onclick="$(this).parent().parent().remove();">删除</a></td>
	                </tr>
                </c:forEach>
                </tbody>
              </table>
          </div>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
                  <div class="form-group special_group01">
                     <label class="title">项目名称：</label>
                     <span>${supplier.projName }</span>
                  </div>
                  <div class="form-group special_group01">
                     <label class="title">项目编号：</label>
                     <span>${supplier.projId}</span>
                  </div>
                  <div class="form-group special_group01">
                     <label class="title">文件类型：</label>
                     <span>合同</span>
                  </div>
                  <div class="form-group special_group01">
                     <label class="title">选择文件上传：</label>
                     <div class="input_area">
                     <form id="upload_form" target="hidden_frame" action="${pageContext.request.contextPath}/supplier/contract/upload_file" enctype="multipart/form-data" method="post">
                       <input id="lefile" name="lefile" type="file" style="display:none">
                       <input type="hidden" name="projId" value="${supplier.projId }"/>
                     </form>
                     <iframe name="hidden_frame" style="display:none;"></iframe>
                       <div class="input-append">
                           <input id="photoCover" class="input-large form-control" type="text" style="height:30px;"> 
                           <a class="btn btn-default red" onclick="$('input[id=lefile]').click();">浏览文件</a>
                           <button type="button" class="btn btn-default red" onclick="upload_click();">确认上传</button>
                           <label>(单个上传文件大小不能超过5M)</label>
                       </div>
                       <script type="text/javascript"> 
                          $('input[id=lefile]').change(function() { 
                            $('#photoCover').val($(this).val());
                          });
                       </script>
                     </div>
                  </div>
              </div>
          </div>
          <div class="submit_btn">
                   <ul>
                       <li><button class="btn btn-default blue" onclick="submit_click();">提交审核</button></li>
                       <li><button class="btn btn-default gray_cart" onclick="history.go(-1);">返回</button></li>
                   </ul>
               </div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper-->
<script type="text/javascript">
function submit_click() {
	var tr = $("#contract_list").append(tr).children();
	if (tr.size() == 0) {
		alert("请上传合同");
		return false;
	}
	
	var data = [];
	
	tr.each(function () {
		var item = $(this).attr("fileId");
		item = item + "@supplier_contract_item@" + $(this).attr("fileName");
		item = item + "@supplier_contract_item@" + $(this).attr("filePath");
		item = item + "@supplier_contract_item@" + $(this).attr("fileVersion");
		item = item + "@supplier_contract_item@" + $(this).attr("uploadTime");
		
		data.push(item);
	});
	
	var param = {
		data:data.join("@supplier_contract@"),
		projId:'${supplier.projId}'
	};
	
	async('${pageContext.request.contextPath}/supplier/contract/upload_submit', param, function (msg) {
		alert("提交成功");
		window.location.href = "${pageContext.request.contextPath}/supplier/contract";
	});
	
}

function upload_click() {
	if ($("#lefile").val() == "") {
		alert("请选择文件");
		return false;
	}
	loading = true;
	$("#upload_form").submit();
}


var _uploadCallback = function (result, url, fail, data) {
	loading = false;
	if (result > 0) {
		var tr = $("<tr>");
		tr.attr("fileId", data.fileId);
		tr.attr("fileName", data.fileName);
		tr.attr("filePath", data.filePath);
		tr.attr("fileVersion", data.fileVersion);
		tr.attr("uploadTime", data.uploadTime);
		
		tr.append("<td>合同</td>");
		tr.append("<td>" + data.fileName + "</td>");
		tr.append("<td>" + data.uploadTime + "</td>");
		tr.append("<td>" + data.fileVersion + "</td>");
		tr.append("<td><a href='javascript:;' onclick='$(this).parent().parent().remove();'>删除</a></td>");
		
		$("#contract_list").append(tr);
		$("#lefile").val("");
		$("#photoCover").val("");
	} else {
		alert(fail);
	}
}

var loading = false;
var async = function (url, param, callback, failed, skipCheck) {
	if (!skipCheck) {
		if (loading) return;
		loading = true;
	}
	$.ajax({
		url:url,
		type:"POST",
		data:param,
		dataType:"json",
		success:function (msg) {
			if (!skipCheck) {
			loading = false;
			}
			if (msg.hasOwnProperty('status')) {
				if (msg.status === 0) {
					if (callback) {
						callback(msg);
					}
				} else {
					if (failed) {
						failed(msg);
					} else {
						alert(msg.result);
					}
				}
			} else {
				this.error();
			}
		},
		error:function () {
			if (!skipCheck) {
			loading = false;
			}
			alert("操作失败，请重试");
		}
	});
}
</script>
</body>
</html>
