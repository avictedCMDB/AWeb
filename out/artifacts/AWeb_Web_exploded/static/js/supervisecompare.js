function removeSupGoods(index){
	var path = $("#path").val();
	if(index==1){
		$("#supOneID").val("");
		$("#supGoodsOneID").val("");
		$("#supGoodsOneImagePath").val("");
		$("#supGoodsOneGoodsName").val("");
		$("#supGoodsOneAgreePrice").val("");
		$("#supGoodsOneBrandName").val("");
		$("#supGoodsOneProductArea").val("");
	}else if(index==2){
		$("#supTwoID").val("");
		$("#supGoodsTwoID").val("");
		$("#supGoodsTwoImagePath").val("");
		$("#supGoodsTwoGoodsName").val("");
		$("#supGoodsTwoAgreePrice").val("");
		$("#supGoodsTwoBrandName").val("");
		$("#supGoodsTwoProductArea").val("");
	}else if(index==3){
		$("#supThreeID").val("");
		$("#supGoodsThreeID").val("");
		$("#supGoodsThreeImagePath").val("");
		$("#supGoodsThreeGoodsName").val("");
		$("#supGoodsThreeAgreePrice").val("");
		$("#supGoodsThreeBrandName").val("");
		$("#supGoodsThreeProductArea").val("");
	}else if(index==4){
		$("#supFourID").val("");
		$("#supGoodsFourID").val("");
		$("#supGoodsFourImagePath").val("");
		$("#supGoodsFourGoodsName").val("");
		$("#supGoodsFourAgreePrice").val("");
		$("#supGoodsFourBrandName").val("");
		$("#supGoodsFourProductArea").val("");
	}
	document.getElementById("commitForm").action=path+"/supervise/compare/detail";
	document.getElementById("commitForm").submit();
}

//���ӹ��ﳵ
function addCart(){
	var path = $("#path").val();
	var goodsCount=0;
	if	($("#supGoodsOneID").val()!=""){
		goodsCount++;
	}
	if	($("#supGoodsTwoID").val()!=""){
		goodsCount++;
	}
	if	($("#supGoodsThreeID").val()!=""){
		goodsCount++;
	}
	if	($("#supGoodsFourID").val()!=""){
		goodsCount++;
	}
	if(goodsCount<3){
		alert("��������������Ʒ");
		return;
	}
	var reasonRadiosinline = $('input[name="reasonRadiosinline"]:checked').val();
	if(reasonRadiosinline==""||typeof(reasonRadiosinline) == "undefined"){
		alert("������ɹ�����");
		return;
	}
	var chooseGoodsIndex = $("input[name='optionsRadiosinline']:checked").val();
	if(chooseGoodsIndex==""||typeof(chooseGoodsIndex) == "undefined"){
		alert("��ѡ��ѡ����Ʒ");
		return;
	}
	$("#remark").val($('#remarkTRA').val());
	var reason = "";
	$('input:checkbox[name=reasonRadiosinline]:checked').each(function(i){
	       if(0==i){
	    	   reason = $(this).val();
	       }else{
	    	   reason += (","+$(this).val());
	       }
	});
	$("#ProCheckedReason").val(reason);
	$("#chooseGoodsIndex").val(chooseGoodsIndex);
	document.getElementById("commitForm").action=path+"/supervise/compare/addCart";
	document.getElementById("commitForm").submit();
}

function cancle(){
	window.location.href=$("#returnUrl").val();
}
function cancleToList(){
	var path = $("#path").val();
	window.location.href = "/AWeb/"+$("#returnUrl").val();
}
function search(){
	var path = $("#path").val();
	document.getElementById("managementCompareForm").action=path+"/supervise/compare";
	document.getElementById("managementCompareForm").submit();
}
function clear(){
	$("#startTime").val("");
	$("#endTime").val("");
	$("#searchGoodsName").val("");
	$("#searchSupName").val("");
}
function updateProductCompare(compareID){
	var path = $("#path").val();
	window.location.href = path+"/supervise/compare/update/"+compareID;
}

function deleteProductCompare(compareID){
	var path = $("#path").val();
	window.location.href = path+"/supervise/compare/del/"+compareID;
}

function downLoadPDF(){
	var path = $("#path").val();
	var chooseGoodsIndex = $("input[name='optionsRadiosinline']:checked").val();
	$("#remark").val($('#remarkTRA').val());
	$("#chooseGoodsIndex").val(chooseGoodsIndex);
	
	if(chooseGoodsIndex == "undefined" || chooseGoodsIndex == null){
		alert("��ѡ����Ʒ��");
		return;
	}
	
	if($('input[name="reasonRadiosinline"]:checked').val() == "undefined" || $('input[name="reasonRadiosinline"]:checked').val() == null){
		alert("��ѡ��ɹ����ɣ�");
		return;
	}
	var reason = "";
	$('input:checkbox[name=reasonRadiosinline]:checked').each(function(i){
	       if(0==i){
	    	   reason = $(this).val();
	       }else{
	    	   reason += (","+$(this).val());
	       }
	});
	$("#ProCheckedReason").val(reason);
	document.getElementById("commitForm").action=path+"/supervise/compare/downloadPDF";
	document.getElementById("commitForm").submit();
}