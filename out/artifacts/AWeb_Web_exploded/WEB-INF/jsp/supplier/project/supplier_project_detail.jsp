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
<title>竞价公告|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_supplier_info.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

</head>

<body>
  <div id="contents">
    <div class="inner">
      <div id="matter_section">
          <h2>竞价公告</h2>
          <div class="tab">
              <ul id="myTab" class="nav nav-tabs">
                  <li class="active"><a href="#outline" data-toggle="tab">竞价概要</a></li>
                  <li><a href="#notice" data-toggle="tab">竞价须知</a></li>
              </ul>
          </div>
          <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in active" id="outline">
              <div class="tab_section">
                <h3>竞价公告</h3>
                <div class="tab_main clearfix">
                  <dl class="special clearfix">
                    <dt>采购类别：</dt>
                    <dd>${proj.bidCatName }</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>项目编号：</dt>
                    <dd>${proj.projId }</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>项目名称：</dt>
                    <dd>${proj.projName }</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>竞价类型：</dt>
                    <dd>${proj.projType == 1 ? '邀请竞价' : '公开竞价' }</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>决标方式：</dt>
                    <dd>${proj.decideType == 1 ? '价格决标' : '评标决标' }</dd>
                  </dl>
                <c:if test="${proj.budgetPublic == 1}">
                  <dl class="clearfix">
                    <dt>采购预算：</dt>
                    <dd>${proj.budget }</dd>
                  </dl>
                </c:if>
                  <dl class="clearfix">
                    <dt>币种：</dt>
                    <dd>${proj.currencyName }</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>排序规则：</dt>
                    <dd>价格排序</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>交货条件：</dt>
                    <dd>按合同约定</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>供方现场是否显示供应商报价：</dt>
                    <dd>隐藏报价</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>付款条件：</dt>
                    <dd>按合同约定付款</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>供方现场是否显示供应商数量：</dt>
                    <dd>显示数量</dd>
                  </dl>
                </div>
                <p class="notice">（1）邀请合格的竞投人通过网上竞价平台参加下列货物的竞价</p>
              </div>
              <div class="tab_section">
                <h3>竞价的标的，投标拆分及报价要求</h3>
                <div class="tab_main clearfix">
                  <dl class="clearfix">
                    <dt>报价上限：</dt>
                    <dd>${proj.quotaLimitType == 1 ? '不限' : proj.quotaLimitNum }</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>报价方式：</dt>
                    <dd>${proj.quotaType == 1 ? '单标的报价' : '多标的报总价' }</dd>
                  </dl>
                </div>
              </div>
              <div class="tab_section tab_section_last">
                <h3>竞价标的</h3>
                <div class="tab_main">
                  <table class="table_area">
                    <tr>
                      <th width="40">序号</th>
                      <th width="120">标的编码</th>
                      <th width="150">标的名称</th>
                      <th width="90">数量</th>
                      <th width="70">计量单位</th>
                      <th width="90">说明</th>
                      <th width="70">标的商品</th>
                    </tr>
                    <c:forEach var="item" items="${subject }" varStatus="sta">
                    <tr>
                      <td>${sta.index + 1 }</td>
                      <td>${item.subjectId }</td>
                      <td>${item.subjectName }</td>
                      <td>${item.subjectNum }</td>
                      <td>${item.subjectUnit }</td>
                      <td>${item.intro }</td>
                   	  <td ><a href="${pageContext.request.contextPath}/supplier/project/export/mtr?projId=${proj.projId}&subjectId=${item.subjectId}" target="_blank">标的商品</a></td>
                    </tr>
                    </c:forEach>
                  </table>
                </div>
              </div>
            </div>
            <div class="tab-pane fade" id="notice">
              <div class="tab_section">
                <h3>本次竞价的起止日期和时间</h3>
                <div class="tab_main clearfix">
                  <dl class="clearfix">
                    <dt>报名截至时间：</dt>
                    <dd><fmt:formatDate value="${proj.joinEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>竞价开始时间：</dt>
                    <dd><fmt:formatDate value="${proj.bidStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>在线竞价时间长度：</dt>
                    <dd>${proj.bidDuration }分钟</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>超时竞价时间间隔：</dt>
                    <dd>${proj.timeoutInterval }秒</dd>
                  </dl>
                </div>
              </div>
              <div class="tab_section">
                <h3>竞价项目要求</h3>
                <div class="tab_main clearfix">
                  <dl class="clearfix">
                    <dt>最低降价值：</dt>
                    <dd>
                    	<c:if test="${proj.minIncrType == 1 }">不限</c:if>
                    	<c:if test="${proj.minIncrType == 2 }">${proj.minIncrVal }</c:if>
                    	<c:if test="${proj.minIncrType == 3 }">${proj.minIncrVal }%</c:if>
                    </dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>最大降价幅度百分比限制：</dt>
                    <dd>${proj.quotaDecrLimit }%</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>报价次数限制：</dt>
                    <dd>${proj.timesLimitType == 1 ? '不限' : proj.timesLimitNum }</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>是否显示供应商最低报价：</dt>
                    <dd>${proj.showMinQuota == 1 ? '是' : '否'}</dd>
                  </dl>
                </div>
              </div>
              <div class="tab_section">
                <h3>商务要求</h3>
                <div class="tab_main">
                  <table class="table_area">
                    <tr>
                      <th width="40">序号</th>
                      <th width="90">标题</th>
                      <th width="70">发票类型</th>
                      <th width="60">交货期</th>
                      <th width="200">收货地</th>
                      <th>内容</th>
                      <th class="last" width="90">文件</th>
                    </tr>
                    <c:forEach var="item" items="${tender1 }">
                    <tr>
                      <td>${item.tenderId }</td>
                      <td>${item.tenderTitle }</td>
                      <td>
                    	<c:if test="${item.invoiceType == 1 }">不需求</c:if>
                    	<c:if test="${item.invoiceType == 2 }">普通发票</c:if>
                    	<c:if test="${item.invoiceType == 3 }">增值发票</c:if>
                      </td>
                      <td>${item.deliveryTime }天</td>
                      <td>${item.addrProvName } ${item.addrCityName } ${item.addrDistName } ${item.addrDetail }</td>
                      <td>${item.tenderContent }</td>
                      <td><a target="_blank" href="${pageContext.request.contextPath}/supplier/project/download?projId=${item.projId}&tenderType=${item.tenderType}&tenderId=${item.tenderId}">${item.attachName }</a></td>
                    </tr>
                    </c:forEach>
                  </table>
                </div>
            </div>
            <div class="tab_section tab_section_last">
                <h3>技术要求</h3>
                <div class="tab_main">
                  <table class="table_area">
                    <tr>
                      <th width="40">序号</th>
                      <th width="90">标题</th>
                      <th>内容</th>
                      <th class="last" width="90">文件</th>
                    </tr>
                    <c:forEach var="item" items="${tender2 }">
                    <tr>
                      <td>${item.tenderId }</td>
                      <td>${item.tenderTitle }</td>
                      <td>${item.tenderContent }</td>
                      <td><a target="_blank" href="${pageContext.request.contextPath}/supplier/project/download?projId=${item.projId}&tenderType=${item.tenderType}&tenderId=${item.tenderId}">${item.attachName }</a></td>
                    </tr>
                    </c:forEach>
                  </table>
                </div>
              </div>
            </div>
          </div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>
