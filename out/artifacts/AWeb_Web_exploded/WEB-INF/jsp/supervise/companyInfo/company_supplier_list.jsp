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
<title>采购单位管理|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_gongyingshang.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/businessEnterprise.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
<input id="adminType" type="hidden" value="${adminType}"/>
<div class="page-wrapper">
 <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
      <jsp:include page="../left.jsp">
		  <jsp:param name="menu" value="businessEnterprise" />
	  </jsp:include>
      <div id="matter_section">
      	<h2>采购单位管理</h2>
      	<div class="search_area section">
      	<form action="${pageContext.request.contextPath}/supervise/companyInfo" id="companyForm" method="post">
          <div class="search_list clearfix">
            <%-- <dl class="clearfix">
              <dt>组织机构编号：</dt>
              <dd>
                <input type="text" class="form-control" name="companyCode" id="companyCode" value="${companyCode}">
              </dd>
            </dl> --%>
             <dl class="clearfix">
              <dt>企业名称：</dt>
              <dd>
                <input type="text" class="form-control" name="companyName" id="companyName" value="${companyName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>管理账号：</dt>
              <dd>
                <input type="text" class="form-control" name="userName" id="userName" value="${userName}">
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>联系人：</dt>
              <dd>
                <input type="text" class="form-control" name="contactPerson" id="contactPerson" value="${contactPerson}">
              </dd>
            </dl>
            <dl class="clearfix first">
              <dt>联系电话：</dt>
              <dd>
                <input type="text" class="form-control" name="contactIphone" id="contactIphone" value="${contactIphone}">
              </dd>
            </dl>
            
            <%-- <c:if test="${adminType=='1'}">
            <dl class="clearfix last">
              <dt>用户类型：</dt>
              <dd>
              	<select class="form-control" name="companyType" id="companyType">
                	<option value="">全部</option>
                	<option value="1" <c:if test="${companyType=='1'}">selected="selected"</c:if>>传统供应商</option>
                	<option value="2" <c:if test="${companyType=='2'}">selected="selected"</c:if>>采购单位</option>
                </select>
              </dd>
            </dl>
             </c:if> --%>
	           <dl class="clearfix">
	           <dt>审核状态：</dt>
	           <dd>
	           	<select class="form-control" name="ifCheck" id="ifCheck">
	             	<option value="">全部</option>
	             	<option value="0" <c:if test="${ifCheck=='0'}">selected="selected"</c:if>>待审核</option>
	             	<option value="1" <c:if test="${ifCheck=='1'}">selected="selected"</c:if>>通过</option>
	             	<option value="2" <c:if test="${ifCheck=='2'}">selected="selected"</c:if>>拒绝</option>
	             	<option value="3" <c:if test="${ifCheck=='3'}">selected="selected"</c:if>>资料未完善待审核</option>
	             </select>
	           </dd>
	         </dl>
	         <dl class="clearfix last">
              <dt>创建时间：</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" class=" form-control special_input" name="timeStart" id="timeStart" value="${timeStart}" readonly="readonly" style="background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeStart').focus()"></i></span>
                    </div>
                  </li>
                  <li>-</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" class=" form-control special_input" name="timeEnd" id="timeEnd" value="${timeEnd}" readonly="readonly" style="background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeEnd').focus()"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="searchCompany();">查询</button></li>
              <!-- <li><button type="button" class="btn btn-default red" onclick="addCompanyInfo();">新增组织机构</button></li> -->
              <li><button type="button" class="btn btn-default gray" onclick="clean();">清空</button></li>
            </ul>
          </div>
            
        <!--.search_area--></div>
        </form>
      	<div class="search_result">
          <table border="0">
            <tr>
              <th>企业名称</th>
              <th width="90">企业类型</th>
              <th width="70">管理账号</th>
              <th width="70">企业联系人</th>
              <th width="90">手机</th>
              <th width="120">邮箱</th>
              <th width="90">创建时间</th>
              <th width="70">审核状态</th>
              <th width="120" class="last">操作</th>
            </tr>
            <c:forEach var="company" items="${companyInfos}" varStatus="status">
	            <tr>
	              <td class="left-align">${company.companyName}</td>
	              	<td>
		              	<c:if test="${company.companyType == '1'}">
		              		传统供应商
		              	</c:if>
		              	<c:if test="${company.companyType == '2'}">
		              		采购单位
		              	</c:if>
	              	</td>
	              	<td>${company.userName}</td>
	              	<td>${company.contactPerson}</td>
	              	<td>${company.contactIphone}</td>
	              	<td>${company.contactEmail}</td>
	              	<td>${company.createDate}</td>
	              	<td>
		              	<c:if test="${company.ifCheck == '0'}">
		              		待审核
		              	</c:if>
		              	<c:if test="${company.ifCheck == '1'}">
		              		通过
		              	</c:if>
		              	<c:if test="${company.ifCheck == '2'}">
		              		拒绝
		              	</c:if>
		              	<c:if test="${company.ifCheck == '3'}">
		              		资料未完善待审核
		              	</c:if>
	              	</td>
	              	
	              <td>
	              	  <a href="javascript:void(0);" onclick="addCompanyInfo('${company.id}')">修改</a>
	              	  <a href="javascript:void(0);" onclick="delCompanyInfo('${company.id}','${company.companyType}')">删除</a>
	              	  <a href="javascript:void(0);" onclick="checkInit('${company.id}')">审核</a>
	              	  <a href="javascript:void(0);" onclick="selDepartment('${company.companyCode}')">企业人员信息</a>
				  </td>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
        <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>