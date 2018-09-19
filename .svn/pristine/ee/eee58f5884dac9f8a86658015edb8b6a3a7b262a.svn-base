<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>首页|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/profession_enquiry.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/enquiry.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/validateUtil.js"></script>
</head>

<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<div id="vat_info">
  <div class="inner">
    <div class="add_title clearfix">询价<a href="#"><i class="fa fa-close"></i></a></div>
    <div class="main_inner">
    <form action="" id="enquiryForm" method="post">
      <input type="hidden" id="goodsID" name="goodsID" value="${enquiryGoods.goodsID}"/>
      <input type="hidden" id="supID" name="supID" value="${enquiryGoods.supID}"/>
      <input type="hidden" id="goodsPriceBefore" name="goodsPriceBefore" value="${enquiryGoods.goodsPriceBefore}"/>
      <div class="up_area clearfix">
        	<dl class="clearfix date_list">
              <dt><span class="red">*</span>商品名称：</dt>
              <dd>
                  <input type="text" class="form-control" readonly="readonly" value="${enquiryGoods.goodsName}"/>
              </dd>
            </dl>
            <dl class="clearfix date_list">
              <dt><span class="red">*</span>规格型号：</dt>
              <dd>
                  <input type="text" class="form-control" readonly="readonly" value="${enquiryGoods.goodsModel}"/>
              </dd>
            </dl>
            <dl class="clearfix date_list">
              <dt><span class="red">*</span>询价联系人：</dt>
              <dd>
                <input type="text" class="form-control" id="contactName" name="contactName"/>
              </dd>
      	    </dl>
            <dl class="clearfix date_list">
              <dt><span class="red">*</span>联系人电话：</dt>
              <dd>
                <input type="text" class="form-control" id="contactTel" name="contactTel"/>
              </dd>
      	    </dl>
            <dl class="clearfix date_list">
              <dt><span class="red">*</span>价格有效期至：</dt>
              <dd>
                <ul class="clearfix">
                  <li class="input_box">
                    <div class="input-group">
                      <input type="text" class="form-control special_input" id="enquiryDate" name="enquiryDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
      	    </dl>
            <dl class="clearfix date_list">
              <dt><span class="red">*</span>采购数量：</dt>
              <dd>
                <input type="text" class="form-control" id="goodsNum" name="goodsNum"/>
              </dd>
      	    </dl>
        </div>
       </form>
      <div class="btn_list">
          <button class="btn btn-default blue" onclick = "enquiry();">提交</button>
          <button class="btn btn-default gray" onclick="window.close();">取消</button>
      </div>
    </div>
  </div>
</div>


</body>
</html>