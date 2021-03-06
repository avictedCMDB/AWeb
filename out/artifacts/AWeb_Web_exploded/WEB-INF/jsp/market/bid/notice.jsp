<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="../meta.jsp">
	<jsp:param value="竞价采购" name="title" />
</jsp:include>

<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_announcement_form.css" rel="stylesheet">
</head>

<body>

  <div id="contents">
      <div class="inner">
          <div id="matter_section">
              <h2>竞价公告</h2>
              <div class="section step_section" id="myproject">
                  <div class="list_inner clearfix">
                      <div class="form-group">
                          <label class="title">项目编号：</label>
                          <span>${proj.projId}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">项目名称：</label>
                          <span>${proj.projName}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">竞价类型：</label>
                          <span>${proj.projType == 2 ? '公开竞价' : '邀请竞价'}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">排序规则：</label>
                          <span>价格排序</span>
                      </div>
                      <div class="form-group">
                          <label class="title">币种：</label>
                          <span>${proj.currencyName}</span>
                          <label class="title">汇率：</label>
                          <span>${proj.exchangeRate}</span>
                      </div>
                      <div class="form-group">
                          <label class="title">采购类别：</label>
                          <span>${proj.bidCatName}</span>
                      </div>
                  </div>
              </div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list01.png" alt="1">邀请合格的竞投人通过网上竞价平台参加下列货物的竞价</h3>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list02.png" alt="2">竞价的标的，授标拆分及报价要求：</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">报价上限：</label>
                          <span>
                          <c:if test="${proj.quotaLimitType == 1}">不限</c:if>
                          <c:if test="${proj.quotaLimitType == 2}">${proj.quotaLimitNum}</c:if>
                          </span>
                      </div>
                      <div class="form-group">
                          <label class="title">报价类型：</label>
                          <span>${proj.quotaType == 1 ? '单个标的报价' : '多个标的报总价'}</span>
                      </div>
                      <table>
                      	  <tr>
                      	  	<th width="60">序号</th>
                      	  	<th width="150">标的编号</th>
                      	  	<th width="200">标的名称</th>
                      	  	<th width="70">计量单位</th>
                      	  	<th width="70">竞价数量</th>
                      	  	<th >说明</th>
                      	  	<th width="70" class="last">标的商品</th>
                      	  </tr>
                      	  <c:forEach var="i" items="${subjects}" varStatus="sta">
                      	  <tr>
                      	  	<td>${sta.index + 1}</td>
                      	  	<td>${i.subjectId}</td>
                      	  	<td class="left">${i.subjectName}</td>
                      	  	<td>${i.subjectUnit}</td>
                      	  	<td>${i.subjectNum}</td>
                      	  	<td class="left">${i.intro}</td>
                      	  	<td ><a href="${pageContext.request.contextPath}/market/bid/notice/export/mtr?projId=${proj.projId}&subjectId=${i.subjectId}" target="_blank">标的商品</a></td>
                      	  </tr>
                      	  </c:forEach>
                      </table>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list03.png" alt="3">标书费和投标保证金：</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">竞价标书费用：</label>
                          <span>${proj.tenderPrice}人民币，售后概不退</span>
                      </div>
                      <div class="form-group">
                          <label class="title">竞价保证金费用：</label>
                          <span>${proj.bidBond}人民币</span>
                      </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list04.png" alt="4">本项竞价的起止日期和时间如下：</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">报名截至时间：</label>
                          <span><fmt:formatDate value="${proj.joinEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                      </div>
                      <div class="form-group">
                          <label class="title">竞价开始时间：</label>
                          <span><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                      </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3><img src="${pageContext.request.contextPath}/static/img/bid/img-list05.png" alt="5">本次竞价项目有如下要求：</h3>
                  <div class="notice_inner">
                  	  <div class="form-group">
                          <label class="title">在线竞价时间长度：</label>
                          <span>${proj.bidDuration}分钟</span>
                      </div>
                      <div class="form-group">
                          <label class="title">超时竞价时间间隔：</label>
                          <span>${proj.timeoutInterval}秒</span>
                      </div>
                      <div class="form-group">
                          <label class="title">最低降价值：</label>
                          <span>
                          <c:if test="${proj.minIncrType == 1}">不限</c:if>
                          <c:if test="${proj.minIncrType == 2}">${proj.minIncrVal}</c:if>
                          <c:if test="${proj.minIncrType == 3}">${proj.minIncrVal}%</c:if>
                          </span>
                      </div>
                      <div class="form-group">
                          <label class="title">最大降价幅度百分比限制：</label>
                          <span>${proj.quotaDecrLimit}%</span>
                      </div>
                      <div class="form-group">
                          <label class="title">报价次数限制：</label>
                          <span>
                          
                          <c:if test="${proj.timesLimitType == 1}">不限</c:if>
                          <c:if test="${proj.timesLimitType == 2}">${proj.timesLimitNum}</c:if>
                          </span>
                      </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <div class="other">
                  	<h3>其他问题或咨询请联系：</h3>
                  	<p>${user.companyName}<span>${user.contactPerson}</span></p>
                  	<div class="form-group">
                  	    <label class="title">电话：</label>
                  	    <span>${user.contactNum}</span>
                  	</div>
                  	<div class="form-group">
                  	    <label class="title">传真：</label>
                  	    <span>${user.contactFax}</span>
                  	</div>
                  	<div class="form-group">
                  	    <label class="title">电子邮件</label>
                  	    <span><a href="mailto:${user.email}">${user.email}</a></span>
                  	</div>
                  </div>
              	
              <!--.list_notice--></div>
              
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>