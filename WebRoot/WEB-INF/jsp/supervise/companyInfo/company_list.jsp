<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>��Ӧ�̹���|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supervise_gongyingshang.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/companyInfo.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<input id="path" type="hidden" value="${pageContext.request.contextPath}"/>
<input id="adminType" type="hidden" value="${adminType}"/>
<div class="page-wrapper">
 <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
      <jsp:include page="../left.jsp">
		  <jsp:param name="menu" value="companyInfo" />
	  </jsp:include>
      <div id="matter_section">
      	<h2>��Ӧ�̹���</h2>
      	<div class="search_area section">
      	<form action="${pageContext.request.contextPath}/supervise/companyInfo" id="companyForm" method="post">
          <div class="search_list clearfix">
            <%-- <dl class="clearfix">
              <dt>��֯������ţ�</dt>
              <dd>
                <input type="text" class="form-control" name="companyCode" id="companyCode" value="${companyCode}">
              </dd>
            </dl> --%>
             <dl class="clearfix first">
              <dt>��ҵ���ƣ�</dt>
              <dd>
                <input type="text" class="form-control" name="companyName" id="companyName" value="${companyName}">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�����˺ţ�</dt>
              <dd>
                <input type="text" class="form-control" name="userName" id="userName" value="${userName}">
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>��ϵ�ˣ�</dt>
              <dd>
                <input type="text" class="form-control" name="contactPerson" id="contactPerson" value="${contactPerson}">
              </dd>
            </dl>
            <dl class="clearfix first">
              <dt>��ϵ�绰��</dt>
              <dd>
                <input type="text" class="form-control" name="contactIphone" id="contactIphone" value="${contactIphone}">
              </dd>
            </dl>
            
            <%-- <c:if test="${adminType=='1'}">
            <dl class="clearfix last">
              <dt>�û����ͣ�</dt>
              <dd>
              	<select class="form-control" name="companyType" id="companyType">
                	<option value="">ȫ��</option>
                	<option value="1" <c:if test="${companyType=='1'}">selected="selected"</c:if>>��ͳ��Ӧ��</option>
                	<option value="2" <c:if test="${companyType=='2'}">selected="selected"</c:if>>�ɹ���λ</option>
                </select>
              </dd>
            </dl>
             </c:if> --%>
	           <dl class="clearfix">
	           <dt>���״̬��</dt>
	           <dd>
	           	<select class="form-control" name="ifCheck" id="ifCheck">
	             	<option value="">ȫ��</option>
	             	<option value="0" <c:if test="${ifCheck=='0'}">selected="selected"</c:if>>�����</option>
	             	<option value="1" <c:if test="${ifCheck=='1'}">selected="selected"</c:if>>ͨ��</option>
	             	<option value="2" <c:if test="${ifCheck=='2'}">selected="selected"</c:if>>�ܾ�</option>
	             	<option value="3" <c:if test="${ifCheck=='3'}">selected="selected"</c:if>>����δ���ƴ����</option>
	             </select>
	           </dd>
	         </dl>
	         <dl class="clearfix last">
              <dt>����ʱ�䣺</dt>
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
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="searchCompany();">��ѯ</button></li>
             <!--   <li><button type="button" class="btn btn-default red" onclick="addCompanyInfo();">������֯����</button></li>-->
              <li><button type="button" class="btn btn-default gray" onclick="clean();">���</button></li>
            </ul>
          </div>
            
        <!--.search_area--></div>
        </form>
      	<div class="search_result">
          <table border="0">
            <tr>
              <th>��ҵ����</th>
              <th width="90">��ҵ����</th>
              <th width="70">�����˺�</th>
              <th width="70">��ҵ��ϵ��</th>
              <th width="90">�ֻ�</th>
              <th width="120">����</th>
              <th width="90">����ʱ��</th>
              <th width="70">���״̬</th>
              
              <th width="120" class="last">����</th>
            </tr>
            <c:forEach var="company" items="${companyInfos}" varStatus="status">
	            <tr>
	              <td class="left-align">${company.companyName}</td>
	              	<td>
		              	<c:if test="${company.companyType == '1'}">
		              		��ͳ��Ӧ��
		              	</c:if>
		              	<c:if test="${company.companyType == '2'}">
		              		�ɹ���λ
		              	</c:if>
	              	</td>
	              	<td>${company.userName}</td>
	              	<td>${company.contactPerson}</td>
	              	<td>${company.contactIphone}</td>
	              	<td>${company.contactEmail}</td>
	              	<td>${company.createDate}</td>
	              	<td>
		              	<c:if test="${company.ifCheck == '0'}">
		              		�����
		              	</c:if>
		              	<c:if test="${company.ifCheck == '1'}">
		              		ͨ��
		              	</c:if>
		              	<c:if test="${company.ifCheck == '2'}">
		              		�ܾ�
		              	</c:if>
		              	<c:if test="${company.ifCheck == '3'}">
		              		����δ���ƴ����
		              	</c:if>
	              	</td>
	              	
	              <td>
	              	  <a href="javascript:void(0);" onclick="addCompanyInfo('${company.id}')">�޸�</a>
	              	  <a href="javascript:void(0);" onclick="delCompanyInfo('${company.id}','${company.companyType}')">ɾ��</a>
				 	  <c:if test="${adminType=='1'}">
	              	  	<a href="javascript:void(0);" onclick="checkInit('${company.id}')">���</a>
	              	  </c:if>
	              	  <a href="javascript:void(0);" data-toggle="modal" data-target="#change_pwd" onclick="resetPassword('${company.userName}','${company.supID}');">��������</a>
				  </td>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
        <jsp:include page="../page.jsp" />
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp"/>
<!--.page-wrapper--></div>
<!-- �������뵯����start -->
               <div class="modal fade" id="change_pwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                 <div class="modal-dialog">
                   <div class="modal-content">
                     <div class="modal-header">
                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">��</button>
                       <h4 class="modal-title" id="myModalLabel">��������</h4>
                     </div>
                     <div class="modal-body">
                       <div class="change_inner">
                         <dl class="clearfix">
                           <dt>��¼�˺ţ�</dt>
                           <dd id="userNameDD"></dd>
                           <input id="supID" type="hidden">
                         </dl>
                         <dl class="clearfix">
                           <dt>�����룺</dt>
                           <dd><input class="form-control" type="password" id="newPassword"></dd>
                         </dl>
                         <dl class="clearfix">
                           <dt>ȷ�����룺</dt>
                           <dd><input class="form-control" type="password" id="valitedPassword"></dd>
                         </dl>
                       </div>
                     </div>
                     <div class="modal-footer">
                       <button type="button" class="btn btn-primary" onclick="editSupPassword();">����</button>
                       <button type="button" class="btn btn-default gray_cart" data-dismiss="modal">�ر�</button>
                     </div>
                   </div>
                 </div>
                </div>
               <!-- �������뵯����end -->
</body>
</html>