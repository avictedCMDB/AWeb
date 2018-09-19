<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_order.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierOrder.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	<c:forEach var="supplierQuoteInfo" items="${supplierQuoteInfoList}" varStatus="status">
		$("#img_quote_${status.index}").imgbox();
	</c:forEach>
	var myt = document.getElementById('uploadFileContract'); 
	myt.onchange =function(){
		   //�����ϴ�·����input-text�ؼ���ʾ
		 $('#contractCover').val($(this).val()); 
	}
	});	
</script>
<base target="_self"/>
</head>
<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  <div id="contents">
    <div class="inner">
    	<div id="order_details">
        <div class="section_main pro_info">
          <h2>��Ʒ��Ϣ</h2>
          <table>
            <tr>
              <th colspan="2">��Ʒ����</th>
              <th width="200">���ۣ�Ԫ��</th>
              <th width="200">����������</th>
              <th width="200">�ܼۣ�Ԫ��</th>
            </tr>
            <c:forEach varStatus="sta" var="item" items="${order.snapshots}">
            <tr>
              <td class="left_align" width="77">
                <p class="img_pro"><a href="#"><img alt="" src="${item.imagePath}" width="55px" height="55px"/></a></p>
              </td>
              <td class="left_align">
              	<a href="${pageContext.request.contextPath}/supplier/goodsInfo/queryDetailed/${item.supGoodsId}" target="_blank">${item.goodsName}(${item.goodsModel})</a>
              	<input type="hidden" value="${item.supGoodsId}" name="supGoodsId"/>
              </td>
              <td>
              <div class="input-group input-group-num">
                <!--  <span class="input-group-btn"><button class="btn btn-default input-group-addon" type="button" onclick="minusNum('1','${sta.index}')">-</button></span> -->
                  <input id="price${sta.index}" onblur="checkNum('1','${sta.index}')" name="goodsPrice" class="form-control" type="text" maxlength="8" value="<fmt:formatNumber value="${item.goodsPrice}" pattern="#0.00#"></fmt:formatNumber>" disabled="disabled"/>
                 <!-- <span class="input-group-btn"><button class="btn btn-default input-group-addon" type="button" onclick="addNum('1','${sta.index}')">+</button></span> -->
                </div>
              </td>
              <td>
              	<div class="input-group input-group-num">
                  <!--<span class="input-group-btn"> <button class="btn btn-default input-group-addon" type="button" onclick="minusNum('2','${sta.index}')">-</button></span> -->
                  <input id="num${sta.index}" onblur="checkNum('2','${sta.index}')" name="buyNum" class="form-control" type="text" maxlength="8" value="${item.buyNum}" disabled="disabled"/>
                  <!--<span class="input-group-btn"><button class="btn btn-default input-group-addon" type="button" onclick="addNum('2','${sta.index}')">+</button></span> -->
                </div>
              </td>
              <td>
              	<div class="input-group input-group-num">
               <!--    <span class="input-group-btn"><button class="btn btn-default input-group-addon" type="button" onclick="minusNum('3','${sta.index}')">-</button></span> -->
                  <input id="sumPrice${sta.index}" name="orderAmount" class="form-control" id="" type="text" maxlength="8" value="<fmt:formatNumber value="${item.goodsPrice * item.buyNum}" pattern="#0.00#"></fmt:formatNumber>" disabled="disabled" />
                 <!-- <span class="input-group-btn"><button class="btn btn-default input-group-addon" type="button" onclick="addNum('3','${sta.index}')">+</button></span>-->
                </div>
              </td>
            </tr>
            </c:forEach>
          </table>
        </div>
        <div class="section_main clearfix section_inner">
          <div class="special_area first">
            <h2>��ַ��Ϣ</h2>
            <div class="details_list">
              <dl class="dl-horizontal">
                <dt>����Ҫ��</dt>
                <dd>${order.expressType == 1 ? '��������' : '������ȡ'}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>���͵�ַ��</dt>
                <dd>${fn:escapeXml(order.addrDetail)}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>�ռ���������</dt>
                <dd>${order.addrName}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>��ϵ�绰��</dt>
                <dd>${order.addrPhone == '' ? order.addrTel : order.addrPhone}</dd>
              </dl>
            </div>
          </div>
          <form id="contractForm" method="post">
          <input type="hidden" name="orderId" value="${order.orderId}"/>
          <div class="special_area">
            <h2>���۵���Ϣ</h2>
            <div class="details_list">
              <dl class="dl-horizontal">
                <dt>�ͻ���</dt>
                <dd><input class="form-control" type="text" name="companyname" value="${order.companyname}" readonly="readonly" id="companyname"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>��ϵ�ˣ�</dt>
                <dd><input class="form-control" type="text" name="contactPerson" value="${order.contactPerson}" readonly="readonly" id="contactPerson"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>�绰��</dt>
                <dd><input class="form-control" type="text" name="contactNum" value="${order.contactNum}" readonly="readonly" id="contactNum"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>���棺</dt>
                <dd><input type="text" name="contactFax" id="contactFax" value="${order.contactFax}" readonly="readonly" class="form-control special_input"/>
                </dd>
              </dl>
            </div>
          </div>
          <div class="special_area">
            <div class="details_list details_list_special">
              <dl class="dl-horizontal">
                <dt>���ڣ�</dt>
                <dd><input class="form-control" type="text" name="quoteDate" value="${supplierQuoteInfo.quoteDate}" id="quoteDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>�����ˣ�</dt>
                <dd><input class="form-control" type="text" name="sendPerson" value="${supplierQuoteInfo.sendPerson}" id="sendPerson"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>�ֻ���</dt>
                <dd><input class="form-control" type="text" name="sendPersonTel" value="${supplierQuoteInfo.sendPersonTel}" id="sendPersonTel"/></dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>���棺</dt>
                <dd><input type="text" name="sendPersonFax" id="sendPersonFax" value="${supplierQuoteInfo.sendPersonFax}" class="form-control special_input"/>
                </dd>
              </dl>
            </div>
          </div>
          <div class="special_area">
            <h2>���۵�</h2>
            <div class="details_list">
                <input id="uploadFileContract" name="uploadFileContract" type="file" style="display:none" />
                <div class="input-append">
                    <input id="contractCover" class="form-control" type="text" style="height:30px; width: 165px; margin-left: 0;"/>
                    <a class="btn btn-default red" onclick="$('input[id=uploadFileContract]').click()">���</a>
                    <button type="button" id="uploadContractButton" class="btn btn-default red" onclick="uploadContract('${pageContext.request.contextPath}/supplier/order/uploadContract','1')">�ϴ�</button>
                </div>
                <input type="hidden" name="quoteAttachmentPath" id="quoteAttachmentPath" value="${filePath}"/>
                <input type="hidden" name="fileName" id ="fileName" value="${fileName}"/>
               <p class="up_link">
	                <c:forEach varStatus="sta" var="item" items="${supplierQuoteInfoList}">
	                	<c:if test="${isPicture =='0'}">
                			<a id="img_quote_${sta.index}" href="${pageContext.request.contextPath}${item.quoteAttachmentPath}"><img src="${pageContext.request.contextPath}${item.quoteAttachmentPath}" width="80px" height="80px"/></a>
	                	</c:if>
	                	<c:if test="${isPicture !='0'}">
	                		<a href="${pageContext.request.contextPath}/supplier/order/downloadContract?downFile=${item.quoteAttachmentPath}" class="download">${item.fileName}</a>
	                	</c:if>
	                </c:forEach>
                </p>
            </div>
          </div>
          </form>
        <!--    <div class="special_area">
            <h2>��ͬ����</h2>
            <div class="details_list">
                <input id="uploadPicture" name="uploadPicture" type="file" style="display:none"/>
                <div class="input-append">
                    <input id="uploadPictureCover" class="form-control" type="text" style="height:30px; width: 165px; margin-left: 0;"/>
                    <a class="btn btn-default red" onclick="$('input[id=uploadPicture]').click();">���</a>
                    <button type="button" id="uploadPictureButton" class="btn btn-default red" onclick="uploadContract('${pageContext.request.contextPath}/supplier/order/uploadPicture','2')">�ϴ�</button>
                </div>
                <input type="hidden" name="pictures" id="pictures" value="${supplierOrderContract.pictures}"/>
                <script type="text/javascript"> 
                    $('input[id=uploadPicture]').change(function() {
                        $('#uploadPictureCover').val($(this).val());
                    });
                </script>
                <div class="up_img">
                    <ul>
                    	<c:forEach var="supplierGoodsImage" items="${supplierOrderContract.supplierGoodsImages}" varStatus="status">
                    		<li>
                    			<a id="img_${status.index}" href="${pageContext.request.contextPath}${supplierGoodsImage.imagePath}">
                    				<img height='80px' width='80px' src="${pageContext.request.contextPath}${supplierGoodsImage.imagePath}"/>
                    		    </a>
                    		    <a class="btn_close" href="javascript:void(0)" onclick="deletePicture('${pageContext.request.contextPath}/supplier/order/deletePicture?deleteUrl=${supplierGoodsImage.imagePath}')">
                    		    	<img src="${pageContext.request.contextPath}/static/img/icon-close_blue.png"/>
                    		    </a>
                    		</li>
                    	</c:forEach>
                    </ul>
                </div>
            </div>
          </div>
          -->
        </div>
        <div class="section_main clearfix price_area">
          <div class="btn_list">
            <ul class="list-inline">
              <li><button type="button" class="btn btn-default blue" onclick="passStatus('${pageContext.request.contextPath}/supplier/order/passStatus','${order.orderId}','${pageContext.request.contextPath}/supplier/order','${authority}')">ͨ��</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="returnStatus('${pageContext.request.contextPath}/supplier/order/returnStatus','${order.orderId}','${pageContext.request.contextPath}/supplier/order')">�ܾ�</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="redirectPage('${pageContext.request.contextPath}/supplier/order')">����</button></li>
            </ul>
          </div>
        </div>
        
      <!--.order_details--></div>
    	
      
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>