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
<title>��������|�к��ɹ���</title>
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
		//�µ�ʱ���ѯ����
		<%if(order_time!=null && !"".equals(order_time)){%>
			$("#order_time").val(<%=order_time%>);
		<%}%>
		
		//����״̬����
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
      	<h2>��������</h2>
      	<form action="" method="post" id="searchForm">
      	<input type="hidden" name="order_status" id="order_status" value="<%=order_query.getOrder_status()==null?"":order_query.getOrder_status() %>"/>
      	<input type="hidden" id="path" name="path" value="<%=path %>"/>
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>��Ӧ������</dt>
              <dd>
                <input type="text" id="sup_name" name="sup_name" value="<%=order_query.getSup_name()==null?"":order_query.getSup_name() %>" class="form-control">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�������</dt>
              <dd>
                <input type="text" id="order_id" name="order_id" value="<%=order_query.getOrder_id()==null?"":order_query.getOrder_id() %>" class="form-control">
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>��Ʒ����</dt>
              <dd>
                <input type="text" id="goods_name" name="goods_name" value="<%=order_query.getGoods_name()==null?"":order_query.getGoods_name() %>" class="form-control">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�µ�ʱ��</dt>
              <dd>
                <ul class="clearfix">
                <li>
                  <div class="input-group">
                    <input id="startTime" name="startTime" style="width:72px" type="text" class="form-control special_input" value="${order_query.startTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
                <li>��</li>
                <li class="last">
                  <div class="input-group">
                    <input id="endTime" name="endTime" style="width:72px" type="text" class="form-control special_input" value="${order_query.endTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                  </div>
                </li>
              </ul>
               <!--  <select id="order_time" name="order_time" class="form-control">
                  <option value="99">ȫ��</option>
                  <option value="0">���һ����</option>
                  <option value="1">���������</option>
                  <option value="2">���һ��</option>
                </select> -->
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>����״̬</dt>
              <dd>
                <select id="order_status1" name="order_status1" class="form-control" onchange="getOrderStatus();">
                <option value="99">ȫ��</option>
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
              <dt>��Ӧ������</dt>
              <dd>
                <select id="supType" name="supType" class="form-control" >
                	<option value="" <c:if test="${order_query.supType == ''}"> selected="selected" </c:if>>ȫ��</option>
					<option value="0" <c:if test="${order_query.supType == '0'}"> selected="selected" </c:if>>����</option>
					<option value="1" <c:if test="${order_query.supType == '1'}"> selected="selected" </c:if>>��ͳ��Ӧ��</option>
                </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="doInit('<%=path %>');">��ѯ</button></li>
              <li><button type="reset" class="btn btn-default gray" onclick="clrAllVal();">���</button></li>
              <li><button type="button" class="btn btn-default red" onclick="downloadExcel('<%=path %>');">����</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
        
      	<div class="search_result">
          <div class="state_list">
            <ul id='sul'>
              <li id="li99" class="active"><a href="javascript:void(0)">ȫ��</a></li>
              <li id="li1"><a href="javascript:void(0)">�����</a></li>
              <li id="li3"><a href="javascript:void(0)">���ջ�</a></li>
              <li id="li6"><a href="javascript:void(0)">���˻�</a></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th colspan="2">��Ʒ��Ϣ</th>
              <th width="95">����(Ԫ)</th>
              <th width="75">����</th>
              <th width="95">���(Ԫ)</th>
              <th width="110">����״̬</th>
              <th width="110" class="last">����</th>
            </tr>
            <%if(!ordersList.isEmpty()){
            	String tmpOrderId = "";
            	int rowSpan = 0;
    	    	for(int i=0;i<ordersList.size();i++){
    	    		rowSpan++;
    	    		Order aOrder = (Order) ordersList.get(i);
    	    		String goodsDetailUrl = path+"/market/goods/show?sid="+aOrder.getSup_id()+"&gid="+aOrder.getSupGoodsID();
	                String imgPath = aOrder.getImage_path();
	                if("1".equals(aOrder.getSup_type())){//��ͳ��Ӧ����Ĭ��ͼƬ��ַ
	              	  if(imgPath==null || "".equals(imgPath)){
	              		  imgPath = path+"/static/img/img-profession.jpg";
	              	  }
	                }
    	    		if(i==0 || (i>0 && !tmpOrderId.equals(aOrder.getOrder_id()))){%>
 	    	<tr class="company">
              <td colspan="7">
                <ul>
                  <li>������ţ�<a href="<%=path %>/market/order/detail?o=<%=aOrder.getOrder_id() %>"><%=aOrder.getOrder_id() %></a></li>
                  <li>��Ӧ�̣�<span><%=aOrder.getSup_name() %></span></li>
	              	<%if("0".equals(aOrder.getSup_type())){//��ͳ��Ӧ��%>
	                  <li>��Ӧ�̶�����ţ�<span><%=aOrder.getSup_order_id() %></span></li>     
	              	<%}%>            		 
                  <li <%if("1".equals(aOrder.getInvoice_status())){%>
                  		<%= "onmouseover=\"invoiceShow('in_','"+aOrder.getOrder_id()+"')\" onmouseout=\"invoiceHide('in_','"+aOrder.getOrder_id()+"')\"" %> 
               		  <%} %>>
                  	��Ʊ״̬��
                  	<span><%="1".equals(aOrder.getInvoice_status())==true?"�ѿ���":"δ����"%>
                  	<div id="in_<%=aOrder.getOrder_id() %>" class="delivery_info" style="display:none;">
	                    <div class="arrow_top"><img src="${pageContext.request.contextPath}/static/img/management/icon-up.png"></div>
	                    <div class="title">��Ʊ���</div>
	                    <ul>
	                      <li style="list-style-type:none;">
	                        <p style="line-height: 23px;">��ݹ�˾��<%=aOrder.getExpress_name()==null?"":aOrder.getExpress_name() %></p>
	                        <p style="line-height: 23px;">��ݵ��ţ�<%=aOrder.getExpress_code()==null?"":aOrder.getExpress_code() %></p>
	                      </li>
	                    </ul>
                    </div></span>
               	 </li>
                  <li class="right_box">�µ�ʱ�䣺<span><%=aOrder.getOrder_time() %></span></li>
                  <li class="right_box">�ϼƣ�
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
              	<%if("1".equals(aOrder.getSup_type())){//��ͳ��Ӧ��%>
              		<%=aOrder.getGoods_name()+"��"+aOrder.getGoods_model()+"��" %>
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
              		 contStr+="<a href='"+path+"/management/exchange?searchOrderID="+aOrder.getOrder_id()+"'>�л���</a>";
              	 }
              	 if(aOrder.getRNum()!=null && !"".equals(aOrder.getRNum()) && !"0".equals(aOrder.getRNum())){
              		 if(!"".equals(contStr)){
              			contStr+=",<a href='"+path+"/management/refound?searchOrderID="+aOrder.getOrder_id()+"'>���˻�</a>";
              		 }else{
              			contStr+="<a href='"+path+"/management/refound?searchOrderID="+aOrder.getOrder_id()+"'>���˻�</a>";
              		 }
             	 }
              	 String status_name = "";
              	 if(order_status_int ==20){
              		status_name = "��������";
              	 }else if(!"".equals(contStr) && order_status_int ==20){
              		 status_name = "��������</br><span style='margin-right: -10px;margin-left: -9px;'>��"+contStr+"��</span>";
              	 }else if(!"".equals(contStr)){
              		 status_name = "�������</br><span style='margin-right: -10px;margin-left: -9px;'>��"+contStr+"��</span>";
              	 }else{
              		 status_name = "�������";
              	 }
              	 %>
              	 <%=status_name %>
               <%}else{ %>
              	<%=aOrder.getOrder_status_name() %>
           	  <%}%>
              </td>
              <td class="payment" rowspan="<%=aOrder.getRowspan() %>">
              	<a href="<%=path %>/market/order/detail?o=<%=aOrder.getOrder_id() %>">�鿴</a>
              	<%if("22".equals(aOrder.getOrder_status())){%> 
              		<a href="<%=path %>/management/order/contract?orderId=<%=aOrder.getOrder_id() %>">���ɵ��Ӻ�ͬ</a>
              	<%}%>
              	<%if("24".equals(aOrder.getOrder_status())){%> 
              		<a href="<%=path %>/management/order/contractAudit?orderId=<%=aOrder.getOrder_id() %>">���Ӻ�ͬ���</a>
              	<%}%>
              	<%if("1".equals(aOrder.getSup_type()) && (order_status_int==5 || order_status_int==14 || order_status_int==20 || order_status_int==21)){//��ͳ��Ӧ��%> 
              	<a href="javascript:void(0);" onclick="showP('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>');">�鿴���۵�</a>
              	<a href="<%=path %>/management/order/contractAudit?orderId=<%=aOrder.getOrder_id() %>">�鿴���Ӻ�ͬ</a>
              	<%}//��ͳ��Ӧ��%>
		             <% if(order_status_int>5 && order_status_int <= 14 && "1".equals(aOrder.getIsShowThhBtn())){ %>
              	<a href="javascript:void(0);" onclick="refoundGoods('${pageContext.request.contextPath}','<%=aOrder.getOrder_id() %>')">�˻�</a>
              	<a href="javascript:void(0);" onclick="exchangeGoods('${pageContext.request.contextPath}','<%=aOrder.getOrder_id() %>')">����</a>
           			<%}else if(order_status_int==2 || order_status_int==5){ %>
              	<a id="dc_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="doReceived('${pageContext.request.contextPath}','<%=aOrder.getOrder_id() %>')">ȷ���ջ�</a>
               		<%}else if(order_status_int==1 || order_status_int==15){// �����/��֧��  %>
                		<%
                		User user = (User)session.getAttribute(SessionKeys.LOGIN_USER);
                		if(user.getAuthorities().contains(UserRole.CLIENT.value())==true){// 2C�û�(����2C�û���˵�ǲ�����ִ����״̬��)  %>
       			<a id="qf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0002">��ҵ֧��</a>
              	<a id="gf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0001">����֧��</a>
              	<a id="wf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0004">�޿�֧��</a>
              	<a id="wf_<%=aOrder.getOrder_id() %>" target="_blank" href="${pageContext.request.contextPath}/management/finance/pay?o=<%=aOrder.getOrder_id() %>&t=0005">֧����</a>
                		<%} %>
       			<a id="cancelBtn_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="orderCancel('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>','<%=aOrder.getSup_order_id() %>','<%=aOrder.getSup_type() %>')">ȡ������</a>
               		<%}else if(order_status_int==0 || order_status_int==18 || order_status_int==19){//��˾ܾ�/����Ӧ�����/��Ӧ����˾ܾ���ֻ�в鿴��ȡ��������ť�� %>
       			<a id="cancelBtn_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="orderCancel('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>','<%=aOrder.getSup_order_id() %>','<%=aOrder.getSup_type() %>')">ȡ������</a>
               		<%}else if(order_status_int==17){//ȡ���Ķ���������ɾ���� %>
       			<a id="delBtn_<%=aOrder.getOrder_id() %>" href="javascript:void(0);" onclick="orderDel('<%=aOrder.getOrder_id() %>')">ɾ������</a>
               		<%}%>
               		
               		<% if(order_status_int>=2 && order_status_int!=17 && order_status_int!=15 && order_status_int!=18 && order_status_int!=19){//���⴦��֧�����֮���״̬����ʾ�鿴���� %>
              	<span id="wl_<%=aOrder.getOrder_id() %>" class="delivery">
                  <a href="javascript:void(0);" <%if(aOrder.getSup_id().equals("4")){ %> data-toggle="modal" data-target="#logistics_check" <%}%> onclick="wuLiuShow('<%=aOrder.getOrder_id() %>','<%=aOrder.getSup_id() %>','<%=aOrder.getSup_order_id() %>','<%=aOrder.getSup_type() %>')">�鿴����</a>
      			<input type="hidden" id="supExpressCode_<%=aOrder.getOrder_id() %>" name="supExpressCode_<%=aOrder.getOrder_id() %>" value="<%=aOrder.getSup_express_code() %>"/>
       			<input type="hidden" id="supExpressName_<%=aOrder.getOrder_id() %>" name="supExpressName_<%=aOrder.getOrder_id() %>" value="<%=aOrder.getSup_express_name() %>"/>
                </span>
                <% }%>
              		<% if( !"".equals(aOrder.getCompareId()) && aOrder.getCompareId() != null){%> 
              			<a href="${pageContext.request.contextPath}/management/compare?orderID=<%=aOrder.getCompareId() %>">��Ʒ�ȶԼ�¼</a>
              		<% }%>
              </td>
            </tr>
    	    		<%}else{%>
	    	<tr>
              <td class="right_none"><p class="img_pro"><a href='javascript:void(0)' onclick="openWindow('<%=goodsDetailUrl %>')"><img style="height: 55px;width: 55px;" src="<%=imgPath %>" /></a></p></td>
              <td width="387" class="left_none">
              <a href='javascript:void(0)' onclick="openWindow('<%=goodsDetailUrl %>')">
               <%if("1".equals(aOrder.getSup_type())){//��ͳ��Ӧ��%>
              		<%=aOrder.getGoods_name()+"��"+aOrder.getGoods_model()+"��" %>
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
          <!-- ��ʾ����div -->
          <div class="modal fade" id="logistics_check" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                   <div class="modal-dialog">
                       <div class="modal-content">
                           <div class="modal-header">
                               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                               <h4 class="modal-title" id="myModalLabel">������Ϣ</h4>
                           </div>
                           <div class="modal-body">
                               <table id = "resultTab">
                                  <!--  <tr>
                                       <th width="40%">��Ʒ����</th>
                                       <th class="last" width="60%">������ϸ</th>
                                   </tr>
                                   <tr>
                                       <td>��ƷA<br />��Ʒ<br />A��Ʒ<br />A��ƷA</td>
                                       <td class="limited">
                                           <ul>
                                               <li><span class="title">��������</span><span>2017-02-14 10:09:10</span>���ύ�˶�������ȴ�ϵͳȷ��</li>
                                               <li><span class="title">��������</span><span>2017-02-14 10:09:10</span>���ύ�˶�������ȴ�ϵͳȷ��</li>
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