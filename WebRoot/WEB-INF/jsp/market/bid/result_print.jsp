<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>定标通知书</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_notice_a4.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/jquery.event.drag-1.5.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/jquery.touchSlider.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/profession.js"></script>
<script type="text/javascript">
$(function () {
	window.print();
});
</script>

</head>

<body>
    <div id="contents">
        <div class="inner">
            <h2>定标通知书</h2>
            <div class="article">
              <p class="txt txt01"><span>${sup.supName }</span></p>
              <p class="txt">你方于<span><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy"/></span>年<span><fmt:formatDate value="${proj.bidStartTime}" pattern="MM"/></span>月<span><fmt:formatDate value="${proj.bidStartTime}" pattern="dd"/></span>日，参加“<span>${proj.projName }</span>”电子竞价，已确定为成交人，本次采购过程符合&laquo;中华人民共和国招投标法&raquo;、&laquo;电子招标法&raquo;、&laquo;政府采购法&raquo;等有关法律法规的规定。</p>
              <div class="info">
                <p class="txt01">定标情况如下</p>
                <table class="table_area">
                  <tr>
                    <th width="90">定标号</th>
                    <th>品名</th>
                    <th width="90">定标数量</th>
                    <th width="90">定标单位</th>
                    <th width="90">保证金</th>
                    <th width="90">交易费</th>
                    <th class="last" width="90">成交额</th>
                  </tr>
                  <c:forEach var="i" items="${subs}" varStatus="sta">
                    <tr>
                      <td>${i.subjectId }</td>
                      <td>${i.subjectName }</td>
                      <td>${i.subjectNum }</td>
                      <td>${sup.supName }</td>
                      <td>${proj.bidBond }</td>
                      <td>0</td>
                      <c:if test="${sta.index == 0}">
                      <td rowspan="${fn:length(subs)}">${sup.realCurrentQuota}</td>
                      </c:if>
                    </tr>
                    </c:forEach>
                </table>
              </div>
              <p class="txt02">特此通知。</p>
              <div class="img_seal">
                 <img src="${pageContext.request.contextPath}/static/img/bid/img_seal_sample02.jpg" alt="" />
                   <p class="right"><fmt:formatDate value="${proj.noticeTime}" pattern="yyyy年MM月dd日"/></p>
              </div>
              

            <div class="saler">
              <p class="name">中航技国际经贸发展有限公司</p>
              <div class="result_area clearfix">
                  <dl class="special clearfix">
                    <dt>地址 : </dt>
                    <dd>北京市朝阳区慧忠路5号，远大中心B座14层</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>电话：</dt>
                    <dd>（+86-10）84892588</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>传真：</dt>
                    <dd>（+86-10）84892589，84892590</dd>
                  </dl>
              </div>
            </div>
        </div>
    </div>
</body>
</html>
