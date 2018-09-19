<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>采购监管平台|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_contract.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/superviseContract.js"></script>
<script type="text/javascript">
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../../header.jsp" />
  <div id="header"><!--#header--></div>
  <input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
  <div id="contents">
    <div class="inner">
    	<jsp:include page="../../left.jsp">
    		<jsp:param value="contract" name="menu"/>
    	</jsp:include>
	      <div id="matter_section">
	      	<h2>合同管理</h2>
	      	<div class="search_area section">
    		<form action="${pageContext.request.contextPath}/business/contract" id="searchForm" method="post">
	          <div class="search_list clearfix">
	          
	            <dl class="clearfix first">
	              <dt>合同编号：</dt>
	              <dd>
	                <input type="text" id="contract_code" name="contract_code" class="form-control" value="${searchContract.contract_code}"/>
	              </dd>
	            </dl>
	            <dl class="clearfix">
	              <dt>业务ID：</dt>
	              <dd>
	                <input type="text" id="busi_id" name="busi_id" class="form-control" value="${searchContract.busi_id}"/>
	              </dd>
	            </dl>
	            <dl class="clearfix last">
	              <dt>业务类型：</dt>
	              <dd>
	                <select id="busi_type" name="busi_type" class="form-control">
		                <option value="">全部</option>
	                	<option value="0" <c:if test="${searchContract.busi_type == '0'}"> selected="selected" </c:if> >专业市场</option>
	                	<option value="1" <c:if test="${searchContract.busi_type == '1'}"> selected="selected" </c:if>>电子竞价</option>
	                </select>
	              </dd>
	            </dl>

	            <dl class="clearfix first">
	              <dt>合同签订日期：</dt>
	              <dd>
	                <ul class="clearfix">
	                <li>
	                  <div class="input-group">
	                    <input type="text" id="begin_date" name="begin_date" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${searchContract.begin_date}"/>
	                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                  </div>
	                </li>
	                <li>至</li>
	                <li class="last">
	                  <div class="input-group">
	                    <input type="text" id="end_date" name="end_date" class="form-control special_input"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${searchContract.end_date}"/>
	                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
	                  </div>
	                </li>
	              </ul>
	              </dd>
	            </dl>
	            
	          </div>
	          <div class="btn_list">
	            <ul>
	              <li><button type="button" class="btn btn-default red" onclick="search();">查询</button></li>
	              <li><button type="button" class="btn btn-default gray" onclick="makeClear(this.form);">清空</button></li>
	            </ul>
	          </div>
	          </form>
	        <!--.search_area--></div>
	      	<div class="search_result section">
	          <table border="0">
	            <tr>
	              <th width="120">合同编号</th>
	              <th width="220">业务ID</th>
	              <th width="280">成交供应商</th>
	              <th width="120">合同签订日期</th>
	              <th width="250">业务类型</th>
	              <th width="100" class="last">操作</th>
	            </tr>
	            
            <c:forEach var="contract" items="${contracts}" varStatus="status">
	            <tr>
	              <td width="120">${contract.contract_code}</td>
	              <td width="200">
	              <c:if test="${contract.busi_type == '0'}">
	              	<a href="${pageContext.request.contextPath}/supervise/order/list?orderId=${contract.busi_id}">${contract.busi_id}</a>
	              </c:if>
	              <c:if test="${contract.busi_type == '1'}">
	              	<a href="${pageContext.request.contextPath}/supervise/bid/project/detail?projId=${contract.busi_id}">${contract.busi_id}</a>
	              </c:if>
	              </td>
	              <td width="300">${contract.sup_name}</td>
	              <td width="120">${contract.sign_date}</td>
	              <td width="120">
	              <c:if test="${contract.busi_type == '0'}">
	              	专业市场
	              </c:if>
	              <c:if test="${contract.busi_type == '1'}">
	              	 电子竞价
	              </c:if>
	              </td>
	              <td width="100">
	              	<a href='${pageContext.request.contextPath}/supervise/contract/view?projId=${contract.busi_id}&busi_type=${contract.busi_type}' target='_blank'>查看</a>
	              </td>
	            </tr>
            </c:forEach>
	          </table>
	        <!--.search_result-->
	        </div>
        <jsp:include page="../../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>