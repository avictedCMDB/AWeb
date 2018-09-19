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
<title>��Ӧ�̹�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supplier_nonstandard.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/viewer/Viewer.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/viewer/viewer.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	<c:forEach var="image" items="${imageList}" varStatus="status">
		$("#img_${status.index}").imgbox();
	</c:forEach>

});
$(document).ready(function(){
		$("#img_quote_${type}").imgbox();

	});	
</script>
<script type="text/javascript">
$(document).ready(function(){
	/* <c:forEach var="image" items="${supplierOrderContract.supplierGoodsImages}" varStatus="status">
		$("#img_${status.index}").imgbox();
	</c:forEach> */
	var myt = document.getElementById('file'); 
	myt.onchange =function(){
   	   //�����ϴ�·����input-text�ؼ���ʾ
		$('#photoCover').val($(this).val()); 
	}
	var myt = document.getElementById('uploadFileContract'); 
	myt.onchange =function(){
   	   //�����ϴ�·����input-text�ؼ���ʾ
		 $('#contractCover').val($(this).val()); 
	}

	});
<c:if test="${ok == '1'}">
alert("�ϴ����ļ�Ϊ���ļ��������ʺ������ϴ���");
</c:if>
<c:if test="${ok == '2'}">
alert("�ϴ����ļ�����ʧ�ܣ���ʹ��ָ����ģ���ļ���");
</c:if>
<c:if test="${ok == '3'}">
alert("�ϴ��ɹ���");
</c:if>
<c:if test="${ok == '4'}">
alert("�ϴ��ɹ���");
</c:if>
<c:if test="${ok == '5'}">
alert("�ϴ����ļ���С�����ļ���С���ܳ���2MB���������ϴ���");
</c:if>
function updateStatus(action,checkSize,returnAction){
	if(checkSize == 0){
		alert('���ϴ�������Ʒ��');
		return ;
	}
	if ($("#quotePath").val() == '') {
		alert('��ѡ��Ҫ�ϴ��ı��۵���');
		return;
	}
	$.ajax({
		
		 url: action ,
	     type: 'POST',
		    data : {
				'id' : $('#id').val(),
				'sendFilePath' : $('#quotePath').val(),
				'filePath' : $('#filePath').val(),
				'fileName' : $('#fileName').val()
			} ,
			 contentType:"application/x-www-form-urlencoded; charset=utf-8",
	    success: function (data){
	    	window.location.href=returnAction;
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}


</script>
</head>

<body>
<div class="page-wrapper">
 <jsp:include page="../header.jsp" />
  <div id="contents">
    <div class="inner">
      <div id="matter_section" class="inner_main">
      	<h2>��Ʒ�������</h2>
      	<div id="info_list">
            <div class="section_inner">
           	  <dl class="clearfix">
           	  	<dt>�������ƣ�</dt>
                  <dd><input class="form-control" type="text" disabled="disabled" value="${supplierOffStandRequire.goodsName}"></input></dd>
           	  </dl>
              <dl class="clearfix">
                  <dt>����������</dt>
                  <dd><textarea class="form-control" disabled="disabled" rows="4">${supplierOffStandRequire.goodsDescNew}</textarea></dd>
              </dl>
              <c:if test="${supplierOffStandRequire.status == '3'}">
              		<dl class="clearfix">
	                  <dt>�������ɣ�</dt>
	                  <dd><textarea class="form-control" disabled="disabled" rows="4">${supplierOffStandRequire.cancelReason}</textarea></dd>
	              </dl>
              </c:if>
              <dl class="clearfix">
                  <dt>��Ʒ������</dt>
                  <dd>
                      <div class="detail_list">
                            <ul id="imageul" class="clearfix">
                                <c:forEach var="image" items="${supplierOffStandRequire.imageList}" varStatus="status">
	                      			<li>
	                      				<c:choose>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.jpg')}">
	                      						<div id="img_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.png')}">
	                      						<div id="img_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.bmp')}">
	                       						<div id="img_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.jpeg')}">
	                      						<div id="img_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.gif')}">
	                      						<div id="img_${status.index}"><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:otherwise>
	                      						<a href="${pageContext.request.contextPath}/supplier/order/downloadContract?downFile=${image.url}" class="download">${image.fileName}</a>
	                      					</c:otherwise>
	                      				</c:choose>
	                      			</li>
	                      		</c:forEach>
                            </ul>
                        </div>
                  </dd>
              </dl>
              <form id="uploadForm" method="post">
              <c:if test="${type == '1'}">
	              <dl class="clearfix last">
	                  <dt>������Ʒ��</dt>
	                  <dd>
	                  	  <input type="hidden" name="id" id="id" value="${supplierOffStandRequire.id}"/>
	                  	  <input type="hidden" name="filePath" id="filePath" value="${supplierOffStandRequire.filePath}"/>
	                      <input id="file" name="uploadFile" type="file" style="display:none" accept=".xls,.xlsx"/>
	                        <div class="input-append">
	                            <input id="photoCover" class="form-control" type="text" style="height:30px; width: 350px; margin-left: 0; margin-top: 1px;"/>
	                            <a class="btn btn-default red" onclick="$('input[id=file]').click();">����ļ�</a>
	                            <button type="button" class="btn btn-default red" onclick="upload('${pageContext.request.contextPath}/supplier/offStandRequire/uploadGoods?type=1')" id= "uploadButton">��ʼ�ϴ�</button> <span class="blue-text">�ϴ��ļ�Ϊexcel���ļ���СС��2M��<br></span>
	                            <a href="${pageContext.request.contextPath}/supplier/goodsInfo/download?type=4" class="download">���߹�װ����ģ������</a>
	                            &nbsp; <a href="${pageContext.request.contextPath}/supplier/goodsInfo/download?type=5" class="download">������Ʒ����ģ������</a>
	                        </div>
	                        <script type="text/javascript"> 
	                            function upload(action){
	                            	$('#uploadButton').attr('disabled',"true");
	                            	$('#uploadForm').attr('enctype', 'multipart/form-data'); 
	                            	document.getElementById("uploadForm").action=action;
	                            	document.getElementById("uploadForm").submit();
	                            }	
	                        </script>
	                  </dd>
	              </dl>
	              <dl class="clearfix last">
	                  <dt>���뱨�۵���</dt>
	                  <dd>
	                      <input id="uploadFileContract" name="uploadFileContract" type="file" style="display:none"/>
			                <div class="input-append">
			                    <input id="contractCover" class="form-control" type="text" style="height:30px; width: 350px; margin-left: 0; margin-top: 1px;"/>
			                    <a class="btn btn-default red" onclick="$('input[id=uploadFileContract]').click()">����ļ�</a>
			                    <button type="button" id="uploadContractButton" class="btn btn-default red" onclick="upload('${pageContext.request.contextPath}/supplier/offStandRequire/uploadContract?type=1','1')">��ʼ�ϴ�</button><span class="blue-text">�ϴ����۵���ǹ�˾���£��ļ���СС��2M��<br></span>
			                </div>
	                        <script type="text/javascript"> 
	                        function upload(action,type){
	                        	if (type == '1') {
	                        		if ($("#uploadFileContract").val() == '') {
	                        			alert('��ѡ��Ҫ�ϴ��ı��۵���!');
	                        			return;
	                        		}
	                        	}
	                        	$('#uploadForm').attr('enctype', 'multipart/form-data'); 
	                        	document.getElementById("uploadForm").action=action;
	                        	document.getElementById("uploadForm").submit();
	                        }
	                        </script>
	                        <input type="hidden" name="quotePath" id="quotePath" value="${supplierOffStandRequire.quotePath}"/>
	                        <input type="hidden" name="fileName" id="fileName" value="${supplierOffStandRequire.fileName}"/>
                			<p class="up_link">
                				<!-- <c:if test="${supplierOffStandRequire.quotePath != null and supplierOffStandRequire.quotePath != ''}"> -->
                					<c:if test="${isPicture =='0'}">
				            			<div id="img_quote_1"><img src="${pageContext.request.contextPath}${supplierOffStandRequire.quotePath}" data-original="${pageContext.request.contextPath}${supplierOffStandRequire.quotePath}" width="80px" height="80px"/></a>
				            		</c:if>
				            		<c:if test="${isPicture !='0'}">
				            			<a href="${pageContext.request.contextPath}/supplier/order/downloadContract?downFile=${supplierOffStandRequire.quotePath}" class="download">${supplierOffStandRequire.fileName}</a>
				            		</c:if>
				            	<!--</c:if> -->
							</p>
	                  </dd>
	              </dl>
              </c:if>
              </form>
            <p>
            <div class="upload_img">
            <c:if test="${type == '2'}">
            
            
            <p>���۵���</p>
            	<c:if test="${supplierOffStandRequire.quotePath != null and supplierOffStandRequire.quotePath != ''}">
            		<c:if test="${isPicture =='0'}">
            			<div id="img_quote_2" class="upload_link"><img src="${pageContext.request.contextPath}${supplierOffStandRequire.quotePath}" data-original="${pageContext.request.contextPath}${supplierOffStandRequire.quotePath}" width="80px" height="80px"/></div>
            		</c:if>
            		<c:if test="${isPicture !='0'}">
            			<a href="${pageContext.request.contextPath}/supplier/order/downloadContract?downFile=${supplierOffStandRequire.quotePath}" class="download">${supplierOffStandRequire.fileName}</a>
            		</c:if>
            	</c:if>
          	</c:if>
          	</div>
          	<c:if test="${ok == '3'}">
	          	������������${count} �ɹ�������${sussCount}  ʧ��������${errCount}<br/> 
	          	<c:if test="${errMsg != ''}">
	          		����������${errMsg}
	          	</c:if>
          	</c:if>
          </p>
              <div class="search_result section">
          <table border="0">
            <tr>
              <th>��Ʒ����</th>
              <th width="235">����ͺ�</th>
              <th width="150">����</th>
              <th width="120">Ʒ��</th>
              <th width="120">��Ʒ����</th>
              <th width="100" class="last">��������</th>
            </tr>
            <c:forEach var="supplierGoodInfo" items="${supplierGoodInfoList}" varStatus="status">
	            <tr>
	              <td>${supplierGoodInfo.goodsName}</td>
	              <td>${supplierGoodInfo.goodsModel}</td>
	              <td>${supplierGoodInfo.goodsStuff}</td>
	              <td>${supplierGoodInfo.brandName}</td>              
	              <td>${supplierGoodInfo.countPrice}</td>
	              <td>${supplierGoodInfo.quoteNum}</td>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
              <div class="btn_list_check">
                  <ul class="list-inline clearfix">
                  	  <c:if test="${type == '1'}">
                  	 	<li><button type="button" class="btn btn-default add_btn" onclick="updateStatus('${pageContext.request.contextPath}/supplier/offStandRequire/updateStatus','${fn:length(supplierGoodInfoList)}','${pageContext.request.contextPath}/supplier/offStandRequire')">�ṩ</button></li>
                  	  </c:if>
                      <li><button type="button" class="btn btn-default add_btn" onclick="redirectPage('${pageContext.request.contextPath}/supplier/offStandRequire')">����</button></li>
                  </ul>
              </div>
            </div>
        </div>
      	
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>

<script>
	var options = {
        url: 'data-original',
        scalable:true
     };
	$('#imageul').viewer(options);
	$('#img_quote_1').viewer(options);
	$('#img_quote_2').viewer(options);
</script>
</body>
</html>