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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierInfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript">
<c:if test="${ok == '1'}">
alert("����Ʒ���¼ܣ��޷��鿴��ϸ��Ϣ��");
window.close();
</c:if>
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
      <div id="product_main">
        <div id="product_intro" class="clearfix">
          <div id="preview">
            <div class="photo"><img src="${supplierGoodsInfo.imagePath}" alt="" width="350px" height="350px"></div>
            <div class="spec_list">
              <ul class="clearfix">
                <c:forEach var="supplierGoodsImage" items="${supplierGoodsImageList}" varStatus="sta">
					<li style="cursor:pointer;"><img class="small_pic" src="${supplierGoodsImage.imagePath}" alt="" width="44px" height="44px"></li>
				</c:forEach>
              </ul>
            </div>
          <!--#preview--></div>
          <div id="item_info">
            <h1>${supplierGoodsInfo.goodsName}</h1>
            <div id="summary" class="clearfix">
              <div class="left_list">
                <dl class="dl-horizontal clearfix">
                  <dt>Ʒ�ƣ�</dt>
                  <dd>${supplierGoodsInfo.brandName}</dd>
                </dl>
                <dl class="dl-horizontal clearfix">
                  <dt>�������̣�</dt>
                  <dd>${supplierGoodsInfo.productArea}</dd>
                </dl>
                <dl class="dl-horizontal clearfix">
                  <dt>�г��ۣ�</dt>
                  <dd class="price">��<fmt:formatNumber value="${supplierGoodsInfo.salePrice}" pattern="#0.00#"/></dd>
                </dl>
                <dl class="dl-horizontal clearfix">
                  <dt>�вɼۣ�</dt>
                  <dd class="price">��<fmt:formatNumber value="${supplierGoodsInfo.agreePrice}" pattern="#0.00#"/></dd>
                </dl>
                <dl class="dl-horizontal clearfix">
                  <dt>���ϳ��У�</dt>
                  <dd></dd>
                </dl>
              </div>
              <div class="left_list">
                <dl class="dl-horizontal clearfix">
                  <dt>�ͺţ�</dt>
                  <dd>${supplierGoodsInfo.goodsModel}</dd>
                </dl>
                <dl class="dl-horizontal clearfix">
                  <dt>�ϼ����ڣ�</dt>
                  <dd>2015-01-01</dd>
                </dl>
                <dl class="dl-horizontal clearfix">
                  <dt>����ȣ�</dt>
                  <dd>0.00%</dd>
                </dl>
                <dl class="dl-horizontal clearfix">
                  <dt>�Ż��ʣ�</dt>
                  <dd><fmt:formatNumber value="${1-supplierGoodsInfo.countPrice/supplierGoodsInfo.salePrice}" type="percent" /></dd>
                </dl>
              </div>
              
                
            </div>
        </div>
        <div id="ext_info">
          <h2>${sessionScope.supUsernamecn}</h2>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red">�ղ�</button></li>
              <li><button type="button" class="btn btn-default red">���볬��</button></li>
            </ul>
          </div>
          
          <div class="commond">
            <p class="commond_sum">��������ȣ�0.00��</p>
            <div class="commond_detail">
              <dl class="dl-horizontal clearfix"><dt>����ȣ�</dt><dd>0.00%</dd></dl>
              <dl class="dl-horizontal clearfix"><dt>��Ʒ������</dt><dd>0.00%</dd></dl>
              <dl class="dl-horizontal clearfix"><dt>�ۺ����</dt><dd>0.00%</dd></dl>
            </div>
            <div class="btn_list">
              <button type="button" class="btn btn-default red">�鿴����</button>
            </div>
          </div>
          <dl id="contact">
              <dt class="font-16 font-color-red">�ͷ��绰</dt>
              <dd>${sessionScope.loginSupContactNum}</dd>
          </dl>
          <dl id="other_shop">
              <dt class="font-16">��Ӫ����Ʒ�������̻�</dt>
              <dd>
                  <ul>
                      <li><a href="#">����Ʒ��</a></li>
                      <li><a href="#">����Ʒ��</a></li>
                      <li><a href="#">����Ʒ��</a></li>
                  </ul>
              </dd>
          </dl>
      <!--#ext_info--></div>
        <!--#product_intro--></div>
        <div id="product_detail" class="clearfix">
							<div id="menu_list" class="clearfix">
								<ul>
									<li class="select" id="showDetailed01"><a href="javascript:void(0);" onclick="showDetailed('01')">��Ʒ����</a></li>
									<li id="showDetailed02"><a href="javascript:void(0);" onclick="showDetailed('02')">��Ʒ����</a></li>
									<li id="showDetailed03"><a href="javascript:void(0);" onclick="showDetailed('03')">��Ʒ�ɽ��۸�</a></li>
								</ul>
							</div>
							<div id="tab01">
                              ${supplierGoodsInfo.goodsDesc}
								<!--#tab01-->
							</div>
							<div id="tab02" style="display:none;">
								${supplierGoodsInfo.goodsParam}
								<!--#tab02-->
							</div>
							<div id="tab03" style="display:none;">
                              <div class="price_list">
                                <label>ƽ���ɽ��ۣ�</label><span><fmt:formatNumber value="${reportOrderData.avgPrice}" pattern="#0.00#"/></span>
                                <label>��߳ɽ��ۣ�</label><span><fmt:formatNumber value="${reportOrderData.maxPrice}" pattern="#0.00#"/></span>
                                <label>��ͳɽ��ۣ�</label><span><fmt:formatNumber value="${reportOrderData.minPrice}" pattern="#0.00#"/></span>
                                <label>����ɽ��ۣ�</label><span><fmt:formatNumber value="${reportOrderData.nowPrice}" pattern="#0.00#"/></span>
                              </div>
								<table class="tableStyle02" width="1018" border="0">
									<tr>
										<th width="160">�ɹ���</th>
										<th width="160">�ɽ��۸�</th>
										<th width="356">��������</th>
										<th width="160">�ɽ�����</th>
										<th width="160">��ʽ���ͺ�</th>
									</tr>
									 <c:forEach var="orderData" items="${orderDataList}" varStatus="status">
									 	<tr>
											<td>${orderData.userId}</td>
											<td class="font-color-red"><fmt:formatNumber value="${orderData.goodsPrice}" pattern="#0.00#"/></td>
											<td>${orderData.buyNum}</td>
	                                        <td>${orderData.payTime}</td>
											<td>${supplierGoodsInfo.goodsModel}</td>
										</tr>
            						 </c:forEach>
								</table>
							<jsp:include page="../page.jsp" />
								<!--#tab03-->
							</div>
							<!--#product_detail-->
						</div>
      <!--#product_main--></div>
    </div>
  </div>
<jsp:include page="../footer.jsp" />
  <div id="copy_right">
    <div class="inner">
      <p>��Ȩ��Ϣ����ʾ��Ȩ��Ϣ��������</p>
    </div>
  </div>
<!--.page-wrapper--></div>
</body>
</html>