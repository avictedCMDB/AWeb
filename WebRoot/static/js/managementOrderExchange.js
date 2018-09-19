$(document).ready(function(){
	//ȫѡ�¼�
	$('#allchecked').click(function(){
		var allcheck = $("#allchecked").is(':checked');
		$('input[name="subCheckbox"]').attr('checked',allcheck);
		getTotalText();
	});
});

function gotoSelectGoodsPage(path,order_id){
	$('#sup_goods_id').val('');
	var url = path+'/management/orderExchange/orderSelect?o='+order_id;
	var iWidth=1200;                          //�������ڵĿ���; 
    var iHeight=600;                         //�������ڵĸ߶�; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no,modal=yes');
	
}

function childCallParentMethod(){
	setTimeout("fnDelayed()",100);
}

function fnDelayed(){
	var result = $('#sup_goods_id').val();
	if(result!=null && result!='' && result!=undefined){
		var url=$('#path').val()+"/management/orderExchange/orderSelectMain?order_id="+$('#order_id').val()+"&sup_goods_id="+result;
        $.getJSON(url,function (dataJson) {
            var strHtml = getSelectedGoodsHtml(dataJson,$('#path').val());
            $("tr[id^='tr_']").each(function(){
				$(this).remove();
			});
			$('#btn_tr').after(strHtml);
			
			//Ĭ�ϱ���ȫѡ״̬
			$("#allchecked").attr('checked',true);
			$('input[name="subCheckbox"]').attr('checked',true);
			getTotalText();
        });
	}
}

function getSelectedGoodsHtml(dataJson,path){
	var strArr = new Array();
	if(dataJson!=null && dataJson!="" && dataJson !=undefined){
		$(dataJson).each(function () {
			var goodsDetailUrl = path+"/market/goods/show?sid="+this.sup_id+"&gid="+this.sup_goods_id;
			strArr.push("<tr id='tr_"+this.sup_goods_id+"'>");
				strArr.push("<td class='left_line'><input type='checkbox' name='subCheckbox' onclick='getTotalText()' value='"+this.sup_goods_id+"'></td>");
				strArr.push("<td width='77'><p class='img_pro'><a href='javascript:void(0)' onclick=\"openWindow('"+goodsDetailUrl+"')\"><img style='height: 55px;width: 55px;' src='"+this.image_path+"'/></a></p></td>");
				strArr.push("<td class='link_area'><a href='javascript:void(0)' onclick=\"openWindow('"+goodsDetailUrl+"')\">"+this.goods_name+"</a></td>");
				strArr.push("<td>"+this.buy_num_show+"</td>");
				strArr.push("<td id='totalNum_"+this.sup_goods_id+"'>"+this.buy_num+"</td>");
				strArr.push("<td id='singleOriginalPrice_"+this.sup_goods_id+"' class='price' style='display: none;'>"+Number(this.goods_price_init)+"</td>");
				strArr.push("<td id='singlePrice_"+this.sup_goods_id+"' class='price'>"+Number(this.goods_price)+"</td>");
				strArr.push("<td>");
					strArr.push("<div class='input-group input-group-num'>");
					strArr.push("<input id='num_"+this.sup_goods_id+"' class='form-control' type='number' max='10' min='1' value='0' onchange=\"changeNum('"+this.sup_goods_id+"')\">");
					strArr.push("</div>");
				strArr.push("</td>");
				strArr.push("<td id='price_"+this.sup_goods_id+"' class='price'>0</td>");
				strArr.push("<td id='priceOriginal_"+this.sup_goods_id+"' class='price' style='display: none;'>0</td>");
				strArr.push("<td><input id='reason_"+this.sup_goods_id+"' maxlength='256' class='form-control' type='text'></td>");
				strArr.push("<td class='right_line'>");
					strArr.push("<a href='javascript:void(0);' onclick=\"removeGoods('"+this.sup_goods_id+"');\">ɾ��</a>");
				strArr.push("</td>");
			strArr.push("</tr>");
	    });
	    return strArr.join("");
    }else{
    	return "";
    }
}

function changeNum(sup_goods_id){
	var num = $("#num_"+sup_goods_id).val();
	if(num==null || num=="" || num==undefined || num<0){
		$("#num_"+sup_goods_id).val('0');
	}else{
		var totalNum = $('#totalNum_'+sup_goods_id).html();
		if(Number(totalNum)<Number(num)){//�����ɻ�������ʱ��ֵ����Ϊmax
			$("#num_"+sup_goods_id).val(Number(totalNum));
		}
		var totalPrice = $('#singlePrice_'+sup_goods_id).html() * $('#num_'+sup_goods_id).val();
		$('#price_'+sup_goods_id).html(totalPrice.toFixed(2));
		var totalOriginalPrice = $('#singleOriginalPrice_'+sup_goods_id).html() * $('#num_'+sup_goods_id).val();
		$('#priceOriginal_'+sup_goods_id).html(totalOriginalPrice.toFixed(2));
	}
	getTotalText();
}

function removeGoods(sup_goods_id){
	$('#tr_'+sup_goods_id).remove();
	getTotalText();
}

//���㻻�����������ܽ��
function getTotalText(){
	var checkObj = $('input:checkbox[name=subCheckbox]:checked');
	var exchange_amount = 0;
	var exchange_price = 0;
	var exchange_price_o = 0;
	checkObj.each(function(i){
		var goodsId = $(this).val();
		exchange_amount += Number($('#num_'+goodsId).val());
		exchange_price += Number($('#price_'+goodsId).html());//������
		exchange_price_o += Number($('#priceOriginal_'+goodsId).html());//������
	});
	$('#hhzsl').html(exchange_amount);
	$('#hhzje').html(exchange_price.toFixed(2));
	$('#hhzje_o').html(exchange_price_o.toFixed(2));
}

function doSave(path){
	var customerArray = new Array();
	var checkObj = $('input:checkbox[name=subCheckbox]:checked');
	checkObj.each(function(i){
		var goodsId = $(this).val();
		if(Number($("#num_"+goodsId).val())>0){
			customerArray.push({sup_goods_id: goodsId, buy_num: $("#num_"+goodsId).val(), exchange_reason: $("#reason_"+goodsId).val()});
		}
	});
	
	if(checkObj.length==0 || $('#hhzsl').html()=='0'){
		alert('����ѡ�񻻻���Ʒ����д�������������ύ��');
		return;
	}
	
	var imgArray = new Array();
	var imgObj = $('input:hidden[name=hidden_path]');
	imgObj.each(function(i){
		imgArray.push(imgObj[i].value);
	});
	var imgPaths = imgArray.join(",");
	
	$.ajax({
	    url: path+"/management/orderExchange/doSave?remark="+encodeURI(encodeURI($('#remark').val()))
	    	+"&order_id="+$('#order_id').val()+"&sup_id="+$('#sup_id').val()
	    	+"&exchange_amount="+$('#hhzsl').html()+"&exchange_price="+$('#hhzje').html()
	    	+"&imgCount="+$('#realCount').val()+"&imgPaths="+imgPaths+"&exchange_price_init="+$('#hhzje_o').html(),
	    type: "POST",
	    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
	    dataType:"json",
	    data: JSON.stringify(customerArray),    //��Json�������л���Json�ַ�����JSON.stringify()ԭ��̬����
	    success: function(data){
	    	if(data.result=='ok'){
	    		window.location.href=path+"/management/order";
	    	}else if(data.result=='failed'){
	    		alert(data.msg);
	    	}else{
	    		alert('ϵͳæ�����Ժ����ԡ�');
	    	}
	    },
	    error: function(res){
            alert('ϵͳæ�����Ժ����ԡ�');
        }
	});
}

function openWindow(path){
	window.open(path);
}