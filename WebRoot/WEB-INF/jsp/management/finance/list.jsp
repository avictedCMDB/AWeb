<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>֧������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_auditor.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript">
$(function () {
	$("#btn_query").click(function () {
		var supId = $("#sup_id").val();
		var orderId = $("#order_id").val();
		var goodsName = $("#goods_name").val();
		window.location.href="${pageContext.request.contextPath}/management/finance/list?supId=" + supId + "&orderId=" + orderId + "&goodsName=" + goodsName;
	});
	
	$("#btn_clear").click(function () {
		$("#sup_id").val("0");
		$("#order_id").val("");
		$("#goods_name").val("");
	});
	
	$(".btn-refund").click(function () {
		async('${pageContext.request.contextPath}/management/finance/refund', {o:$(this).attr("data-o")}, function (msg) {
			alert("�˿������ѷ�������ȴ������˿�");
			window.location.reload();
		});
	});
});


var loading = false;

var async = function (url, param, callback, failed) {
	if (loading) return;
	loading = true;
	$.ajax({
		url:url,
		type:"POST",
		data:param,
		dataType:"json",
		success:function (msg) {
			loading = false;
			if (msg.hasOwnProperty('status')) {
				if (msg.status === 0) {
					if (callback) {
						callback(msg);
					}
				} else {
					if (failed) {
						failed(msg);
					} else {
						alert(msg.result);
					}
				}
			} else {
				this.error();
			}
		},
		error:function () {
			loading = false;
			alert("����ʧ�ܣ�������");
		}
	});
}
</script>
</head>

<body>
<div class="page-wrapper">
  <div id="header_top">
    <div class="inner">
       <ul class="social-links clearfix">
        <li><a href="javascript:void(0);"><span class="fa fa-user"></span>${sessionScope.login_user.userNameCN}</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/management/finance/index">�ɹ���������</a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}">ƽ̨��ҳ </a><span>|</span></li>
        <li><a href="${pageContext.request.contextPath}/passport/login/logout">�˳�</a><span>|</span></li>
        <li><a href="#">�ͻ�����</a><span>|</span></li>
        <li><a href="#">��վ����</a><span>|</span></li>
       </ul>
    <!--.inner--></div>
  <!--#header_top--></div>
  <div id="header">
    <div class="inner clearfix">
      <div class="logo">
        <img src="${pageContext.request.contextPath}/static/img/management/logo-management.png" alt="�к��б���" />
      </div>
      <div class="search">
        <div class="input-group">
          <input type="text" class="form-control"><span class="input-group-btn"><button class="btn btn-default" type="button">����</button></span>
        </div>
      </div>
      <div class="buy">
        <button class="btn btn-default" type="button" onclick="window.location.href='${pageContext.request.contextPath}/market/cart/list';"><i class="fa fa-shopping-cart shopping"></i>�ҵĹ��ﳵ<i class="fa fa-angle-right arrow-right"></i></button></div>
    <!--.inner--></div>
  <!--#header--></div>
  
  
  <div id="contents">
    <div class="inner">
    	
    	<div id="side_navi">
    		<dl>
    			
    			<dt class="tlt_receipt">���׹���<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd class="last_child">
    				<ul>
    					<li><a href="${pageContext.request.contextPath}/management/finance/list"><span class="fa fa-caret-right"></span>֧������</a></li>
    				</ul>
    			</dd>
    		</dl>
    		<!--#side_navi-->
    	</div>
      
      <div id="matter_section">
      	<h2>֧������</h2>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>��Ӧ������</dt>
              <dd>
              
                <select class="form-control" id="sup_id">
                  <option value="0">ȫ��</option>
                  <c:forEach varStatus="sta" var="item" items="${sups}">
                  <option value="${item.supID}" <c:if test="${item.supID == supId}">selected="selected"</c:if>>${item.supName}</option>
                  </c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�������</dt>
              <dd>
                <input type="text" class="form-control" id="order_id" value="${orderId}">
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>��Ʒ��Ϣ</dt>
              <dd>
                <input type="text" class="form-control" id="goods_name" value="${goodsName}">
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" id="btn_query">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" id="btn_clear">���</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
      	<div class="search_result">
          <div class="state_list">
            <ul>
              <li <c:if test="${orderStatus == '0'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/management/finance/list?supId=${supId}&orderId=${orderId}&goodsName=${goodsName}">ȫ��</a></li>
              <li <c:if test="${orderStatus == '15'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/management/finance/list?supId=${supId}&orderId=${orderId}&goodsName=${goodsName}&orderStatus=15">��֧��</a></li>
              <li <c:if test="${orderStatus == '2'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/management/finance/list?supId=${supId}&orderId=${orderId}&goodsName=${goodsName}&orderStatus=2">֧���ɹ�</a></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th colspan="2">��Ʒ��Ϣ</th>
              <th width="95">����(Ԫ)</th>
              <th width="75">����</th>
              <th width="95">���(Ԫ)</th>
              <th width="110">����״̬</th>
              <th width="110" class="last">����</th>
            </tr>
            
            <c:forEach varStatus="sta" var="item" items="${list}">
            <tr class="company">
              <td colspan="7">
                <ul>
                  <li>������ţ�<a href="${pageContext.request.contextPath}/market/order/detail?o=${item.order_id}">${item.order_id}</a></li>
                  <li>��Ӧ�̣�<span>${item.sup_name }</span></li>
                  <li class="right_box">�µ�ʱ�䣺<span>${item.order_time }</span></li>
                  <li class="right_box">�ϼƣ�<span class="price"><fmt:formatNumber value="${item.order_amount}" pattern="#0.00#"></fmt:formatNumber></span></li>
                  
                </ul>
              </td>
            </tr>
            <c:forEach var="goods" items="${item.snapshots}" varStatus="ista">
            <tr>
              <td class="right_none"><p class="img_pro"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${goods.supId}&gid=${goods.supGoodsId}">
              <c:if test="${goods.supType == 1}">
                <img width="55px" height="55px" alt="" src="${pageContext.request.contextPath}${goods.imagePath == null ? '/static/img/img-profession.jpg' : goods.imagePath}">
				</c:if>
				<c:if test="${goods.supType == 0}">
                <img width="55px" height="55px" alt="" src="${goods.imagePath}">
				</c:if>
              </a></p></td>
              <td width="387" class="left_none"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${goods.supId}&gid=${goods.supGoodsId}">${goods.goodsName}</a></td>
              <td class="price"><fmt:formatNumber value="${goods.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
              <td class="num">${goods.buyNum}</td>
              <td class="price"><fmt:formatNumber value="${goods.goodsPrice * goods.buyNum}" pattern="#0.00#"></fmt:formatNumber></td>
              <c:if test="${ista.index == 0}">
              <td rowspan="${fn:length(item.snapshots)}">
              <c:choose>
				<c:when test="${item.order_status == '15'}">��֧��</c:when>
				<c:when test="${item.order_status == '2'}">֧���ɹ�</c:when>
				<c:when test="${item.order_status == '9'}">���˿�</c:when>
				<c:when test="${item.order_status == '13'}">���˿�</c:when>
			  </c:choose>
              </td>
              <td class="payment" rowspan="${fn:length(item.snapshots)}">
              <c:if test="${item.order_status == '15'}">
              	<a target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=${item.order_id}&t=0002"><span class="fa fa-caret-right"></span>��ҵ֧��</a>
              	<a target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=${item.order_id}&t=0001"><span class="fa fa-caret-right"></span>����֧��</a>
              	<a target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=${item.order_id}&t=0004"><span class="fa fa-caret-right"></span>�޿�֧��</a>
              	<a target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=${item.order_id}&t=0005"><span class="fa fa-caret-right"></span>֧����</a>
              </c:if>
              	<a href="${pageContext.request.contextPath}/market/order/detail?o=${item.order_id}"><span class="fa fa-caret-right"></span>�鿴</a>
              
              </td>
              </c:if>
            </tr>
            </c:forEach>
            
            </c:forEach>
            
          </table>
        <!--.search_result--></div>
      	<jsp:include page="page.jsp" />
      <!--#matter_section-->	
      </div>
      
      
      
      
     
    <!--.inner--></div>
  <!--#contents--></div>
  <div id="footer">
    <div class="inner">
      <div class="section clearfix">
        <div class="tel"><img src="${pageContext.request.contextPath}/static/img/img-tel.png" alt="" /></div>
        <div class="customer_service clearfix">
          <dl>
            <dt class="icon_shopping">����ָ��</dt>
            <dd>
              <ul>
                <li><a href="#">���Ͼ��۲ɹ�</a></li>
                <li><a href="#">����ֱ�Ӳɹ�</a></li>
                <li><a href="#">֧������</a></li>
              </ul>
            </dd>
          </dl>
          <dl>
            <dt class="icon-delivery">���Ͱ���</dt>
            <dd>
              <ul>
                <li><a href="#">���ͽ��Ȳ�ѯ</a></li>
                <li><a href="#">���ͷ�Χ���˷�</a></li>
              </ul>
            </dd>
          </dl>
          <dl>
            <dt class="icon-other">��������</dt>
            <dd>
              <ul>
                <li><a href="#">��ͼ����</a></li>
                <li><a href="#">�ͻ�����</a></li>
                <li><a href="#">��������</a></li>
              </ul>
            </dd>
          </dl>
        </div>
      </div>
    </div>
  <!--#footer--></div>
  <div id="copy_right">
    <div class="inner">
      <p>��Ȩ��Ϣ����ʾ��Ȩ��Ϣ��������</p>
    </div>
  </div>
<!--.page-wrapper--></div>
</body>
</html>