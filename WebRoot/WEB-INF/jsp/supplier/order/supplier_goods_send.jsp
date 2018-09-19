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
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_info.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrder.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>

</head>

<body>
<div class="return_pro inner">
  <h2>商品发货</h2>
  <div class="add_details">
   <!--  <div class="info_mian">
      <label>商品编号：</label>
      <span>${supplierGoodsPrice.supGoodsId}</span>
      <label>商品名称 ：</label>
      <span>${supplierGoodsPrice.goodsName} </span>
    </div> -->
    <h3>发货</h3>
 	<form id="supplierSubmit"  method="post">
    <table>
      <tr>
        <th width="200">物流名称</th>
        <th width="200">物流单号（多个物流单号以，分割）</th>
      </tr>
      <tr>
        <td><input type="text"  size="50" maxlength="32" id="supExpressName"/></td>
        <td><input type="text" size="50" maxlength="16" id="supExpressCode"/></td>
      </tr>
    </table>
    </form>
   <div class="btn_area">
    <ul>
      <li><button type="button" class="btn btn-default red" onclick="doSend('${pageContext.request.contextPath}/supplier/order/doSend','${orderId}')">确认</button></li>
      <li><button type="button" class="btn btn-default gray" onclick="window.close();">取消</button></li>
    </ul>
  </div>
  </div>

</div>
</body>
</html>
