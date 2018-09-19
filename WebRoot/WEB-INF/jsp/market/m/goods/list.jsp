<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<jsp:include page="../head.jsp">
	<jsp:param value="搜索" name="title"/>
</jsp:include>
<style type="text/css">
body.search .prod-list .prod-item img {
    height: 90px;
    width: 90px;
    padding: 5px;
    float: left;
}
p.n{
	line-height: 100%;
}
body.search .cnd{
	max-height: 100%;
    overflow-y: auto;
   	background-color: inherit;
}
body.search .cnd .cnd-list,.button-group{
	background-color: #fff;
}

</style>
<body class="search">
    <div id="search" v-bind:class="{'fix' : fullBorder}">
        <div class="header">
            <i class="iconfont back" @click="back()">&#xe615;</i>
            <div class="input">
                <i class="iconfont">&#xe60b;</i>
                <form action="#" v-on:submit="submit($event)">
                	<input type="search" autocomplete="off" placeholder="路由器" v-model="q"/>
                </form>
            </div>
        </div>
        <ul class="order">
            <li
                    v-for="(order, index) in orders"
                    v-bind:class="{'active' : orderBy == index, 'full-right-border' : fullBorder && (''+fullBorder).indexOf(index) != -1}"
                    v-on:click="sort(index)">
                <span>{{order.name}}</span>
            </li>
        </ul>
        <div class="cnd" v-bind:class="{'show': fullBorder}" id="cnd">
            <div id="scroll">
            	<div class="cnd-list" style="display: none;" v-bind:class="{'show' : orderBy == 0}" id="cnd-0">
	                <c:forEach var="item" items="${supList}" varStatus="sta">
						<c:if test="${item.supType == 0}">
		                	<a v-on:click="filter(1, '${item.supId}')" class="item" v-bind:class="{'active' : '${item.supId}' == sup}">${fn:escapeXml(item.supName)}</a>
						</c:if>
					</c:forEach>
	            </div>
	            <div class="cnd-list" style="display: none;" v-bind:class="{'show' : orderBy == 1}" id="cnd-1">
	                <c:forEach var="item" items="${brandList}" varStatus="sta">
	                	<a v-on:click='filter(2, "${item}")' class="item" v-bind:class='{"active" : "${item}" == searchBrand}'>${fn:escapeXml(item)}</a>
					</c:forEach>
					</div>
	            </div>
	            
	            <div class="cnd-list" style="display: none;" v-bind:class="{'show' : orderBy == 2}" id="cnd-2">
	                <a v-on:click="filter(3, '0,99')" class="item" v-bind:class="{'active' : price == '0,99'}">0-99</a>
	                <a v-on:click="filter(3, '100,999')" class="item" v-bind:class="{'active' : price == '100,999'}">100-999</a>
	                <a v-on:click="filter(3, '1000,4999')" class="item" v-bind:class="{'active' : price == '1000,4999'}">1000-4999</a>
	                <a v-on:click="filter(3, '5000,0')" class="item" v-bind:class="{'active' : price == '5000,0'}">5000以上</a>
	            </div>
	            <div class="button-group">
	                <a class="btn btn-disable" v-on:click="filter(0)">重选</a>
	                <a class="btn btn-primary" v-on:click="submit()">确认</a>
	            </div>
					<div style="height: 84px; opacity: 0;">
            </div>
        </div>
        <div class="prod-list">
        	
			<c:forEach var="item" items="${list}" varStatus="sta">
				<div class="prod-item" @click="to('${item.supGoodsId}', '${item.supId}')">
	                <img src="${item.imagePath}"/>
	                <div>
	                    <p class="n">
	                        [${dataCache.getSupplierName(item.supId)}] ${fn:escapeXml(item.goodsName)}
	                    </p>
	                    <p class="p">
	                        ￥${item.agreePrice }
	                    </p>
	                    <p class="c">
	                        销量 ${item.saleNum }
	                    </p>
	                </div>
	            </div>
			</c:forEach>
			<div class="prod-item" v-for="item in list" @click="to(item.supGoodsId, item.supId)">
				<img :src="item.imagePath"/>
                <div>
                    <p class="n">
                        [{{item.brandName}}] {{item.goodsName}}
                    </p>
                    <p class="p">
                        ￥{{item.agreePrice}}
                    </p>
                    <p class="c">
                        销量 {{item.saleNum}}
                    </p>
                </div>
			</div>
        </div>
        <div class="order-mask" v-if="fullBorder"></div>
    </div>
<script type="text/javascript">
$(window).scroll(function(){
　　var scrollTop = $(this).scrollTop();
　　var scrollHeight = $(document).height();
　　var windowHeight = $(this).height();
　　if(scrollTop + windowHeight == scrollHeight && search.hasMore){
　　　　	search.load();
　　}
});
var search = new Vue({
    el      : '#search',
    data    : {
    	
    	q			: '${searchKeyword}',
        p			: 1,
        orderBy     : null,
        fullBorder  : null,
        sup			: '${sup}',
        searchBrand	: '${fn:escapeXml(searchBrand)}',
        price		: '${price}',
        loading		: false,
        hasMore 	: ${pages == 1 ? 'false' : 'true'},
        list		: [],
        orders      : [
            {by : 1, name : '供应商'},
            {by : 2, name : '品牌'},
            {by : 3, name : '价格'}
        ]
    },
    methods : {
    	back	: function () {
    		location.href = '../index';
    	},
    	load	: function () {
    		if (this.loading) return;
    		if (this.p > ${pages}) {
    			hasMore = false;
    			return;
    		}
    		this.loading = true;
    		++ this.p;
    		var url = '${pageContext.request.contextPath}/market/goods/search/ajax?q=' + encodeURIComponentGBK(this.q ? this.q : '') 
    		+ '&price=' + (this.price ? this.price : '')
			+ '&brand=' + (encodeURIComponentGBK(this.searchBrand ? this.searchBrand : ''))
			+ '&sup=' 	+ (this.sup ? this.sup : '')
			+ '&cat='	+ '${cat}'
			+ '&p='		+ this.p;
    		this.$http.get(url).then(function(res){
    			this.loading = false;
    			if (res.body) {
    				var list = res.body.result.list;
    				if (list.length  == 0) {
    					this.hasMore = false;
    				}
    				for (var i = 0; i < list.length; i++) {
    					this.list.push(list[i]);
    				}
    			}
    		}, function(res){
    			this.loading = false;
    		});
    	},
    	submit	: function (event) {
    		event && event.preventDefault();
    		//q=12&cat=0&price=100,999&brand=&sup=1&o=0&view=pic
    		location.href = '${pageContext.request.contextPath}/market/goods/search?q=' + encodeURIComponentGBK(this.q ? this.q: '') 
    				+ '&price=' + (this.price ? this.price : '')
    				+ '&brand=' + (encodeURIComponentGBK(this.searchBrand ? this.searchBrand : ''))
    				+ '&cat='	+ '${cat}'
    				+ '&sup=' 	+ (this.sup ? this.sup : '');
    	},
    	filter	: function (index, val) {
    		switch (index) {
			case 1:
				this.sup = val == this.sup ? null : val;
				break;
			case 2:
				this.searchBrand = val == this.searchBrand ? null : val;
				break;
			case 3:
				this.price = val == this.price ? null : val;
				break;
			default:
				this.sup = this.searchBrand = this.price = null;
				break;
			}
    	},
    	sort	: function (index) {
            if (index == this.orderBy) {
                this.orderBy = null;
                this.fullBorder = null;
            } else {
                this.orderBy = index;
                var last = this.orders.length - 1;
                switch (index) {
                    case 0:
                        this.fullBorder = 1;
                        break;
                    case last:
                        this.fullBorder = last;
                        break;
                    default:
                        this.fullBorder = index + '' + (index+1);
                        break;
                }
            }
        },
		to	: function (gid, sid) {
			location.href = '${pageContext.request.contextPath}/market/goods/show?gid=' + gid + '&sid=' + sid;
		}
    }
});

</script>
</body>
</html>