<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="רҵ�г�" name="title" />
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/profession.css" type="text/css" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/jquery.event.drag-1.5.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/jquery.touchSlider.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/profession/profession.js"></script>
<script type="text/javascript">
$(function () {
	$(".p1-cat").change(function () {
		var cat = $(this).val();
		var container = $(this).parent().parent().parent();
		var brand = container.find(".p1-brand");
		var sup = container.find(".p1-sup");
		
		brand.html('<option value="">ȫ��</option>');
		sup.html('<option value="">ȫ��</option>');
		
		if (cat != "") {
			brand.html('<option value="">������...</option>');
			async('${pageContext.request.contextPath}/market/goods/prof/brand', {cat:cat}, function (msg) {
				var result = msg.result;
				brand.html("<option value=''>ȫ��</option>");
				for (var i = 0; i < result.length; i++) {
					brand.append("<option value='"+result[i]+"'>"+result[i]+"</option>");
				}
			}, function () {
				brand.html("<option value=''>����ʧ��</option>");
			});
		}		
	});
	$(".p1-brand").change(function () {
		var brand = $(this).val();
		var container = $(this).parent().parent().parent();
		var sup = container.find(".p1-sup");
		var cat = container.find(".p1-cat");

		sup.html('<option value="">ȫ��</option>');
		
		if (brand != "") {
			sup.html('<option value="">������...</option>');
			async('${pageContext.request.contextPath}/market/goods/prof/sup?cat=' + cat.val() + '&brand=' + encodeURIComponentGBK(brand), {}, function (msg) {
				var result = msg.result;
				sup.html("<option value=''>ȫ��</option>");
				for (var i = 0; i < result.length; i++) {
					sup.append("<option value='"+result[i].supId+"'>"+result[i].supName+"</option>");
				}
			}, function () {
				sup.html("<option value=''>����ʧ��</option>");
			});
		}
	});
	
	$(".p1-search").click(function () {
		var container = $(this).parent().parent();
		var cat1 = container.attr("data-cat1");
		var cat2 = container.attr("data-id");
		var cat3 = container.find(".p1-cat").val();
		var brand = container.find(".p1-brand").val();
		var model = container.find(".p1-model").val();
		var name = container.find(".p1-name").val();
		var stuff = container.find(".p1-stuff").val();
		var sup = container.find(".p1-sup").val();
		var price1 = container.find(".p1-price-start").val();
		var price2 = container.find(".p1-price-end").val();
		
		window.location.href = "${pageContext.request.contextPath}/market/goods/prof?stuff=" + encodeURIComponentGBK(stuff) + "&sup=" + sup + "&cat1=" + cat1 + "&cat2=" + cat2 + "&cat3=" + cat3 + "&brand=" + encodeURIComponentGBK(brand) + "&model=" + encodeURIComponentGBK(model) + "&q=" + encodeURIComponentGBK(name) + "&price1=" + price1 + "&price2=" + price2;
	});
	/*
	$(".p2-search").click(function () {
		var container = $(this).parent().parent();
		var cat2 = container.attr("data-id");
		var cat3 = container.find(".p2-cat").val();
		var brand = container.find(".p2-brand").val();
		var name = container.find(".p2-name").val();
		var sup = container.find(".p2-sup").val();
		var price1 = container.find(".p2-price-start").val();
		var price2 = container.find(".p2-price-end").val();
		
		window.location.href = "${pageContext.request.contextPath}/market/goods/prof?sup=" + sup + "&cat1=P2&cat2=" + cat2 + "&cat3=" + cat3 + "&brand=" + encodeURIComponentGBK(brand) + "&q=" + encodeURIComponentGBK(name) + "&price1=" + price1 + "&price2=" + price2;
	});
	
	$(".p3-search").click(function () {
		var container = $(this).parent().parent();
		var desc = container.find("#p3_desc").val();
		var name = container.find("#p3_name").val();
		
		window.location.href = "${pageContext.request.contextPath}/market/goods/prof?cat1=P3&q=" + encodeURIComponentGBK(name) + "&desc=" + encodeURIComponentGBK(desc);
	});
	*/
	

	$(".search_type li a").on("click",function(){
		if ($(this).attr("data-valid") == "1") return;
		var $search_type_list =$(this).parent();
		$search_type_list.addClass("cur").siblings().removeClass("cur");
		var num02= $search_type_list.index();
		$search_type_list.parent().parent().find(".search_input_box").eq(num02).show().siblings().hide();
    })
});
</script>
</head>

<body>
<div class="page-wrapper">
    
		<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
			<div id="nav_area">
			<div class="inner clearfix" style="z-index:999;">
				<jsp:include page="../categorys.jsp" />
			</div>
    <!--#nav_area-->
  </div>
    <div id="banner_header">
        <div class="search_box">
            <div class="search_box_inner">
                <div class="search_nav">
                    <ul>
                        <c:forEach var="item" items="${cats}" varStatus="sta">  
                        <li <c:if test="${sta.first}"> class="cur"</c:if>><a href="javascript:void(0)">${item.marketCatName}</a></li>
                        </c:forEach>
                    </ul>
                <!--.search_nav--></div>
                <div class="search_main">
                    <ul>
                        <c:forEach var="p1" items="${cats}" varStatus="sta">  
                    	<li class="search_main_box" <c:if test="${sta.index > 0}"> style="display:none;"</c:if>>
                            <ul class="search_type">
                            <c:forEach var="item" items="${p1.subs}" varStatus="sta">                           
                                <li data-id="${item.marketCatId}"><a <c:if test="${sta.first}"> style="padding:0;"</c:if>  href="javascript:void(0)" data-valid="${item.ifValid}">${item.marketCatName}<i></i></a></li>
                            </c:forEach>
                            </ul>
                            <div class="search_area">
                            <c:forEach var="item" items="${p1.subs}" varStatus="sta2">  
                                <div class="search_input_box" data-cat1="${p1.marketCatId}" data-id="${item.marketCatId}" <c:if test="${sta2.index > 0}"> style="display:none;"</c:if>>
                                    <div class="search_inner">
                                        <dl class="item_s">
                                           <dt>����</dt>
                                           <dd>
                                               <select class="form-control p1-cat">
                                                   <option value="">ȫ��</option>
                           						   <c:forEach var="sub" items="${item.subs}">
                                                   <option value="${sub.marketCatId}">${sub.marketCatName}</option>
                            					   </c:forEach>
                                               </select>
                                           </dd> 
                                        </dl>
                                        <dl class="item_s">
                                           <dt>Ʒ��</dt>
                                           <dd>
                                               <input class="form-control p1-name" type="text">
                                           </dd>
                                        </dl>
                                        <dl class="item_s special">
                                           <dt>Ʒ��</dt>
                                           <dd>
                                               <select class="form-control p1-brand">
                                                   <option value="">ȫ��</option>
                                               </select>
                                           </dd>
                                        </dl>
                                        <dl class="item_s">
                                           <dt>���</dt>
                                           <dd>
                                               <input class="form-control p1-model" type="text">
                                           </dd> 
                                        </dl>
                                        <dl class="item_s">
                                           <dt>����</dt>
                                           <dd>
                                               <input class="form-control p1-stuff" type="text">
                                           </dd> 
                                        </dl>
                                        <dl class="item_s special">
                                           <dt>��Ӧ��</dt>
                                           <dd>
                                               <select class="form-control p1-sup">
                                                   <option value="">ȫ��</option>
                                               </select>
                                           </dd> 
                                        </dl>
                                        <dl class="item_s">
                                           <dt>�۸�����</dt>
                                           <dd>
                                               <input class="form-control special_input p1-price-start" type="text">-
                                               <input class="form-control special_input p1-price-end" type="text">
                                           </dd> 
                                        </dl>
                                    </div>
                                    <div class="btn_search"><button class="btn btn-default blue p1-search" type="button">����</button><a href="${pageContext.request.contextPath}/management/specialGoods" class="btn btn-default blue" style="margin-left:20px;" >��</a></div>
                                    <div class="img_list"><img src="${pageContext.request.contextPath}/static/img/profession/img-server.jpg" width="412" height="31" alt=""></div>
                                </div>
                            </c:forEach>
                            </div>
                        </li>
                    	</c:forEach>
                    
                    </ul>
                <!--.search_main--></div>
            </div>
        </div>
        <div class="main_visual">
          <div class="flicking_con">
              <a href="#"></a>
              <a href="#"></a>
              <a href="#"></a>

          </div>
          <div class="main_image">
              <ul>
                  <li><span class="img_6"></span></li>
                  <li><span class="img_7"></span></li>
                  <li><span class="img_8"></span></li>
              </ul>
              <a href="javascript:;" id="btn_prev"></a>
              <a href="javascript:;" id="btn_next"></a>
          </div>
      </div>
    <!--main_visual end-->
    <!--#banner_header--></div>
    <div class="contents">
        <div class="inner">
            <div class="section_pro">
              <h2><img src="${pageContext.request.contextPath}/static/img/profession/title-recommend.gif" width="86" height="20" alt=""></h2>
              <div class="logo_list">
                  <ul>
                  <c:forEach var="item" items="${brands}">
                      <li><a href="${pageContext.request.contextPath}/market/goods/prof?brand=${item.brandName}&from=brand"><img src="${pageContext.request.contextPath}${item.brandImage}" width="178" height="55" alt=""></a></li>
                  </c:forEach>
                  </ul>
              </div>
            </div>
            <div class="section_pro">
                <a href="${pageContext.request.contextPath}/management/specialGoods">
              		<img src="${pageContext.request.contextPath}/static/img/profession/bnr-go.jpg" width="1169" height="157" alt="">
                </a>
            </div>
            <c:if test="${empty my }">
            <div class="section_pro">
                <h2><img src="${pageContext.request.contextPath}/static/img/profession/title-supplier.gif" width="109" height="20" alt=""></h2>
                <div class="supplier_area">
                    <div class="supplier_area_bottom">
                        <div class="left_area">
                            <h3>���¼��빩Ӧ��</h3>
                            <ul>
                            <c:forEach var="item" items="${newSup}">                            
                                <li><a href="${pageContext.request.contextPath}/market/goods/prof?sup=${item.supId}&from=sup">${item.supName}</a><span><fmt:formatDate value="${item.enterDate}" pattern="yyyy-MM-dd"/>��פ</span></li>
                            </c:forEach>
                            </ul>
                        </div>
                        <div class="right_area">
                            <ul>
                            <c:forEach var="item" items="${recSup}">
                                <li>
                                    <p><img src="${pageContext.request.contextPath}${item.supImage}" width="53" height="56" alt=""></p>
                                    <h3><a href="${pageContext.request.contextPath}/market/goods/prof?sup=${item.supId}&from=sup">${item.supName}</a></h3>
                                    <p class="gray">��ӪƷ�ࣺ${item.busiType}</p>
                                    <p class="gray">��ӪƷ�ƣ�${item.busiRange}</p>
                                </li>
                            </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>
            <c:if test="${not empty my }">
            <div class="section_pro">
                <h2><img src="${pageContext.request.contextPath}/static/img/profession/title-supplier.gif" width="109" height="20" alt=""></h2>
                <div class="supplier_area">
                    <div class="supplier_area_bottom">
                        <div class="left_area">
                            <h3>������Ӧ��</h3>
                            <ul>
                            <c:forEach var="item" items="${my}">                            
                                <li><a href="${pageContext.request.contextPath}/market/goods/prof?sup=${item.supId}&from=sup">${item.supName}</a><span><fmt:formatDate value="${item.enterDate}" pattern="yyyy-MM-dd"/>��פ</span></li>
                            </c:forEach>
                            </ul>
                        </div>
                        <div class="right_area">
                            <ul>
                            <c:forEach var="item" items="${recSup}">
                                <li>
                                    <p><img src="${pageContext.request.contextPath}${item.supImage}" width="53" height="56" alt=""></p>
                                    <h3><a href="${pageContext.request.contextPath}/market/goods/prof?sup=${item.supId}&from=sup">${item.supName}</a></h3>
                                    <p class="gray">��ӪƷ�ࣺ${item.busiType}</p>
                                    <p class="gray">��ӪƷ�ƣ�${item.busiRange}</p>
                                </li>
                            </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>
        </div>
    </div>
		<jsp:include page="../footer.jsp" />
</div>
</body>
</html>