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
<title>供应商管理中心|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_statement.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierStatement.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp">
    		<jsp:param name="menu" value="statement" />
    	</jsp:include>
      <div id="matter_section">
      	<h2>结算单管理</h2>
      	<div class="search_area section">
      	<form id="queryForm" method="post" >
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>生成结算日期</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" name="createTimeStar" value="${supplierStatementParam.createTimeStar}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>至</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" name="createTimeEnd" value="${supplierStatementParam.createTimeEnd}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>结算单编号</dt>
              <dd>
                <input type="text" class="form-control" name="settleId" id="settleId" value="${supplierStatementParam.settleId}"/>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supplier/statement')">查询</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">清空</button></li>
            </ul>
          </div>
          </form>
        <!--.search_area--></div>
      	<div class="search_result">
          <table border="0">
            <tr>
              <th>结算单编号</th>
              <th width="75">单据数量</th>
              <th width="95">商品总数</th>
              <th width="110">结算金额（元）</th>
              <th width="110">创建日期</th>
              <th width="110">结算单状态</th>
              <th width="110" class="last">操作</th>
            </tr>
            <c:forEach var="supplierStatement" items="${supplierStatementList}" varStatus="status">
				<tr>
	              <td>${supplierStatement.settleId}</td>
	              <td>${supplierStatement.orderNum}</td>
	              <td>${supplierStatement.goodsNum}</td>
	              <td>${supplierStatement.settleAmount}</td>
	              <td>${supplierStatement.createTime}</td>
	              <c:choose>
					   <c:when test="${supplierStatement.settleStatus == '1'}">  
					        <td>未生效</td>
					   </c:when>
					   <c:otherwise> 
					    	<td>已生效</td>
					   </c:otherwise>
				  </c:choose>
	              <td><a href="${pageContext.request.contextPath}/supplier/statement/queryDetailed/${supplierStatement.settleId}">查看</a></td>
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
