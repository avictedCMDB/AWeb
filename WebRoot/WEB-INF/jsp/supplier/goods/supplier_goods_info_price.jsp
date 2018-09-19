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
<title>��Ӧ�̹�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_goods_info.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
</head>

<body>
<div class="return_pro inner">
  <h2>��Ʒ�۸�</h2>
  <div class="add_details">
    <div class="info_mian">
      <label>��Ʒ��ţ�</label>
      <span>${supplierGoodsPrice.supGoodsId}</span>
      <label>��Ʒ���� ��</label>
      <span>${supplierGoodsPrice.goodsName} </span>
    </div>
    <div class="info_mian">
      <label>��ǰ��ƷĿ¼�µ���߽�������Ϊ(%)��</label>
      <span>0.00</span>
      <label>���㹫ʽ��</label>
      <span>�������� =�����ۼ۸�-�����۸�/�����۸� </span>
    </div>
    <div class="info_mian">
      <label>��ǰ��ƷĿ¼�µ�����Ż���Ϊ(%)��</label>
      <span>0.00</span>
      <label>���㹫ʽ��</label>
      <span>�Ż��� =���г��۸�-���ۼ۸�/�г��۸�</span>
    </div>
    <h3>ƥ��۸�</h3>
    <table>
      <tr>
        <th>SKU����</th>
        <th>SKU����</th>
        <th>���ۼ۸�</th>
        <th>�г��۸�</th>
        <th>�Ż���(%)</th>
        <th>�����۸� </th>
        <th>��������(%)</th>
      </tr>
      <tr>
        <td>1h1069</td>
        <td></td>
        <td><input class="form-control" disabled="disabled"/></td>
        <td><input class="form-control" disabled="disabled"/></td>
        <td><input class="form-control" value="${supplierGoodsPrice.salePrice}" disabled="disabled"/></td>
        <td><input class="form-control" disabled="disabled"/></td>
        <td><input class="form-control" disabled="disabled"/></td>
      </tr>
    </table>
    
  <!--  <div class="btn_area">
    <ul>
      <li><button type="button" class="btn btn-default red">����</button></li>
      <li><button type="button" class="btn btn-default gray">����</button></li>
    </ul>
  </div>--> 
  </div> 

</div>
</body>
</html>