<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  <div id="side_navi">
    		<dl>
    			<dt class="tlt_merchandise">交易管理<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li <c:if test="${param.menu == 'order'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/order"><span class="fa fa-caret-right"></span>订单管理</a></li>
                        <!-- <li><a href="${pageContext.request.contextPath}/supplier/delivery"><span class="fa fa-caret-right"></span>发货管理</a></li> -->
                        <li <c:if test="${param.menu == 'exchange'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/exchange"><span class="fa fa-caret-right"></span>换货管理</a></li>
                        <li <c:if test="${param.menu == 'return'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/return"><span class="fa fa-caret-right"></span>退货管理</a></li>
                        <c:if test="${sessionScope.loginSupType == '1'}">
    						 <li  <c:if test="${param.menu == 'enquiry'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsEnquiry"><span class="fa fa-caret-right"></span>询价管理</a></li>
    						 <li  <c:if test="${param.menu == 'nonstandard'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/offStandRequire"><span class="fa fa-caret-right"></span>商品需求管理</a></li>
    					</c:if>
    				</ul>
    			</dd>
    			<dt class="tlt_transaction">信息维护<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li <c:if test="${param.menu == 'myinfo'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/companyMyInfo"> <span class="fa fa-caret-right"></span>企业资料管理
							</a>
						</li>
    					<!--<li><a href="#"><span class="fa fa-caret-right"></span>联系人信息</a></li>
    					<li <c:if test="${param.menu == 'address'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/address"><span class="fa fa-caret-right"></span>地址库管理</a></li>
                        <li <c:if test="${param.menu == 'express'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/express"><span class="fa fa-caret-right"></span>快递公司管理</a></li>-->
    					<c:if test="${sessionScope.loginSupType == '1'}">
    						 <li  <c:if test="${param.menu == 'infoExt'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsInfoExt"><span class="fa fa-caret-right"></span>扩展信息维护</a></li>
    					</c:if>
    					<li <c:if test="${param.menu == 'changPassWord'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsInfoExt/changPassWord"><span class="fa fa-caret-right"></span>账户信息</a></li>
    				</ul>
    			</dd>
    			<dt class="tlt_reeturns ">结算管理<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd>
    				<ul>
    					<li <c:if test="${param.menu == 'statement'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/statement"><span class="fa fa-caret-right"></span>结算单管理</a></li>
    				</ul>
    			</dd>
    			<dt class="tlt_receipt">我的超市<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd class="last_child">
    				<ul>
    					<li <c:if test="${param.menu == 'goods'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsInfo"><span class="fa fa-caret-right"></span>商品信息管理</a></li>
    					<c:if test="${sessionScope.loginSupType == '1'}">
	    					<li  <c:if test="${param.menu == 'online'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsOnline"><span class="fa fa-caret-right"></span>自动上下架</a></li>
	                        <!--<li><a href="#"><span class="fa fa-caret-right"></span>商品标签管理</a></li> -->
	                        <li  <c:if test="${param.menu == 'trash'}">class="active"</c:if>><a href="${pageContext.request.contextPath}/supplier/goodsTrash"><span class="fa fa-caret-right"></span>商品回收站</a></li>
                        </c:if>
    				</ul>
    			</dd>
    			<dt class="tlt_receipt">项目管理<span class="fa fa-caret-square-o-down"></span></dt>
    			<dd class="last_child">
    				<ul>
						<li <c:if test="${param.menu == 'project_public'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/project/public">
								<span class="fa fa-caret-right"></span>
								最新公开的项目
							</a>
						</li>
						<li <c:if test="${param.menu == 'project_underway'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/project/underway">
								<span class="fa fa-caret-right"></span>
								正在进行的项目
							</a>
						</li>
						<li <c:if test="${param.menu == 'project_over'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/project/over">
								<span class="fa fa-caret-right"></span>
								已结束的项目
							</a>
						</li>
						<li <c:if test="${param.menu == 'contract'}">class="active"</c:if>>
							<a href="${pageContext.request.contextPath}/supplier/contract">
								<span class="fa fa-caret-right"></span>
								合同管理
							</a>
						</li>
					</ul>
    			</dd>
    		</dl>
    		<!--#side_navi-->
    	</div>