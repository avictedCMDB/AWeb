<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%> 
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_auditor.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/audit.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/imgUpload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}">
<input id="orderStatus" type="hidden" value="${orderStatus}"/>
<div class="confirm_pro inner">
  <h2>��˶�����Ϣ</h2>
  <div class="section_inner">
    <h3>����״̬</h3>
    <div class="main_inner">
      <dl class="dl-horizontal">
        <dt>��˽����</dt>
        <dd>${auditOrder.reviewResultName}</dd>
      </dl>
      <dl class="dl-horizontal">
        <dt>����ˣ�</dt>
        <dd>${auditOrder.reviewPerson}</dd>
      </dl>
      <dl class="dl-horizontal">
        <dt>���ʱ�䣺</dt>
        <dd>${auditOrder.reviewTime}</dd>
      </dl>
      <dl class="dl-horizontal">
        <dt>��������</dt>
        <dd>${auditOrder.reviewRemark}</dd>
      </dl>
      
     	<dl class="dl-horizontal">
	        <dt>�����鿴��</dt>
	        <dd>
	        <c:choose>
		        <c:when test="${!empty auditImages }">
		      		<div class="up_img_list">
		              <ul class="clearfix">
		               <c:forEach var="image" items="${auditImages}" varStatus="status">
		               		<li><a class="preview" name="image_show" id="image_show${status.index}"  href="${pageContext.request.contextPath}${image.url}"><img src="${pageContext.request.contextPath}${image.url}" width="100" height="100" class="image"/></a></li>
		               </c:forEach>
		              </ul>
		            </div> 
	            </c:when>
	            <c:otherwise>
	            	��
	            </c:otherwise>
            </c:choose>
            </dd>
      	</dl> 
      	
    </div>
  </div>
  
	  <div class="section_inner">
	    <h3>��˲���</h3>
	    <div class="main_inner">
	    <form action="" method="post" id="auditForm">
		  <input type="hidden" name="orderID" id="orderID" value="${auditOrder.orderID}"/>
		  <input type="hidden" name="reviewRemark" id="reviewRemark"/>
		  <input type="hidden" name="reviewResult" id="reviewResult"/>
	      <dl class="dl-horizontal">
	        <dt>��˽����</dt>
	        <dd>
	        <c:choose>
		        <c:when test="${searchFlg==1}">
		          <label class="checkbox-inline">
		            <input type="radio" checked value="0" name="optionsRadiosinline">
		            	ͬ��
		          </label>
		          <label class="checkbox-inline">
		            <input type="radio" value="1" name="optionsRadiosinline">
		            	��ͬ��
		          </label>
		         </c:when>
		         <c:otherwise>
			         <label class="checkbox-inline">
			            <input type="radio" disabled>
			            	ͬ��
			          </label>
			          <label class="checkbox-inline">
			            <input type="radio" disabled>
			            	��ͬ��
			          </label>
		         </c:otherwise>
	         </c:choose>
	        </dd>
	      </dl>
	      <dl class="dl-horizontal">
	        <dt>��������</dt>
	        <dd>
	         <c:choose>
		        <c:when test="${searchFlg==1}">
	        	<textarea class="form-control" id="auditReviewRemark" rows="4"></textarea>
	        	</c:when>
		         <c:otherwise>
		         <textarea class="form-control" id="auditReviewRemark" rows="4" readonly></textarea>
		         </c:otherwise>
	         </c:choose>
	        </dd>
	      </dl>
	      </form>
	    <c:if test="${searchFlg==1}">
	      <dl class="dl-horizontal">
        <dt>�����ϴ���</dt>
        <dd>
        	<mc:ImgUploadTag mark='chk'></mc:ImgUploadTag>
          <!-- <input id="lefile" type="file" style="display:none">
            <div class="input-append"> 
              <input id="photoCover" class="input-large form-control" type="text" style="height:30px;"> 
              <a class="btn btn-default red" onclick="$('input[id=lefile]').click();">����ļ�</a>
              <button type="button" class="btn btn-default red" >��ʼ�ϴ�</button>
            </div>
            <script type="text/javascript"> 
              $('input[id=lefile]').change(function() { 
                $('#photoCover').val($(this).val()); 
              }); 
            </script>-->
                      ֧�ֵ�ͼƬ��ʽΪjpg/jpeg/png/gif/bmp/pdf������ͼƬ��С��2M��
        </dd>
      </dl> 
      </c:if>
	      <!-- <dl class="dl-horizontal">
	        <dt>����������</dt>
	        <dd><button type="button" class="btn btn-default red">�ϴ�</button></dd>
	      </dl>  -->   
	    </div>
	  </div>
	  <div class="btn_list">
	    <ul>
	      <li>
	      <c:choose>
		        <c:when test="${searchFlg==1}">
	        	<button type="button" class="btn btn-default red" onclick="auditSubmit();">�ύ</button>
	        	</c:when>
	         </c:choose>
	      
	      </li>
	      <li><button type="button" class="btn btn-default gray" onclick="cacleParentWindow();">ȡ��</button></li>
	    </ul>
	  </div>
  
</div>
</body>
</html>