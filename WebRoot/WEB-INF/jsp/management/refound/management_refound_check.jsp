<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>�˻�����|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_exchange.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/imgbox.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/refound.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.imgbox.pack.js"></script>
</head>
<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />  
  <div id="contents">
    <div class="inner details">
    <input type="hidden" value="${pageContext.request.contextPath}" id="path"/>
      <h2>�˻�����</h2>
      <div id="step"> 
	    	<ul class="image_list clearfix">
	    		<li <c:if test="${refound.refoundStatus >= 0}">class="selected"</c:if>>
	    			<c:choose>
	    				<c:when test="${refound.refoundStatus >= 0}">
	    					<img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" />
	    				</c:when>
	    				<c:otherwise>
	    					1
	    				</c:otherwise>
	    			</c:choose>
	    		</li>
	    		<li <c:if test="${refound.refoundStatus >= 1}">class="selected"</c:if>>
	    			<c:choose>
	    				<c:when test="${refound.refoundStatus >= 1}">
	    					<img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" />
	    				</c:when>
	    				<c:otherwise>
	    					2
	    				</c:otherwise>
	    			</c:choose>
	    		</li>
	    		<li <c:if test="${refound.refoundStatus >= 3}">class="selected"</c:if>>
	    			<c:choose>
	    				<c:when test="${refound.refoundStatus >= 3}">
	    					<img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" />
	    				</c:when>
	    				<c:otherwise>
	    					3
	    				</c:otherwise>
	    			</c:choose>
	    		</li>
	    		<li <c:if test="${refound.refoundStatus >= 4}">class="selected"</c:if>>
	    			<c:choose>
	    				<c:when test="${refound.refoundStatus >= 4}">
	    					<img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" />
	    				</c:when>
	    				<c:otherwise>
	    					4
	    				</c:otherwise>
	    			</c:choose>
	    		</li>
                <li <c:if test="${refound.refoundStatus == 5}">class="selected"</c:if>>
	    			<c:choose>
	    				<c:when test="${refound.refoundStatus == 5}">
	    					<img src="${pageContext.request.contextPath}/static/img/management/img-selected.png" />
	    				</c:when>
	    				<c:otherwise>
	    					5
	    				</c:otherwise>
	    			</c:choose>
	    		</li>
                
	    	</ul>
	    	
	    	<ul class="text_step clearfix">
	    		<li>�ɹ��������˻�</li>
	    		<li>��Ӧ�����ͨ��</li>
	    		<li>��Ӧ�̴��ջ�</li>
	    		<li>��Ӧ�����ջ�</li>
                <li>���˿�</li>
	    	</ul>	      
	    	<!--.replace_step-->	
      </div>
      <div class="section">
        <h3>�˻���������Ϣ</h3>
        <div class="section_info">
          <label>������ţ�</label>
          <span>${refound.orderID}</span>
          <label>�˻�����ţ� 	</label>
          <span>${refound.refoundID}</span>
          <label>�ɹ���λ���ƣ�</label>
          <span>${refound.companyName}</span>
          <label>�ɹ�����ϵ�ˣ�</label>
          <span>${refound.addrName}</span>
          <label>�ɹ�����ϵ�绰��</label>
          <span>${refound.addrPhone}</span>
          <label>�˻���������</label>
          <span>${refound.refoundAmount}</span>
        </div>
        <div class="section_info">
          <label>��ע��</label>
          <span>${refound.remark}</span>
        </div>
<%-- 	        <div class="section_info">
	        <c:if test="${!empty refound.refoundExpressCodeSup}">
	          <label>��ݵ��ţ�</label>
	          <span>${refound.refoundExpressCodeSup}</span>
	        </c:if>
	          <label>��ݹ�˾��</label>
	          <span>${refound.refoundExpressNameSup}</span>
	        </div>--%>
         <div class="section_info">
          <label>������</label>
          <span>
	          <c:choose>
			        <c:when test="${!empty imageInfos }">
			      		<div class="up_img_list">
			              <ul class="clearfix">
			               <c:forEach var="image" items="${imageInfos}" varStatus="status">
			               		<li><a class="preview" name="image_show" id="image_show${status.index}"  href="${pageContext.request.contextPath}${image.url}"><img src="${pageContext.request.contextPath}${image.url}" width="100" height="100" class="image"/></a></li>
			               </c:forEach>
			              </ul>
			            </div> 
		            </c:when>
		            <c:otherwise>
		            	��
		            </c:otherwise>
	            </c:choose>
            </span>
        </div>
        
      </div>
      <div class="section detail_exchange">
        <h3>�˻�����ϸ</h3>
        <table border="0">
          <tr>
            <th width="40">���</th>
            <th colspan="2">��Ʒ����</th>	
            <th width="110">����(Ԫ)</th>
            <th width="110">�ɹ�����</th>
            <th width="110">�˻�����</th>
            <th width="110">�˻����</th>
            <th width="200" class="last">�˻�ԭ��</th>
          </tr>
          <c:forEach var="orderSnapshot" items="${refound.orderSnapshots}" varStatus="status">
	           <tr>
	            <td>${status.index+1}</td>
	            <td class="right_none" width="57"><p class="img_pro"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${orderSnapshot.supId}&gid=${orderSnapshot.supGoodsId}"><img src="${orderSnapshot.imagePath}" width="55px" height="55px"/></a></p></td>
	            <td class="left_none"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${orderSnapshot.supId}&gid=${orderSnapshot.supGoodsId}">${orderSnapshot.goodsName}</a></td>
	            <td class="price">${orderSnapshot.goodsPrice}</td>
	            <td>${orderSnapshot.fullBuyNum}</td>
	            <td>${orderSnapshot.buyNum}</td>
	            <td>${orderSnapshot.goodsPrice*orderSnapshot.buyNum}</td>
	            <td>${orderSnapshot.refoundReason}</td>
	          </tr>
          </c:forEach>
        </table>
      </div>
      <div class="btn_close">
        <button type="button" class="btn btn-default gray" onclick="closeRefound();">�ر�</button>
      </div>
      
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>