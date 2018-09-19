<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<jsp:include page="../meta.jsp">
	<jsp:param value="���ﳵ" name="title" />
</jsp:include>
<link href="${pageContext.request.contextPath}/static/css/cart.css" rel="stylesheet">
<script type="text/javascript">
$(function () {
	$("input[id^=sup_chx_]").click(function () {
		checked = this.checked;
		$("input[id^=sup_goods_"+this.value+"_]").each(function () {
			if (this.disabled) return;
			this.checked = checked;
		});
		calPrice();
	});
	$("input[id^=sup_goods_]").click(function () {
		var supId = $(this).attr("id").split("_")[2];
		var t = 0, f = 0;
		$("input[id^=sup_goods_"+supId+"_]").each(function () {
			if (this.disabled) return;
			this.checked ? (t++) : (f++);
		});
		
		if (t > 0 && f == 0) {
			$("#sup_chx_" + supId).get(0).checked = true;
		} else if (t == 0 && f > 0) {
			$("#sup_chx_" + supId).get(0).checked = false;
		}
		
		calPrice();
	});
	
	$(".cart-goods-del").click(function () {
		if (confirm("ȷ��ɾ�������Ʒ��")) {
			var sid = $(this).attr("data-sid");
			var gid = $(this).attr("data-gid");
			var ids = sid + "#" + gid;
			async('${pageContext.request.contextPath}/market/cart/del', {ids:ids}, function (msg) {
				setCartNum(msg.result);
				$("#row_" + sid + "_" + gid).remove();
				cartCheck();
			});
		}
	});
	
	$("#batch_del").click(function () {
		var ids = [];
		$("input[id^=sup_goods_]").each(function () {
			if (this.checked) {
				var sep = $(this).attr("id").split("_");
				ids.push(sep[2] + "#" + sep[3]);
			}
		});
		
		if (ids.length == 0) {
			alert("��ѡ��Ҫɾ������Ʒ");
			return;
		}
		
		if (confirm("ȷ��ɾ����Щ��Ʒ��")) {
			async('${pageContext.request.contextPath}/market/cart/del', {ids:ids.join("^")}, function (msg) {
				setCartNum(msg.result);
				$(ids).each(function () {
					var sep = this.split("#");
					$("#row_" + sep[0] + "_" + sep[1]).remove();
				});
				cartCheck();
			});
		}
		
	});
	
	$(".btn_reduce").click(function () {
		var $num = $(this).parent().parent().find(".amount");
		var num = parseInt($num.val());
		
		if (num > 1) {
			num --;
			$num.val(num);
			
			calRow($num.attr("id").replace("buy_num_", ""));
			calPrice();
			
			var all = parseInt($("#cart_num").text().replace("(", "").replace(")", ""));
			all --;
			
			setCartNum(all);
		}
		
	});
	
	$(".btn_add").click(function () {
		var $num = $(this).parent().parent().find(".amount");
		var num = parseInt($num.val());
		
		if (num < 100000) {
			num ++;
			$num.val(num);


			var all = parseInt($("#cart_num").text().replace("(", "").replace(")", ""));
			all ++;
			
			setCartNum(all);
			
			calRow($num.attr("id").replace("buy_num_", ""));
			calPrice();
			
		}
		
	});

	$(".amount").bind("keyup afterpaste", function (e) {
		var val = this.value.replace(/\D/g, '');
		
		this.value = parseInt(val == "" ? 1 : val, 10);

		if (this.value == 0) {
			this.value = 1;
		}
		
		if (this.value > 9999) {
			this.value = 9999;
		}

		calRow($(this).attr("id").replace("buy_num_", ""));
		calPrice();
		

		var all = 0;
		$(".amount").each(function () {
			all += this.value - 0;
		});
		
		setCartNum(all);
	});
	
	$("#cart_checkout").click(function () {
		var choice = [];
		var error = [];
		var supId = false;
		var check = true;
		var total = 0;
		$("input[id^=sup_goods_]").each(function () {
			var rid = $(this).attr("id").replace("sup_goods_", "");
			if (this.checked) {
				
				if (!supId) {
					supId = rid.split("_")[0];
				}
				
				if (supId != rid.split("_")[0]) {
					check = false;
				}
				
				var status = $("#goods_status_" + rid).attr("data-goods-status");
				if ($("#goods_compare_" + rid).attr("data-compare") > 0) {
					if (status != 1) {
						error.push("��Ʒ��"+$("#goods_name_" + rid).text()+"�����¼�");
					} else if (parseInt($("#buy_num_" + rid).val()) > $("#goods_stock_" + rid).text()) {
						error.push("��Ʒ��"+$("#goods_name_" + rid).text()+"����治��");
					}
				} else {
					if (status != 1) {
						error.push("��Ʒ��"+$("#goods_name_" + rid).text()+"�����¼�");
					} else if (parseInt($("#buy_num_" + rid).val()) > $("#goods_stock_" + rid).text()) {
						error.push("��Ʒ��"+$("#goods_name_" + rid).text()+"����治��");
					}
					//error.push("��Ʒ��"+$("#goods_name_" + rid).text()+"��δ�Ա�");
				}
				
				var num = $("#buy_num_" + rid).val();
				
				if (num < 1 || num > 9999) {
					error.push("��Ʒ��"+$("#goods_name_" + rid).text()+"������������1-9999֮��");
				} 
				choice.push(rid + "_" + num);
			}
		});
		if (supId == 4 && $("#total_price").text().replace(/[^0-9.]/, "") <= 99) {
			error.push("���򡾾���������Ʒ��������������99Ԫ");
		}
		
		if (choice.length == 0) {
			alert("��ѡ��Ҫ�µ�����Ʒ");
			return;
		}
		
		if (!check) {
			alert("��ѡ��ͬһ����Ӧ�̵���Ʒ�µ�");
			return;
		}
		
		if (error.length > 0) {
			alert("�µ�ʧ�ܣ�\n" + error.join("\n"));
			return;
		}
		var warnflag = '0';
		$("input[id^=sup_goods_]").each(function () {
			var rid = $(this).attr("id").replace("sup_goods_", "");			
			if (this.checked) {
				if($("#goods_status_" + rid).text().indexOf("Ԥ��") > 0){
					if(confirm("Ԥ����Ʒ���ͻ�����Ϊ7-15�죬��ȷ���Ƿ���")){							
						return false;
					}else{
						warnflag = '1';
						return false;
					}
				}
			}
		});	
		if(warnflag == '0'){
			window.location.href = "${pageContext.request.contextPath}/market/order/confirm?warning=1&ids=" + choice.join(",");			
		}
					
	});
	
	calPrice();
	
	<c:if test="${error != null}">
	alert("${error}");
	</c:if>
});

var timers = {};

var calRow = function (rid) {
	var price = parseFloat($("#goods_price_" + rid).text());
	var num = parseInt($("#buy_num_" + rid).val());
	$("#goods_total_" + rid).text((price * num).toFixed(2));
	
	var status = $("#goods_status_" + rid);

	if (status.attr("data-goods-status") == 1) {
		var stock = parseInt($("#goods_stock_" + rid).text());
		if(status.text().indexOf("Ԥ��") <= 0){
			if (stock >= num) {
				status.text("�л�");
			} else {
				status.text("��治��");
			}				
		}
	}
	
	
	if (timers[rid]) {
		clearTimeout(timers[rid]);
	}
	
	timers[rid] = setTimeout(function () {
		var sep = rid.split("_");
		async('${pageContext.request.contextPath}/market/cart/num', {sid:sep[0], gid:sep[1], num:num, all:parseInt($("#cart_num").text().replace("(", "").replace(")", ""))}, function (msg) {
			
		}, function () {});
	}, 1000);
}

var cartCheck = function () {
	$("div[id^=sup_item_]").each(function () {
		var supId = $(this).attr("id").replace("sup_item_", "");
		if ($("input[id^=sup_goods_"+supId+"_]").size() == 0) {
			$(this).remove();
		}
	});
	
	if ($("div[id^=sup_item_]").size() == 0) {
		$("#cart_main").html('<div style="text-align:center; line-height:100px; font-size:30px; color:#cccccc;">���ﳵ�ǿյ�</div>');
	}
	calPrice();
}

var calPrice = function () {
	var total = 0;
	var num = 0;
	$("span[id^=sub_total_]").each(function () {
		var supId = $(this).attr("id").replace("sub_total_", "");
		var subTotal = 0;
		$("input[id^=sup_goods_"+supId+"_]").each(function () {
			if (this.checked) {
				subTotal += parseFloat($("#" + $(this).attr("id").replace("sup_goods_", "goods_total_")).text());
				num += parseInt($("#" + $(this).attr("id").replace("sup_goods_", "buy_num_")).val());
			}
		});
		
		$(this).text(subTotal.toFixed(2));
		
		total += subTotal;
	});
	
	$("#total_num").text(num);
	$("#total_price").text("��" + total.toFixed(2));
	
}
</script>
</head>

<body>
	<div class="page-wrapper">
		<jsp:include page="../header.jsp" />
		<div id="nav_area">
			<div class="inner clearfix">
				<jsp:include page="../categorys.jsp" />
			</div>
			<!--#nav_area-->
		</div>
		<div id="contents">
			<div class="inner">
				<div class="breadcrumb">
					<ul>
						<li><a href="${pageContext.request.contextPath}">��ҳ</a><span>&gt;</span></li>
						<li>�ҵĹ��ﳵ</li>
					</ul>
					<!--.breadcrumb-->
				</div>

				<div id="cart_main">
					<c:if test="${empty list}">
					<div style="text-align:center; line-height:100px; font-size:30px; color:#cccccc;">
						���ﳵ�ǿյ�
					</div>
					</c:if>
					<c:if test="${!empty list}">
					<div id="btn_list" class="clearfix">
						<ul class="clearfix">						
							<li><a href="${pageContext.request.contextPath}/" class="btn btn-default blue">��������</a></li>
							<li><a href="${pageContext.request.contextPath}/market/cart/clear" class="btn btn-default blue" onclick="return confirm('ȷ��Ҫ��չ��ﳵ�ڵ���Ʒ��');">��չ��ﳵ</a></li>
							<li><a href="javascript:void(0);" id="batch_del" class="btn btn-default gray_cart">ɾ��</a></li>
						</ul>
					</div>
					<div id="title_list">
						<table class="tableStyle01" width="1170">
							<tr>
								<th width="440">��Ʒ��Ϣ</th>
								<th width="110">���ۣ�Ԫ��</th>
								<th width="110">�������</th>
								<th width="110">�ɹ�����</th>
								<th width="110">��Ʒ״̬</th>
								<th width="110">�ܼۣ�Ԫ��</th>
								<th width="100">�Ա�״̬</th>
								<th width="80">����</th>
							</tr>
						</table>
					</div>
					<c:set value="0" var="sup"></c:set>
					<c:forEach var="item" items="${list}" varStatus="sta">
						<c:if test="${sup != item.supId}">
							<c:set value="${item.supId}" var="sup"></c:set>
							<c:if test="${sta.index > 0}">
								</table>
								<!--.item_info-->
							</div>
							</c:if>
							<div class="item_info" id="sup_item_${sup}">
								<div class="clearfix">
									<form class="supplier">
										<input value="${sup}" name="checkbox" type="checkbox" id="sup_chx_${sup}"> <label for="checkbox" class="font-color-red">��Ӧ�̣�${dataCache.getSupplierName(sup)}</label>
									</form>
									<div class="total">
										�ϼƣ�<span class="font-color-red" id="sub_total_${sup}">0</span>
									</div>
								</div>
								<table class="tableStyle02" width="1170">
						</c:if>
						
						
							<tr id="row_${item.supId}_${item.supGoodsId}" data-sid="${item.supId}" data-gid="${item.supGoodsId}">
								<td width="440">
									<div class="product_info">
										<input type="checkbox" value="${item.supGoodsId}" id="sup_goods_${item.supId}_${item.supGoodsId}">
										<c:if test="${item.supType == 1}">
										<img class="img_bor" src="${pageContext.request.contextPath}${item.imagePath == null ? '/static/img/img-profession.jpg' : item.imagePath}" alt="" width="55px" height="55px">
										</c:if>
										<c:if test="${item.supType == 0}">
										<img class="img_bor" src="${item.imagePath}" alt="" width="55px" height="55px">
										</c:if>
										
										<a id="goods_name_${item.supId}_${item.supGoodsId}" style="display: inline-block; word-break: break-all; width: 320px;" href="${pageContext.request.contextPath}/market/goods/show?sid=${item.supId}&gid=${item.supGoodsId}">${fn:escapeXml(item.goodsName)}<c:if test="${item.supType == '1'}">(${fn:escapeXml(item.goodsModel)})</c:if></a>
									</div>
								</td>
								<td width="110" class="font-color-red"><strong id="goods_price_${item.supId}_${item.supGoodsId}"><fmt:formatNumber value="${item.agreePrice}" pattern="#0.00#"></fmt:formatNumber></strong></td>
								<td width="110" id="goods_stock_${item.supId}_${item.supGoodsId}">
								<c:choose>
									<c:when test="${item.supId == 2}">${item.stock < 0 ? 9999 : item.stock}</c:when>
									<c:otherwise>${item.stock < 0 ? 0 : item.stock}</c:otherwise>
								</c:choose>
								</td>
								
								<td>
                                  <div class="input-group input-group-num">
                                    <span class="input-group-btn"><button class="btn btn-default input-group-addon btn_reduce" type="button">-</button></span>
                                    <input id="buy_num_${item.supId}_${item.supGoodsId}" class="form-control amount" type="text" max="10" min="1" value="${item.buyNum}">
                                    <span class="input-group-btn"><button class="btn btn-default input-group-addon btn_add" type="button">+</button></span>
                                  </div>
                                </td>
								<td width="110" id="goods_status_${item.supId}_${item.supGoodsId}" data-goods-status="${item.goodsStatus}">
								<c:choose>
									<c:when test="${item.goodsStatus != 1}">�¼�</c:when>
									<c:when test="${item.stock ==-1}">Ԥ��</c:when>
									<c:when test="${item.stock == 0 || item.stock < item.buyNum}">��治��</c:when>
									<c:otherwise>�л�</c:otherwise>
								</c:choose>
								</td>
								<td width="110" class="font-color-red"><strong id="goods_total_${item.supId}_${item.supGoodsId}"><fmt:formatNumber value="${item.agreePrice * item.buyNum}" pattern="#0.00#"></fmt:formatNumber></strong></td>
								<td width="100" class="font-color-gray" id="goods_compare_${item.supId}_${item.supGoodsId}" data-compare="${item.compare}">

								<c:choose>
									<c:when test="${item.compare > 0}">�ѶԱ�</c:when>
									<c:otherwise>δ�Ա�</c:otherwise>
								</c:choose>
								
								</td>
								<td width="80"><a href="javascript:void(0);" class="cart-goods-del" data-sid="${item.supId}" data-gid="${item.supGoodsId}">ɾ��</a></td>
							</tr>
						
						<c:if test="${sta.last}">
								</table>
								<!--.item_info-->
							</div>
						</c:if>
					</c:forEach>

					<div id="gather" class="clearfix">
					<!-- 
						<div class="select_all">
							<input type="checkbox"><label for="checkbox">ȫѡ</label>
						</div>
						<div class="operations">ɾ��</div>
					 -->
						<div class="preview clearfix">
							<p class="amount_sum">
								��ѡ��Ʒ<span class="sum_style" id="total_num">0</span>��
							</p>
							<p class="price_sum">
								�ϼƣ�<span class="sum_style" id="total_price">��0.00</span>
							</p>
						</div>
						<div class="orders">
							<img src="${pageContext.request.contextPath}/static/img/cart/btn-orders.gif" alt="���ɶ���" style="cursor:pointer;" id="cart_checkout">
						</div>
						<!--#gather-->
					</div>
					</c:if>
					<!--#cart_main-->
				</div>
				<!--.inner-->
			</div>
			<!--#contents-->
		</div>
		<jsp:include page="../footer.jsp" />
		<!--.page-wrapper-->
	</div>
</body>

</html>