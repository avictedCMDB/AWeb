<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>菜单|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_role.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function deployUserRole(action){
	var menuIds = '';
    $("input[type='checkbox']:checked").each(function(){
    	menuIds+=$(this).val()+",";
    });
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: {
			'roleId' : $('#roleId').val(),
			'menuIds' : menuIds
		}  ,

	    success: function (data){
			alert('操作成功');
	    	window.opener.reloadWindows(null);
	    	window.close();
	    } ,
	    dataType: 'json',
	    
	    cache:false,
	});
}
function checkUpMenu(id,parentId){
	var checkbox = document.getElementById(id); 
	if ($("input[name='"+id+"']").length != 0) {
		if (checkbox.checked) {
			$("input[name='"+id+"']").prop("checked","true"); 
		}else {
			$("input[name='"+id+"']").removeAttr("checked"); 
		}
		$("input[name='"+id+"']").each(function(){  
				var upId = $(this).attr("id");
				checkUpMenu(upId,id);
		});
	}
}
function checkTopMenu(id,parentId){
	var checkbox = document.getElementById(id); 
	if ($("#" + parentId) != undefined) {
		if (checkbox.checked) {
			if(!document.getElementById(parentId).checked){
				$("#" + parentId).prop("checked","true");
			}
		}else {
			if ($("input[name='"+parentId+"']:checked").length == 0) {
				$("#" + parentId).removeAttr("checked"); 
			}
		}
		
		var topPip = $("#" + parentId).attr("name");
		if(topPip != undefined){
			checkTopMenu(parentId,topPip);
		}
	}
}
function checkMenuFor(id,parentId){
	checkUpMenu(id,parentId);
	checkTopMenu(id,parentId);
}
</script>
<body>
<div id="vat_info" class="special">
  <div class="inner">
    <div class="add_title clearfix">分配菜单<a href="#"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
      <div class="btn_list btn_right">
          <ul>
            <li><button type="button" class="btn btn-default red" onclick="deployUserRole('${pageContext.request.contextPath}/supervise/superviseRole/deployUserRole')">确定</button></li>
            <li><button type="button" class="btn btn-default gray" onclick="window.close();">关闭</button></li>
          </ul>
      </div> 
      <input type="hidden" value="${roleId}" id="roleId" name="roleId"/>
      <div class="tree_area clearfix">
         <c:forEach var="menu" items="${menuList}" varStatus="status">
         	${menu}
         </c:forEach>
      </div>
    </div>
  </div>
</div>
</html>