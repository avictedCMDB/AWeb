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
<title>供应商管理中心|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_order.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrderExchange.js"></script>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	<c:forEach var="supplierQuoteInfo" items="${supplierQuoteInfoList}" varStatus="status">
		$("#img_quote_${status.index}").imgbox();
	</c:forEach>
	});	
</script>
</head>

<body>
<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
  <div id="contents">
    <div class="inner">
      <div id="order_details">
        <div class="section_main pro_info">
          <h2>商品信息</h2>
          <table>
            <tr>
              <th colspan="2">商品名称</th>
              <th width="200">单价（元）</th>
              <th width="200">数量（个）</th>
              <th width="200">总价（元）</th>
            </tr>
            <c:forEach varStatus="sta" var="item" items="${order.snapshots}">
            <tr>
              <td class="left_align" width="77">
                <p class="img_pro"><a href="#"><img alt="" src="${item.imagePath}" width="55px" height="55px"/></a></p>
              </td>
              <td class="left_align"><a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${item.supGoodsId}" target="_blank">${item.goodsName}(${item.goodsModel})</a></td>
              <td><fmt:formatNumber value="${item.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
              <td>${item.buyNum}</td>
              <td><fmt:formatNumber value="${item.goodsPrice * item.buyNum}" pattern="#0.00#"></fmt:formatNumber></td>
            </tr>
            </c:forEach>
          </table>
        </div>
        <div class="section_main clearfix section_inner">
          <div class="special_area first">
            <h2>地址信息</h2>
            <div class="details_list">
              <dl class="dl-horizontal">
                <dt>配送要求：</dt>
                <dd>${order.expressType == 1 ? '物流配送' : '上门自取'}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>配送地址：</dt>
                <dd>${fn:escapeXml(order.addrDetail)}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>收件人姓名：</dt>
                <dd>${order.addrName}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>联系电话：</dt>
                <dd>${order.addrPhone == '' ? order.addrTel : order.addrPhone}</dd>
              </dl>
            </div>
          </div>
          <div class="special_area">
            <h2>报价单信息</h2>
            <div class="details_list">
              <dl class="dl-horizontal">
                <dt>客户：</dt>
                <dd><input class="form-control" type="text" name="companyname" value="${order.companyname}" readonly="readonly" id="companyname"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>联系人：</dt>
                <dd><input class="form-control" type="text" name="contactPerson" value="${order.contactPerson}"  id="contactPerson" readonly="readonly"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>电话：</dt>
                <dd><input class="form-control" type="text" name="contactNum" value="${order.contactNum}"  id="contactNum" readonly="readonly"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>传真：</dt>
                <dd><input class="form-control" type="text" name="contactFax" value="${order.contactFax}"  id="contactFax" readonly="readonly"/></dd>
              </dl>
            </div>
          </div>
          <div class="special_area">
            <div class="details_list details_list_special">
                <dl class="dl-horizontal">
                <dt>日期：</dt>
                <dd><input type="text" name="signDate" id="sendPerson" value="${supplierQuoteInfo.quoteDate}" class="form-control special_input" readonly="readonly"/>
                </dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>发件人：</dt>
                <dd><input type="text" name="signDate" id="sendPerson" value="${supplierQuoteInfo.sendPerson}" class="form-control special_input" readonly="readonly"/>
                </dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>手机：</dt>
                <dd><input type="text" name="sendPersonTel" id="sendPersonTel" value="${supplierQuoteInfo.sendPersonTel}" class="form-control special_input" readonly="readonly"/>
                </dd>
              </dl>
               <dl class="dl-horizontal">
                <dt>传真：</dt>
                <dd><input type="text" name="sendPersonFax" id="signDate" value="${supplierQuoteInfo.sendPersonFax}" class="form-control special_input" readonly="readonly"/>
                </dd>
              </dl>
            </div>
          </div>
          <div class="special_area">
            <h2>报价单</h2>
            <div class="details_list">
                <c:forEach varStatus="sta" var="item" items="${supplierQuoteInfoList}">
                	<c:if test="${isPicture =='0'}">
                		<a id="img_quote_${sta.index}" href="${pageContext.request.contextPath}${item.quoteAttachmentPath}"><img src="${pageContext.request.contextPath}${item.quoteAttachmentPath}" width="80px" height="80px"/></a>
                	</c:if>
                	<c:if test="${isPicture !='0'}">
                		<a href="${pageContext.request.contextPath}/supplier/order/downloadContract?downFile=${item.quoteAttachmentPath}" class="download">${item.fileName}</a>
                	</c:if>
                </c:forEach>
            </div>
          </div>
          </div>
        <div class="btn_list">
          <ul class="list-inline">
            <li><button type="button" class="btn btn-default gray" onclick="history.go(-1);">返回</button></li>
          </ul>
        </div>
      <!--.order_details--></div>
      
      
      
      <!--.inner--> 
    </div>
    <!--#contents--> 
  </div>
	<jsp:include page="../footer.jsp" />
  <!--.page-wrapper--> 
</div>
</body>
</html>