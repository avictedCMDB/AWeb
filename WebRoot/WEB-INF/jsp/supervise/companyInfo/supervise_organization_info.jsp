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
<link href="${pageContext.request.contextPath}/static/css/supervise_organization_info.css" rel="stylesheet">
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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/validateUtil.js"></script>
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

function searchUsers(){
	var path = $("#path").val();
	document.getElementById("searchUsersForm").action = path+"/supervise/companyInfo/organizationInfo";
	document.getElementById("searchUsersForm").submit();
}
function selEmployee(companyCode){
	var path = $("#path").val();
	$("#searCompanyCode").val(companyCode);
	window.location.href=path+"/supervise/companyInfo/organizationInfo?searCompanyCode="+companyCode;
	/* document.getElementById("searchUsersForm").action = path+"/supervise/companyInfo/organizationInfo?searCompanyCode="+companyCode;
	document.getElementById("searchUsersForm").submit(); */
}

function clearSearch(){
	$("#userName").val("");
	$("#contactPerson").val("");
	$("#contactNum").val("");
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
		  <jsp:param name="menu" value="organizationInfo" />
	  </jsp:include>
      <div id="matter_section">
        <h2>机构管理</h2>
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
          <div class="nav_table clearfix">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#list_info" data-toggle="tab">用户列表</a></li>
                <li><a href="#add_organization" data-toggle="tab">机构添加</a></li>
              </ul>
            </div>
          <form action="" id="searchUsersForm" method="post" >
          	<input type="hidden" value="${companyCode}" id="companyCode" name="companyCode">
          	<input type="hidden" value="${searCompanyCode}" id="searCompanyCode" name="searCompanyCode">
          	<div class="tab-con tab-content">
              <div id="list_info" class="tab-pane fade in active">
            <div class="search_area section">
              <div class="search_list clearfix">
                <dl class="clearfix">
                  <dt>用户名：</dt>
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
                </ul>
              </div>
            </div>
            </form>
            <div class="search_result">
              <table border="0">
                <tr>
                  <th class="left-list">归属公司</th>
                  <th class="left-list" width="70">归属部门</th>
                  <th width="70">登录名</th>
                  <th width="70">联系人</th>
                  <th width="70">电话</th>
                  <th width="70">邮箱</th>
                  <th class="last" width="110">操作</th>
                </tr>
                	<c:forEach var="u" items="${userList}" varStatus="status">
                	<tr>
                		<td>${companyNameRoot}</td>
                	 	<td>${u.companyName}</td>
		                <td>${u.userName}</td>
		                <td>${u.contactPerson}</td>
		                <td>${u.contactNum}</td>
		                <td>${u.contactFax}</td>
		                <td><a href="${pageContext.request.contextPath}/supervise/supplierUser?menuParam=user">采购人用户管理</a></td>
                	</tr>
                	</c:forEach>
              </table>
            </div>
            <jsp:include page="../page.jsp" />
            </div>
             <div id="add_organization" class="tab-pane fade in">
             <form action="" id="organizationForm">
                <div class="search_area section">
                  <div class="search_list clearfix">
                    <dl>
                      <dt>上级机构：</dt>
                      <dd>
                        <select class="form-control" id="parentCompanyId" name="parentCompanyId">
                          <option value="-1" selected="selected">请选择</option>
                          <c:forEach var="organizationDepartment" items="${organizationDepartments}" varStatus="status">
                          	<option value="${organizationDepartment.companyCode}">${organizationDepartment.companyName}</option>
                          </c:forEach>
                        </select>
                      </dd>
                    </dl>
                    <dl>
                      <dt>机构名称：</dt>
                      <dd><input type="text" class="form-control" id="addCompanyName" name="addCompanyName"></dd>
                    </dl>
                    <dl>
                      <dt>联系人：</dt>
                      <dd><input type="text" class="form-control" id="addContactPerson" name="addContactPerson"></dd>
                    </dl>
                    <dl>
                      <dt>电话：</dt>
                      <dd><input type="text" class="form-control" id="addContactIphone" name="addContactIphone"></dd>
                    </dl>
                    <dl>
                      <dt>传真：</dt>
                      <dd><input type="text" class="form-control" id="addContactFax" name="addContactFax"></dd>
                    </dl>
                    <dl>
                      <dt>邮箱：</dt>
                      <dd><input type="text" class="form-control" id="addContactEmail" name="addContactEmail"></dd>
                    </dl>
                  </div>
                  <div class="btn_list">
                    <ul>
                      <li><button type="button" class="btn btn-default red" onclick = "saveOrganizationInfo();">保存</button></li>
                    </ul>
                  </div>
                </div>
				</form>
              </div>
              
              <!-- 修改机构 -->
              <input type="hidden" id="updCompanyInfoID">
              <input type="hidden" id="compareCompanyName">
              <div class="modal fade" id="change" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                   <div class="modal-dialog">
                     <div class="modal-content">
                       <div class="modal-header">
                         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                         <h4 class="modal-title" id="myModalLabel">组织结构管理</h4>
                       </div>
                      
                       <div class="modal-body">
                         <div class="form-group clearfix">
                           <label class="col-sm-2 control-label">上级机构：</label>
                           <div class="col-sm-10">
                             <select class="form-control" id="updParentCompanyId" name="updParentCompanyId">
	                          <c:forEach var="organizationDepartment" items="${organizationDepartments}" varStatus="status">
	                          	<option value="${organizationDepartment.companyCode}">${organizationDepartment.companyName}</option>
	                          </c:forEach>
	                        </select>
                           </div>
                         </div>
                         <div class="form-group clearfix">
                           <label class="col-sm-2 control-label">机构名称：</label>
                           <div class="col-sm-10">
                             <input class="form-control" id="updCompanyName">
                           </div>
                         </div>
                         <div class="form-group clearfix">
                           <label class="col-sm-2 control-label">联系人：</label>
                           <div class="col-sm-10">
                             <input class="form-control" id="updContactPerson">
                           </div>
                         </div>
                         <div class="form-group clearfix">
                           <label class="col-sm-2 control-label">电话：</label>
                           <div class="col-sm-10">
                             <input class="form-control" id="updContactIphone">
                           </div>
                         </div>
                         <div class="form-group clearfix">
                           <label class="col-sm-2 control-label">传真：</label>
                           <div class="col-sm-10">
                             <input class="form-control" id="updContactFax">
                           </div>
                         </div>
                         <div class="form-group clearfix">
                           <label class="col-sm-2 control-label">邮箱：</label>
                           <div class="col-sm-10">
                             <input class="form-control" id="updContactEmail">
                           </div>
                         </div>
                       </div>
                       <div class="modal-footer">
                         <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">关闭</button>
                         <button type="button" class="btn btn-primary" onclick="updateOrganizationInfo();">提交更改</button>
                       </div>
                     </div>
                   </div>
                 </div>
        </div>
       </div>
	</div>
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>