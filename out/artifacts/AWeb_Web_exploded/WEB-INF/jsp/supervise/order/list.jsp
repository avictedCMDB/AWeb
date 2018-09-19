<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>

<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<jsp:include page="../meta.jsp" >
	<jsp:param value="订单管理" name="title"/>
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/supervise_order.css" rel="stylesheet"/>
<script type="text/javascript">
$(function () {
	$("#clear").click(function () {
		$("#supId").val("");
		$("#orderId").val("");
		$("#goodsName").val("");
		$("#companyName").val("");
		$("#timeStart").val("");
		$("#timeEnd").val("");
		$("#orderStatus").val("");
		$("#supType").val("");
	});
	
	$(".del-btn").click(function () {
		

		if (confirm("是否确定删除此订单？")) {
			var oid = $(this).attr("data-id");
			
			async('${pageContext.request.contextPath}/supervise/order/del', {oid:oid}, function (msg) {
				alert(msg.result);
				window.location.reload();
			});
		}
		
		return false;
	});
});

function doQuery(){
	document.getElementById("commitForm").action="${pageContext.request.contextPath}/supervise/order/list";
	document.getElementById("commitForm").submit();
}

function downloadExcel(){
	document.getElementById("commitForm").action="${pageContext.request.contextPath}/supervise/order/downloadExcel";
	document.getElementById("commitForm").submit();
}

function wuLiuShow(order_id,sup_id,supOrderId,sup_type){
	if($("#cpiDiv").length==0||$("#cpiDiv").is(":hidden")){
		$("#cpiDiv").remove();
		if(sup_type=='1'){//传统供应商
			var span = $("#wl_"+order_id);
	    	var cpiDiv = $("<div id='cpiDiv'  onclick='closeDiv()'  class='delivery_info'>" +
	    						"<div class='arrow_top'><img src='${pageContext.request.contextPath}/static/img/management/icon-up.png'></div>" +
	    				  "<div class='close'><i class='fa fa-close'></i></div><div class='title'>物流配送</div></div>");
	    	var cpiUL = $("<ul id='cpiUL'></ul>");
    		var cpiLI;
    		var supExpressCodeVal=$('#supExpressCode_'+order_id).val();
    		if(supExpressCodeVal!='null' && supExpressCodeVal!=null && supExpressCodeVal!='' && supExpressCodeVal!=undefined){
   				cpiLI = $("<li>" +
	   						"<p>物流名称："+$('#supExpressName_'+order_id).val()+"</p>" +
	   						"<p>物流单号："+supExpressCodeVal+"</p>" +
	   					"</li>");
	    		cpiLI.appendTo(cpiUL);
    		}
	    	cpiUL.appendTo(cpiDiv);
	    	cpiDiv.appendTo(span);
   		}else{
   			if(sup_id=='4'){
	   			$("#resultTab").empty();
	   			var resultTab = $("#resultTab");
	   	    	var title = $("<tr><th width='40%'>商品名称</th><th class='last' width='60%'>物流明细</th></tr>");
	   	    	title.appendTo(resultTab);
	   			$.ajax({
	   			    url: '${pageContext.request.contextPath}/supervise/order/wuLiu?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId,
	   			    type: "POST",
	   			    contentType : 'application/json;charset=gbk', //设置请求头信息
	   			    dataType:"json",
	   			    success: function(data){
	   			    	$(data).each(function (i) {
	   			    		var tr = $("<tr></tr>");
	   			    		var goodsTD = $("<td></td>");
	   			    		var goodsStr = "";
	   			    		console.log(this.names[0]);
	   			    		 for ( var i = 0; i < this.names.length; i++) {
	   			    			 goodsStr += this.names[i]+"<br/>";
	   						}
	   			    		goodsTD.html(goodsStr);
	   			    		goodsTD.appendTo(tr);
	   			    		
	   			    		var wuliuTD = $("<td class='limited'></td>");
	   			    		var wuliuUL = $("<ul></ul>");
	   			    		 for ( var i = 0; i < this.orderCpis.length; i++) {
	   			    			 var li = $("<li><span class='title'>物流配送</span>" +
	   				    					"<span>"+this.orderCpis[i].msgTime+"</span>" +
	   				    					this.orderCpis[i].content+"</li>");
	   				    			li.appendTo(wuliuUL);
	   						}
	   			    		wuliuUL.appendTo(wuliuTD);
	   			    		wuliuTD.appendTo(tr);
	   			    		tr.appendTo(resultTab);
	   			    		
	   			    	});
	   			    },
	   			    error: function(res){
	   		            alert('系统忙，请稍后再试。');
	   		        }
	   			});	   			
	   		}
			else{ 
			$.ajax({
			    url: '${pageContext.request.contextPath}/supervise/order/wuLiu?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId,
			    type: "POST",
			    contentType : 'application/json;charset=gbk', //设置请求头信息
			    dataType:"json",
			    success: function(data){
			    	var span = $("#wl_"+order_id);
			    	var cpiDiv = $("<div id='cpiDiv' onclick='closeDiv()'  class='delivery_info'>" +
			    						"<div class='arrow_top'><img src='${pageContext.request.contextPath}/static/img/management/icon-up.png'></div>" +
			    				  "<div class='close'><i class='fa fa-close'></i></div><div class='title'>物流配送</div></div>");
			    	var cpiUL = $("<ul id='cpiUL'></ul>");
			    	$(data).each(function (i) {
			    		var cpiLI;
			    		if (sup_id == '2' ||sup_id == '4' ){
			    			if(i==0){
				    			cpiLI = $("<li>" +
				    						"<p>"+this.msgTime+"</p>" +
				    						"<p>"+this.content+"</p>" +
				    						"<p>"+this.operator+"</p>" +
				    					"</li>");
				    		}else{
				    			cpiLI = $("<li class='old'>" +
			    						"<p>"+this.msgTime+"</p>" +
			    						"<p>"+this.content+"</p>" +
			    						"<p>"+this.operator+"</p>" +
			    					"</li>");
				    		}		    			
			    		}else{
			    			if(i==0){
				    			cpiLI = $("<li>" +
				    						"<p>"+this.operate_time+"</p>" +
				    						"<p>"+this.content+"</p>" +
				    						"<p>"+this.operator+"</p>" +
				    					"</li>");
				    		}else{
				    			cpiLI = $("<li class='old'>" +
			    						"<p>"+this.operate_time+"</p>" +
			    						"<p>"+this.content+"</p>" +
			    						"<p>"+this.operator+"</p>" +
			    					"</li>");
				    		}		    			
			    		}
			    		cpiLI.appendTo(cpiUL);
		            });
			    	
			    	cpiUL.appendTo(cpiDiv);
			    	cpiDiv.appendTo(span);
			    },
			    error: function(res){
		            alert('系统忙，请稍后再试。');
		        }
			});
			}
   		}
	}else{
		$("#cpiDiv").hide();
	}
}

function wuLiuHide(prefix,wlid){
	$('#cpiDiv').hide();
}
function closeDiv(){
	$("#cpiDiv").remove();
}
function orderCancel(order_id,sup_id,supOrderId,sup_type){
	var result =confirm("您确定要取消订单吗？");
	if(result ==true){
		$.ajax({
		    url:'${pageContext.request.contextPath}/supervise/order/orderCancel?orderID='+order_id+"&supID="+sup_id+"&supOrderId="+supOrderId+"&sup_type="+sup_type,
		    type: "POST",
		    contentType : 'application/json;charset=gbk', //设置请求头信息
		    dataType:"json",
		    success: function(data){
		    	if(data.result=='ok'){
					window.location.reload();
		    	}else{
		    		alert('系统忙，请稍后再试。');
		    	}
		    },
		    error: function(res){
	            alert('系统忙，请稍后再试。');
	        }
		});
	}
}
</script>
</head>

<body>
<div class="page-wrapper">
  
  <jsp:include page="../header.jsp" />
  
  <div id="contents">
    <div class="inner">
    	
      <jsp:include page="../left.jsp">
      	<jsp:param value="order" name="menu"/>
      </jsp:include>	
    	
      <div id="matter_section">
      	<h2>订单管理</h2>
      	<div class="search_area section">
          <form id="commitForm" action="${pageContext.request.contextPath}/supervise/order/list" method="get">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>供应商名称：</dt>
              <dd>
                <select class="form-control" name="supId" id="supId">
                	<option value="">全部</option>
					<c:forEach var="item" varStatus="sta" items="${sups}">
					<option value="${item.supId}" <c:if test="${supId == item.supId}">selected="selected"</c:if>>${item.supName }</option>
					</c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>订单编号：</dt>
              <dd>
                <input type="text" class="form-control" name="orderId" id="orderId" value="${orderId}">
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>商品名称：</dt>
              <dd>
                <input type="text" class="form-control" name="goodsName" id="goodsName" value="${goodsName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>采购单位：</dt>
              <dd>
                <input type="text" class="form-control" name="companyName" id="companyName" value="${companyName}">
              </dd>
            </dl>
            <dl class="clearfix date_list">
              <dt>下单时间：</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" class=" form-control special_input" name="timeStart" id="timeStart" value="${timeStart}" readonly="readonly" style="background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeStart').focus()"></i></span>
                    </div>
                  </li>
                  <li>-</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" class=" form-control special_input" name="timeEnd" id="timeEnd" value="${timeEnd}" readonly="readonly" style="background-color: #ffffff;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                      <span class="input-group-addon"><i class="fa fa-calendar" onclick="$('#timeEnd').focus()"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>订单状态：</dt>
              <dd>
                <select class="form-control" name="orderStatus" id="orderStatus">
                    <option value="">全部</option>
					<c:forEach var="item" varStatus="sta" items="${codes}">
					<option value="${item.codeValue}" <c:if test="${orderStatus == item.codeValue}">selected="selected"</c:if>>${item.codeText }</option>
					</c:forEach>
                </select>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>类别：</dt>
              <dd>
                <select class="form-control" name="supType" id="supType">
                	<option value="">全部</option>
					<option value="0" <c:if test="${supType == 0}">selected="selected"</c:if>>电商</option>
					<option value="1" <c:if test="${supType == 1}">selected="selected"</c:if>>专业市场</option>
				</select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="submit" onclick="doQuery();" class="btn btn-default red">查询</button></li>
              <li><button type="button" id="clear" class="btn btn-default gray">清空</button></li>
              <li><button type="button" onclick="downloadExcel();" class="btn btn-default red">导出</button></li>
            </ul>
          </div></form>
        </div>
        <div class="search_result">
          <div class="state_list">
            <div style="float:right;">采购金额合计：<span class="price"><fmt:formatNumber value="${stat.orderAmountInit == null ? 0 : stat.orderAmountInit}" pattern="#0.00#"></fmt:formatNumber></span> 
            销售金额合计：<span class="price"><fmt:formatNumber value="${stat.orderAmount == null ? 0 : stat.orderAmount}" pattern="#0.00#"></fmt:formatNumber></span>
            退款金额合计：<span class="price"><fmt:formatNumber value="${stat.refundPrice == null ? 0 : stat.refundPrice}" pattern="#0.00#"></fmt:formatNumber></span></div>
          </div>
          <table>
            <tr>
              <th colspan="2">商品信息</th>
              <th width="95">供应商单价(元)</th>
              <th width="95">单价(元)</th>
              <th width="75">数量</th>
              <th width="95">金额(元)</th>
              <th width="110">订单状态</th>
              <th width="120" class="last">操作</th>
            </tr>
			<c:forEach var="item" varStatus="sta" items="${list}">
            <tr class="company">
              <td colspan="6">
                <ul class="clearfix">
                  <li>订单编号：<a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.orderId}">${item.orderId}</a></li>
                  <c:if test="${item.supOrderId !='' and item.supOrderId != null  }">
                  <li>供应商订单编号：${item.supOrderId}</li>
                  </c:if>
                  <li>供应商：<span>${item.supName}</span></li>
                </ul>
                <ul>  
                  <li>采购单位：<span>${item.companyName}</span></li>
                  <li>采购类型：<span>${item.buyType == 1 ? '企业自采' : '正常采购'}</span></li>
                  <li>利润：<span class="price"><fmt:formatNumber value="${item.orderAmount - item.orderAmountInit}" pattern="#0.00#"></fmt:formatNumber></li>
                  <li>合计：<span class="price"><fmt:formatNumber value="${item.orderAmount}" pattern="#0.00#"></fmt:formatNumber></li>   
                  <c:if test="${item.refundPrice > 0}">
                  <li>退款：<span class="price"><fmt:formatNumber value="${item.refundPrice}" pattern="#0.00#"></fmt:formatNumber></li> 
                  </c:if>
                  </ul>
                </td>
                <td colspan="2">
                  <ul><li class="right_box">下单时间：<span><fmt:formatDate pattern="yyyy-MM-dd" 
            value="${item.orderTime}" /></span></li>      </ul>           
              </td>
            </tr>
            <c:forEach var="goods" varStatus="sta" items="${item.snapshots}">
            <tr>
              <td class="right_none"><p class="img_pro"><a href="${pageContext.request.contextPath}/supervise/order/goods?gid=${goods.supGoodsId}&sid=${goods.supId}">
              
              	<c:if test="${goods.supType == 1}">
                <img width="55px" height="55px" src="${pageContext.request.contextPath}${goods.imagePath == null ? '/static/img/img-profession.jpg' : goods.imagePath}">
				</c:if>
				<c:if test="${goods.supType == 0}">
                <img width="55px" height="55px" src="${goods.imagePath}">
				</c:if>
              </a></p></td>
              <td width="387" class="left_none"><a href="${pageContext.request.contextPath}/supervise/order/goods?gid=${goods.supGoodsId}&sid=${goods.supId}">${fn:escapeXml(goods.goodsName)}<c:if test="${goods.supType == 1}">(${goods.goodsModel})</c:if></a></td>
              <td class="price"><fmt:formatNumber value="${goods.goodsPriceInit}" pattern="#0.00#"></fmt:formatNumber></td>
              <td class="price"><fmt:formatNumber value="${goods.goodsPrice}" pattern="#0.00#"></fmt:formatNumber></td>
              <td class="num">${goods.buyNum }</td>
              <td class="price"><fmt:formatNumber value="${goods.goodsPrice * goods.buyNum}" pattern="#0.00#"></fmt:formatNumber></td>
              <c:if test="${sta.index == 0 }">
              <td rowspan="${fn:length(item.snapshots)}">${item.orderStatusName}</td>
              <td width="130" rowspan="${fn:length(item.snapshots)}">
              <a href="${pageContext.request.contextPath}/supervise/order/detail?o=${item.orderId}">查看</a>
              <c:if test="${item.orderStatus >=2 && item.orderStatus!=17 && item.orderStatus!=15 && item.orderStatus!=18 && item.orderStatus!=19 }">
	               <span id="wl_${item.orderId}" class="delivery" >
	                  <a href="javascript:void(0);" <c:if test="${item.supId == '4'}"> data-toggle="modal" data-target="#logistics_check"</c:if> onclick="wuLiuShow('${item.orderId}','${item.supId}','${item.supOrderId}','${item.supType}')">查看物流</a>
	      			<input type="hidden" id="supExpressCode_${item.orderId}" name="supExpressCode_${item.orderId}" value="${item.supExpressCode}"/>
	       			<input type="hidden" id="supExpressName_${item.orderId}" name="supExpressName_${item.orderId}" value="${item.supExpressName}"/>
	                </span>
              </c:if>
              <c:if test="${item.orderStatus==1 || item.orderStatus==15 || item.orderStatus==0 || item.orderStatus==18 || item.orderStatus==19}">
               <a id="cancelBtn_${item.orderId}" href="javascript:void(0);" onclick="orderCancel('${item.orderId}','${item.supId}','${item.supOrderId}','${item.supType}')">取消订单</a>
              </c:if>              	
              <c:if test="${item.orderStatus == 17}">
              <a href="javascript:;" data-id="${item.orderId}" class="del-btn">删除</a>
              </c:if>
              </td>
              </c:if>
            </tr>
            </c:forEach>
            </c:forEach>
          </table>
          <!-- 显示物流div -->
          <div class="modal fade" id="logistics_check" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                   <div class="modal-dialog">
                       <div class="modal-content">
                           <div class="modal-header">
                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                               <h4 class="modal-title" id="myModalLabel">物流信息</h4>
                           </div>
                           <div class="modal-body">
                               <table id = "resultTab">
                                  <!--  <tr>
                                       <th width="40%">商品名称</th>
                                       <th class="last" width="60%">物流明细</th>
                                   </tr>
                                   <tr>
                                       <td>商品A<br />商品<br />A商品<br />A商品A</td>
                                       <td class="limited">
                                           <ul>
                                               <li><span class="title">物流配送</span><span>2017-02-14 10:09:10</span>您提交了订单，请等待系统确认</li>
                                               <li><span class="title">物流配送</span><span>2017-02-14 10:09:10</span>您提交了订单，请等待系统确认</li>
                                           </ul>
                                       </td>
                                   </tr> -->
                               </table>
                           </div>
                       </div>
                   </div>
                 </div>
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
