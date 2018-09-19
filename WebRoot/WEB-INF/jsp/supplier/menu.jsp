<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  <div id="side_navi">
    		<dl>
    			<dt class="tlt_merchandise">���׹���<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li <c:if test="${param.menu == 'order'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/order"><span class="fa fa-caret-right"></span>��������</a></li>
                        <!-- <li><a href="${pageContext.request.contextPath}/supplier/delivery"><span class="fa fa-caret-right"></span>��������</a></li> -->
                        <li <c:if test="${param.menu == 'exchange'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/exchange"><span class="fa fa-caret-right"></span>��������</a></li>
                        <li <c:if test="${param.menu == 'return'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/return"><span class="fa fa-caret-right"></span>�˻�����</a></li>
                        <c:if test="${sessionScope.loginSupType == '1'}">
    						 <li  <c:if test="${param.menu == 'enquiry'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsEnquiry"><span class="fa fa-caret-right"></span>ѯ�۹���</a></li>
    						 <li  <c:if test="${param.menu == 'nonstandard'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/offStandRequire"><span class="fa fa-caret-right"></span>��Ʒ�������</a></li>
    					</c:if>
    				</ul>
    			</dd>
    			<dt class="tlt_transaction">��Ϣά��<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li <c:if test="${param.menu == 'myinfo'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/companyMyInfo"> <span class="fa fa-caret-right"></span>��ҵ���Ϲ���
							</a>
						</li>
    					<!--<li><a href="#"><span class="fa fa-caret-right"></span>��ϵ����Ϣ</a></li>
    					<li <c:if test="${param.menu == 'address'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/address"><span class="fa fa-caret-right"></span>��ַ�����</a></li>
                        <li <c:if test="${param.menu == 'express'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/express"><span class="fa fa-caret-right"></span>��ݹ�˾����</a></li>-->
    					<c:if test="${sessionScope.loginSupType == '1'}">
    						 <li  <c:if test="${param.menu == 'infoExt'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsInfoExt"><span class="fa fa-caret-right"></span>��չ��Ϣά��</a></li>
    					</c:if>
    					<li <c:if test="${param.menu == 'changPassWord'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsInfoExt/changPassWord"><span class="fa fa-caret-right"></span>�˻���Ϣ</a></li>
    				</ul>
    			</dd>
    			<dt class="tlt_reeturns ">�������<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li <c:if test="${param.menu == 'statement'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/statement"><span class="fa fa-caret-right"></span>���㵥����</a></li>
    				</ul>
    			</dd>
    			<dt class="tlt_receipt">�ҵĳ���<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd class="last_child">
    				<ul>
    					<li <c:if test="${param.menu == 'goods'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsInfo"><span class="fa fa-caret-right"></span>��Ʒ��Ϣ����</a></li>
    					<c:if test="${sessionScope.loginSupType == '1'}">
	    					<li  <c:if test="${param.menu == 'online'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsOnline"><span class="fa fa-caret-right"></span>�Զ����¼�</a></li>
	                        <!--<li><a href="#"><span class="fa fa-caret-right"></span>��Ʒ��ǩ����</a></li> -->
	                        <li  <c:if test="${param.menu == 'trash'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsTrash"><span class="fa fa-caret-right"></span>��Ʒ����վ</a></li>
                        </c:if>
    				</ul>
    			</dd>
    			<dt class="tlt_receipt">��Ŀ����<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd class="last_child">
    				<ul>
						<li <c:if test="${param.menu == 'project_public'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/project/public">
								<span class="fa fa-caret-right"></span>
								���¹�������Ŀ
							</a>
						</li>
						<li <c:if test="${param.menu == 'project_underway'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/project/underway">
								<span class="fa fa-caret-right"></span>
								���ڽ��е���Ŀ
							</a>
						</li>
						<li <c:if test="${param.menu == 'project_over'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/project/over">
								<span class="fa fa-caret-right"></span>
								�ѽ�������Ŀ
							</a>
						</li>
						<li <c:if test="${param.menu == 'contract'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/contract">
								<span class="fa fa-caret-right"></span>
								��ͬ����
							</a>
						</li>
					</ul>
    			</dd>
    		</dl>
    		<!--#side_navi-->
    	</div>