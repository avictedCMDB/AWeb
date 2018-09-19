<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="head.jsp">
	<jsp:param value="首页" name="title"/>
</jsp:include>
<body class="index include-footer">
    	<div id="app">
    		<div class="search-wrapper">
	        <img src="${pageContext.request.contextPath}/static/image/index_search_bg.jpg">
	        <div class="search">
	            <span class="iconfont">&#xe60b;</span>
	            <input type="text" placeholder="路由器" readonly="readonly" onclick="location.href = '${pageContext.request.contextPath}/market/goods/search';"/>
	        </div>
	    </div>
	    <div class="nav-wrapper">
	        <ul class="nav">
	            <li onclick="location.href = '${pageContext.request.contextPath}/market/goods/cate';">
	                <img src="${pageContext.request.contextPath}/static/image/nav-cate.png">
	                <p>商品分类</p>
	            </li>
	            <li>
	                <img src="${pageContext.request.contextPath}/static/image/nav-point.png">
	                <p>积分</p>
	            </li>
	            <li onclick="location.href = '${pageContext.request.contextPath}/market/goods/prof/index';">
	                <img src="${pageContext.request.contextPath}/static/image/nav-service.png">
	                <p>专业市场</p>
	            </li>
	        </ul>
	    </div>
	    <div class="hot margin-top-10">
	        <p>
	            <span class="iconfont">&#xe60c;&#xe60c;</span>
	            <a>热卖推荐</a>
	            <span class="iconfont">&#xe60c;&#xe60c;</span>
	        </p>
	        <div class="item">
	            <img src="${pageContext.request.contextPath}/static/image/hot-01.jpg" 
	            	onclick="location.href = '"/>
	        </div>
	        <div class="item">
	            <img src="${pageContext.request.contextPath}/static/image/hot-02.jpg" 
	            	onclick="location.href = '${pageContext.request.contextPath}/market/goods/search?q=&cat=3&brand=TP-LINK';"/>
	        </div>
	        <div class="item">
	            <img src="${pageContext.request.contextPath}/static/image/hot-03.jpg" 
	            	onclick="location.href = '"/>
	        </div>
	        <div class="item">
	            <img src="${pageContext.request.contextPath}/static/image/hot-04.jpg" 
	            	onclick="location.href = '${pageContext.request.contextPath}/market/goods/search?q=&cat=2&brand=佳能';"/>
	        </div>
	        <div class="clear"></div>
	    </div>
	    <img class="big margin-top-10" src="${pageContext.request.contextPath}/static/image/index-banner.jpg"/>
	    <div class="cate margin-top-10">
	        <div class="hd">
	            <img class="left" src="${pageContext.request.contextPath}/static/image/cate1.png">
	            <a class="title" data-desc="让你的办公与众不同">办公用品</a>
	            <img class="right" src="${pageContext.request.contextPath}/static/image/cate-right.png" 
	            	onclick="location.href = '${pageContext.request.contextPath}/market/goods/cate?q=办公用品';">
	        </div>
	        <div class="prod">
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_03.png"/>
	                    <div>
	                        <p class="name">爱普生</p>
	                        <p class="desc">T0841 墨盒</p>
	                        <a class="buy" @click="to('1100000501EA', '2')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_05.png"/>
	                    <div>
	                        <p class="name">金得利</p>
	                        <p class="desc">F28 A4 2寸档案盒</p>
	                        <a class="buy" @click="to('1100010263EA', '2')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_09.png"/>
	                    <div>
	                        <p class="name">晨光</p>
	                        <p class="desc">金属笔筒 ABT98403</p>
	                        <a class="buy" @click="to('1036522', '1')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_12.png"/>
	                    <div>
	                        <p class="name">史泰博</p>
	                        <p class="desc">210G云彩纸</p>
	                        <a class="buy" @click="to('1100006258EA', '2')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	        </div>
	        
	        <div class="hd margin-top-10">
	            <img class="left" src="${pageContext.request.contextPath}/static/image/cate2.png">
	            <a class="title" data-desc="助力办公，非你不可">办公设备</a>
	            <img class="right" src="${pageContext.request.contextPath}/static/image/cate-right.png" 
	            	onclick="location.href = '${pageContext.request.contextPath}/market/goods/cate?q=办公设备';">
	        </div>
	        <div class="prod">
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_16.png"/>
	                    <div>
	                        <p class="name">联想 </p>
	                        <p class="desc">Lenovo 激光一体机 M7655DHF</p>
	                        <a class="buy" @click="to('1050020', '1')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_17.png"/>
	                    <div>
	                        <p class="name">惠普</p>
	                        <p class="desc">HP 多功能一体机 M277dw</p>
	                        <a class="buy" @click="to('1042905', '1')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_21.png"/>
	                    <div>
	                        <p class="name">三木</p>
	                        <p class="desc">SD9610 碎纸机</p>
	                        <a class="buy" @click="to('1100153070EA', '2')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_23.png"/>
	                    <div>
	                        <p class="name">佳能 Canon</p>
	                        <p class="desc">激光一体机 iC MF215</p>
	                        <a class="buy" @click="to('1042905', '1')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	        </div>
	        
	        <div class="hd margin-top-10">
	            <img class="left" src="${pageContext.request.contextPath}/static/image/cate3.png">
	            <a class="title" data-desc="品质生活，从选择开始">生活用品</a>
	            <img class="right" src="${pageContext.request.contextPath}/static/image/cate-right.png" 
	            	onclick="location.href = '${pageContext.request.contextPath}/market/goods/cate?q=生活用品';">
	        </div>
	        <div class="prod">
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_27.png"/>
	                    <div>
	                        <p class="name">公牛</p>
	                        <p class="desc">BULL 电源转换器 GN-L01CE</p>
	                        <a class="buy" @click="to('1048420', '1')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_30.png"/>
	                    <div>
	                        <p class="name">龙士达</p>
	                        <p class="desc">601衣架 LE-1601</p>
	                        <a class="buy" @click="to('1100168174EA', '2')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_34.png"/>
	                    <div>
	                        <p class="name">白猫</p>
	                        <p class="desc">蓝洁灵</p>
	                        <a class="buy" @click="to('1100013900EA', '2')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_36.png"/>
	                    <div>
	                        <p class="name">蓝月亮</p>
	                        <p class="desc">深层洁净护理洗衣液</p>
	                        <a class="buy" @click="to('355022', '1')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	        </div>
	        
	        <div class="hd margin-top-10">
	            <img class="left" src="${pageContext.request.contextPath}/static/image/cate4.png">
	            <a class="title" data-desc="网络时代，就要有范">电脑及配件</a>
	            <img class="right" src="${pageContext.request.contextPath}/static/image/cate-right.png" 
	            	onclick="location.href = '${pageContext.request.contextPath}/market/goods/cate?q=电脑及配件';">
	        </div>
	        <div class="prod">
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_43.png"/>
	                    <div>
	                        <p class="name">惠普 HP</p>
	                        <p class="desc">立体声耳机 Pan750</p>
	                        <a class="buy" @click="to('1052495', '1')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_41.png"/>
	                    <div>
	                        <p class="name">TP-LINK</p>
	                        <p class="desc">无线路由器 TL-WR842N</p>
	                        <a class="buy" @click="to('1100004785EA', '2')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_48.png"/>
	                    <div>
	                        <p class="name">联想 Lenovo</p>
	                        <p class="desc">启天M4550</p>
	                        <a class="buy" @click="to('1100173861EA', '2')">立即购买</a>
	                    </div>
	                </div>
	                <div class="item">
	                    <img src="${pageContext.request.contextPath}/static/image/m/index/goods_51.png"/>
	                    <div>
	                        <p class="name">罗技</p>
	                        <p class="desc">无线鼠标 M275</p>
	                        <a class="buy" @click="to('1042263', '1')">立即购买</a>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <img class="big margin-top-10" style="margin-bottom: 60px;" src="${pageContext.request.contextPath}/static/image/index-banner-2.jpg"/>
        <div style="height: 1px; opacity: 0;"></div>
	    <jsp:include page="./foot.jsp">
	    	<jsp:param value="首页" name="tab"/>
	    </jsp:include>
    	</div>
<script type="text/javascript">
var app = new Vue({
	el	: '#app',
	data	: {
		cartCount	: 0
	},
	methods	: {
		to	: function (gid, sid) {
			location.href = '${pageContext.request.contextPath}/market/goods/show?gid=' + gid + '&sid=' + sid;
		}
	}
});
</script>
</body>
</html>