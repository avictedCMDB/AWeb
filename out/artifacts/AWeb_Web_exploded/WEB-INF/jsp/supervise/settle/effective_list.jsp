<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="�������" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
	$("#clear").click(function () {
		$("#timeStart").val("");
		$("#timeEnd").val("");
		$("#settleId").val("");
		$("#supId").val("");
		$("#settleStatus").val("");
	});
	
	$("#batch_btn").click(function () {
		
		var ids = [];
		
		$(".chxbox").each(function () {
			if (!this.disabled) {
				if (this.checked) {
					ids.push($(this).val());
				}
			}
		});
		if (ids.length == 0) {
			alert("��ѡ��Ҫ��Ч�Ľ��㵥");
			return false;
		}
		
		submit_eff(ids);
		
		return false;
	});
	
	$("#chx_all").click(function () {
		var chx = this.checked;
		$(".chxbox").each(function () {
			if (!this.disabled) {
				this.checked = chx;
			}
		});
	});
	
	$(".chxbox").click(function () {
		if (!this.disabled) {
			var flag = true;
			$(".chxbox").each(function () {
				if (!this.disabled) {
					if (!this.checked) {
						flag = false;
					}
				}
			});
			
			$("#chx_all").get(0).checked = flag;
		}
	});
	
	$(".eff-btn").click(function () {
		var ids = [];
		ids.push($(this).attr("data-id"))
		submit_eff(ids);
		
		return false;
	});
});

var submit_eff = function (ids) {
	if (confirm("�Ƿ�ȷ����Ч��ǰѡ�����㵥��")) {
		
		async('${pageContext.request.contextPath}/supervise/settle/effective/submit', {ids:ids.join(",")}, function (msg) {
			alert(msg.result);
			window.location.reload();
		});
	}
}

var form_check = function () {
	var timeStart = $("#timeStart").val();
	var timeEnd = $("#timeEnd").val();
	
	if (timeStart != "" && timeEnd != "") {
		var a = parseInt(timeStart.replace("-", ""));
		var b = parseInt(timeEnd.replace("-", ""));
		
		if (a > b) {
			alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
			return false;
		}
	}
	
	return true;
}
</script>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../left.jsp">
    		<jsp:param value="settle-effective" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>���㵥����</h2>
      	<div class="search_area section">
         <form action="${pageContext.request.contextPath}/supervise/settle/effective/list" method="get" onsubmit="return form_check();">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>���ɽ������ڣ�</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" class="form-control special_input" id="timeStart" name="timeStart" value="${timeStart}" readonly="readonly" style="cursor:pointer;background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeStart').focus()"></i></span>
                    </div>
                  </li>
                  <li>��</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" class="form-control special_input" id="timeEnd" name="timeEnd" value="${timeEnd}" readonly="readonly" style="cursor:pointer;background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeEnd').focus()"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>���㵥��ţ�</dt>
              <dd>
                <input type="text" class="form-control" id="settleId" name="settleId" value="${settleId}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��Ӧ�����ƣ�</dt>
              <dd>
                <select class="form-control" name="supId" id="supId">
                	<option value="">ȫ��</option>
					<c:forEach var="item" varStatus="sta" items="${sups}">
					<option value="${item.supId}" <c:if test="${supId == item.supId}">selected="selected"</c:if>>${item.supName }</option>
					</c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>���㵥״̬��</dt>
              <dd>
                <select class="form-control" name="settleStatus" id="settleStatus">
                  <option value="">ȫ��</option>
                  <option value="1" <c:if test="${settleStatus == 1}">selected="selected"</c:if>>δ��Ч</option>
                  <option value="2" <c:if test="${settleStatus == 2}">selected="selected"</c:if>>����Ч</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="submit" class="btn btn-default red">��ѯ</button></li>
              <li><button type="button" id="clear" class="btn btn-default gray">���</button></li>
            </ul>
          </div>
          </form>
        </div>
        <div class="search_result">
          <div class="state_list">
          <button class="btn btn-default red" id="batch_btn" type="button">������Ч</button>
          </div>
          <table>
            <tr>
              <th width="70"><input type="checkbox" value="" id="chx_all"></th>
              <th>���㵥���</th>
              <th>��Ӧ������</th>
              <th width="90">��������</th>
              <th width="90">��Ʒ����</th>
              <th width="110">�����Ԫ��</th>
              <th width="110">��������</th>
              <th width="90">���㵥״̬</th>
              <th width="110" class="last">����</th>
            </tr>
            <c:forEach var="item" varStatus="sta" items="${list}">
            <tr>
              <td><input type="checkbox" value="${item.settleId}" class="chxbox" <c:if test="${item.settleStatus == 2}">disabled="disabled"</c:if>></td>
              <td>${item.settleId}</td>
              <td>${item.supName}</td>
              <td>${item.orderNum}</td>
              <td>${item.goodsNum}</td>
              <td><fmt:formatNumber value="${item.settleAmount}" pattern="#0.00#"></fmt:formatNumber></td>
              <td><fmt:formatDate pattern="yyyy-MM-dd" value="${item.createTime}" /></td>
              <td>
				<c:if test="${item.settleStatus == 1}">δ��Ч</c:if>
				<c:if test="${item.settleStatus == 2}">����Ч</c:if>
			  </td>
              <td>
				<c:if test="${item.settleStatus == 1}">
              	<a href="#" data-id="${item.settleId}" class="eff-btn">��Ч</a>
				</c:if>
              	<a href="${pageContext.request.contextPath}/supervise/settle/effective/detail?s=${item.settleId}">�鿴</a>
              </td>
            </tr>
            </c:forEach>
          </table>
        </div>
        <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>
