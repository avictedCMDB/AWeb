<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>角色管理|中航采购网</title>
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

function query(action){
	
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
	
}
function clearForm(objE){//objE为form表单  
    $(objE).find(':input').each(  
        function(){  
            switch(this.type){  
                case 'passsword':  
                case 'select-multiple':  
                case 'select-one':  
                case 'text':  
                case 'textarea':  
                    $(this).val('');  
                    break;  
                case 'checkbox':  
                case 'radio':  
                    this.checked = false;  
            }  
        }     
    );  
}
function opDialog(action,dialogWidth,dialogHeight) {
	var iTop = (parseInt(window.screen.availHeight)-30-parseInt(dialogHeight))/2;       //获得窗口的垂直位置;
	var iLeft = (parseInt(window.screen.availWidth)-10-parseInt(dialogWidth))/2;           //获得窗口的水平位置;
	window.open(action, 'newwindow', 'height='+dialogHeight+', width='+dialogWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no,modal=yes');
}
function reloadWindows(action){
	if (action ==null) {
		window.location.href=window.location.href;
	}else{
		window.location.href = action;
	}
		
}
function deleteRole(roleId,action){
	if(confirm("是否删除该角色？")){
		$.ajax({
		     type: 'POST',
		     url: action ,
		    data: {
				'roleId' : roleId
			}  ,
		    success: function (data){
		    	if(data == '0'){
		    		alert("删除成功");
			    	window.location.href=window.location.href;
		    	}else{
		    		alert('删除失败，请先撤销所有绑定该角色的用户！');
		    	}
		    	
		    } ,
		    error: function(XMLHttpRequest, textStatus, errorThrown) {
		    	 alert(XMLHttpRequest.status);
		    	 alert(XMLHttpRequest.readyState);
		    	 alert(textStatus);
		    	   },
		    dataType: 'json',
		    cache:false,
		});
	}
}
</script>
</head>
<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" /> 
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../left.jsp">
		  <jsp:param name="menu" value="role" />
	  </jsp:include>
      <div id="matter_section">
      	<h2>角色管理</h2>
      	<form id="queryForm" method="post">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix first">
              <dt>角色名称：</dt>
              <dd>
                <input type="text" class="form-control" name="roleName" value="${roleParam.roleName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>状态：</dt>
              <dd>
                <select class="form-control" name="isUseable" id="isUseable">
                  <option value="" <c:if test="${roleParam.isUseable == ''}"> selected="selected" </c:if>>全部</option>
	              <option value="1" <c:if test="${roleParam.isUseable == '1'}"> selected="selected"</c:if>>可用</option>
	              <option value="0" <c:if test="${roleParam.isUseable == '0'}"> selected="selected"</c:if>>禁用</option>
	            </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>平台：</dt>
              <dd>
                <select class="form-control" name="systemFlag" id="systemFlag">
                  <option value="" <c:if test="${role.systemFlag == ''}"> selected="selected"</c:if>>全部</option>
	              <option value="0" <c:if test="${roleParam.systemFlag == '0'}"> selected="selected"</c:if>>管理平台</option>
	              <option value="1" <c:if test="${roleParam.systemFlag == '1'}"> selected="selected"</c:if>>采购平台</option>
	            </select>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>支付角色：</dt>
              <dd>
                <select class="form-control" name="ifPayRole" id="ifPayRole">
                  <option value="" <c:if test="${role.ifPayRole == ''}"> selected="selected"</c:if>>全部</option>
	              <option value="0" <c:if test="${roleParam.ifPayRole == '0'}"> selected="selected"</c:if>>是</option>
	              <option value="1" <c:if test="${roleParam.ifPayRole == '1'}"> selected="selected"</c:if>>否</option>
	            </select>
              </dd>
            </dl>
            <div class="btn_list">
                <ul>
                  <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supervise/superviseRole')">查询</button></li>
                  <c:if test="${companyCode == 'system'}">
                  <li><button type="button" class="btn btn-default red" onclick="opDialog('${pageContext.request.contextPath}/supervise/superviseRole/roleAddPage?type=1','800px','400px')">新增</button></li>
                  </c:if>
                </ul>
            </div>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th width="100">角色名称</th>
              <th width="70">平台</th>
              <th width="70">支付角色</th>
              <th width="100">创建人</th>
              <th width="150">创建时间</th>
              <th width="100">修改人</th>
              <th width="150">修改时间</th>
              <th width="50">状态</th>
              <c:if test="${companyCode == 'system'}"><th width="150" class="last">操作</th></c:if>
            </tr>
            <c:forEach var="role" items="${roleList}" varStatus="status">
            <tr>
               <td>${role.roleName}</td>
               <td>
               	<c:if test="${role.systemFlag == '0'}"> 管理平台
               		</c:if>
               		<c:if test="${role.systemFlag == '1'}"> 采购平台
               		</c:if>
               </td>
                <td>
               	<c:if test="${role.ifPayRole == '0'}"> 是
               		</c:if>
               		<c:if test="${role.ifPayRole == '1'}"> 否
               		</c:if>
               </td>
               <td>${role.createUser}</td>
               <td>${role.createDate}</td>
               <td>${role.updateUser}</td>
               <td>${role.updateDate}</td>
                              <td>
               	<c:if test="${role.isUseable == '0'}"> 不可用
               		</c:if>
               		<c:if test="${role.isUseable == '1'}"> 可用
               		</c:if>
               </td>
               <c:if test="${companyCode == 'system'}">
               <td><a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/superviseRole/roleUpdatePage?type=2&roleId=${role.id}','800px','400px')">修改</a>
               <a href="javascript:void(0)" onclick="deleteRole('${role.id}','${pageContext.request.contextPath}/supervise/superviseRole/deleteRole')">删除</a>
               <a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/superviseRole/deployUserRolePage?roleId=${role.id}&systemFlag=${role.systemFlag}','800px','600px')">分配菜单</a></td>
            </c:if>
            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
      	<jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>