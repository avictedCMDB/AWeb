<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ page import="java.util.List" %>
<%@ page import="com.avic.management.models.Order" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.avic.passport.models.User" %>
<%@ page import="com.avic.common.constants.SessionKeys" %>
<%@ page import="com.avic.common.constants.UserRole" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%
	String path = request.getContextPath();
	List<Order> ordersList = (List<Order>) request.getAttribute("ordersList");
	Order order_query = (Order) request.getAttribute("order_query");
	List<Order> ordersStatusList = (List<Order>) request.getAttribute("ordersStatusList");
	String order_time = order_query.getOrder_time();
	String order_status = order_query.getOrder_status();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>订单管理|中航采购网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_order.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/managementOrder.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//下单时间查询回显
		<%if(order_time!=null && !"".equals(order_time)){%>
			$("#order_time").val(<%=order_time%>);
		<%}%>
		
		//订单状态回显
		<%if(order_status!=null && !"".equals(order_status)){%>
			$("#order_status1").val(<%=order_status%>);
		  <%if("99".equals(order_status)||"1".equals(order_status)||"6".equals(order_status)){%>
				$("#li"+<%=order_status%>).addClass('active').siblings().removeClass('active');
		  <%}else if("2".equals(order_status)){%>
				$('#li3').addClass('active').siblings().removeClass('active');
		  <%}else{%>
			  $("#li99").removeClass('active').siblings().removeClass('active');
		  <%}
		}%>
	});
</script>
<style type="text/css">
.search_result table tr td a {
    margin-right: 0px;
}
</style>
</head>

<body>
<div class="page-wrapper">
  <jsp:include page="header.jsp"/>
  
  <div id="contents">
    <div class="inner">
	  <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="order" />
	  </jsp:include>
      
      <div id="matter_section">
      	<h2>订单管理</h2>
      	<form action="" method="post" id="searchForm">
      	<input type="hidden" name="order_status" id="order_status" value="<%=order_query.getOrder_status()==null?"":order_query.getOrder_status() %>"/>
      	<input type="hidden" id="path" name="path" value="<%=path %>"/>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>供应商名称</dt>
              <dd>
                <input type="text" id="sup_name" name="sup_name" value="<%=order_query.getSup_name()==null?"":order_query.getSup_name() %>" class="form-control">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>订单编号</dt>
              <dd>
                <input type="text" id="order_id" name="order_id" value="<%=order_query.getOrder_id()==null?"":order_query.getOrder_id() %>" class="form-control">
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>商品名称</dt>
              <dd>
                <input type="text" id="goods_name" name="goods_name" value="<%=order_query.getGoods_name()==null?"":order_query.getGoods_name() %>" class="form-control">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>下单时间</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input id="startTime" name="startTime" style="width:72px" type="text" class="form-control special_input" value="${order_query.startTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>至</li>
                <li class="last">
                  <div class="input-group">
                    <input id="endTime" name="endTime" style="width:72px" type="text" class="form-control special_input" value="${order_query.endTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
               <!--  <select id="order_time" name="order_time" class="form-control">
                  <option value="99">全部</option>
                  <option value="0">最近一个月</option>
                  <option value="1">最近三个月</option>
                  <option value="2">最近一年</option>
                </select> -->
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>订单状态</dt>
              <dd>
                <select id="order_status1" name="order_status1" class="form-control" onchange="getOrderStatus();">
                <option value="99">全部</option>
                <%
                if(!ordersStatusList.isEmpty()){
                	for(int j=0;j<ordersStatusList.size();j++) {
                    	Order t_order = (Order) ordersStatusList.get(j);
              	%>
              		<option value="<%=t_order.getStatusValue() %>"><%=t_order.getStatusName() %></option>
              	<%	
                    }
                }
                %>
                </select>
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>供应商类型</dt>
              <dd>
                <select id="supType" name="supType" class="form-control" >
                	<option value="" <c:if test="${order_query.supType == ''}"> selected="selected" </c:if>>全部</option>
					<option value="0" <c:if test="${order_query.supType == '0'}"> selected="selected" </c:if>>电商</option>
					<option value="1" <c:if test="${order_query.supType == '1'}"> selected="selected" </c:if>>传统供应商</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="doInit('<%=path %>');">查询</button></li>
              <li><button type="reset" class="btn btn-default gray" onclick="clrAllVal();">清空</button></li>
              <li><button type="button" class="btn btn-default red" onclick="downloadExcel('<%=path %>');">导出</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
        
      	<div class="search_result">
          <div class="state_list">
            <ul id='sul'>
              <li id="li99" class="active"><a href="javascript:void(0)">全部</a></li>
              <li id="li1"><a href="javascript:void(0)">待审核</a></li>
              <li id="li3"><a href="javascript:void(0)">待收货</a></li>
              <li id="li6"><a href="javascript:void(0)">已退回</a></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th colspan="2">商品信息</th>
              <th width="95">单价(元)</th>
              <th width="75">数量</th>
              <th width="95">金额(元)</th>
              <th width="110">订单状态</th>
              <th width="110" class="last">操作</th>
            </tr>
            <%if(!ordersList.isEmpty()){
            	String tmpOrderId = "";
            	int rowSpan = 0;
    	    	for(int i=0;i<ordersList.size();i++){
    	    		rowSpan++;
    	    		Order aOrder = (Order) ordersList.get(i);
    	    		String goodsDetailUrl = path+"/market/goods/show?sid="+aOrder.getSup_id()+"&gid="+aOrder.getSupGoodsID();
	                String imgPath = aOrder.getImage_path();
	                if("1".equals(aOrder.getSup_type())){//传统供应商有默认图片地址
	              	  if(imgPath==null || "".equals(imgPath)){
	              		  imgPath = path+"/static/img/img-profession.jpg";
	              	  }
	                }
    	    		if(i==0 || (i>0 && !tmpOrderId.equals(aOrder.getOrder_id()))){%>
 	    	<tr class="company">
              <td colspan="7">
                <ul>
                  <li>订单编号：<a href="<%=path %>/market/order/detail?o=<%=aOrder.getOrder_id() %>"><%=aOrder.getOrder_id() %></a></li>
                  <li>供应商：<span><%=aOrder.getSup_name() %></span></li>
	              	<%if("0".equals(aOrder.getSup_type())){//传统供应商%>
	                  <li>供应商订单编号：<span><%=aOrder.getSup_order_id() %></span></li>     
	              	<%}%>            		 
                  <li <%if("1".equals(aOrder.getInvoice_status())){%>
                  		<%= "onmouseover=\"invoiceShow('in_','"+aOrder.getOrder_id()+"')\" onmouseout=\"invoiceHide('in_','"+aOrder.getOrder_id()+"')\"" %> 
               		  <%} %>>
                  	发票状态：
                  	<span><%="1".equals(aOrder.getInvoice_status())==true?"已开具":"未开具"%>
                  	<div id="in_<%=aOrder.getOrder_id() %>" class="delivery_info" style="display:none;">
	                    <div class="arrow_top"><img src="${pageContext.request.contextPath}/static/img/management/icon-up.png"></div>
	                    <div class="title">发票快递</div>
	                    <ul>
	                      <li style="list-style-type:none;">
	                        <p style="line-height: 23px;">快递公司：<%=aOrder.getExpress_name()==null?"":aOrder.getExpress_name() %></p>
	                        <p style="line-height: 23px;">快递单号：<%=aOrder.getExpress_code()==null?"":aOrder.getExpress_code() %></p>
	                      </li>
	                    </ul>
                    </div></span>
               	 </li>
                  <li class="right_box">下单时间：<span><%=aOrder.getOrder_time() %></span></li>
                  <li class="right_box">合计：
                  	<span class="price">
                  	<%= new BigDecimal(aOrder.getOrder_amount()).setScale(2,BigDecimal.ROUND_HALF_UP)%>
                  	<span>
                  </li>
                </ul>
              </td>
            </tr>
            <tr>
              <td class="right_none"><p class="img_pro"><a href='javascript:void(0)' onclick="openWindow('<%=goodsDetailUrl %>')"><img style="height: 55px;width: 55px;" src="<%=imgPath %>" /></a></p></td>
              <td width="387" class="left_none">
              	<a href='javascript:void(0)' onclick="openWindow('<%=goodsDetailUrl %>')">
              	<%if("1".equals(aOrder.getSup_type())){//传统供应商%>
              		<%=aOrder.getGoods_name()+"（"+aOrder.getGoods_model()+"）" %>
              	<%}else{%>
              		<%=aOrder.getGoods_name() %>
                <%}%>
                </a>
              </td>
              <td class="price"><%=aOrder.getGoods_price() %></td>
              <td class="num"><%=aOrder.getBuy_num() %></td>
              <td class="price"><%=aOrder.getTotalprice() %></td>
              <td id="status_<%=aOrder.getOrder_id() %>" rowspan="<%=aOrder.getRowspan() %>">
              <% int order_status_int = Integer.valueOf(aOrder.getOrder_status());
              	 if(order_status_int>5 && order_status_int <=14 || order_status_int ==20){
              	 String contStr ="";
              	 if(aOrder.getENum()!=null && !"".equals(aOrder.getENum()) && !"0".equals(aOrder.getENum())){
              		 contStr+="<a href='"+path+"/management/exchange?searchOrderID="+aOrder.getOrder_id()+"'>有换货</a>";
              	 }
              	 if(aOrder.getRNum()!=null && !"".equals(aOrder.getRNum()) && !"0".equals(aOrder.getRNum())){
              		 if(!"".equals(contStr)){
              			contStr+=",<a href='"+path+"/management/refound?searchOrderID="+aOrder.getOrder_id()+"'>有退货</a>";
              		 }else{
              			contStr+="<a href='"+path+"/management/refound?searchOrderID="+aOrder.getOrder_id()+"'>有退货</a>";
              		 }
             	 }
              	 String status_name = "";
              	 if(order_status_int ==20){
              		status_name = "订单结束";
              	 }else if(!"".equals(contStr) && order_status_int ==20){
              		 status_name = "订单结束</br><span style='margin-right: -10px;margin-left: -9px;'>（"+contStr+"）</span>";
              	 }else if(!"".equals(contStr)){
              		 status_name = "订单完成</br><span style='margin-right: -10px;margin-left: -9px;'>（"+contStr+"）</span>";
              	 }else{
              		 status_name = "订单完成";
              	 }
              	 %>
              	 <%=status_name %>
               <%}else{ %>
              	<%=aOrder.getOrder_status_name() %>
           	  <%}%>
              </td>
              <td class="payment" rowspan="<%=aOrder.getRowspan() %>">
              	<a href="<%=path %>/market/order/detail?o=<%=aOrder.getOrder_id() %>">查看</a>
              	<%if("22".equals(aOrder.getOrder_status())){%> 
              		<a href="<%=path %>/management/order/contract?orderId=<%=aOrder.getOrder_id() %>">生成电子合同</a>
              	<%}%>
              	<%if("24".equals(aOrder.getOrder_status())){%> 
              		<a href="<%=path %>/management/order/contractAudit?orderId=<%=aOrder.getOrder_id() %>">电子合同审核</a>
              	<%}%>
              	<%if("1".equals(aOrder.getSup_type()) && (order_status_int==5 || order_status_int==14 || order_status_int==20 || order_status_int==21)){//传统供应商%> 
              	<a href="javascript:void(0);" onclick="showP('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>');">查看报价单</a>
              	<a href="<%=path %>/management/order/contractAudit?orderId=<%=aOrder.getOrder_id() %>">查看电子合同</a>
              	<%}//传统供应商%>
		             <% if(order_status_int>5 && order_status_int <= 14 && "1".equals(aOrder.getIsShowThhBtn())){ %>
              	<a href="javascript:void(0);" onclick="refoundGoods('${pageContext.request.contextPath}','<%=aOrder.getOrder_id() %>')">退货</a>
              	<a href="javascript:void(0);" onclick="exchangeGoods('${pageContext.request.contextPath}','<%=aOrder.getOrder_id() %>')">换货</a>
           			<%}else if(order_status_int==2 || order_status_int==5){ %>
              	<a id="dc_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="doReceived('${pageContext.request.contextPath}','<%=aOrder.getOrder_id() %>')">确认收货</a>
               		<%}else if(order_status_int==1 || order_status_int==15){// 待审核/待支付  %>
                		<%
                		User user = (User)session.getAttribute(SessionKeys.LOGIN_USER);
                		if(user.getAuthorities().contains(UserRole.CLIENT.value())==true){// 2C用户(对于2C用户来说是不会出现待审核状态的)  %>
       			<a id="qf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0002">企业支付</a>
              	<a id="gf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0001">个人支付</a>
              	<a id="wf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0004">无卡支付</a>
              	<a id="wf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0005">支付宝</a>
                		<%} %>
       			<a id="cancelBtn_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="orderCancel('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>','<%=aOrder.getSup_order_id() %>','<%=aOrder.getSup_type() %>')">取消订单</a>
               		<%}else if(order_status_int==0 || order_status_int==18 || order_status_int==19){//审核拒绝/待供应商审核/供应商审核拒绝（只有查看和取消订单按钮） %>
       			<a id="cancelBtn_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="orderCancel('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>','<%=aOrder.getSup_order_id() %>','<%=aOrder.getSup_type() %>')">取消订单</a>
               		<%}else if(order_status_int==17){//取消的订单（可以删除） %>
       			<a id="delBtn_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="orderDel('<%=aOrder.getOrder_id() %>')">删除订单</a>
               		<%}%>
               		
               		<% if(order_status_int>=2 && order_status_int!=17 && order_status_int!=15 && order_status_int!=18 && order_status_int!=19){//特殊处理支付完成之后的状态都显示查看物流 %>
              	<span id="wl_<%=aOrder.getOrder_id() %>" class="delivery">
                  <a href="javascript:void(0);" <%if(aOrder.getSup_id().equals("4")){ %> data-toggle="modal" data-target="#logistics_check" <%}%> onclick="wuLiuShow('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>','<%=aOrder.getSup_order_id() %>','<%=aOrder.getSup_type() %>')">查看物流</a>
      			<input type="hidden" id="supExpressCode_<%=aOrder.getOrder_id() %>" name="supExpressCode_<%=aOrder.getOrder_id() %>" value="<%=aOrder.getSup_express_code() %>"/>
       			<input type="hidden" id="supExpressName_<%=aOrder.getOrder_id() %>" name="supExpressName_<%=aOrder.getOrder_id() %>" value="<%=aOrder.getSup_express_name() %>"/>
                </span>
                <% }%>
              		<% if( !"".equals(aOrder.getCompareId()) && aOrder.getCompareId() != null){%> 
              			<a href="${pageContext.request.contextPath}/management/compare?orderID=<%=aOrder.getCompareId() %>">商品比对记录</a>
              		<% }%>
              </td>
            </tr>
    	    		<%}else{%>
	    	<tr>
              <td class="right_none"><p class="img_pro"><a href='javascript:void(0)' onclick="openWindow('<%=goodsDetailUrl %>')"><img style="height: 55px;width: 55px;" src="<%=imgPath %>" /></a></p></td>
              <td width="387" class="left_none">
              <a href='javascript:void(0)' onclick="openWindow('<%=goodsDetailUrl %>')">
               <%if("1".equals(aOrder.getSup_type())){//传统供应商%>
              		<%=aOrder.getGoods_name()+"（"+aOrder.getGoods_model()+"）" %>
              	<%}else{%>
              		<%=aOrder.getGoods_name() %>
                <%}%>
              </a></td>
              <td class="price"><%=aOrder.getGoods_price() %></td>
              <td class="num"><%=aOrder.getBuy_num() %></td>
              <td class="price"><%=aOrder.getTotalprice() %></td>
            </tr>
    	    		<%}
    	    		tmpOrderId = aOrder.getOrder_id();
    	    	}
            }
            %>
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
          
        <!--.search_result--></div>
      	<jsp:include page="page.jsp" />
      <!--#matter_section-->
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
  
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>