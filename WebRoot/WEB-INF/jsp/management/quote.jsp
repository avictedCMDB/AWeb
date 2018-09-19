<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>非标商品需求|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/quote.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/professionSpecialGoods.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/imgUpload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/quote.js"></script>
</head>

<body>
<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath}"/>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">报价单<a href="javascript:void(0);"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
      <div class="list_area clearfix">
          <div class="section_area">
              <h2>${quote.supName}</h2>
              <div class="info_list clearfix">
                  <dl class="clearfix">
                      <dt>客户：</dt>
                      <dd>${quote.buyCompany}</dd>
                  </dl>
                  <dl class="clearfix">
                      <dt>日期：</dt>
                      <dd>${quote.quoteDate}</dd>
                  </dl>
                  <dl class="clearfix">
                      <dt>联系人：</dt>
                      <dd>${quote.contactName}</dd>
                  </dl>
                  <dl class="clearfix">
                      <dt>发件人：</dt>
                      <dd>${quote.sendPerson}</dd>
                  </dl>
                  <dl class="clearfix">
                      <dt>电话：</dt>
                      <dd>${quote.contactTel}</dd>
                  </dl>
                  <dl class="clearfix">
                      <dt>手机：</dt>
                      <dd>${quote.sendPersonTel}</dd>
                  </dl>
                  <dl class="clearfix">
                      <dt>传真：</dt>
                      <dd>${quote.contactFax}</dd>
                  </dl>
                  <dl class="clearfix">
                      <dt>传真：</dt>
                      <dd>${quote.sendPersonFax}</dd>
                  </dl>
              </div>
              <div class="price">合计：<span>${amount}</span>元</div>
              <table>
                  <thead>
                      <tr>
                          <th width="110">品牌</th>
                          <th>名称</th>
                          <th width="110">型号</th>
                          <th width="110">数量</th>
                          <th class="last" width="120">单价（含税）</th>
                      </tr>
                  </thead>
                  <tbody>
                     <c:forEach var="qs" items="${quoteSnapshots}" varStatus="status">
	                     <tr>
	                          <td>${qs.brandName}</td>
	                          <td>${qs.goodsName}</td>
	                          <td>${qs.goodsModel}</td>
	                          <td>${qs.buyNum}</td>
	                          <td>${qs.goodsPrice}</td>
	                      </tr>
                     </c:forEach>
                      
                  </tbody>
              </table>
              <div class="info_list special clearfix">
                  <dl class="clearfix">
                     <dd>报价单附件：
                     <c:if test="${paths.size()>0}">
                        <c:forEach var="path" items="${paths}" varStatus="status">
                        	<a href="${pageContext.request.contextPath}/management/order/downloadQuote?qupteAttachmentPath=${path}">${fileNames.get(status.index)}</a>
                        </c:forEach>
                     	
                     </c:if>
                     </dd>
                  </dl>
              </div>
          </div>
       </div>
       <div class="btn_list">
          <button class="btn btn-default gray" onclick="cancle();">返回</button>
       </div>
    </div>
</div>
</div>
</body>
</html>