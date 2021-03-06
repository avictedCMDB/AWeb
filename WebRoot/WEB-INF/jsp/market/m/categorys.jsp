<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="head.jsp">
	<jsp:param value="分类" name="title"/>
</jsp:include>
<meta name="full-screen" content="yes">
<meta name="x5-fullscreen" content="true">
<style type="text/css">
.search.cate{
	overflow: hidden;
}
</style>
<body class="search cate">
    <div id="cate">
        <div class="header">
            <i class="iconfont back" onclick="history.go(-1);">&#xe615;</i>
            <div class="input">
                <i class="iconfont">&#xe60b;</i>
                <input type="text" autocomplete="off" placeholder="路由器" readonly="readonly" onclick="location.href = '${pageContext.request.contextPath}/market/goods/search';">
            </div>
        </div>
        <div class="left" id="left" style="overflow-y: hidden;">
            <div id="sidebar">
                <c:forEach var="cat" items="${dataCache.getCategoryTree()}" varStatus="status">
                <p class="c" data-cat-id="${cat.sysCatId}" :class="{'active' : ${cat.sysCatId} == active}">
                   	${cat.sysCatName}
                </p>
                </c:forEach>
            </div>
        </div>
        <div class="right" id="right" style="overflow-y: auto;">
           <%-- 	<div id="cate-list" id="cate-list">
			<c:forEach var="level1" items="${dataCache.getCategoryTree()}" varStatus="sta1">
            	<div id="c-${level1.sysCatId}" style="height: 1px; opacity: 0;"></div>
            	<c:forEach var="level2" items="${level1.childCategory}" varStatus="sta2">
            		<div class="cate-item">
	                    <p class="hd" @click="to('${level2.sysCatId}')">${level2.sysCatName}</p>
	                    <div class="content">
	                        <c:forEach var="level3" items="${level2.childCategory}" varStatus="sta3">
	                        	<c:if test="${sta3.first}">
	                        		<div class="row">
	                        	</c:if>
	                            <c:if test="${not sta3.first && sta3.index % 3 == 0}">
	                            	</div><div class="row">
	                            </c:if>
								<div class="cate-item-m" @click="to('${level3.sysCatId}')">
	                                <img :src="replace('${level3.sysCatName}')"/>
	                                <p>${level3.sysCatName}</p>
	                            </div>
	                            <c:if test="${sta3.last}">
	                            	<c:if test="${sta3.index % 3 == 0 || sta3.index % 3 == 1}">
	                            		<c:forEach begin="1" end="${2 - (sta3.index % 3)}">
	                            			<div></div>
	                            		</c:forEach>
	                            	</c:if>
	                            	</div>
	                            </c:if>
							</c:forEach>
	                    </div>
	                </div>
				</c:forEach>
			</c:forEach>
            </div> --%>
<!--
<div></div>
-->

<div id="cate-list">
    <div id="c-1" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('101')" class="hd">办公文具</p>
        <div class="content">
            <div class="row">
                <div @click="to('10101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/24.jpg">
                    <p>书写修正工具</p>
                </div>
                <div @click="to('10102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/237.jpg">
                    <p>文件夹/包/袋</p>
                </div>
                <div @click="to('10103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/266.jpg">
                    <p>桌面文具</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/254.jpg">
                    <p>本册/便签</p>
                </div>
                <div @click="to('10105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/393.jpg">
                    <p>财务用品</p>
                </div>
                <div @click="to('10106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/409.jpg">
                    <p>邮寄运输用品</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/401.jpg">
                    <p>软木板/白板</p>
                </div>
                <div @click="to('10108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/334.jpg">
                    <p>画具画材</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('102')" class="hd">办公用纸</p>
        <div class="content">
            <div class="row">
                <div @click="to('10201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/112.jpg">
                    <p>复印纸</p>
                </div>
                <div @click="to('10202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/204.jpg">
                    <p>打印纸</p>
                </div>
                <div @click="to('10203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/370.jpg">
                    <p>艺术纸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/117.jpg">
                    <p>多用途纸</p>
                </div>
                <div @click="to('10205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/306.jpg">
                    <p>照片纸</p>
                </div>
                <div @click="to('10206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/68.jpg">
                    <p>办公用纸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/185.jpg">
                    <p>彩色复印纸</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('103')" class="hd">办公耗材</p>
        <div class="content">
            <div class="row">
                <div @click="to('10301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/110.jpg">
                    <p>墨粉</p>
                </div>
                <div @click="to('10302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/340.jpg">
                    <p>硒鼓</p>
                </div>
                <div @click="to('10303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/109.jpg">
                    <p>墨盒</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/368.jpg">
                    <p>色带</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('104')" class="hd">文具套装</p>
        <div class="content">
            <div class="row">
                <div @click="to('10401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/64.jpg">
                    <p>办公套装</p>
                </div>
                <div @click="to('10403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/130.jpg">
                    <p>学生套装</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-2" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('201')" class="hd">标签识别设备及耗材</p>
        <div class="content">
            <div class="row">
                <div @click="to('20101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/263.jpg">
                    <p>标签机/条码设备</p>
                </div>
                <div @click="to('20102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/264.jpg">
                    <p>标签机色带/条码设备耗材</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('202')" class="hd">传真机</p>
        <div class="content">
            <div class="row">
                <div @click="to('20201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/297.jpg">
                    <p>激光传真机</p>
                </div>
                <div @click="to('20202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/369.jpg">
                    <p>色带/热转印传真机</p>
                </div>
                <div @click="to('20203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/302.jpg">
                    <p>热敏传真机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/33.jpg">
                    <p>传真机配件</p>
                </div>
                <div @click="to('20206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/32.jpg">
                    <p>传真机</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('203')" class="hd">打印机</p>
        <div class="content">
            <div class="row">
                <div @click="to('20301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/451.jpg">
                    <p>黑白激光打印机</p>
                </div>
                <div @click="to('20302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/187.jpg">
                    <p>彩色激光打印机</p>
                </div>
                <div @click="to('20303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/98.jpg">
                    <p>喷墨/照片打印机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/411.jpg">
                    <p>针式/票据/热敏打印机</p>
                </div>
                <div @click="to('20305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/385.jpg">
                    <p>证卡/热升华打印机</p>
                </div>
                <div @click="to('20306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/120.jpg">
                    <p>大幅面打印机/绘图仪</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/260.jpg">
                    <p>条码打印机</p>
                </div>
                <div @click="to('20308')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/203.jpg">
                    <p>打印机配件</p>
                </div>
                <div @click="to('20309')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/260.jpg">
                    <p>条码打印机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20310')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/446.jpg">
                    <p>高速行式打印机</p>
                </div>
                <div @click="to('20311')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/200.jpg">
                    <p>打印机</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('204')" class="hd">多功能一体机</p>
        <div class="content">
            <div class="row">
                <div @click="to('20401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/450.jpg">
                    <p>黑白激光一体机</p>
                </div>
                <div @click="to('20402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/186.jpg">
                    <p>彩色激光一体机</p>
                </div>
                <div @click="to('20403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/97.jpg">
                    <p>喷墨一体机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/201.jpg">
                    <p>打印机/一体机/传真机配件</p>
                </div>
                <div @click="to('20405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/114.jpg">
                    <p>多功能一体机</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('205')" class="hd">复印机及印刷机</p>
        <div class="content">
            <div class="row">
                <div @click="to('20501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/184.jpg">
                    <p>彩色低速数码复印机</p>
                </div>
                <div @click="to('20502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/183.jpg">
                    <p>彩色中高速数码复印机</p>
                </div>
                <div @click="to('20503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/449.jpg">
                    <p>黑白低速数码复印机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/111.jpg">
                    <p>复印机选购件</p>
                </div>
                <div @click="to('20505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/448.jpg">
                    <p>黑白中高速数码复印机</p>
                </div>
                <div @click="to('20506')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/76.jpg">
                    <p>印刷机</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('206')" class="hd">考勤/监控设备</p>
        <div class="content">
            <div class="row">
                <div @click="to('20601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/360.jpg">
                    <p>考勤机</p>
                </div>
                <div @click="to('20602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/421.jpg">
                    <p>门禁设备</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('207')" class="hd">其他设备</p>
        <div class="content">
            <div class="row">
                <div @click="to('20701')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/341.jpg">
                    <p>碎纸机</p>
                </div>
                <div @click="to('20702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/299.jpg">
                    <p>点钞/验钞机</p>
                </div>
                <div @click="to('20703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/319.jpg">
                    <p>电子白板</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20704')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/231.jpg">
                    <p>收银机</p>
                </div>
                <div @click="to('20705')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/376.jpg">
                    <p>薪资机</p>
                </div>
                <div @click="to('20706')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/77.jpg">
                    <p>印后设备</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20707')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/434.jpg">
                    <p>音频设备</p>
                </div>
                <div @click="to('20708')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/51.jpg">
                    <p>其他财务设备</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('208')" class="hd">扫描仪</p>
        <div class="content">
            <div class="row">
                <div @click="to('20801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/176.jpg">
                    <p>平板式扫描仪</p>
                </div>
                <div @click="to('20802')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/443.jpg">
                    <p>馈纸式扫描仪</p>
                </div>
                <div @click="to('20803')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/443.jpg">
                    <p>馈纸式扫描仪</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20804')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/207.jpg">
                    <p>扫描枪/扫描器</p>
                </div>
                <div @click="to('20805')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/206.jpg">
                    <p>扫描仪配件</p>
                </div>
                <div @click="to('20806')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/34.jpg">
                    <p>便携式扫描仪</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20807')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/445.jpg">
                    <p>高拍仪</p>
                </div>
                <div @click="to('20808')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/85.jpg">
                    <p>名片扫描仪</p>
                </div>
                <div @click="to('20809')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/205.jpg">
                    <p>扫描仪</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('209')" class="hd">投影机（幕）/演示用品</p>
        <div class="content">
            <div class="row">
                <div @click="to('20901')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/209.jpg">
                    <p>投影机</p>
                </div>
                <div @click="to('20902')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/230.jpg">
                    <p>支架幕</p>
                </div>
                <div @click="to('20903')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/194.jpg">
                    <p>手动挂幕</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20904')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/317.jpg">
                    <p>电动挂幕</p>
                </div>
                <div @click="to('20905')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/210.jpg">
                    <p>投影胶片</p>
                </div>
                <div @click="to('20906')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/208.jpg">
                    <p>投影仪配件</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20907')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/335.jpg">
                    <p>画框幕</p>
                </div>
                <div @click="to('20908')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/157.jpg">
                    <p>实物展台</p>
                </div>
                <div @click="to('20909')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/241.jpg">
                    <p>无线投影模块</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20910')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/296.jpg">
                    <p>演示笔</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('210')" class="hd">装订/塑封设备及配件</p>
        <div class="content">
            <div class="row">
                <div @click="to('21001')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/107.jpg">
                    <p>塑封机及塑封膜</p>
                </div>
                <div @click="to('21002')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/305.jpg">
                    <p>热熔装订机</p>
                </div>
                <div @click="to('21003')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/268.jpg">
                    <p>梳式装订机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('21004')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/304.jpg">
                    <p>热熔封套</p>
                </div>
                <div @click="to('21005')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/382.jpg">
                    <p>装订封面</p>
                </div>
                <div @click="to('21006')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/394.jpg">
                    <p>财务装订机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('21007')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/395.jpg">
                    <p>财务装订配件</p>
                </div>
                <div @click="to('21008')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/366.jpg">
                    <p>胶圈/铁圈/装订夹条</p>
                </div>
                <div @click="to('21009')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/55.jpg">
                    <p>冷裱机/刻字机/打字机及耗材</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('21010')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/367.jpg">
                    <p>胶装机</p>
                </div>
                <div @click="to('21011')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/381.jpg">
                    <p>装订/塑封设备及配件</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-3" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('301')" class="hd">电脑整机</p>
        <div class="content">
            <div class="row">
                <div @click="to('30101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/84.jpg">
                    <p>台式电脑</p>
                </div>
                <div @click="to('30102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/352.jpg">
                    <p>笔记本电脑</p>
                </div>
                <div @click="to('30103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/177.jpg">
                    <p>平板电脑</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/11.jpg">
                    <p>一体式电脑</p>
                </div>
                <div @click="to('30105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/252.jpg">
                    <p>服务器</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('302')" class="hd">存储设备</p>
        <div class="content">
            <div class="row">
                <div @click="to('30201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/10.jpg">
                    <p>U盘</p>
                </div>
                <div @click="to('30202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/53.jpg">
                    <p>内存条</p>
                </div>
                <div @click="to('30204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/422.jpg">
                    <p>闪存卡</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/402.jpg">
                    <p>软盘</p>
                </div>
                <div @click="to('30206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/42.jpg">
                    <p>光盘</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('303')" class="hd">外设产品</p>
        <div class="content">
            <div class="row">
                <div @click="to('30301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/8.jpg">
                    <p>UPS电源</p>
                </div>
                <div @click="to('30302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/330.jpg">
                    <p>电脑耳麦</p>
                </div>
                <div @click="to('30303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/418.jpg">
                    <p>键盘/鼠标/鼠标垫</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/227.jpg">
                    <p>摄像头</p>
                </div>
                <div @click="to('30305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/431.jpg">
                    <p>音箱</p>
                </div>
                <div @click="to('30306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/435.jpg">
                    <p>音频配件</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/9.jpg">
                    <p>USB扩展配件</p>
                </div>
                <div @click="to('30308')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/329.jpg">
                    <p>电脑清洁</p>
                </div>
                <div @click="to('30312')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/44.jpg">
                    <p>光驱</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30310')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/359.jpg">
                    <p>网线</p>
                </div>
                <div @click="to('30311')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/327.jpg">
                    <p>电脑包</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('304')" class="hd">刻录机/刻录盘/录像带</p>
        <div class="content">
            <div class="row">
                <div @click="to('30402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/62.jpg">
                    <p>刻录机</p>
                </div>
                <div @click="to('30403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/63.jpg">
                    <p>刻录盘</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('305')" class="hd">电脑配件</p>
        <div class="content">
            <div class="row">
                <div @click="to('30503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/325.jpg">
                    <p>电源适配器</p>
                </div>
                <div @click="to('30505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/246.jpg">
                    <p>显示器</p>
                </div>
                <div @click="to('30509')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/424.jpg">
                    <p>阅读架</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30510')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/295.jpg">
                    <p>演示器</p>
                </div>
                <div @click="to('30511')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/20.jpg">
                    <p>主板</p>
                </div>
                <div @click="to('30512')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/245.jpg">
                    <p>显卡</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30513')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/258.jpg">
                    <p>机箱</p>
                </div>
                <div @click="to('30514')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/232.jpg">
                    <p>散热器</p>
                </div>
                <div @click="to('30515')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/3.jpg">
                    <p>CPU</p>
                </div>
            </div>
        </div>
    </div>
    <div id="c-4" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('401')" class="hd">影像设备</p>
        <div class="content">
            <div class="row">
                <div @click="to('40101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/13.jpg">
                    <p>一次性成像相机</p>
                </div>
                <div @click="to('40102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/73.jpg">
                    <p>单电相机</p>
                </div>
                <div @click="to('40103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/72.jpg">
                    <p>单反照相机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/233.jpg">
                    <p>数码摄像机</p>
                </div>
                <div @click="to('40105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/234.jpg">
                    <p>数码照相机</p>
                </div>
                <div @click="to('40106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/189.jpg">
                    <p>微单相机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/220.jpg">
                    <p>掌上电脑</p>
                </div>
                <div @click="to('40108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/322.jpg">
                    <p>电子阅读器</p>
                </div>
                <div @click="to('40109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/293.jpg">
                    <p>滤镜</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('402')" class="hd">影音设备</p>
        <div class="content">
            <div class="row">
                <div @click="to('40201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/181.jpg">
                    <p>录音笔</p>
                </div>
                <div @click="to('40202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/235.jpg">
                    <p>数码相框</p>
                </div>
                <div @click="to('40203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/5.jpg">
                    <p>MP3/MP4播放器</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/361.jpg">
                    <p>耳机/耳麦</p>
                </div>
                <div @click="to('40205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/113.jpg">
                    <p>复读机</p>
                </div>
                <div @click="to('40206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/250.jpg">
                    <p>智能设备</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/432.jpg">
                    <p>音箱/音响</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('403')" class="hd">数码配件</p>
        <div class="content">
            <div class="row">
                <div @click="to('40301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/16.jpg">
                    <p>三角架</p>
                </div>
                <div @click="to('40302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/236.jpg">
                    <p>数码设备电池</p>
                </div>
                <div @click="to('40303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/188.jpg">
                    <p>影像包/保护套</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/4.jpg">
                    <p>GPS设备</p>
                </div>
                <div @click="to('40305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/288.jpg">
                    <p>清洁套装</p>
                </div>
                <div @click="to('40306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/419.jpg">
                    <p>镜头/闪光灯</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/339.jpg">
                    <p>相机摄像机配件</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('404')" class="hd">存储卡/读卡器</p>
        <div class="content">
            <div class="row">
                <div @click="to('40401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/2.jpg">
                    <p>CF卡</p>
                </div>
                <div @click="to('40402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/6.jpg">
                    <p>SD卡</p>
                </div>
                <div @click="to('40403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/7.jpg">
                    <p>TF卡</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/392.jpg">
                    <p>读卡器/转换器</p>
                </div>
                <div @click="to('40405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/384.jpg">
                    <p>记忆棒</p>
                </div>
                <div @click="to('40406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/49.jpg">
                    <p>其他数码存储</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('405')" class="hd">通讯设备</p>
        <div class="content">
            <div class="row">
                <div @click="to('40501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/182.jpg">
                    <p>录音答录电话机</p>
                </div>
                <div @click="to('40502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/248.jpg">
                    <p>普通电话机</p>
                </div>
                <div @click="to('40503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/407.jpg">
                    <p>通讯配件</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/242.jpg">
                    <p>无绳电话机</p>
                </div>
                <div @click="to('40505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/83.jpg">
                    <p>可扩展电话</p>
                </div>
                <div @click="to('40506')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/383.jpg">
                    <p>视频会议系统</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40507')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/433.jpg">
                    <p>音频会议电话</p>
                </div>
                <div @click="to('40508')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/315.jpg">
                    <p>电信版手机</p>
                </div>
                <div @click="to('40509')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/344.jpg">
                    <p>移动版手机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40510')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/363.jpg">
                    <p>联通版手机</p>
                </div>
                <div @click="to('40511')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/164.jpg">
                    <p>对讲机及配件</p>
                </div>
                <div @click="to('40512')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/198.jpg">
                    <p>手机配件</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40513')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/406.jpg">
                    <p>通用版手机</p>
                </div>
                <div @click="to('40514')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/375.jpg">
                    <p>蓝牙设备</p>
                </div>
                <div @click="to('40515')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/41.jpg">
                    <p>充值卡</p>
                </div>
            </div>
        </div>
    </div>
    <div id="c-5" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('501')" class="hd">桌台</p>
        <div class="content">
            <div class="row">
                <div @click="to('50101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/21.jpg">
                    <p>主管桌</p>
                </div>
                <div @click="to('50102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/362.jpg">
                    <p>职员桌</p>
                </div>
                <div @click="to('50103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/31.jpg">
                    <p>会议桌</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/211.jpg">
                    <p>折叠桌</p>
                </div>
                <div @click="to('50105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/221.jpg">
                    <p>接待台</p>
                </div>
                <div @click="to('50106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/60.jpg">
                    <p>制图桌</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/150.jpg">
                    <p>定制桌子</p>
                </div>
                <div @click="to('50108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/158.jpg">
                    <p>实验台</p>
                </div>
                <div @click="to('50109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/265.jpg">
                    <p>桌台</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('502')" class="hd">座椅</p>
        <div class="content">
            <div class="row">
                <div @click="to('50202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/88.jpg">
                    <p>员工椅</p>
                </div>
                <div @click="to('50203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/30.jpg">
                    <p>会客/接待椅</p>
                </div>
                <div @click="to('50210')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/179.jpg">
                    <p>座椅</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/261.jpg">
                    <p>板凳/吧椅</p>
                </div>
                <div @click="to('50205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/169.jpg">
                    <p>工业座椅</p>
                </div>
                <div @click="to('50206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/151.jpg">
                    <p>定制椅</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/270.jpg">
                    <p>椅垫</p>
                </div>
                <div @click="to('50208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/212.jpg">
                    <p>折叠椅/可堆叠椅</p>
                </div>
                <div @click="to('50209')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/224.jpg">
                    <p>搁脚凳</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('503')" class="hd">沙发及茶几</p>
        <div class="content">
            <div class="row">
                <div @click="to('50301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/278.jpg">
                    <p>沙发</p>
                </div>
                <div @click="to('50302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/372.jpg">
                    <p>茶几</p>
                </div>
                <div @click="to('50303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/279.jpg">
                    <p>沙发及茶几</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('504')" class="hd">储物柜</p>
        <div class="content">
            <div class="row">
                <div @click="to('50401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/214.jpg">
                    <p>抽屉柜</p>
                </div>
                <div @click="to('50402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/346.jpg">
                    <p>移门柜</p>
                </div>
                <div @click="to('50403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/180.jpg">
                    <p>开门柜</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/75.jpg">
                    <p>卡片柜</p>
                </div>
                <div @click="to('50405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/115.jpg">
                    <p>多功能组合柜</p>
                </div>
                <div @click="to('50406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/25.jpg">
                    <p>书架/书柜</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50407')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/251.jpg">
                    <p>更衣柜</p>
                </div>
                <div @click="to('50408')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/396.jpg">
                    <p>货架</p>
                </div>
                <div @click="to('50409')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/243.jpg">
                    <p>无门柜</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50410')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/78.jpg">
                    <p>卷帘门柜</p>
                </div>
                <div @click="to('50411')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/222.jpg">
                    <p>推柜</p>
                </div>
                <div @click="to('50412')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/159.jpg">
                    <p>家具单品</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50413')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/146.jpg">
                    <p>定制文件柜</p>
                </div>
                <div @click="to('50414')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/238.jpg">
                    <p>文件柜搁板</p>
                </div>
                <div @click="to('50415')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/59.jpg">
                    <p>制图文件柜</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50416')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/425.jpg">
                    <p>防火文件柜</p>
                </div>
                <div @click="to('50417')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/127.jpg">
                    <p>媒体文件柜</p>
                </div>
                <div @click="to('50422')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/39.jpg">
                    <p>储物柜</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50419')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/156.jpg">
                    <p>定制靠墙橱柜</p>
                </div>
                <div @click="to('50420')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/40.jpg">
                    <p>储物柜配件</p>
                </div>
                <div @click="to('50421')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/163.jpg">
                    <p>密集柜</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('505')" class="hd">保险箱/保管箱</p>
        <div class="content">
            <div class="row">
                <div @click="to('50501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/257.jpg">
                    <p>机械锁保险箱</p>
                </div>
                <div @click="to('50502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/321.jpg">
                    <p>电子锁保险箱</p>
                </div>
                <div @click="to('50503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/256.jpg">
                    <p>机械锁保管箱</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/320.jpg">
                    <p>电子锁保管箱</p>
                </div>
                <div @click="to('50505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/217.jpg">
                    <p>指纹锁保管箱</p>
                </div>
                <div @click="to('50506')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/218.jpg">
                    <p>指纹锁保险箱</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('506')" class="hd">家具配套产品</p>
        <div class="content">
            <div class="row">
                <div @click="to('50601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/378.jpg">
                    <p>衣帽架</p>
                </div>
                <div @click="to('50602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/213.jpg">
                    <p>报刊/资料架</p>
                </div>
                <div @click="to('50603')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/427.jpg">
                    <p>雨伞架</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50604')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/101.jpg">
                    <p>地毯/窗帘</p>
                </div>
                <div @click="to('50605')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/168.jpg">
                    <p>屏风</p>
                </div>
                <div @click="to('50606')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/65.jpg">
                    <p>办公收纳</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50607')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/429.jpg">
                    <p>面板/搁架</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('507')" class="hd">推车和支架</p>
        <div class="content">
            <div class="row">
                <div @click="to('50701')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/67.jpg">
                    <p>办公用推车</p>
                </div>
                <div @click="to('50702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/331.jpg">
                    <p>电视机/录像机台</p>
                </div>
                <div @click="to('50703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/328.jpg">
                    <p>电脑支架</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50704')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/202.jpg">
                    <p>打印机支架</p>
                </div>
                <div @click="to('50705')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/255.jpg">
                    <p>机器支架</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('508')" class="hd">组合家具</p>
        <div class="content">
            <div class="row">
                <div @click="to('50801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/337.jpg">
                    <p>直送组合家具</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('509')" class="hd">大家电</p>
        <div class="content">
            <div class="row">
                <div @click="to('50901')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/349.jpg">
                    <p>空调</p>
                </div>
                <div @click="to('50902')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/54.jpg">
                    <p>冰箱/冰吧/冷柜/酒柜</p>
                </div>
                <div @click="to('50903')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/332.jpg">
                    <p>电视机/影碟机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50904')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/283.jpg">
                    <p>洗衣机</p>
                </div>
                <div @click="to('50905')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/303.jpg">
                    <p>热水器</p>
                </div>
                <div @click="to('50906')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/161.jpg">
                    <p>家电配件</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('510')" class="hd">生活电器</p>
        <div class="content">
            <div class="row">
                <div @click="to('51001')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/441.jpg">
                    <p>饮水机/净水桶</p>
                </div>
                <div @click="to('51002')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/347.jpg">
                    <p>空气净化器/加湿器</p>
                </div>
                <div @click="to('51003')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/437.jpg">
                    <p>风扇/空调扇</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51004')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/80.jpg">
                    <p>取暖器</p>
                </div>
                <div @click="to('51005')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/86.jpg">
                    <p>吸尘器/扫地机/地毯清洗机</p>
                </div>
                <div @click="to('51006')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/174.jpg">
                    <p>干手机/烘手机</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51007')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/307.jpg">
                    <p>熨斗/挂烫机</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('511')" class="hd">个人护理/健康电器</p>
        <div class="content">
            <div class="row">
                <div @click="to('51101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/377.jpg">
                    <p>血压计/体温计/血糖仪</p>
                </div>
                <div @click="to('51102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/219.jpg">
                    <p>按摩椅/按摩器/足浴盆</p>
                </div>
                <div @click="to('51103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/37.jpg">
                    <p>健康秤/电子秤</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/318.jpg">
                    <p>电吹风/剃须刀/脱毛器/电动牙刷</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('512')" class="hd">厨房电器</p>
        <div class="content">
            <div class="row">
                <div @click="to('51201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/90.jpg">
                    <p>咖啡机</p>
                </div>
                <div @click="to('51202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/323.jpg">
                    <p>电水壶/电热水瓶</p>
                </div>
                <div @click="to('51203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/190.jpg">
                    <p>微波炉/烤箱</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/286.jpg">
                    <p>消毒柜/洗碗机</p>
                </div>
                <div @click="to('51205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/333.jpg">
                    <p>电饭煲/电压力锅/电磁炉</p>
                </div>
                <div @click="to('51206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/440.jpg">
                    <p>饮料加工机</p>
                </div>
            </div>
        </div>
    </div>
    <div id="c-6" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('601')" class="hd">安全防护用品</p>
        <div class="content">
            <div class="row">
                <div @click="to('60101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/195.jpg">
                    <p>手套</p>
                </div>
                <div @click="to('60102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/122.jpg">
                    <p>头部防护</p>
                </div>
                <div @click="to('60103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/132.jpg">
                    <p>安全鞋/雨鞋</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('60104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/398.jpg">
                    <p>身体防护</p>
                </div>
                <div @click="to('60105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/191.jpg">
                    <p>急救用品</p>
                </div>
                <div @click="to('60106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/81.jpg">
                    <p>口罩</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('60107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/171.jpg">
                    <p>工作装</p>
                </div>
                <div @click="to('60108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/131.jpg">
                    <p>安全防护用品</p>
                </div>
                <div @click="to('60109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/298.jpg">
                    <p>灭火器</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('602')" class="hd">工作装</p>
        <div class="content">
            <div class="row">
                <div @click="to('60201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/226.jpg">
                    <p>搬运车/手推车/折叠车</p>
                </div>
                <div @click="to('60202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/267.jpg">
                    <p>梯子/脚凳</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-7" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('701')" class="hd">生活用纸</p>
        <div class="content">
            <div class="row">
                <div @click="to('70101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/336.jpg">
                    <p>盒装抽取式面纸</p>
                </div>
                <div @click="to('70102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/400.jpg">
                    <p>软包抽取式面纸</p>
                </div>
                <div @click="to('70103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/228.jpg">
                    <p>擦手纸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/196.jpg">
                    <p>手帕纸</p>
                </div>
                <div @click="to('70105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/291.jpg">
                    <p>湿纸巾</p>
                </div>
                <div @click="to('70106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/165.jpg">
                    <p>小卷纸/无芯纸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/118.jpg">
                    <p>大卷纸</p>
                </div>
                <div @click="to('70108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/79.jpg">
                    <p>厨房纸巾</p>
                </div>
                <div @click="to('70109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/439.jpg">
                    <p>餐巾纸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70110')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/175.jpg">
                    <p>平板卫生纸</p>
                </div>
                <div @click="to('70111')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/119.jpg">
                    <p>大卷纸配件</p>
                </div>
                <div @click="to('70112')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/166.jpg">
                    <p>小卷纸/无芯纸配件</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70113')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/215.jpg">
                    <p>抽纸配件</p>
                </div>
                <div @click="to('70114')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/229.jpg">
                    <p>擦手纸配件</p>
                </div>
                <div @click="to('70115')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/103.jpg">
                    <p>坐垫纸架</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70116')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/314.jpg">
                    <p>生活用纸</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('702')" class="hd">清洁用品</p>
        <div class="content">
            <div class="row">
                <div @click="to('70201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/284.jpg">
                    <p>洗衣粉/洗衣液/肥皂</p>
                </div>
                <div @click="to('70202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/287.jpg">
                    <p>清洁剂</p>
                </div>
                <div @click="to('70203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/348.jpg">
                    <p>空气清新剂</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/444.jpg">
                    <p>驱虫用品</p>
                </div>
                <div @click="to('70205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/129.jpg">
                    <p>季节用品</p>
                </div>
                <div @click="to('70206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/272.jpg">
                    <p>樟脑/干燥剂</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/48.jpg">
                    <p>其他化学清洁用品</p>
                </div>
                <div @click="to('70208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/290.jpg">
                    <p>清洁用品</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('703')" class="hd">个人洗护</p>
        <div class="content">
            <div class="row">
                <div @click="to('70301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/277.jpg">
                    <p>沐浴/香皂/浴盐</p>
                </div>
                <div @click="to('70302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/281.jpg">
                    <p>洗手液</p>
                </div>
                <div @click="to('70303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/280.jpg">
                    <p>洗发护发</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/82.jpg">
                    <p>口腔护理</p>
                </div>
                <div @click="to('70305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/199.jpg">
                    <p>手足护理</p>
                </div>
                <div @click="to('70306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/17.jpg">
                    <p>个人护理</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/273.jpg">
                    <p>毛巾</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('704')" class="hd">一次性餐具及用品</p>
        <div class="content">
            <div class="row">
                <div @click="to('70401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/15.jpg">
                    <p>一次性餐具</p>
                </div>
                <div @click="to('70402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/36.jpg">
                    <p>保鲜膜/保鲜袋</p>
                </div>
                <div @click="to('70403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/12.jpg">
                    <p>一次性台布/伞套及鞋套</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/14.jpg">
                    <p>一次性纸杯/塑杯</p>
                </div>
                <div @click="to('70405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/308.jpg">
                    <p>牙签</p>
                </div>
                <div @click="to('70406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/45.jpg">
                    <p>其他一次用品</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('705')" class="hd">杯、壶及生活餐具</p>
        <div class="content">
            <div class="row">
                <div @click="to('70501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/275.jpg">
                    <p>水杯/保温杯</p>
                </div>
                <div @click="to('70502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/35.jpg">
                    <p>保鲜盒/食物盒</p>
                </div>
                <div @click="to('70503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/438.jpg">
                    <p>餐具/茶具</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/416.jpg">
                    <p>锅具</p>
                </div>
                <div @click="to('70505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/56.jpg">
                    <p>刀具</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('706')" class="hd">办公日杂</p>
        <div class="content">
            <div class="row">
                <div @click="to('70601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/324.jpg">
                    <p>电池/充电器/移动电源</p>
                </div>
                <div @click="to('70602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/356.jpg">
                    <p>粘钩/挂钩</p>
                </div>
                <div @click="to('70603')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/128.jpg">
                    <p>存储收纳</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70604')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/420.jpg">
                    <p>镜框/相框</p>
                </div>
                <div @click="to('70605')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/423.jpg">
                    <p>闹钟/挂钟</p>
                </div>
                <div @click="to('70606')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/300.jpg">
                    <p>烟缸/花瓶</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70607')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/249.jpg">
                    <p>晴雨伞/雨衣</p>
                </div>
                <div @click="to('70608')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/239.jpg">
                    <p>旅行箱包</p>
                </div>
                <div @click="to('70609')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/240.jpg">
                    <p>旗帜/地图</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70610')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/276.jpg">
                    <p>汽车养护</p>
                </div>
                <div @click="to('70611')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/99.jpg">
                    <p>圣诞/节庆饰品</p>
                </div>
                <div @click="to('70612')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/365.jpg">
                    <p>胶卷</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70613')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/197.jpg">
                    <p>手提袋</p>
                </div>
                <div @click="to('70614')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/282.jpg">
                    <p>洗晒用具</p>
                </div>
                <div @click="to('70615')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/397.jpg">
                    <p>贺卡/礼金袋/请柬</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70616')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/125.jpg">
                    <p>奖状/证书</p>
                </div>
                <div @click="to('70617')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/66.jpg">
                    <p>办公杂件</p>
                </div>
                <div @click="to('70618')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/223.jpg">
                    <p>插座</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('707')" class="hd">运动娱乐及户外用品</p>
        <div class="content">
            <div class="row">
                <div @click="to('70701')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/355.jpg">
                    <p>篮球/排球/足球及其他球类</p>
                </div>
                <div @click="to('70702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/23.jpg">
                    <p>乒乓球/羽毛球/网球及配件</p>
                </div>
                <div @click="to('70703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/269.jpg">
                    <p>棋牌类及其他娱乐类</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70704')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/38.jpg">
                    <p>健身器械</p>
                </div>
                <div @click="to('70705')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/193.jpg">
                    <p>户外用品</p>
                </div>
                <div @click="to('70706')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/22.jpg">
                    <p>乐器</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70707')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/364.jpg">
                    <p>背包/手提包/皮包</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('708')" class="hd">图书</p>
        <div class="content">
            <div class="row">
                <div @click="to('70801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/326.jpg">
                    <p>电脑书籍</p>
                </div>
                <div @click="to('70802')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/95.jpg">
                    <p>商务书籍</p>
                </div>
                <div @click="to('70803')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/430.jpg">
                    <p>音像书籍</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70804')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/259.jpg">
                    <p>杂志</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('709')" class="hd">清洁工具</p>
        <div class="content">
            <div class="row">
                <div @click="to('70901')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/106.jpg">
                    <p>垃圾袋</p>
                </div>
                <div @click="to('70902')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/105.jpg">
                    <p>垃圾桶</p>
                </div>
                <div @click="to('70903')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/170.jpg">
                    <p>工业擦拭纸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70904')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/413.jpg">
                    <p>钢丝球/百洁布/抹布</p>
                </div>
                <div @click="to('70905')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/102.jpg">
                    <p>地面清洁</p>
                </div>
                <div @click="to('70906')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/100.jpg">
                    <p>地垫</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70907')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/50.jpg">
                    <p>其他清洁工具</p>
                </div>
                <div @click="to('70908')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/61.jpg">
                    <p>刷子</p>
                </div>
                <div @click="to('70909')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/353.jpg">
                    <p>笤帚/扫把/簸箕</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70910')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/216.jpg">
                    <p>拖布</p>
                </div>
                <div @click="to('70911')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/289.jpg">
                    <p>清洁工具</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-8" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('801')" class="hd">五金工具</p>
        <div class="content">
            <div class="row">
                <div @click="to('80102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/316.jpg">
                    <p>电动工具</p>
                </div>
                <div @click="to('80103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/172.jpg">
                    <p>工具箱/包/车</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('802')" class="hd">刃具</p>
        <div class="content">
            <div class="row">
                <div @click="to('80201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/414.jpg">
                    <p>钻头</p>
                </div>
                <div @click="to('80202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/415.jpg">
                    <p>铣刀</p>
                </div>
                <div @click="to('80203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/399.jpg">
                    <p>车刀</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('803')" class="hd">测量工具</p>
        <div class="content">
            <div class="row">
                <div @click="to('80301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/167.jpg">
                    <p>尺</p>
                </div>
                <div @click="to('80302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/57.jpg">
                    <p>划线规</p>
                </div>
                <div @click="to('80303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/379.jpg">
                    <p>表/表座</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('804')" class="hd">锁具</p>
        <div class="content">
            <div class="row">
                <div @click="to('80401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/173.jpg">
                    <p>常规锁具</p>
                </div>
                <div @click="to('80402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/309.jpg">
                    <p>特殊用途锁具</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-9" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('901')" class="hd">实验室常规设备</p>
        <div class="content">
            <div class="row">
                <div @click="to('90101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/391.jpg">
                    <p>试验台</p>
                </div>
                <div @click="to('90102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/192.jpg">
                    <p>恒温器</p>
                </div>
                <div @click="to('90103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/69.jpg">
                    <p>加热/冷却机器</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/225.jpg">
                    <p>搅拌器</p>
                </div>
                <div @click="to('90105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/403.jpg">
                    <p>过滤器</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('902')" class="hd">试验室仪器及耗材</p>
        <div class="content">
            <div class="row">
                <div @click="to('90201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/388.jpg">
                    <p>试管</p>
                </div>
                <div @click="to('90202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/301.jpg">
                    <p>烧杯</p>
                </div>
                <div @click="to('90203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/312.jpg">
                    <p>玻璃管</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/390.jpg">
                    <p>试纸</p>
                </div>
                <div @click="to('90205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/292.jpg">
                    <p>滤纸</p>
                </div>
                <div @click="to('90206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/404.jpg">
                    <p>过滤网</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/294.jpg">
                    <p>漏斗</p>
                </div>
                <div @click="to('90208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/87.jpg">
                    <p>吸管</p>
                </div>
                <div @click="to('90209')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/108.jpg">
                    <p>塞子</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90210')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/71.jpg">
                    <p>化学试剂</p>
                </div>
                <div @click="to('90211')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/389.jpg">
                    <p>试管刷</p>
                </div>
                <div @click="to('90212')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/386.jpg">
                    <p>试料袋</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90213')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/387.jpg">
                    <p>试样袋</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-10" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('1001')" class="hd">咖啡配套及冲调</p>
        <div class="content">
            <div class="row">
                <div @click="to('100101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/408.jpg">
                    <p>速溶咖啡</p>
                </div>
                <div @click="to('100102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/92.jpg">
                    <p>咖啡礼盒</p>
                </div>
                <div @click="to('100110')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/271.jpg">
                    <p>植脂末</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/126.jpg">
                    <p>奶精/奶球</p>
                </div>
                <div @click="to('100105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/357.jpg">
                    <p>糖</p>
                </div>
                <div @click="to('100106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/91.jpg">
                    <p>咖啡滤纸/搅拌棒</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/46.jpg">
                    <p>其他冲调</p>
                </div>
                <div @click="to('100108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/447.jpg">
                    <p>麦片/蜂蜜/奶茶</p>
                </div>
                <div @click="to('100109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/89.jpg">
                    <p>咖啡伴侣</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1002')" class="hd">茶叶</p>
        <div class="content">
            <div class="row">
                <div @click="to('100201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/373.jpg">
                    <p>茶叶</p>
                </div>
                <div @click="to('100202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/380.jpg">
                    <p>袋泡茶</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1003')" class="hd">酒水饮料</p>
        <div class="content">
            <div class="row">
                <div @click="to('100301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/274.jpg">
                    <p>水</p>
                </div>
                <div @click="to('100302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/342.jpg">
                    <p>碳酸饮料</p>
                </div>
                <div @click="to('100303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/374.jpg">
                    <p>茶饮料</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/262.jpg">
                    <p>果汁</p>
                </div>
                <div @click="to('100305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/405.jpg">
                    <p>运动/健康饮料</p>
                </div>
                <div @click="to('100306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/94.jpg">
                    <p>咖啡饮料</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/26.jpg">
                    <p>乳品饮料</p>
                </div>
                <div @click="to('100308')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/410.jpg">
                    <p>酒精饮料</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-11" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('1101')" class="hd">食物礼券</p>
        <div class="content">
            <div class="row">
                <div @click="to('110101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/104.jpg">
                    <p>坚果食品券</p>
                </div>
                <div @click="to('110102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/285.jpg">
                    <p>海鲜干货券</p>
                </div>
                <div @click="to('110103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/428.jpg">
                    <p>面包甜品券</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1102')" class="hd">办公礼品</p>
        <div class="content">
            <div class="row">
                <div @click="to('110201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/96.jpg">
                    <p>商务套装</p>
                </div>
                <div @click="to('110202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/343.jpg">
                    <p>礼品笔</p>
                </div>
                <div @click="to('110203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/178.jpg">
                    <p>年历/台历</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/358.jpg">
                    <p>红包/贺卡/请柬</p>
                </div>
                <div @click="to('110205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/123.jpg">
                    <p>奖牌/镜框</p>
                </div>
                <div @click="to('110206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/124.jpg">
                    <p>奖状/聘书/证书</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/338.jpg">
                    <p>相册</p>
                </div>
                <div @click="to('110208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/436.jpg">
                    <p>题名册/签到簿</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1103')" class="hd">多用途现金礼券</p>
        <div class="content">
            <div class="row">
                <div @click="to('110301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/116.jpg">
                    <p>多用途现金礼券</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1104')" class="hd">企业定制</p>
        <div class="content">
            <div class="row">
                <div @click="to('110401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/144.jpg">
                    <p>定制广告帽</p>
                </div>
                <div @click="to('110402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/145.jpg">
                    <p>定制广告衫</p>
                </div>
                <div @click="to('110403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/138.jpg">
                    <p>定制其他服装</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/149.jpg">
                    <p>定制本册/年历本</p>
                </div>
                <div @click="to('110405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/154.jpg">
                    <p>定制胶带</p>
                </div>
                <div @click="to('110406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/137.jpg">
                    <p>定制其他文具</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110407')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/133.jpg">
                    <p>定制书写用品</p>
                </div>
                <div @click="to('110408')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/147.jpg">
                    <p>定制文件管理</p>
                </div>
                <div @click="to('110409')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/148.jpg">
                    <p>定制文具套装</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110410')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/155.jpg">
                    <p>定制胸卡/挂绳</p>
                </div>
                <div @click="to('110411')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/139.jpg">
                    <p>定制单据</p>
                </div>
                <div @click="to('110412')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/141.jpg">
                    <p>定制名片</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110413')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/135.jpg">
                    <p>定制其他印刷制品</p>
                </div>
                <div @click="to('110414')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/140.jpg">
                    <p>定制台历</p>
                </div>
                <div @click="to('110415')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/134.jpg">
                    <p>定制信封</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110416')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/153.jpg">
                    <p>定制纸杯</p>
                </div>
                <div @click="to('110417')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/142.jpg">
                    <p>定制回墨印</p>
                </div>
                <div @click="to('110418')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/136.jpg">
                    <p>定制其他印章</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110419')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/152.jpg">
                    <p>定制橡皮章</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1105')" class="hd">家居生活</p>
        <div class="content">
            <div class="row">
                <div @click="to('110501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/162.jpg">
                    <p>家纺布艺</p>
                </div>
                <div @click="to('110502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/58.jpg">
                    <p>创意摆件</p>
                </div>
                <div @click="to('110503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/160.jpg">
                    <p>家居装饰</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/313.jpg">
                    <p>生活家电</p>
                </div>
                <div @click="to('110505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/22.jpg">
                    <p>乐器</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1106')" class="hd">名品百货</p>
        <div class="content">
            <div class="row">
                <div @click="to('110601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/70.jpg">
                    <p>化妆品</p>
                </div>
                <div @click="to('110602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/412.jpg">
                    <p>钟表</p>
                </div>
                <div @click="to('110603')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/442.jpg">
                    <p>饰品</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110604')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/354.jpg">
                    <p>箱包</p>
                </div>
                <div @click="to('110605')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/121.jpg">
                    <p>太阳镜</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1107')" class="hd">数码科技</p>
        <div class="content">
            <div class="row">
                <div @click="to('110702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/18.jpg">
                    <p>个性U盘</p>
                </div>
                <div @click="to('110703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/244.jpg">
                    <p>时尚数码</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1108')" class="hd">工艺精品</p>
        <div class="content">
            <div class="row">
                <div @click="to('110801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/311.jpg">
                    <p>玻璃琉璃</p>
                </div>
                <div @click="to('110802')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/310.jpg">
                    <p>玉石玉器</p>
                </div>
                <div @click="to('110803')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/371.jpg">
                    <p>茶具</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110804')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/19.jpg">
                    <p>中国风</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
</div>



        </div>
    </div>
    <jsp:include page="./foot.jsp">
    	<jsp:param value="分类" name="tab"/>
    </jsp:include>
<script type="text/javascript">

    var app = new Vue({
        el      : '#cate',
        data    : {
			active : '1'
		},
		methods : {
			to	: function (cat) {
				location.href = '${pageContext.request.contextPath}/market/goods/search?cat=' + cat;
			}
		}
	});
var last = 0;
$(function () {
	$('#sidebar .c').click(function () {
		
	});
	var c = $('#sidebar .c:contains(${q})');
	if (c && c.length == 1) {
		var catId = c.attr('data-cat-id');
		if (app.active != catId) {
			last = last + $("#c-" + catId).offset().top - 46;
			$('#right').animate({
	            scrollTop : last
	        }, 200);
		}
		app.active = catId;
	}
	$('img[data-src]').each(function () {
		var self = $(this);
		self.attr('src', self.attr('data-src'));
	});
});
//left
var target = document.getElementById('sidebar');
Transform(target);
var min = window.innerHeight - 46 - (document.getElementsByClassName('c').length * 47) - 100, startY = 0, moveY = 0;
new AlloyTouch({
    touch:"#left",//反馈触摸的dom
    target: target, //运动的对象
    min : min > 0 ? 0 : min,
    max: 0,
    property: "translateY",  //被运动的属性
    bindSelf: false,
    initialValue: 0,
    touchStart	: function (event, val) {
    	console.log(event, val);
    	startY = moveY = event.touches[0].clientY;
    },
    touchMove	: function (event, val) {
    	moveY = event.touches[0].clientY;
    },
    touchEnd	: function (event, val) {
    	if (Math.abs(startY - moveY) < 30) {
    		var catId = $(event.target).attr('data-cat-id');
    		if (app.active != catId) {
    			$('#right').animate({
    	            scrollTop : last
    	        }, 0);
    			last += $("#c-" + catId).offset().top - 46;
    			$('#right').animate({
    	            scrollTop : last
    	        }, 100);
    		}
    		app.active = catId;
    	} 
    }
});
</script>
</body>
</html>