<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="head.jsp">
	<jsp:param value="����" name="title"/>
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
                <input type="text" autocomplete="off" placeholder="·����" readonly="readonly" onclick="location.href = '${pageContext.request.contextPath}/market/goods/search';">
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
        <p @click="to('101')" class="hd">�칫�ľ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('10101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/24.jpg">
                    <p>��д��������</p>
                </div>
                <div @click="to('10102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/237.jpg">
                    <p>�ļ���/��/��</p>
                </div>
                <div @click="to('10103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/266.jpg">
                    <p>�����ľ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/254.jpg">
                    <p>����/��ǩ</p>
                </div>
                <div @click="to('10105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/393.jpg">
                    <p>������Ʒ</p>
                </div>
                <div @click="to('10106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/409.jpg">
                    <p>�ʼ�������Ʒ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/401.jpg">
                    <p>��ľ��/�װ�</p>
                </div>
                <div @click="to('10108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/334.jpg">
                    <p>���߻���</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('102')" class="hd">�칫��ֽ</p>
        <div class="content">
            <div class="row">
                <div @click="to('10201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/112.jpg">
                    <p>��ӡֽ</p>
                </div>
                <div @click="to('10202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/204.jpg">
                    <p>��ӡֽ</p>
                </div>
                <div @click="to('10203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/370.jpg">
                    <p>����ֽ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/117.jpg">
                    <p>����;ֽ</p>
                </div>
                <div @click="to('10205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/306.jpg">
                    <p>��Ƭֽ</p>
                </div>
                <div @click="to('10206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/68.jpg">
                    <p>�칫��ֽ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/185.jpg">
                    <p>��ɫ��ӡֽ</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('103')" class="hd">�칫�Ĳ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('10301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/110.jpg">
                    <p>ī��</p>
                </div>
                <div @click="to('10302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/340.jpg">
                    <p>����</p>
                </div>
                <div @click="to('10303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/109.jpg">
                    <p>ī��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('10304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/368.jpg">
                    <p>ɫ��</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('104')" class="hd">�ľ���װ</p>
        <div class="content">
            <div class="row">
                <div @click="to('10401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/64.jpg">
                    <p>�칫��װ</p>
                </div>
                <div @click="to('10403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/130.jpg">
                    <p>ѧ����װ</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-2" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('201')" class="hd">��ǩʶ���豸���Ĳ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('20101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/263.jpg">
                    <p>��ǩ��/�����豸</p>
                </div>
                <div @click="to('20102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/264.jpg">
                    <p>��ǩ��ɫ��/�����豸�Ĳ�</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('202')" class="hd">�����</p>
        <div class="content">
            <div class="row">
                <div @click="to('20201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/297.jpg">
                    <p>���⴫���</p>
                </div>
                <div @click="to('20202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/369.jpg">
                    <p>ɫ��/��תӡ�����</p>
                </div>
                <div @click="to('20203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/302.jpg">
                    <p>���������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/33.jpg">
                    <p>��������</p>
                </div>
                <div @click="to('20206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/32.jpg">
                    <p>�����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('203')" class="hd">��ӡ��</p>
        <div class="content">
            <div class="row">
                <div @click="to('20301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/451.jpg">
                    <p>�ڰ׼����ӡ��</p>
                </div>
                <div @click="to('20302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/187.jpg">
                    <p>��ɫ�����ӡ��</p>
                </div>
                <div @click="to('20303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/98.jpg">
                    <p>��ī/��Ƭ��ӡ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/411.jpg">
                    <p>��ʽ/Ʊ��/������ӡ��</p>
                </div>
                <div @click="to('20305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/385.jpg">
                    <p>֤��/��������ӡ��</p>
                </div>
                <div @click="to('20306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/120.jpg">
                    <p>������ӡ��/��ͼ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/260.jpg">
                    <p>�����ӡ��</p>
                </div>
                <div @click="to('20308')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/203.jpg">
                    <p>��ӡ�����</p>
                </div>
                <div @click="to('20309')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/260.jpg">
                    <p>�����ӡ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20310')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/446.jpg">
                    <p>������ʽ��ӡ��</p>
                </div>
                <div @click="to('20311')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/200.jpg">
                    <p>��ӡ��</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('204')" class="hd">�๦��һ���</p>
        <div class="content">
            <div class="row">
                <div @click="to('20401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/450.jpg">
                    <p>�ڰ׼���һ���</p>
                </div>
                <div @click="to('20402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/186.jpg">
                    <p>��ɫ����һ���</p>
                </div>
                <div @click="to('20403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/97.jpg">
                    <p>��īһ���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/201.jpg">
                    <p>��ӡ��/һ���/��������</p>
                </div>
                <div @click="to('20405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/114.jpg">
                    <p>�๦��һ���</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('205')" class="hd">��ӡ����ӡˢ��</p>
        <div class="content">
            <div class="row">
                <div @click="to('20501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/184.jpg">
                    <p>��ɫ�������븴ӡ��</p>
                </div>
                <div @click="to('20502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/183.jpg">
                    <p>��ɫ�и������븴ӡ��</p>
                </div>
                <div @click="to('20503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/449.jpg">
                    <p>�ڰ׵������븴ӡ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/111.jpg">
                    <p>��ӡ��ѡ����</p>
                </div>
                <div @click="to('20505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/448.jpg">
                    <p>�ڰ��и������븴ӡ��</p>
                </div>
                <div @click="to('20506')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/76.jpg">
                    <p>ӡˢ��</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('206')" class="hd">����/����豸</p>
        <div class="content">
            <div class="row">
                <div @click="to('20601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/360.jpg">
                    <p>���ڻ�</p>
                </div>
                <div @click="to('20602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/421.jpg">
                    <p>�Ž��豸</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('207')" class="hd">�����豸</p>
        <div class="content">
            <div class="row">
                <div @click="to('20701')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/341.jpg">
                    <p>��ֽ��</p>
                </div>
                <div @click="to('20702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/299.jpg">
                    <p>�㳮/�鳮��</p>
                </div>
                <div @click="to('20703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/319.jpg">
                    <p>���Ӱװ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20704')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/231.jpg">
                    <p>������</p>
                </div>
                <div @click="to('20705')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/376.jpg">
                    <p>н�ʻ�</p>
                </div>
                <div @click="to('20706')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/77.jpg">
                    <p>ӡ���豸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20707')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/434.jpg">
                    <p>��Ƶ�豸</p>
                </div>
                <div @click="to('20708')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/51.jpg">
                    <p>���������豸</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('208')" class="hd">ɨ����</p>
        <div class="content">
            <div class="row">
                <div @click="to('20801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/176.jpg">
                    <p>ƽ��ʽɨ����</p>
                </div>
                <div @click="to('20802')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/443.jpg">
                    <p>��ֽʽɨ����</p>
                </div>
                <div @click="to('20803')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/443.jpg">
                    <p>��ֽʽɨ����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20804')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/207.jpg">
                    <p>ɨ��ǹ/ɨ����</p>
                </div>
                <div @click="to('20805')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/206.jpg">
                    <p>ɨ�������</p>
                </div>
                <div @click="to('20806')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/34.jpg">
                    <p>��Яʽɨ����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20807')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/445.jpg">
                    <p>������</p>
                </div>
                <div @click="to('20808')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/85.jpg">
                    <p>��Ƭɨ����</p>
                </div>
                <div @click="to('20809')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/205.jpg">
                    <p>ɨ����</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('209')" class="hd">ͶӰ����Ļ��/��ʾ��Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('20901')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/209.jpg">
                    <p>ͶӰ��</p>
                </div>
                <div @click="to('20902')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/230.jpg">
                    <p>֧��Ļ</p>
                </div>
                <div @click="to('20903')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/194.jpg">
                    <p>�ֶ���Ļ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20904')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/317.jpg">
                    <p>�綯��Ļ</p>
                </div>
                <div @click="to('20905')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/210.jpg">
                    <p>ͶӰ��Ƭ</p>
                </div>
                <div @click="to('20906')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/208.jpg">
                    <p>ͶӰ�����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20907')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/335.jpg">
                    <p>����Ļ</p>
                </div>
                <div @click="to('20908')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/157.jpg">
                    <p>ʵ��չ̨</p>
                </div>
                <div @click="to('20909')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/241.jpg">
                    <p>����ͶӰģ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('20910')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/296.jpg">
                    <p>��ʾ��</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('210')" class="hd">װ��/�ܷ��豸�����</p>
        <div class="content">
            <div class="row">
                <div @click="to('21001')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/107.jpg">
                    <p>�ܷ�����ܷ�Ĥ</p>
                </div>
                <div @click="to('21002')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/305.jpg">
                    <p>����װ����</p>
                </div>
                <div @click="to('21003')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/268.jpg">
                    <p>��ʽװ����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('21004')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/304.jpg">
                    <p>���۷���</p>
                </div>
                <div @click="to('21005')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/382.jpg">
                    <p>װ������</p>
                </div>
                <div @click="to('21006')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/394.jpg">
                    <p>����װ����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('21007')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/395.jpg">
                    <p>����װ�����</p>
                </div>
                <div @click="to('21008')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/366.jpg">
                    <p>��Ȧ/��Ȧ/װ������</p>
                </div>
                <div @click="to('21009')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/55.jpg">
                    <p>���ѻ�/���ֻ�/���ֻ����Ĳ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('21010')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/367.jpg">
                    <p>��װ��</p>
                </div>
                <div @click="to('21011')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/381.jpg">
                    <p>װ��/�ܷ��豸�����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-3" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('301')" class="hd">��������</p>
        <div class="content">
            <div class="row">
                <div @click="to('30101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/84.jpg">
                    <p>̨ʽ����</p>
                </div>
                <div @click="to('30102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/352.jpg">
                    <p>�ʼǱ�����</p>
                </div>
                <div @click="to('30103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/177.jpg">
                    <p>ƽ�����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/11.jpg">
                    <p>һ��ʽ����</p>
                </div>
                <div @click="to('30105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/252.jpg">
                    <p>������</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('302')" class="hd">�洢�豸</p>
        <div class="content">
            <div class="row">
                <div @click="to('30201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/10.jpg">
                    <p>U��</p>
                </div>
                <div @click="to('30202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/53.jpg">
                    <p>�ڴ���</p>
                </div>
                <div @click="to('30204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/422.jpg">
                    <p>���濨</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/402.jpg">
                    <p>����</p>
                </div>
                <div @click="to('30206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/42.jpg">
                    <p>����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('303')" class="hd">�����Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('30301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/8.jpg">
                    <p>UPS��Դ</p>
                </div>
                <div @click="to('30302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/330.jpg">
                    <p>���Զ���</p>
                </div>
                <div @click="to('30303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/418.jpg">
                    <p>����/���/����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/227.jpg">
                    <p>����ͷ</p>
                </div>
                <div @click="to('30305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/431.jpg">
                    <p>����</p>
                </div>
                <div @click="to('30306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/435.jpg">
                    <p>��Ƶ���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/9.jpg">
                    <p>USB��չ���</p>
                </div>
                <div @click="to('30308')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/329.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('30312')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/44.jpg">
                    <p>����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30310')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/359.jpg">
                    <p>����</p>
                </div>
                <div @click="to('30311')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/327.jpg">
                    <p>���԰�</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('304')" class="hd">��¼��/��¼��/¼���</p>
        <div class="content">
            <div class="row">
                <div @click="to('30402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/62.jpg">
                    <p>��¼��</p>
                </div>
                <div @click="to('30403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/63.jpg">
                    <p>��¼��</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('305')" class="hd">�������</p>
        <div class="content">
            <div class="row">
                <div @click="to('30503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/325.jpg">
                    <p>��Դ������</p>
                </div>
                <div @click="to('30505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/246.jpg">
                    <p>��ʾ��</p>
                </div>
                <div @click="to('30509')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/424.jpg">
                    <p>�Ķ���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30510')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/295.jpg">
                    <p>��ʾ��</p>
                </div>
                <div @click="to('30511')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/20.jpg">
                    <p>����</p>
                </div>
                <div @click="to('30512')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/245.jpg">
                    <p>�Կ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('30513')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/258.jpg">
                    <p>����</p>
                </div>
                <div @click="to('30514')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/232.jpg">
                    <p>ɢ����</p>
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
        <p @click="to('401')" class="hd">Ӱ���豸</p>
        <div class="content">
            <div class="row">
                <div @click="to('40101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/13.jpg">
                    <p>һ���Գ������</p>
                </div>
                <div @click="to('40102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/73.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('40103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/72.jpg">
                    <p>���������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/233.jpg">
                    <p>���������</p>
                </div>
                <div @click="to('40105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/234.jpg">
                    <p>���������</p>
                </div>
                <div @click="to('40106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/189.jpg">
                    <p>΢�����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/220.jpg">
                    <p>���ϵ���</p>
                </div>
                <div @click="to('40108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/322.jpg">
                    <p>�����Ķ���</p>
                </div>
                <div @click="to('40109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/293.jpg">
                    <p>�˾�</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('402')" class="hd">Ӱ���豸</p>
        <div class="content">
            <div class="row">
                <div @click="to('40201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/181.jpg">
                    <p>¼����</p>
                </div>
                <div @click="to('40202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/235.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('40203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/5.jpg">
                    <p>MP3/MP4������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/361.jpg">
                    <p>����/����</p>
                </div>
                <div @click="to('40205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/113.jpg">
                    <p>������</p>
                </div>
                <div @click="to('40206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/250.jpg">
                    <p>�����豸</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/432.jpg">
                    <p>����/����</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('403')" class="hd">�������</p>
        <div class="content">
            <div class="row">
                <div @click="to('40301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/16.jpg">
                    <p>���Ǽ�</p>
                </div>
                <div @click="to('40302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/236.jpg">
                    <p>�����豸���</p>
                </div>
                <div @click="to('40303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/188.jpg">
                    <p>Ӱ���/������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/4.jpg">
                    <p>GPS�豸</p>
                </div>
                <div @click="to('40305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/288.jpg">
                    <p>�����װ</p>
                </div>
                <div @click="to('40306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/419.jpg">
                    <p>��ͷ/�����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/339.jpg">
                    <p>�����������</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('404')" class="hd">�洢��/������</p>
        <div class="content">
            <div class="row">
                <div @click="to('40401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/2.jpg">
                    <p>CF��</p>
                </div>
                <div @click="to('40402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/6.jpg">
                    <p>SD��</p>
                </div>
                <div @click="to('40403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/7.jpg">
                    <p>TF��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/392.jpg">
                    <p>������/ת����</p>
                </div>
                <div @click="to('40405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/384.jpg">
                    <p>�����</p>
                </div>
                <div @click="to('40406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/49.jpg">
                    <p>��������洢</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('405')" class="hd">ͨѶ�豸</p>
        <div class="content">
            <div class="row">
                <div @click="to('40501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/182.jpg">
                    <p>¼����¼�绰��</p>
                </div>
                <div @click="to('40502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/248.jpg">
                    <p>��ͨ�绰��</p>
                </div>
                <div @click="to('40503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/407.jpg">
                    <p>ͨѶ���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/242.jpg">
                    <p>�����绰��</p>
                </div>
                <div @click="to('40505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/83.jpg">
                    <p>����չ�绰</p>
                </div>
                <div @click="to('40506')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/383.jpg">
                    <p>��Ƶ����ϵͳ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40507')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/433.jpg">
                    <p>��Ƶ����绰</p>
                </div>
                <div @click="to('40508')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/315.jpg">
                    <p>���Ű��ֻ�</p>
                </div>
                <div @click="to('40509')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/344.jpg">
                    <p>�ƶ����ֻ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40510')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/363.jpg">
                    <p>��ͨ���ֻ�</p>
                </div>
                <div @click="to('40511')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/164.jpg">
                    <p>�Խ��������</p>
                </div>
                <div @click="to('40512')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/198.jpg">
                    <p>�ֻ����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('40513')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/406.jpg">
                    <p>ͨ�ð��ֻ�</p>
                </div>
                <div @click="to('40514')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/375.jpg">
                    <p>�����豸</p>
                </div>
                <div @click="to('40515')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/41.jpg">
                    <p>��ֵ��</p>
                </div>
            </div>
        </div>
    </div>
    <div id="c-5" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('501')" class="hd">��̨</p>
        <div class="content">
            <div class="row">
                <div @click="to('50101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/21.jpg">
                    <p>������</p>
                </div>
                <div @click="to('50102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/362.jpg">
                    <p>ְԱ��</p>
                </div>
                <div @click="to('50103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/31.jpg">
                    <p>������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/211.jpg">
                    <p>�۵���</p>
                </div>
                <div @click="to('50105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/221.jpg">
                    <p>�Ӵ�̨</p>
                </div>
                <div @click="to('50106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/60.jpg">
                    <p>��ͼ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/150.jpg">
                    <p>��������</p>
                </div>
                <div @click="to('50108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/158.jpg">
                    <p>ʵ��̨</p>
                </div>
                <div @click="to('50109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/265.jpg">
                    <p>��̨</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('502')" class="hd">����</p>
        <div class="content">
            <div class="row">
                <div @click="to('50202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/88.jpg">
                    <p>Ա����</p>
                </div>
                <div @click="to('50203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/30.jpg">
                    <p>���/�Ӵ���</p>
                </div>
                <div @click="to('50210')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/179.jpg">
                    <p>����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/261.jpg">
                    <p>���/����</p>
                </div>
                <div @click="to('50205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/169.jpg">
                    <p>��ҵ����</p>
                </div>
                <div @click="to('50206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/151.jpg">
                    <p>������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/270.jpg">
                    <p>�ε�</p>
                </div>
                <div @click="to('50208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/212.jpg">
                    <p>�۵���/�ɶѵ���</p>
                </div>
                <div @click="to('50209')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/224.jpg">
                    <p>��ŵ�</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('503')" class="hd">ɳ�����輸</p>
        <div class="content">
            <div class="row">
                <div @click="to('50301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/278.jpg">
                    <p>ɳ��</p>
                </div>
                <div @click="to('50302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/372.jpg">
                    <p>�輸</p>
                </div>
                <div @click="to('50303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/279.jpg">
                    <p>ɳ�����輸</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('504')" class="hd">�����</p>
        <div class="content">
            <div class="row">
                <div @click="to('50401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/214.jpg">
                    <p>�����</p>
                </div>
                <div @click="to('50402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/346.jpg">
                    <p>���Ź�</p>
                </div>
                <div @click="to('50403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/180.jpg">
                    <p>���Ź�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/75.jpg">
                    <p>��Ƭ��</p>
                </div>
                <div @click="to('50405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/115.jpg">
                    <p>�๦����Ϲ�</p>
                </div>
                <div @click="to('50406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/25.jpg">
                    <p>���/���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50407')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/251.jpg">
                    <p>���¹�</p>
                </div>
                <div @click="to('50408')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/396.jpg">
                    <p>����</p>
                </div>
                <div @click="to('50409')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/243.jpg">
                    <p>���Ź�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50410')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/78.jpg">
                    <p>�����Ź�</p>
                </div>
                <div @click="to('50411')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/222.jpg">
                    <p>�ƹ�</p>
                </div>
                <div @click="to('50412')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/159.jpg">
                    <p>�Ҿߵ�Ʒ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50413')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/146.jpg">
                    <p>�����ļ���</p>
                </div>
                <div @click="to('50414')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/238.jpg">
                    <p>�ļ�����</p>
                </div>
                <div @click="to('50415')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/59.jpg">
                    <p>��ͼ�ļ���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50416')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/425.jpg">
                    <p>�����ļ���</p>
                </div>
                <div @click="to('50417')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/127.jpg">
                    <p>ý���ļ���</p>
                </div>
                <div @click="to('50422')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/39.jpg">
                    <p>�����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50419')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/156.jpg">
                    <p>���ƿ�ǽ����</p>
                </div>
                <div @click="to('50420')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/40.jpg">
                    <p>��������</p>
                </div>
                <div @click="to('50421')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/163.jpg">
                    <p>�ܼ���</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('505')" class="hd">������/������</p>
        <div class="content">
            <div class="row">
                <div @click="to('50501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/257.jpg">
                    <p>��е��������</p>
                </div>
                <div @click="to('50502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/321.jpg">
                    <p>������������</p>
                </div>
                <div @click="to('50503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/256.jpg">
                    <p>��е��������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/320.jpg">
                    <p>������������</p>
                </div>
                <div @click="to('50505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/217.jpg">
                    <p>ָ����������</p>
                </div>
                <div @click="to('50506')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/218.jpg">
                    <p>ָ����������</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('506')" class="hd">�Ҿ����ײ�Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('50601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/378.jpg">
                    <p>��ñ��</p>
                </div>
                <div @click="to('50602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/213.jpg">
                    <p>����/���ϼ�</p>
                </div>
                <div @click="to('50603')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/427.jpg">
                    <p>��ɡ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50604')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/101.jpg">
                    <p>��̺/����</p>
                </div>
                <div @click="to('50605')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/168.jpg">
                    <p>����</p>
                </div>
                <div @click="to('50606')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/65.jpg">
                    <p>�칫����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50607')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/429.jpg">
                    <p>���/���</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('507')" class="hd">�Ƴ���֧��</p>
        <div class="content">
            <div class="row">
                <div @click="to('50701')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/67.jpg">
                    <p>�칫���Ƴ�</p>
                </div>
                <div @click="to('50702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/331.jpg">
                    <p>���ӻ�/¼���̨</p>
                </div>
                <div @click="to('50703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/328.jpg">
                    <p>����֧��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50704')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/202.jpg">
                    <p>��ӡ��֧��</p>
                </div>
                <div @click="to('50705')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/255.jpg">
                    <p>����֧��</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('508')" class="hd">��ϼҾ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('50801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/337.jpg">
                    <p>ֱ����ϼҾ�</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('509')" class="hd">��ҵ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('50901')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/349.jpg">
                    <p>�յ�</p>
                </div>
                <div @click="to('50902')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/54.jpg">
                    <p>����/����/���/�ƹ�</p>
                </div>
                <div @click="to('50903')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/332.jpg">
                    <p>���ӻ�/Ӱ����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('50904')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/283.jpg">
                    <p>ϴ�»�</p>
                </div>
                <div @click="to('50905')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/303.jpg">
                    <p>��ˮ��</p>
                </div>
                <div @click="to('50906')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/161.jpg">
                    <p>�ҵ����</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('510')" class="hd">�������</p>
        <div class="content">
            <div class="row">
                <div @click="to('51001')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/441.jpg">
                    <p>��ˮ��/��ˮͰ</p>
                </div>
                <div @click="to('51002')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/347.jpg">
                    <p>����������/��ʪ��</p>
                </div>
                <div @click="to('51003')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/437.jpg">
                    <p>����/�յ���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51004')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/80.jpg">
                    <p>ȡů��</p>
                </div>
                <div @click="to('51005')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/86.jpg">
                    <p>������/ɨ�ػ�/��̺��ϴ��</p>
                </div>
                <div @click="to('51006')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/174.jpg">
                    <p>���ֻ�/���ֻ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51007')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/307.jpg">
                    <p>�ٶ�/���̻�</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('511')" class="hd">���˻���/��������</p>
        <div class="content">
            <div class="row">
                <div @click="to('51101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/377.jpg">
                    <p>Ѫѹ��/���¼�/Ѫ����</p>
                </div>
                <div @click="to('51102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/219.jpg">
                    <p>��Ħ��/��Ħ��/��ԡ��</p>
                </div>
                <div @click="to('51103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/37.jpg">
                    <p>������/���ӳ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/318.jpg">
                    <p>�紵��/���뵶/��ë��/�綯��ˢ</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('512')" class="hd">��������</p>
        <div class="content">
            <div class="row">
                <div @click="to('51201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/90.jpg">
                    <p>���Ȼ�</p>
                </div>
                <div @click="to('51202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/323.jpg">
                    <p>��ˮ��/����ˮƿ</p>
                </div>
                <div @click="to('51203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/190.jpg">
                    <p>΢��¯/����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('51204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/286.jpg">
                    <p>������/ϴ���</p>
                </div>
                <div @click="to('51205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/333.jpg">
                    <p>�緹��/��ѹ����/���¯</p>
                </div>
                <div @click="to('51206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/440.jpg">
                    <p>���ϼӹ���</p>
                </div>
            </div>
        </div>
    </div>
    <div id="c-6" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('601')" class="hd">��ȫ������Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('60101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/195.jpg">
                    <p>����</p>
                </div>
                <div @click="to('60102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/122.jpg">
                    <p>ͷ������</p>
                </div>
                <div @click="to('60103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/132.jpg">
                    <p>��ȫЬ/��Ь</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('60104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/398.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('60105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/191.jpg">
                    <p>������Ʒ</p>
                </div>
                <div @click="to('60106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/81.jpg">
                    <p>����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('60107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/171.jpg">
                    <p>����װ</p>
                </div>
                <div @click="to('60108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/131.jpg">
                    <p>��ȫ������Ʒ</p>
                </div>
                <div @click="to('60109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/298.jpg">
                    <p>�����</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('602')" class="hd">����װ</p>
        <div class="content">
            <div class="row">
                <div @click="to('60201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/226.jpg">
                    <p>���˳�/���Ƴ�/�۵���</p>
                </div>
                <div @click="to('60202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/267.jpg">
                    <p>����/�ŵ�</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-7" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('701')" class="hd">������ֽ</p>
        <div class="content">
            <div class="row">
                <div @click="to('70101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/336.jpg">
                    <p>��װ��ȡʽ��ֽ</p>
                </div>
                <div @click="to('70102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/400.jpg">
                    <p>������ȡʽ��ֽ</p>
                </div>
                <div @click="to('70103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/228.jpg">
                    <p>����ֽ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/196.jpg">
                    <p>����ֽ</p>
                </div>
                <div @click="to('70105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/291.jpg">
                    <p>ʪֽ��</p>
                </div>
                <div @click="to('70106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/165.jpg">
                    <p>С��ֽ/��оֽ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/118.jpg">
                    <p>���ֽ</p>
                </div>
                <div @click="to('70108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/79.jpg">
                    <p>����ֽ��</p>
                </div>
                <div @click="to('70109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/439.jpg">
                    <p>�ͽ�ֽ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70110')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/175.jpg">
                    <p>ƽ������ֽ</p>
                </div>
                <div @click="to('70111')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/119.jpg">
                    <p>���ֽ���</p>
                </div>
                <div @click="to('70112')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/166.jpg">
                    <p>С��ֽ/��оֽ���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70113')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/215.jpg">
                    <p>��ֽ���</p>
                </div>
                <div @click="to('70114')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/229.jpg">
                    <p>����ֽ���</p>
                </div>
                <div @click="to('70115')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/103.jpg">
                    <p>����ֽ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70116')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/314.jpg">
                    <p>������ֽ</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('702')" class="hd">�����Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('70201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/284.jpg">
                    <p>ϴ�·�/ϴ��Һ/����</p>
                </div>
                <div @click="to('70202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/287.jpg">
                    <p>����</p>
                </div>
                <div @click="to('70203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/348.jpg">
                    <p>�������¼�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/444.jpg">
                    <p>������Ʒ</p>
                </div>
                <div @click="to('70205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/129.jpg">
                    <p>������Ʒ</p>
                </div>
                <div @click="to('70206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/272.jpg">
                    <p>����/�����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/48.jpg">
                    <p>������ѧ�����Ʒ</p>
                </div>
                <div @click="to('70208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/290.jpg">
                    <p>�����Ʒ</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('703')" class="hd">����ϴ��</p>
        <div class="content">
            <div class="row">
                <div @click="to('70301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/277.jpg">
                    <p>��ԡ/����/ԡ��</p>
                </div>
                <div @click="to('70302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/281.jpg">
                    <p>ϴ��Һ</p>
                </div>
                <div @click="to('70303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/280.jpg">
                    <p>ϴ������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/82.jpg">
                    <p>��ǻ����</p>
                </div>
                <div @click="to('70305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/199.jpg">
                    <p>���㻤��</p>
                </div>
                <div @click="to('70306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/17.jpg">
                    <p>���˻���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/273.jpg">
                    <p>ë��</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('704')" class="hd">һ���Բ;߼���Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('70401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/15.jpg">
                    <p>һ���Բ;�</p>
                </div>
                <div @click="to('70402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/36.jpg">
                    <p>����Ĥ/���ʴ�</p>
                </div>
                <div @click="to('70403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/12.jpg">
                    <p>һ����̨��/ɡ�׼�Ь��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/14.jpg">
                    <p>һ����ֽ��/�ܱ�</p>
                </div>
                <div @click="to('70405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/308.jpg">
                    <p>��ǩ</p>
                </div>
                <div @click="to('70406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/45.jpg">
                    <p>����һ����Ʒ</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('705')" class="hd">������������;�</p>
        <div class="content">
            <div class="row">
                <div @click="to('70501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/275.jpg">
                    <p>ˮ��/���±�</p>
                </div>
                <div @click="to('70502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/35.jpg">
                    <p>���ʺ�/ʳ���</p>
                </div>
                <div @click="to('70503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/438.jpg">
                    <p>�;�/���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/416.jpg">
                    <p>����</p>
                </div>
                <div @click="to('70505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/56.jpg">
                    <p>����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('706')" class="hd">�칫����</p>
        <div class="content">
            <div class="row">
                <div @click="to('70601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/324.jpg">
                    <p>���/�����/�ƶ���Դ</p>
                </div>
                <div @click="to('70602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/356.jpg">
                    <p>ճ��/�ҹ�</p>
                </div>
                <div @click="to('70603')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/128.jpg">
                    <p>�洢����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70604')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/420.jpg">
                    <p>����/���</p>
                </div>
                <div @click="to('70605')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/423.jpg">
                    <p>����/����</p>
                </div>
                <div @click="to('70606')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/300.jpg">
                    <p>�̸�/��ƿ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70607')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/249.jpg">
                    <p>����ɡ/����</p>
                </div>
                <div @click="to('70608')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/239.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('70609')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/240.jpg">
                    <p>����/��ͼ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70610')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/276.jpg">
                    <p>��������</p>
                </div>
                <div @click="to('70611')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/99.jpg">
                    <p>ʥ��/������Ʒ</p>
                </div>
                <div @click="to('70612')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/365.jpg">
                    <p>����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70613')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/197.jpg">
                    <p>�����</p>
                </div>
                <div @click="to('70614')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/282.jpg">
                    <p>ϴɹ�þ�</p>
                </div>
                <div @click="to('70615')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/397.jpg">
                    <p>�ؿ�/����/���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70616')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/125.jpg">
                    <p>��״/֤��</p>
                </div>
                <div @click="to('70617')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/66.jpg">
                    <p>�칫�Ӽ�</p>
                </div>
                <div @click="to('70618')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/223.jpg">
                    <p>����</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('707')" class="hd">�˶����ּ�������Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('70701')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/355.jpg">
                    <p>����/����/������������</p>
                </div>
                <div @click="to('70702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/23.jpg">
                    <p>ƹ����/��ë��/�������</p>
                </div>
                <div @click="to('70703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/269.jpg">
                    <p>�����༰����������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70704')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/38.jpg">
                    <p>������е</p>
                </div>
                <div @click="to('70705')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/193.jpg">
                    <p>������Ʒ</p>
                </div>
                <div @click="to('70706')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/22.jpg">
                    <p>����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70707')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/364.jpg">
                    <p>����/�����/Ƥ��</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('708')" class="hd">ͼ��</p>
        <div class="content">
            <div class="row">
                <div @click="to('70801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/326.jpg">
                    <p>�����鼮</p>
                </div>
                <div @click="to('70802')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/95.jpg">
                    <p>�����鼮</p>
                </div>
                <div @click="to('70803')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/430.jpg">
                    <p>�����鼮</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70804')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/259.jpg">
                    <p>��־</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('709')" class="hd">��๤��</p>
        <div class="content">
            <div class="row">
                <div @click="to('70901')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/106.jpg">
                    <p>������</p>
                </div>
                <div @click="to('70902')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/105.jpg">
                    <p>����Ͱ</p>
                </div>
                <div @click="to('70903')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/170.jpg">
                    <p>��ҵ����ֽ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70904')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/413.jpg">
                    <p>��˿��/�ٽ಼/Ĩ��</p>
                </div>
                <div @click="to('70905')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/102.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('70906')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/100.jpg">
                    <p>�ص�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70907')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/50.jpg">
                    <p>������๤��</p>
                </div>
                <div @click="to('70908')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/61.jpg">
                    <p>ˢ��</p>
                </div>
                <div @click="to('70909')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/353.jpg">
                    <p>����/ɨ��/����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('70910')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/216.jpg">
                    <p>�ϲ�</p>
                </div>
                <div @click="to('70911')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/289.jpg">
                    <p>��๤��</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-8" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('801')" class="hd">��𹤾�</p>
        <div class="content">
            <div class="row">
                <div @click="to('80102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/316.jpg">
                    <p>�綯����</p>
                </div>
                <div @click="to('80103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/172.jpg">
                    <p>������/��/��</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('802')" class="hd">�о�</p>
        <div class="content">
            <div class="row">
                <div @click="to('80201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/414.jpg">
                    <p>��ͷ</p>
                </div>
                <div @click="to('80202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/415.jpg">
                    <p>ϳ��</p>
                </div>
                <div @click="to('80203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/399.jpg">
                    <p>����</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('803')" class="hd">��������</p>
        <div class="content">
            <div class="row">
                <div @click="to('80301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/167.jpg">
                    <p>��</p>
                </div>
                <div @click="to('80302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/57.jpg">
                    <p>���߹�</p>
                </div>
                <div @click="to('80303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/379.jpg">
                    <p>��/����</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('804')" class="hd">����</p>
        <div class="content">
            <div class="row">
                <div @click="to('80401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/173.jpg">
                    <p>��������</p>
                </div>
                <div @click="to('80402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/309.jpg">
                    <p>������;����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-9" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('901')" class="hd">ʵ���ҳ����豸</p>
        <div class="content">
            <div class="row">
                <div @click="to('90101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/391.jpg">
                    <p>����̨</p>
                </div>
                <div @click="to('90102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/192.jpg">
                    <p>������</p>
                </div>
                <div @click="to('90103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/69.jpg">
                    <p>����/��ȴ����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/225.jpg">
                    <p>������</p>
                </div>
                <div @click="to('90105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/403.jpg">
                    <p>������</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('902')" class="hd">�������������Ĳ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('90201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/388.jpg">
                    <p>�Թ�</p>
                </div>
                <div @click="to('90202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/301.jpg">
                    <p>�ձ�</p>
                </div>
                <div @click="to('90203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/312.jpg">
                    <p>������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/390.jpg">
                    <p>��ֽ</p>
                </div>
                <div @click="to('90205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/292.jpg">
                    <p>��ֽ</p>
                </div>
                <div @click="to('90206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/404.jpg">
                    <p>������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/294.jpg">
                    <p>©��</p>
                </div>
                <div @click="to('90208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/87.jpg">
                    <p>����</p>
                </div>
                <div @click="to('90209')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/108.jpg">
                    <p>����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90210')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/71.jpg">
                    <p>��ѧ�Լ�</p>
                </div>
                <div @click="to('90211')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/389.jpg">
                    <p>�Թ�ˢ</p>
                </div>
                <div @click="to('90212')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/386.jpg">
                    <p>���ϴ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('90213')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/387.jpg">
                    <p>������</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-10" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('1001')" class="hd">�������׼����</p>
        <div class="content">
            <div class="row">
                <div @click="to('100101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/408.jpg">
                    <p>���ܿ���</p>
                </div>
                <div @click="to('100102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/92.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('100110')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/271.jpg">
                    <p>ֲ֬ĩ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100104')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/126.jpg">
                    <p>�̾�/����</p>
                </div>
                <div @click="to('100105')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/357.jpg">
                    <p>��</p>
                </div>
                <div @click="to('100106')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/91.jpg">
                    <p>������ֽ/�����</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100107')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/46.jpg">
                    <p>�������</p>
                </div>
                <div @click="to('100108')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/447.jpg">
                    <p>��Ƭ/����/�̲�</p>
                </div>
                <div @click="to('100109')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/89.jpg">
                    <p>���Ȱ���</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1002')" class="hd">��Ҷ</p>
        <div class="content">
            <div class="row">
                <div @click="to('100201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/373.jpg">
                    <p>��Ҷ</p>
                </div>
                <div @click="to('100202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/380.jpg">
                    <p>���ݲ�</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1003')" class="hd">��ˮ����</p>
        <div class="content">
            <div class="row">
                <div @click="to('100301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/274.jpg">
                    <p>ˮ</p>
                </div>
                <div @click="to('100302')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/342.jpg">
                    <p>̼������</p>
                </div>
                <div @click="to('100303')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/374.jpg">
                    <p>������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100304')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/262.jpg">
                    <p>��֭</p>
                </div>
                <div @click="to('100305')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/405.jpg">
                    <p>�˶�/��������</p>
                </div>
                <div @click="to('100306')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/94.jpg">
                    <p>��������</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('100307')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/26.jpg">
                    <p>��Ʒ����</p>
                </div>
                <div @click="to('100308')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/410.jpg">
                    <p>�ƾ�����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div id="c-11" style="height: 1px; opacity: 0;"></div>
    <div class="cate-item">
        <p @click="to('1101')" class="hd">ʳ����ȯ</p>
        <div class="content">
            <div class="row">
                <div @click="to('110101')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/104.jpg">
                    <p>���ʳƷȯ</p>
                </div>
                <div @click="to('110102')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/285.jpg">
                    <p>���ʸɻ�ȯ</p>
                </div>
                <div @click="to('110103')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/428.jpg">
                    <p>�����Ʒȯ</p>
                </div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1102')" class="hd">�칫��Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('110201')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/96.jpg">
                    <p>������װ</p>
                </div>
                <div @click="to('110202')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/343.jpg">
                    <p>��Ʒ��</p>
                </div>
                <div @click="to('110203')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/178.jpg">
                    <p>����/̨��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110204')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/358.jpg">
                    <p>���/�ؿ�/���</p>
                </div>
                <div @click="to('110205')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/123.jpg">
                    <p>����/����</p>
                </div>
                <div @click="to('110206')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/124.jpg">
                    <p>��״/Ƹ��/֤��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110207')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/338.jpg">
                    <p>���</p>
                </div>
                <div @click="to('110208')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/436.jpg">
                    <p>������/ǩ����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1103')" class="hd">����;�ֽ���ȯ</p>
        <div class="content">
            <div class="row">
                <div @click="to('110301')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/116.jpg">
                    <p>����;�ֽ���ȯ</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1104')" class="hd">��ҵ����</p>
        <div class="content">
            <div class="row">
                <div @click="to('110401')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/144.jpg">
                    <p>���ƹ��ñ</p>
                </div>
                <div @click="to('110402')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/145.jpg">
                    <p>���ƹ����</p>
                </div>
                <div @click="to('110403')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/138.jpg">
                    <p>����������װ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110404')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/149.jpg">
                    <p>���Ʊ���/������</p>
                </div>
                <div @click="to('110405')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/154.jpg">
                    <p>���ƽ���</p>
                </div>
                <div @click="to('110406')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/137.jpg">
                    <p>���������ľ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110407')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/133.jpg">
                    <p>������д��Ʒ</p>
                </div>
                <div @click="to('110408')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/147.jpg">
                    <p>�����ļ�����</p>
                </div>
                <div @click="to('110409')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/148.jpg">
                    <p>�����ľ���װ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110410')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/155.jpg">
                    <p>�����ؿ�/����</p>
                </div>
                <div @click="to('110411')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/139.jpg">
                    <p>���Ƶ���</p>
                </div>
                <div @click="to('110412')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/141.jpg">
                    <p>������Ƭ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110413')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/135.jpg">
                    <p>��������ӡˢ��Ʒ</p>
                </div>
                <div @click="to('110414')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/140.jpg">
                    <p>����̨��</p>
                </div>
                <div @click="to('110415')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/134.jpg">
                    <p>�����ŷ�</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110416')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/153.jpg">
                    <p>����ֽ��</p>
                </div>
                <div @click="to('110417')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/142.jpg">
                    <p>���ƻ�īӡ</p>
                </div>
                <div @click="to('110418')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/136.jpg">
                    <p>��������ӡ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110419')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/152.jpg">
                    <p>������Ƥ��</p>
                </div>
                <div></div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1105')" class="hd">�Ҿ�����</p>
        <div class="content">
            <div class="row">
                <div @click="to('110501')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/162.jpg">
                    <p>�ҷĲ���</p>
                </div>
                <div @click="to('110502')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/58.jpg">
                    <p>����ڼ�</p>
                </div>
                <div @click="to('110503')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/160.jpg">
                    <p>�Ҿ�װ��</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110504')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/313.jpg">
                    <p>����ҵ�</p>
                </div>
                <div @click="to('110505')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/22.jpg">
                    <p>����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1106')" class="hd">��Ʒ�ٻ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('110601')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/70.jpg">
                    <p>��ױƷ</p>
                </div>
                <div @click="to('110602')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/412.jpg">
                    <p>�ӱ�</p>
                </div>
                <div @click="to('110603')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/442.jpg">
                    <p>��Ʒ</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110604')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/354.jpg">
                    <p>���</p>
                </div>
                <div @click="to('110605')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/121.jpg">
                    <p>̫����</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1107')" class="hd">����Ƽ�</p>
        <div class="content">
            <div class="row">
                <div @click="to('110702')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/18.jpg">
                    <p>����U��</p>
                </div>
                <div @click="to('110703')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/244.jpg">
                    <p>ʱ������</p>
                </div>
                <div></div>
            </div>
        </div>
    </div>
    <div class="cate-item">
        <p @click="to('1108')" class="hd">���վ�Ʒ</p>
        <div class="content">
            <div class="row">
                <div @click="to('110801')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/311.jpg">
                    <p>��������</p>
                </div>
                <div @click="to('110802')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/310.jpg">
                    <p>��ʯ����</p>
                </div>
                <div @click="to('110803')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/371.jpg">
                    <p>���</p>
                </div>
            </div>
            <div class="row">
                <div @click="to('110804')" class="cate-item-m">
                    <img src="${pageContext.request.contextPath}/static/image/w.png" data-src="${pageContext.request.contextPath}/static/image/cate/19.jpg">
                    <p>�й���</p>
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
    	<jsp:param value="����" name="tab"/>
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
    touch:"#left",//����������dom
    target: target, //�˶��Ķ���
    min : min > 0 ? 0 : min,
    max: 0,
    property: "translateY",  //���˶�������
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