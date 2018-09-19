<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="��������" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/order_details.css" rel="stylesheet">
</head>

<body>
<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
  <div id="nav_area">
    <div class="inner clearfix">
				<jsp:include page="../categorys.jsp" />
    </div>
    <!--#nav_area--></div>
  <div id="contents">
    <div class="inner">
      <div class="breadcrumb clearfix">
        <ul>
          <li><a href="${pageContext.request.contextPath}">��ҳ</a><span>&gt;</span></li>
          <li>��������</li>
        </ul>
        <!--.breadcrumb--> 
      </div>
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
                <p class="img_pro"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${item.supId}&gid=${item.supGoodsId}">
				<c:if test="${item.supType == 1}">
                <img alt="" src="${pageContext.request.contextPath}${item.imagePath == null ? '/static/img/img-profession.jpg' : item.imagePath}" width="55px" height="55px">
                </c:if>
				<c:if test="${item.supType == 0}">
                <img alt="" src="${item.imagePath}" width="55px" height="55px">
				</c:if>
                </a></p>
              </td>
              <td class="left_align"><a href="${pageContext.request.contextPath}/market/goods/show?sid=${item.supId}&gid=${item.supGoodsId}">${item.goodsName}</a></td>
              <td><fmt:formatNumber value="${item.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
              <td>${item.buyNum}</td>
              <td><fmt:formatNumber value="${item.goodsPrice * item.buyNum}" pattern="#0.00#"></fmt:formatNumber></td>
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
          <div class="special_area">
            <h2>��Ʊ��Ϣ</h2>
            <div class="details_list">
              <dl class="dl-horizontal">
                <dt>��Ʊ���ͣ�</dt>
                <dd>${order.invoiceType == 1 ? '��ͨ��Ʊ' : '��ֵ��Ʊ'}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>��Ʊ���ݣ�</dt>
                <dd>${order.invoiceFlag == 1 ? '��ϸ' : fn:escapeXml(order.invoiceContent)}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>���λ��</dt>
                <dd>${fn:escapeXml(order.invoiceCompany)}</dd>
              </dl>
              <dl class="dl-horizontal">
                <dt>˰��ǼǺţ�</dt>
                <dd>${order.invoiceNum}</dd>
              </dl>
            </div>
          </div>
          <div class="special_area">
            <h2>������Ϣ</h2>
            <div class="details_list">
              <dl class="dl-horizontal">
                <dd>${fn:escapeXml(order.decideReason)}</dd>
              </dl>
            </div>
          </div>
          <div class="special_area last">
            <h2>������Ϣ</h2>
            <div class="details_list">
              <ul>
              <c:if test="${!empty order.imgs }">
              <c:forEach var="i" items="${order.imgs }">
                <li><img src="${pageContext.request.contextPath}${i}" /></li>
              </c:forEach>
              </c:if>
              </ul>
            </div>
          </div>
        </div>
        <div class="section_main clearfix price_area">
          <div class="gather_box">
            <div class="gather_inner">
              <p>
                <span>ʵ���</span>
                <span class="symbol">��</span>
                <span class="price"><fmt:formatNumber value="${order.orderAmount}" pattern="#0.00#"></fmt:formatNumber></span>
               </p>
               <p>
                 <span>��������</span>
                 ${fn:escapeXml(order.addrAll)}
               </p>
               <p>
                 <span>�ջ��ˣ�</span>
                 ${order.addrName} ${order.addrPhone == '' ? order.addrTel : order.addrPhone}
               </p>
             </div>
           </div>
        </div>
        <div class="btn_list">
          <ul class="list-inline">
            <li><button type="button" class="btn btn-default gray" onclick="history.go(-1);">����</button></li>
          </ul>
        </div>
      <!--.order_details--></div>
      
      
      
      <!--.inner--> 
    </div>
    <!--#contents--> 
  </div>
	<jsp:include page="../footer.jsp" />
  <!--.page-wrapper--> 
</div>
</body>
</html>