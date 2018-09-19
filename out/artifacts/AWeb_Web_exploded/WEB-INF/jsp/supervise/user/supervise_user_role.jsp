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
<title>分配角色|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_user.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function deployUserRole(action){
	var roleId = "";
	var checkCount = 0;
	$("input:checkbox[name='isCheck']:checked").each(function() {
		checkCount++;
		roleId = roleId + $(this).val() + ',';
	});
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: {
			'userName' : $('#userName').val(),
			'roleIds' : roleId
		}  ,

	    success: function (data){
	    	alert('配置成功！');
	    	window.opener.reloadWindows(null);
	    	window.close();
	    } ,
	    dataType: 'json',
	    
	    cache:false,
	});
	
}
function checkAll(){
	if($("#checkAll").is(':checked') == true){
		$(":checkbox").prop("checked",true);
	}else{
		$(":checkbox").removeAttr("checked");
	}
}
</script>
</head>
<body>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">角色分配<a href="#"><i class="fa fa-close"></i></a></div>
    <input type="hidden" value="${userName}" id="userName">
    <div class="main_inner">
      <div class="up_area clearfix">
        <table class="company_list">
            <tr>
                <th width="40"><input type="checkbox" id="checkAll" type="checkbox" onclick="checkAll();"></th>
                <th>角色名称</th>
                <th width="200" class="last">是否可用</th>
            </tr>
            <c:forEach var="role" items="${roleList}" varStatus="status">
	            <tr>
	                <td><input type="checkbox"  name="isCheck" <c:if test="${role.isCheck == '1'}"> checked="checked" </c:if> value="${role.id}"></td>
	                <td>${role.roleName}</td>
	                <td class="last">
					<c:if test="${role.isUseable == '0'}"> 不可用 </c:if>
					<c:if test="${role.isUseable == '1'}"> 可用 </c:if>
					</td>
	            </tr>
            </c:forEach>
        </table> 
      </div>
      <div class="btn_list">
          <ul>
            <li><button class="btn btn-default blue" onclick="deployUserRole('${pageContext.request.contextPath}/supervise/supplierUser/deployUserRole')">确定</button></li>
            <li><button type="button" class="btn btn-default gray" onclick="window.close();">关闭</button></li>
          </ul>
        </div>  
    </div>
  </div>
</div>
</body>
</html>