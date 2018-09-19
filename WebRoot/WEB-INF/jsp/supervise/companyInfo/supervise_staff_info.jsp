<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>组织机构管理|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_staff_info.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/businessEnterprise.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/myTree/myTree.js"></script>
<script type="text/javascript">
/* $(function () {
    $("#ul_tree").jqtree({
        data: testdata,
        param: { },
        onBeforeLoad: function (param) {
        },
        onLoadSuccess: function (data) {  
        },
        onClickNode: function (selector) {
        }
    });
}); */
/* $(function () {
	var path = $("#path").val();
    $("#ul_tree").myTree({
        url: path+"/supervise/companyInfo/getTreeData",
        param: {'companyCode':$("#companyCode").val()},
        onBeforeLoad: function (param) {
        },
        onLoadSuccess: function (data) {
        },
        onClickNode: function (selector) {
        }
    });
}); */
$(function () {
	var searCompanyCode = $("#searCompanyCode").val();
	var companyCode = $("#companyCode").val();
	if(searCompanyCode!=null && searCompanyCode!=""){
		//$("#span_"+searCompanyCode).addClass("");
		$("#span_"+searCompanyCode).css("color","red");
	}else{
		//$("#span_"+companyCode).addClass("");
		$("#span_"+companyCode).css("color","red");
	}
});
function selEmployee(companyCode){
	var path = $("#path").val();
	$("#searCompanyCode").val(companyCode);
	document.getElementById("searchUsersForm").action = path+"/supervise/companyInfo/selDepartment";
	document.getElementById("searchUsersForm").submit();
}

function searchUsers(){
	var path = $("#path").val();
	document.getElementById("searchUsersForm").action = path+"/supervise/companyInfo/selDepartment";
	document.getElementById("searchUsersForm").submit();
}

function backToList(){
	var path = $("#path").val();
	window.location.href=path+"/supervise/companyInfo/businessEnterprise";
}

function clearSearch(){
	$("#userName").val('');
	$("#contactPerson").val('');
	$("#contactNum").val('');
}
</script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
 <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
      <jsp:include page="../left.jsp">
		  <jsp:param name="menu" value="staffInfo" />
	  </jsp:include>
      <div id="matter_section">
        <h2>企业人员信息管理</h2>
        <div class="matter_inner clearfix">
          <div class="left_inner">
            <div class="tree_area clearfix">
	            <c:forEach var="department" items="${departments}" varStatus="status">
		         	${department}
		        </c:forEach>
            	<!-- <div class="tree">
				    <ul id="ul_tree">
				    </ul>
				</div> -->
            </div>
          </div>
          <div class="right_inner">
          <form action="" id="searchUsersForm" method="post" >
          	<input type="hidden" value="${companyCode}" id="companyCode" name="companyCode">
          	<input type="hidden" value="${searCompanyCode}" id="searCompanyCode" name="searCompanyCode">
            <div class="search_area section">
              <div class="search_list clearfix">
                <dl class="clearfix">
                  <dt>登录名：</dt>
                  <dd><input type="text" class="form-control" name="userName" id="userName" value="${user.userName}"></dd>
                </dl>
                <dl class="clearfix">
                  <dt>联系人：</dt>
                  <dd><input type="text" class="form-control" name="contactPerson" id="contactPerson" value="${user.contactPerson}"></dd>
                </dl>
                <dl class="clearfix last">
                  <dt>联系人电话：</dt>
                  <dd><input type="text" class="form-control" name="contactNum" id="contactNum" value="${user.contactNum}"></dd>
                </dl>
              </div>
              <div class="btn_list">
                <ul>
                  <li><button type="button" class="btn btn-default red" onclick = "searchUsers();">查询</button></li>
                  <li><button type="button" class="btn btn-default red" onclick = "clearSearch();">清空</button></li>
                   <li><button type="button" class="btn btn-default red" onclick = "backToList();">返回</button></li>
                </ul>
              </div>
            </div>
            </form>
            <div class="search_result">
              <table border="0">
                <tr>
                  <th  width="90" class="left-list">归属公司</th>
                  <th class="left-list" width="90">归属部门</th>
                  <th width="50">登录名</th>
                  <th width="60">联系人</th>
                  <th width="70">电话</th>
                  <th width="30">邮箱</th>
                  <th class="last" width="130">操作</th>
                </tr>
                	<c:forEach var="u" items="${userList}" varStatus="status">
                	<tr>
                		<td>${companyNameRoot}</td>
                	 	<td>${u.companyName}</td>
		                <td>${u.userName}</td>
		                <td>${u.contactPerson}</td>
		                <td>${u.contactNum}</td>
		                <td>${u.email}</td>
		                <td><a href="${pageContext.request.contextPath}/supervise/supplierUser?menuParam=user&userName=${u.userName}">采购人用户管理</a></td>
                	</tr>
                	</c:forEach>
              </table>
            </div>
            <jsp:include page="../page.jsp" />
        </div>
       </div>

      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>