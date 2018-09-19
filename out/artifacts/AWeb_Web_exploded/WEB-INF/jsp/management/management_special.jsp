<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="/WEB-INF/tlds/tag.tld" prefix="mc"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>��Ʒ�������|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/management_special.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/viewer/Viewer.min.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/special.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/viewer/viewer.min.js"></script>
</head>

<body>
<input type="hidden" id="path" value="${pageContext.request.contextPath}"/>
<input type="hidden" id="imageCount" value="${fn:length(offStandardRequires)}"/>
<div class="page-wrapper">
<jsp:include page="header.jsp" />
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="offStandardRequire" />
	  </jsp:include>
      
      <div id="matter_section">
      	<h2>��Ʒ�������</h2>
      	<div class="search_area section">
      	<form id="searchForm" action="" method="post">
          <div class="search_list clearfix">
             <dl class="clearfix">
              <dt>�������ƣ�</dt>
              <dd>
                <input id="goodsName" name="goodsName" type="text" class="form-control" value="${offStandardRequire.goodsName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>����������</dt>
              <dd>
                <input id="goodsDescNew" name="goodsDescNew" type="text" class="form-control" value="${offStandardRequire.goodsDescNew}"/>
              </dd>
            </dl>
            <dl class="clearfix"> 	
              <dt>��Ӧ�����ƣ�</dt>
              <dd>
                <select id="supID" name="supID" class="form-control">
                 <option value="">ȫ��</option>
	                <c:forEach var="supinfo" items="${supInfos}" varStatus="status">
	                 <option value="${supinfo.supID}" <c:if test="${supinfo.supID eq offStandardRequire.supID}">selected="selected"</c:if>>${supinfo.supName}</option>
	                </c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��Ʒ״̬��</dt>
              <dd>
                <select id="status" name="status" class="form-control">
                    <option value="">ȫ��</option>
                    <option value="0"<c:if test="${offStandardRequire.status eq '0'}">selected="selected"</c:if>>����Ӧ���ṩ</option>
                    <option value="1"<c:if test="${offStandardRequire.status eq '1'}">selected="selected"</c:if>>��Ӧ���Ѿ��ṩ</option>
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�Ƿ񹫿���</dt>
              <dd>
                <select id="isRelease" name="isRelease" class="form-control">
                    <option value="">ȫ��</option>
                    <option value="1"<c:if test="${offStandardRequire.isRelease eq '1'}">selected="selected"</c:if>>��</option>
                    <option value="0"<c:if test="${offStandardRequire.isRelease eq '0'}">selected="selected"</c:if>>��</option>

                </select>
              </dd>
            </dl>
            <%-- <dl class="clearfix">
              <dt></dt>
              <dd>
                <div class="input-group">
                    <input type="text" id="beginDate" name="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${offStandardRequire.beginDate}" class="form-control special_input">
                   <!--  <span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->
                  </div>
                  <div class="input-group">
                    <input type="text" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${offStandardRequire.endDate}" class="form-control special_input">
                   <!--  <span class="input-group-addon"><i class="fa fa-calendar"></i></span> -->
                  </div>
              </dd>
            </dl> --%>
            <dl class="clearfix last">
              <dt>��ֹ���ڣ�</dt>
              <dd>
              	<ul class="clearfix" style="width:230px">
                <li>
                  <div class="input-group" style="width:68px;">
                   <input type="text" id="beginDate" name="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${offStandardRequire.beginDate}" class="form-control special_input">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
               <li>��</li>
                <li class="last">
                  <div class="input-group" style="width:68px;">
                     <input type="text" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${offStandardRequire.endDate}" class="form-control special_input">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
              
              
              	  <%-- <div class="input-group">
                    <input type="text" id="beginDate" name="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${offStandardRequire.beginDate}" class="form-control special_input">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                  	��
                  <div class="input-group">
                    <input type="text" id="endDate" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${offStandardRequire.endDate}" class="form-control special_input">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div> --%>
                  
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="search();">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clear();">���</button></li>
               <li><button type="button" class="btn btn-default red" onclick="addSpecial();">����</button></li>
            </ul>
          </div>
        <!--.search_area-->
        </form></div>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th width="120">��������</th>
              <th width="100">��������</th>
              <th width="160">����</th>
              <th width="120">���빩Ӧ��</th>
              <th width="110">����ʱ��</th>
              <th width="80">�Ƿ񹫿�</th>
              <th width="110">��ֹ����</th>
              <th width="130">״̬</th>
              <th width="120" class="last">����</th>
            </tr>
             <c:forEach var="osr" items="${offStandardRequires}" varStatus="status">
            <tr>
              <td>${osr.goodsName}</td>
              <td>${osr.goodsDescNew}</td>
              <td class="img_list">
                  <ul id="specialUl_${status.index}">
                      <c:forEach var="image" items="${osr.auditImageInfos}" varStatus="status">
	                  	  	     <li>
	                      				<c:choose>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.jpg')}">
	                      						<div><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.png')}">
	                      						<div><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.bmp')}">
	                      						<div><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.jpeg')}">
	                      						<div><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:when test="${fn:contains(image.url.toLowerCase(),'.gif')}">
	                      						<div><img src="${pageContext.request.contextPath}${image.url}" data-original="${pageContext.request.contextPath}${image.url}" width="80px" height="80px"/></div>
	                      					</c:when>
	                      					<c:otherwise>
	                      						<a href="${pageContext.request.contextPath}/management/specialGoods/downloadSpecialFile?specialAttachmentPath=${image.url}" class="download">${image.fileName}</a>
	                      					</c:otherwise>
	                      				</c:choose>
	                      			</li>
                      	
                      </c:forEach>
                  </ul>
              </td>
              <td>
                <c:choose>
                	<c:when test="${osr.isRelease=='0'}">
	                	<c:forEach var="supInfo" items="${osr.supInfos}" varStatus="status">
		              		<c:choose>
		              			<c:when test="${status.index == 0}">
		              				${supInfo.supName}
		              			</c:when>
		              			<c:otherwise>
		              				<br/>${supInfo.supName}
		              			</c:otherwise>
	              			</c:choose>
	              	    </c:forEach>
                	</c:when>
                	<c:otherwise>
                		ȫ��
                	</c:otherwise>
                </c:choose>
              </td>
              <td>${osr.createDate}</td>
               <td>
              	<c:if test="${osr.isRelease eq '0'}">��</c:if>
              	<c:if test="${osr.isRelease eq '1'}">��</c:if>
              </td> 
              <td>${osr.closeDate}
              </td> 
              <td>
              	<c:if test="${osr.status eq '0'}">����Ӧ���ṩ</c:if>
              	<c:if test="${osr.status eq '1'}">��Ӧ�����ṩ</c:if>
              	<c:if test="${osr.status eq '3'}">������</c:if>
              </td>              
              <td>
              	<c:if test="${osr.status eq '1'}">
              		<a href="javascript:void(0);" onclick="specialCheck('${osr.ID}');">�鿴����</a>
              	</c:if> 
              	<c:if test="${osr.status != '1'}">
              		<span style="color:gray;">�鿴����</span>
              	</c:if> 
              	
              	<c:if test="${osr.status eq '1'}">
              		<span style="color:gray;">�޸�</span>
              		
              	</c:if> 
              	<c:if test="${osr.status eq '0' || osr.status eq '3'}">
              		<a href="javascript:void(0);" onclick="updateSpecial('${osr.ID}');">�޸�</a>
              	</c:if>
              	<c:choose>
              		<c:when test="${osr.status eq '3'}">
              			<span style="color:gray;">����</span>
              		</c:when>
              		<c:otherwise>
              			<a href="javascript:void(0);" onclick="cancellation('${osr.ID}');">����</a>
              		</c:otherwise>
              	</c:choose>
              	
              	<c:if test="${osr.status eq '3'||osr.status eq '0'}">
              		<a href="javascript:void(0);" onclick="delSpecial('${osr.ID}');">ɾ��</a>
              	</c:if> 
              	<c:if test="${osr.status != '3'&&osr.status != '0'}">
              		<span style="color:gray;">ɾ��</span>
              	</c:if>
              </td>
            </tr>
            </c:forEach>
            
            
            
            
            
          </table>
        <!--.search_result--></div>
      	<jsp:include page="page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  <jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>

<form action="${pageContext.request.contextPath}/management/compare/detail" method="post" id="compare_form">
		<input type="hidden" name="supOneID" id="sid_0"/>
		<input type="hidden" name="supGoodsOneID" id="gid_0"/>
		<input type="hidden" name="supTwoID" id="sid_1"/>
		<input type="hidden" name="supGoodsTwoID" id="gid_1"/>
		<input type="hidden" name="supThreeID" id="sid_2"/>
		<input type="hidden" name="supGoodsThreeID" id="gid_2"/>
		<input type="hidden" name="supFourID" id="sid_3"/>
		<input type="hidden" name="supGoodsFourID" id="gid_3"/>
		<input type="hidden" name="returnUrl" id="returnUrl" value="${pageContext.request.contextPath}/management/specialGoods/offStandardRequirePage"/>
	</form>
	
<script>
	var listCounts = $("#imageCount").val();
	 var options = {
		        url: 'data-original',
		        scalable:true
		      };
	for ( var i = 0; i < listCounts; i++) {
		$("#specialUl_"+i).viewer(options);
	}
</script>
</body>
</html>
