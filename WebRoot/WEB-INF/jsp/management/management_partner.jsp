<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>�ɹ����ƽ̨|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/management_jingjia.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript">
var CONTEXT = "${pageContext.request.contextPath}";
	function query(action){
		document.getElementById("queryForm").action = action;
		document.getElementById("queryForm").submit();
	}
	function updateIfBuilding(action,id,ifBuilding){
		var msg = '';
		if(ifBuilding == 0){
			msg = '��ȷ���Ƿ�ָ�������';
		}else{
			msg = '��ȷ���Ƿ���������';
		}
		
		if(confirm(msg)){
			$.ajax({

			     type: 'POST',

			     url: action ,

			    data: {'id':id,'ifBuilding':ifBuilding} ,

			    success: function (data){
			    	alert('�����ɹ�!');
			    	window.location.href=window.location.href;
			    } ,

			    dataType: 'json',
			    
			    cache:false,
			});
		}
	}
	function deleteSupMapping(action,id){
		if(confirm('�Ƿ����ɾ��������')){
			$.ajax({

			     type: 'POST',

			     url: action ,

			    data: {'id':id} ,

			    success: function (data){
			    	alert('�����ɹ�!');
			    	window.location.href=window.location.href;
			    } ,

			    dataType: 'json',
			    
			    cache:false,
			});
		}
	}
	function checkAll(){
		if($("#checkAll").is(':checked') == true){
			$(":checkbox").prop("checked",true);
		}else{
			$(":checkbox").removeAttr("checked");
		}
	}
	
	function insertPartener(action){
		var supIds = "";
		var checkCount = 0;
		$("input:checkbox[name='isCheck']:checked").each(function() {
			checkCount++;
			supIds = supIds + $(this).val() + ',';
		});
		if(checkCount == 0){
			alert('��ѡ��Ҫ�����Ĺ�Ӧ�̣�');
			return;
		}
		$.ajax({

		     type: 'POST',

		     url: action ,

		    data: {'supIds':supIds} ,

		    success: function (data){
		    	alert('�����ɹ�!');
		    	window.location.href=window.location.href;
		    } ,

		    dataType: 'json',
		    
		    cache:false,
		});
	}
	function querySup(action,page){
		if (action == null) {
			action = CONTEXT+'/management/partner/querySup';
		}
		$.ajax({

		     type: 'POST',

		     url: action ,

		    data: {'supNameParam':$('#supNameParam').val(),
		    	'page':page} ,

		    success: function (data){
		    	$("#supplier_query_tbody").empty();
		    	$("#supplier_page").empty();
		    	var pageObj;
		    	for(var i in data)  
		         {  
		    		if (i == data.length -1) {
		    			pageObj = data[i];
		    			continue;
					}
		    		var item = data[i];
		        	var tr = $("<tr>");
		        	tr.append("<td>" + "<input type='checkbox'  name='isCheck' value="+item.id+">"+"</td>");
		            tr.append("<td>" + item.supName + "</td>");
		            tr.append("<td>" + item.contactPerson + "</td>");
		            tr.append("<td>" + item.contactNum + "</td>");
		            $("#supplier_query_tbody").append(tr);
		         }
		    	if (data.length > 1) {
		    		var html ;
		    		html = "<div class='page'>";
		    		html = html + "<ul class='pagination'>";
		    		for ( var i = 1; i <= pageObj.supPages; i++) {
						if (i == pageObj.page) {
							html = html+"<li class='active'><a href='javascript:void(0);'>"+i+"</a></li>";
						}else {
							html = html +"<li><a href='javascript:void(0);' onclick='querySup(null,"+i+")'>"+i+"</a></li>";
						}
					}
		    		
		    		html = html + "</ul></div><div class='clearfix'></div>";
		    		document.getElementById("supplier_page").innerHTML = html;
		    		//$("#supplier_page").append(html);
		    		//$("#supplier_page").listview("refresh"); 
		    		//$("#supplier_page").trigger("create");
				}
		    } ,

		    dataType: 'json',
		    
		    cache:false,
		});
	}
</script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="header.jsp" />  
  
  
  <div id="contents">
    <div class="inner">
    <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="partner" />
	  </jsp:include>
      <div id="matter_section">
        <h2>������Ӧ�̹���</h2>
        <div class="search_area section">
        <form id="queryForm">
          <div class="search_list clearfix">
            <dl class="clearfix first">
              <dt>��Ӧ�����ƣ�</dt>
              <dd>
                <input type="text" name="supName" class="form-control" value="${enterpriseSupMappingParam.supName}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>��Ӧ����ϵ�ˣ�</dt>
              <dd>
                <input type="text" name="contactPerson" class="form-control" value="${enterpriseSupMappingParam.contactPerson}"/>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>��ϵ�绰��</dt>
              <dd>
                <input type="text" name="contactNum" class="form-control" value="${enterpriseSupMappingParam.contactNum}"/>
              </dd>
            </dl>
          </div>
          </form>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/management/partner')">��ѯ</button></li>
              <li><button type="button" class="btn btn-default red" data-toggle="modal" data-target="#new-supplier">���Ӻ�����Ӧ��</button></li>
            </ul>
          </div>
          <div class="modal fade" id="new-supplier" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h4 class="modal-title" id="myModalLabel">���Ӻ�����Ӧ��</h4>
                </div>
                <div class="modal-body clearfix">
                  <div class="form-group clearfix">
                    <label class="title">��Ӧ������</label>
                    <div class="input_area">
                      <input class="form-control" type="text" name="supNameParam" id="supNameParam"/>
                      <button class="btn btn-default blue" onclick="querySup('${pageContext.request.contextPath}/management/partner/querySup',1)">��ѯ</button>
                    </div>
                  </div>
                  <div class="search_result">
                    <table border="0">
                      <tr>
                      	<th width="70"><input type="checkbox" id="checkAll" type="checkbox" onclick="checkAll();"/></th>
                        <th>��Ӧ������</th>
                        <th width="70">��ϵ��</th>
                        <th class="last" width="70">��ϵ�˵绰</th>
                        
                      </tr> 
                      <tbody id="supplier_query_tbody">
                      <c:forEach var="sup" items="${supInfoList}" varStatus="status">
	                      <tr>
	                      	<td><input type="checkbox"  name="isCheck" value="${sup.supInfoId}"/></td>
	                        <td class="left-list">${sup.supName}</td>
	                        <td>${sup.contactPerson}</td>
	                        <td>${sup.contactNum}</td>
	                      </tr>
	                      </c:forEach>
                      </tbody>
                    </table>
                    <div class="page" id="supplier_page">
                    	<c:if test="${supPages > 0}">
							<div class="page">
								<ul class="pagination">
						
								<c:forEach varStatus="i" begin="1" end="${supPages}" step="1">
						
									<c:set var="idx" value="${i.count}"></c:set>
						
									<c:choose>
										<c:when test="${idx == supPageNum}">
											<li class="active">
											<a href="javascript:void(0);">${idx}</a>
											</li>
										</c:when>
										<c:otherwise>
											<li>
										<a href="javascript:void(0);" onclick="querySup('${pageContext.request.contextPath}/management/partner/querySup',${idx})">${idx}</a>
									</li>
										</c:otherwise>
									</c:choose>
						
								</c:forEach>
						
							</ul>
						</div>
						<div class="clearfix"></div>
						</c:if>
                    </div>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default red" onclick="insertPartener('${pageContext.request.contextPath}/management/partner/insertPartener')">ȷ��</button>
                  <button type="button" class="btn btn-default gray" data-dismiss="modal">ȡ��</button>
                </div>
              </div>
            </div>
          </div>
        <!--.search_area--></div>
        <div class="search_result section">
          <table border="0">
            <tr>
              <th>��Ӧ������</th>
              <th width="70">��ϵ��</th>
              <th width="70">��ϵ�˵绰</th>
              <th width="150">��������ʱ��</th>
              <th width="150">����ƽ̨ʱ��</th>
              <th width="150" class="last">����</th>
            </tr>
            <c:forEach var="enterpriseSupMapping" items="${enterpriseSupMappingList}" varStatus="status">
            <tr>
            		<td class="left-list">${enterpriseSupMapping.supName}</td>
            		<td>${enterpriseSupMapping.contactPerson}</td>
            		<td>${enterpriseSupMapping.contactNum}</td>
            		<td>${enterpriseSupMapping.joinDate}</td>
            		<td>${enterpriseSupMapping.supDate}</td>
               		<td>
						<c:choose>
	              		<c:when test="${enterpriseSupMapping.ifBuilding == 0}">
	              			<a href="javascript:void(0);" onclick="updateIfBuilding('${pageContext.request.contextPath}/management/partner/updateIfBuilding','${enterpriseSupMapping.id}','1')">�������</a>
	              		</c:when>
	              		<c:otherwise>
	              			<a href="javascript:void(0);" onclick="updateIfBuilding('${pageContext.request.contextPath}/management/partner/updateIfBuilding','${enterpriseSupMapping.id}','0')">�ָ�����</a>
	              		</c:otherwise>
	              	</c:choose>
	              		<a href="javascript:void(0);" onclick="deleteSupMapping('${pageContext.request.contextPath}/management/partner/deleteSupMapping','${enterpriseSupMapping.id}')"> ɾ��</a>
					</td>
					 </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
<jsp:include page="page.jsp" /></div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
<script type="text/javascript">
function radioShow(){
 var myradio=document.getElementsByName("myradio");
 var div=document.getElementById("c").getElementsByTagName("div");
 for(i=0;i<div.length;i++){
  if(myradio[i].checked){
   div[i].style.display="block";
   }
   else{
   div[i].style.display="none";
   }
  }
 }
</script>
</body>
</html>