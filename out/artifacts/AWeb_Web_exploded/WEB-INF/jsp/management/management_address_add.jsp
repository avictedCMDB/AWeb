<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>地址管理|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_address.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/area.js"></script>
</head>
<body>
<input type="hidden" id="rootUrl" value="${pageContext.request.contextPath}/static/">
<input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
<div class="page-wrapper">
   <jsp:include page="header.jsp" />  
  <div id="contents">
    <div class="inner details">
      <h2>新增地址</h2>
      <form id="marketAddressForm"  method="post">
      	<input id="arseaLebelOne" name="arseaLebelOne" type="hidden"/>
	    <input id=areaLebelTwo name="areaLebelTwo" type="hidden"/>
		<input id="areaLebelThree" name="areaLebelThree" type="hidden"/>
		<input id="areaLevelFour" name="areaLevelFour" type="hidden"/>
		<input id="strArseaLebelOne" name="strArseaLebelOne" type="hidden" value="${marketAddress.arseaLebelOne}"/>
		<input id=strAreaLebelTwo name="strAreaLebelTwo" type="hidden" value="${marketAddress.areaLebelTwo}"/>
		<input id="strAreaLebelThree" name="strAreaLebelThree" type="hidden" value="${marketAddress.areaLebelThree}"/>
		<input id="strAreaLebelFour" name="strAreaLebelFour" type="hidden" value="${marketAddress.areaLevelFour}"/>
			          	  
		<input type="hidden" id="supIDParam" value="${marketAddress.supID}"/>
	      <div class="add_details">
	      	<c:choose>
				<c:when test="${empty marketAddress}"> 
				 <dl class="clearfix">
		          <dt><span class="red_remind">*</span>收货人姓名：</dt>
		          <dd>
		          	
		          	<input id="name" name="name" type="text" class="form-control">
		          </dd>
		        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>供应商：</dt>
			          <dd>
			          	<select id="supID" name="supID" class="form-control" onchange="addAreaSel();">
			                <option value="" selected="selected">请选择</option>
			            </select>
			          </dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>所在地区：</dt>
			          <dd id="areaDD">
			          	  
			              <select id="arseaLebelSelOne" name="arseaLebelSelOne" class="form-control" onchange="checkCity();">
			             	<option value="" selected="selected">请选择</option>
			              </select>
			              <select id="areaLebelSelTwo" name="areaLebelSelTwo" class="form-control"  onchange="checkDistrict();">
			              	<option value="" selected="selected">请选择</option>
			              </select>
			              <select id="areaLebelSelThree" name="areaLebelSelThree" class="form-control"  onchange="checkAreaLebelSelThree();">
			              	<option value="" selected="selected">请选择</option>
			              </select>
			          </dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>详细地址：</dt>
			          <dd><input id="addressDetail" name="addressDetail" type="text" class="form-control"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>电子邮箱：</dt>
			          <dd><input id="email" name="email" type="text" class="form-control"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>手机号码：</dt>
			          <dd><input id="phone" name="phone" type="text" maxlength="11" class="form-control"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>邮政编码：</dt>
			          <dd><input id="zipCode" name="zipCode" type="text" maxlength="6" class="form-control"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dd>
			          	是否设置默认：
			          	<input id="ifDefaultCB" name="ifDefaultCB" type="checkbox">
			          	<input id="ifDefault" name="ifDefault" type="hidden">
			          </dd>
			        </dl>
			        <div class="btn_add btn_middle">
			          <ul>
			            <li><button type="button" class="btn btn-default red" onclick="editMarketAddress(1);">保存</button></li>
			            <li><button type="button" class="btn btn-default gray" onclick="cancle();">取消</button></li>
			          </ul>
			        </div>
			    </c:when>
				<c:otherwise> 
					<input type="hidden" id="updAddressID" value="${marketAddress.addressID}"/>
					<dl class="clearfix">
			          <dt><span class="red_remind">*</span>收货人姓名：</dt>
			          <dd>
			          	
			          	<input id="name" name="name" type="text" class="form-control" value="${marketAddress.name}">
			          </dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>供应商：</dt>
			          <dd>
			          	<select id="supID" name="supID" class="form-control" onchange="addAreaSel();">
			                <option value="" selected="selected">请选择</option>
			            </select>
			          </dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>所在地区：</dt>
			          <dd id="areaDD">
			              <select id="arseaLebelSelOne" name="arseaLebelSelOne" class="form-control" onchange="checkCity();">
			              	<option value="">请选择</option>
			              </select>
			              <select id="areaLebelSelTwo" name="areaLebelSelTwo" class="form-control"  onchange="checkDistrict();">
			              	<option value="">请选择</option>
			              </select>
			              <select id="areaLebelSelThree" name="areaLebelSelThree" class="form-control"  onchange="checkAreaLebelSelThree();">
			              	<option value="">请选择</option>
			              </select>
			          </dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>详细地址：</dt>
			          <dd><input id="addressDetail" name="addressDetail" type="text" class="form-control" value="${marketAddress.addressDetail}"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>电子邮箱：</dt>
			          <dd><input id="email" name="email" type="text" class="form-control" value="${marketAddress.email}"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>手机号码：</dt>
			          <dd><input id="phone" name="phone" type="text" maxlength="11" class="form-control" value="${marketAddress.phone}"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dt><span class="red_remind">*</span>邮政编码：</dt>
			          <dd><input id="zipCode" name="zipCode" type="text" maxlength="6" class="form-control" value="${marketAddress.zipCode}"></dd>
			        </dl>
			        <dl class="clearfix">
			          <dd>
			          	是否设置默认：
			          	<c:choose>
						   <c:when test="${marketAddress.ifDefault == '1'}">  
						        <input id="ifDefaultCB" name="ifDefaultCB" type="checkbox" checked="checked">
						   </c:when>
						   <c:otherwise> 
						    	<input id="ifDefaultCB" name="ifDefaultCB" type="checkbox">
						   </c:otherwise>
				  		</c:choose>
			          	<input id="ifDefault" name="ifDefault" type="hidden">
			          </dd>
			        </dl>
			        <div class="btn_add btn_middle">
			          <ul>
			            <li><button type="button" class="btn btn-default red" onclick="editMarketAddress(2);">保存</button></li>
			            <li><button type="button" class="btn btn-default gray" onclick="cancle();">取消</button></li>
			          </ul>
			        </div>
				</c:otherwise>
			</c:choose>
	      </div>
      </form>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>