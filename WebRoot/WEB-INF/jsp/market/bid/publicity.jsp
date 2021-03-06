<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="竞价公示" name="title" />
</jsp:include>

<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_publicity.css" rel="stylesheet">

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/date.js"></script>

<script type="text/javascript">
    
</script>
</head>

<body>

  <div id="contents">
      <div class="inner">
          <div id="matter_section">
              <h2>竞价公示</h2>
              <div class="section step_section" id="myproject">
                  <h3>${proj.projName }<br>
                  <span>（项目编号：</span><span>${proj.projId }</span><span>）定标结果公示</span>
                  </h3>
                  <p>
                    受<span class="underline">${user.companyName }</span>委托，<span class="underline">中航招标网</span>以网上竞价方式，对<span class="underline">${proj.projName }</span>实施竞价采购，现将竞价结果公示如下：
                  </p>
              </div>
              <div class="section list_notice">
                  <h4>1、邀请合格的竞投人通过网上竞价平台参加下列货物的竞价</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">项目名称：</label>
                      <span>${proj.projName }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">项目编号：</label>
                      <span>${proj.projId }</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h4>2、定标（或成交）信息</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">定标供应商名称：</label>
                      <span>${sup.supName }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">定标供应商地址：</label>
                      <span>${sup.address }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">定标金额：</label>
                      <span>${sup.realCurrentQuota }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">主要定标或成交标的名称、规格型号、数量、单价、服务要求或者标的基本概况：</label>
                    </div>
                    <table>
                          <tr>
                            <th width="60">序号</th>
                            <th width="150">标的编号</th>
                            <th width="200">标的名称</th>
                            <th width="70">计量单位</th>
                            <th width="70">报价单位</th>
                            <th width="70">竞价数量</th>
                            <th>说明</th>
                            <th width="70" class="last">标的商品</th>
                          </tr>
                    <c:forEach var="i" items="${subs}" varStatus="sta">
                          <tr>
                            <td>${sta.index + 1}</td>
                            <td>${i.subjectId }</td>
                            <td class="left">${i.subjectName }</td>
                            <td>${i.subjectUnit }</td>
                            <td>${i.subjectUnit }</td>
                            <td>${i.subjectNum }</td>
                            <td class="left">${i.intro }</td>
                            <td ><a href="${pageContext.request.contextPath}/market/bid/notice/export/mtr?projId=${proj.projId}&subjectId=${i.subjectId}" target="_blank">标的商品</a></td>
                          </tr>
                    </c:forEach>
                      </table>
                  </div>
              <!--.list_notice--></div>

              <div class="section list_notice">
                  <h4>3、采购单位的名称、地址和联系方式</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">采购单位名称：</label>
                      <span>${proj.purchaserName }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">采购单位地址：</label>
                      <span>${proj.purchaserAddr }</span>
                    </div>
                    <div class="form-group">
                      <label class="title">采购单位联系人和联系方式：</label>
                      <span>${proj.purchaserContact }</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h4>4、采购代理机构的名称、地址和联系方式</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <label class="title">采购代理机构名称：</label>
                      <span>中航技国际经贸发展有限公司</span>
                    </div>
                    <div class="form-group">
                      <label class="title">采购代理机构地址：</label>
                      <span>北京市朝阳区慧忠路5号，远大中心B座14层</span>
                    </div>
                    <div class="form-group">
                      <label class="title">采购代理机构联系方式：</label>
                      <span>（+86-10）84892588</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h4>5、定标（或成交）结果公告期限</h4>
                  <div class="notice_inner">
                    <div class="form-group">
                      <span>定标（或成交）结果的公示期限为${diff }个工作日。</span>
                    </div>
                  </div>
              <!--.list_notice--></div>
              <div class="img_seal">
                 <img src="${pageContext.request.contextPath}/static/img/bid/img_seal_sample02.jpg" alt="" />
                 <p class="right"><fmt:formatDate value="${proj.publicityDate}" pattern="yyyy年MM月dd日"/></p>
              </div>
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>
