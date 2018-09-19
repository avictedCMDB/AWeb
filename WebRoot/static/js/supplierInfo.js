function query(action){
	
	document.getElementById("supplierGoodsInfoQueryForm").action=action;
	document.getElementById("supplierGoodsInfoQueryForm").submit();
	
}
function updateGoods(action){
//	var img = $('#updateImg').attr('src');
	
	if(isNaN($("#salePrice").val())){
		alert('��Ʒ�ۼ�ֻ��Ϊ����,���������룡');
		return;
	}
	var img = $('input:hidden[name=hidden_path]').val();
	if (img==null || img == '') {
		img = $('#imgPath').val()+"/static/img/img-profession.jpg";
	}else{
		img = $('#imgPath').val()+img;
	}
	$.ajax({

	     type: 'POST',

	     url: action ,

	    data: {
			'supGoodsId' : $('#supGoodsId').val(),
			'goodsName' : $('#goodsName').val(),
			'goodsDesc' : $('#goodsDesc').val(),
			'goodsParam' : $('#goodsParam').val(),
			'brandName' : $('#brandName').val(),
			'goodsModel' : $('#goodsModel').val(),
			'goodsWeight' : $('#goodsWeight').val(),
			'salePrice' : $('#salePrice').val(),
			'productArea' : $('#productArea').val(),
			'goodsUnit' : $('#goodsUnit').val(),
			'goodsService' : $('#goodsService').val(),
			'goodsCode' : $('#goodsCode').val(),
			'goodsUrl' : img
		}  ,

	    success: function (data){
//	    	window.returnValue = "reload";
	    	window.opener.reloadWindows(null);
	    	window.close();
	    } ,
	    contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	    dataType: 'json',
	    
	    cache:false,
	});
}
function deleteGoods(action,goodsStatus){
	if (goodsStatus == 1) {
		alert('���ϼܵ���Ʒ����ɾ���������¼ܺ��ٳ��ԣ�');
		return;
	}
	if(confirm("�Ƿ�ɾ��������¼��")){
		window.location.href = action;
	}
}
function queryStoreNum(action){
	$.ajax({

	     type: 'POST',

	     url: action ,

		    data : {
			'area' : $('#area').val(),
			'areaSub' : $('#areaSub').val(),
			'areaLast' : $('#areaLast').val(),
			'supGoodsId' : $('#supGoodsId').val()
		} ,

	    success: function (data){
	    	for(var key in data){
	    		$("#spanStore").html(data[key]);
	    	}
	    } ,

	    dataType: 'json',
	    
	    cache:false,
	});
}
function showDetailed(index){
	$("#showDetailed01").removeClass("select"); 
	$("#showDetailed02").removeClass("select"); 
	$("#showDetailed03").removeClass("select"); 
	if (index == '01') {
		$("#tab02").hide();
		$("#tab03").hide();
	} else if (index == '02') {
		$("#tab01").hide();
		$("#tab03").hide();
	} else if (index == '03') {
		$("#tab01").hide();
		$("#tab02").hide();
	}
	$("#tab"+index).show();
	$("#showDetailed"+index).addClass("select"); 
}
function uploadFiles(action){
	if ($("#uploadFile").val() == '') {
		alert('��ѡ��Ҫ�ϴ����ļ�!');
		return;
	}
	$('#uploadButton').attr('disabled',"true");
	$('#supplierGoodsInfoQueryForm').attr('enctype', 'multipart/form-data'); 
	document.getElementById("supplierGoodsInfoQueryForm").action=action;
	document.getElementById("supplierGoodsInfoQueryForm").submit();
}
