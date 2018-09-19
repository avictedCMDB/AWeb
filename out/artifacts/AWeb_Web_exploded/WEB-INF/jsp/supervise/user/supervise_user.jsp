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
<title>用户管理|中航采购网</title>
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
function deleteUser(userName,action){
	if(confirm("是否删除用户【"+userName+"】？")){
		$.ajax({
		     type: 'POST',
		     url: action ,
		    data: {
				'userName' : userName
			}  ,
		    success: function (data){
		    	alert("删除成功");
		    	window.location.href=window.location.href;
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
		  <jsp:param name="menu" value="user" />
	  </jsp:include>
      <div id="matter_section">
      	<h2>用户管理</h2>
	  <form id="queryForm" method="post">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix first">
              <dt>用户名：</dt>
              <dd>
                <input type="text" name="userName" class="form-control" value="${userParam.userName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>机构：</dt>
              <dd>
                <input type="text" name="companyName" class="form-control" value="${userParam.companyName}">
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>联系人：</dt>
              <dd>
                <input type="text" name="contactPerson" class="form-control" value="${userParam.contactPerson}">
              </dd>
            </dl>
            <dl class="clearfix first">
              <dt>联系人电话：</dt>
              <dd>
                <input type="text" name="contactNum" class="form-control" value="${userParam.contactNum}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>是否支付：</dt>
              <dd>
                <select class="form-control" name="nopay">
                <option value="" <c:if test="${userParam.nopay == ''}"> selected="selected" </c:if>>全部</option>
                  <option value="0" <c:if test="${userParam.nopay == '0'}"> selected="selected" </c:if>>是</option>
                  <option value="1" <c:if test="${userParam.nopay == '1'}"> selected="selected" </c:if>>否</option>
                </select>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>是否有效：</dt>
              <dd>
                <select class="form-control" name="enabled">
                <option value="" <c:if test="${userParam.enabled == ''}"> selected="selected" </c:if>>全部</option>
                  <option value="0" <c:if test="${userParam.enabled == '0'}"> selected="selected" </c:if>>是</option>
                  <option value="1" <c:if test="${userParam.enabled == '1'}"> selected="selected" </c:if>>否</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supervise/supplierUser')">查询</button></li>
              <li><button type="button" class="btn btn-default red" onclick="clearForm(this.form)">清空</button></li>
              <li><button type="button" class="btn btn-default red" onclick="opDialog('${pageContext.request.contextPath}/supervise/supplierUser/userAddPage?type=1','1000px','300px')">新增</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th width="70">用户名</th>
              <th>所属角色</th>
              <th width="100">机构</th>
              <th width="70">联系人</th>
              <th width="100">联系人电话</th>
              <th width="100">联系人传真</th>          
              <th width="90">是否需要支付</th>
              <th width="90">是否有效</th>
              <th width="90" class="last">操作</th>
            </tr>
            <c:forEach var="user" items="${userList}" varStatus="status">
            <tr>
               <td>${user.userName}</td>
               <td>${user.roleName}</td>
               <td>${user.companyName}</td>               
               <td>${user.contactPerson}</td>
               <td>${user.contactNum}</td>
               <td>${user.contactFax}</td>
               <td><c:if test="${user.nopay == '0'}"> 是
               		</c:if>
               		<c:if test="${user.nopay == '1'}"> 否
               		</c:if>
               	</td>
               <td><c:if test="${user.enabled == '0'}"> 是 </c:if>
               	   <c:if test="${user.enabled == '1'}"> 否 </c:if>
               </td>
               <td><a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/supplierUser/userUpdatePage?type=2&username=${user.userName}','1000px','300px')">修改</a>
               <a href="javascript:void(0)" onclick="deleteUser('${user.userName}','${pageContext.request.contextPath}/supervise/supplierUser/deleteUser')">删除</a>
               <a href="javascript:void(0)" onclick="opDialog('${pageContext.request.contextPath}/supervise/supplierUser/rolePage?type=2&userName=${user.userName}','800px','800px')">分配角色</a></td>
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