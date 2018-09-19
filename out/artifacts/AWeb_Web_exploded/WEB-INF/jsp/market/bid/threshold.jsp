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
<link href="${pageContext.request.contextPath}/static/css/bid_trial.css" rel="stylesheet">
<script type="text/javascript">
$(function () {

	$("#submit_btn").click(function () {
		var val = $.trim($("#threshold_val").val());
		var projId = "${proj.projId}";
		
		if (val == "") {
			alert("请输入警戒竞价值");
			return false;
		}
		
		if (!/^\d+$/.test(val)) {
			alert("警戒竞价值必须为数字");
			return false;
		}
		
		async('${pageContext.request.contextPath}/market/bid/quota/threshold/submit', {projId:projId, val:val}, function (msg) {
			alert("设置成功");
			window.location.href="${pageContext.request.contextPath}/market/bid/quota?projId=${proj.projId}";
		});
	});
	
	$("#cancel_btn").click(function () {
		if ((navigator.userAgent.indexOf('MSIE') >= 0) && (navigator.userAgent.indexOf('Opera') < 0)){ // IE  
	        if(history.length > 0){  
	            window.history.go( -1 );  
	        }else{  
	            window.opener=null;window.close();  
	        }  
	    }else{ //非IE浏览器  
	        if (navigator.userAgent.indexOf('Firefox') >= 0 ||  
	            navigator.userAgent.indexOf('Opera') >= 0 ||  
	            navigator.userAgent.indexOf('Safari') >= 0 ||  
	            navigator.userAgent.indexOf('Chrome') >= 0 ||  
	            navigator.userAgent.indexOf('WebKit') >= 0){  
	  
	            if(window.history.length > 1){  
	                window.history.go( -1 );  
	            }else{  
	                window.opener=null;window.close();  
	            }  
	        }else{ //未知的浏览器  
	            window.history.go( -1 );  
	        }  
	    }  
	});
});
</script>
</head>

<body>
  <div id="contents">
    <div class="inner">
      <div id="matter_section">
          <h2>设置竞价参数并申请竞价项目编号</h2>
          <div class="tab-content">
              <div class="tab_section">
                 <div class="tab_main clearfix">
                   <dl class="clearfix">
                    <dt>采购类别：</dt>
                    <dd>${proj.bidCatName}</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>项目编号：</dt>
                    <dd>${proj.projId}</dd>
                  </dl>
                 </div>
              </div>
              <div class="tab_section">
                <h3>竞价标的</h3>
                <div class="tab_main clearfix">
                  <table class="table_area">
                    <tr>
                      <th width="40">序号</th>
                      <th width="120">标的编码</th>
                      <th width="120">标的名称</th>
                      <th width="70">计量单位</th>
                      <th width="70">数量</th>
                      <th >备注</th>
                      <th width="70" class="last">标的商品</th>
                    </tr>
                    <c:forEach var="i" items="${subjects}" varStatus="sta">
                    <tr>
                      <td>${sta.index + 1}</td>
                      <td>${i.subjectId}</td>
                      <td>${i.subjectName}</td>
                      <td>${i.subjectUnit}</td>
                      <td>${i.subjectNum}</td>
                      <td>${i.intro}</td>
                      <td ><a href="${pageContext.request.contextPath}/supplier/project/export/mtr?projId=${proj.projId}&subjectId=${i.subjectId}" target="_blank">标的商品</a></td>
                    </tr>
                    
                    </c:forEach>
                  </table>
                </div>
              </div>
              <div class="tab_section">
                <h3>报价设置</h3>
                <div class="tab_main clearfix">
                  <dl class="special clearfix">
                    <dt>报价显示：</dt>
                    <dd>${proj.publishQuota == 2 ? '隐藏报价' : '公开报价'}</dd>
                  </dl>
                  <dl class="special clearfix">
                    <dt>报价上限：</dt>
                    <dd>
                    <c:if test="${proj.quotaLimitType == 1}">不限</c:if>
                    <c:if test="${proj.quotaLimitType == 2}">${proj.quotaLimitNum}</c:if>
                    </dd>
                  </dl>
                  <dl class="special clearfix">
                    <dt>最低降价值：</dt>
                    <dd>
                    <c:if test="${proj.minIncrType == 1}">不限</c:if>
                    <c:if test="${proj.minIncrType == 2}">${proj.minIncrVal}</c:if>
                    <c:if test="${proj.minIncrType == 3}">${proj.minIncrVal}%</c:if>
                    （供应商在竞价过程中每次报价的最小调价幅度值）</dd>
                  </dl>
                  <dl class="special clearfix">
                    <dt>报价限制：</dt>
                    <dd>最大降幅不能超过首次报价的${proj.quotaDecrLimit}%</dd>
                  </dl>
                </div>
              </div>
              <div class="tab_section">
                <h3>调价策略</h3>
                <div class="tab_main clearfix">
                  <dl class="special clearfix">
                    <dt>警戒竞价值：</dt>
                    <dd>
                        <div class="input-group">
                            <input type="text" class="form-control" id="threshold_val" value="${val}">
                            <span>(0为不设置警戒值)</span>
                        </div>
                    </dd>
                  </dl>
                  <p class="notice">为防止报价过程中操作失误，请设定警戒值，报价过程中，当总价低于警戒值时系统会弹出确认提示</p >
                </div>
              </div>
              <div class="tab_section tab_section_last">
                  <div class="submit_btn">
                      <ul>
                          <li><button class="btn btn-default blue" id="submit_btn">确定</button></li>
                          <li><button class="btn btn-default gray_cart" id="cancel_btn">取消</button></li>
                      </ul>
                  </div>
              </div>
                          
          </div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>
