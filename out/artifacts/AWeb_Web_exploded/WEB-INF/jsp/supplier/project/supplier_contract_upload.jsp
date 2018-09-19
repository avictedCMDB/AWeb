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
<title>��ͬ����|�к��ɹ���</title>
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
          <h2>��ͬ�ϴ�</h2>
          <div class="search_result">
              <table class="table_area">
                <tr>
                  <th width="250">��ͬ����</th>
                  <th width="250">�ļ�����</th>
                  <th width="150">�ϴ�ʱ��</th>
                  <th width="150">�汾</th>
                  <th class="last">����</th>
                </tr>
                <tbody id="contract_list">
                <c:forEach var="item" items="${contracts}">
	                <tr fileId="${item.fileId }" fileName="${item.fileName }" filePath="${item.filePath }" uploadTime="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.uploadTime}"/>" fileVersion=${item.fileVersion }>
	                  <td>��ͬ</td>
	                  <td>${item.fileName}</td>
	                  <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.uploadTime}"/></td>
	                  <td>${item.fileVersion }</td>
	                  <td><a href="javascript:;" onclick="$(this).parent().parent().remove();">ɾ��</a></td>
	                </tr>
                </c:forEach>
                </tbody>
              </table>
          </div>
          <div class="step_section section" id="step01">
              <div class="list_inner clearfix">
                  <div class="form-group special_group01">
                     <label class="title">��Ŀ���ƣ�</label>
                     <span>${supplier.projName }</span>
                  </div>
                  <div class="form-group special_group01">
                     <label class="title">��Ŀ��ţ�</label>
                     <span>${supplier.projId}</span>
                  </div>
                  <div class="form-group special_group01">
                     <label class="title">�ļ����ͣ�</label>
                     <span>��ͬ</span>
                  </div>
                  <div class="form-group special_group01">
                     <label class="title">ѡ���ļ��ϴ���</label>
                     <div class="input_area">
                     <form id="upload_form" target="hidden_frame" action="${pageContext.request.contextPath}/supplier/contract/upload_file" enctype="multipart/form-data" method="post">
                       <input id="lefile" name="lefile" type="file" style="display:none">
                       <input type="hidden" name="projId" value="${supplier.projId }"/>
                     </form>
                     <iframe name="hidden_frame" style="display:none;"></iframe>
                       <div class="input-append">
                           <input id="photoCover" class="input-large form-control" type="text" style="height:30px;"> 
                           <a class="btn btn-default red" onclick="$('input[id=lefile]').click();">����ļ�</a>
                           <button type="button" class="btn btn-default red" onclick="upload_click();">ȷ���ϴ�</button>
                           <label>(�����ϴ��ļ���С���ܳ���5M)</label>
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
                       <li><button class="btn btn-default blue" onclick="submit_click();">�ύ���</button></li>
                       <li><button class="btn btn-default gray_cart" onclick="history.go(-1);">����</button></li>
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
		alert("���ϴ���ͬ");
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
		alert("�ύ�ɹ�");
		window.location.href = "${pageContext.request.contextPath}/supplier/contract";
	});
	
}

function upload_click() {
	if ($("#lefile").val() == "") {
		alert("��ѡ���ļ�");
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
		
		tr.append("<td>��ͬ</td>");
		tr.append("<td>" + data.fileName + "</td>");
		tr.append("<td>" + data.uploadTime + "</td>");
		tr.append("<td>" + data.fileVersion + "</td>");
		tr.append("<td><a href='javascript:;' onclick='$(this).parent().parent().remove();'>ɾ��</a></td>");
		
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
			alert("����ʧ�ܣ�������");
		}
	});
}
</script>
</body>
</html>