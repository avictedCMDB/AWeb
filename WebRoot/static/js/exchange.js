$(document).ready(function(){
	var images = $("a[name='image_show']");
	images.each(function(index){
		$("#image_show"+index).imgbox();//���ذ�ͼƬ�Ŵ�Ч��
	 });
});
function searchByCode(status){
	$("#searchExchangeStatus").val(status);
	$('#allStatusLi').find('li').removeClass('active');
	if(status==""){
		$("#allLi").addClass("active");
	}else if(status=='0'){
		$("#li0").addClass("active");
	}else if(status=='1'){
		$("#li1").addClass("active");
	}else if(status=='2'){
		$("#li2").addClass("active");
	}
	searchExchangeOrders();
}

function selCode(){
	$('#allStatusLi').find('li').removeClass('active');
	if($("#selExchangeStatus").val()==""){
		$("#allLi").addClass("active");
	}else if($("#selExchangeStatus").val()=="0"){
		$("#li0").addClass("active");
	}else if($("#selExchangeStatus").val()=="1"){
		$("#li1").addClass("active");
	}else if($("#selExchangeStatus").val()=="2"){
		$("#li2").addClass("active");
	}
	$("#searchExchangeStatus").val($("#selExchangeStatus").val());
}

function checkAll(){
	if($("#checkAll").is(':checked') == true){
		$(":checkbox").prop("checked",true);
	}else{
		$(":checkbox").removeAttr("checked");
	}
}


function searchExchangeOrders(){
	var path = $("#path").val();
	document.getElementById("exchangeForm").action=path+"/management/exchange";
	document.getElementById("exchangeForm").submit();
}


function delExchangeOrders(){
	var path = $("#path").val();
	var exchangeIDs = "";
	var index = $("input:checkbox[name='checkExchangeIDs']:checked").size()-1;
	$("input:checkbox[name='checkExchangeIDs']:checked").each(function(i) { // ������ѡ��
		if(i<index){
			exchangeIDs += $(this).val()+",";  // ÿһ����ѡ�����ֵ
		}else{
			exchangeIDs += $(this).val();
		}
	});
	window.location.href = path+"/management/exchange/del/"+exchangeIDs;
}

function closeExchange(){
	var path = $("#path").val();
	window.location.href = path+"/management/exchange";
}

function orderExchangeSend(){
	var expressType = $('input[name="expressType"]:checked').val();
	if(expressType=="1"){
		if($("#exchangeExpressName").val()=="" || $("#exchangeExpressName").val()==null){
			alert("�������ݹ�˾���ƣ�");
			return;
		}
		if($("#exchangeExpressCode").val()=="" || $("#exchangeExpressCode").val()==null){
			alert("�������ݵ��ţ�");
			return;
		}		
	}
	var path = $("#path").val();
	document.getElementById("updateExpressForm").action = path+"/management/exchange/sendOrderExchange";
	document.getElementById("updateExpressForm").submit();
}

function exchangeConfirm(exchangeID){
	var path = $("#path").val();
	if(confirm("��ȷ���Ƿ��ջ���")){
		window.location.href=path+"/management/exchange/confirmation/"+exchangeID;
	}
}

function clearSearch(){
	$("#startTime").val("");
	$("#endTime").val("");
	$("#searchExchangeID").val("");
	$("#searchSupName").val("");
	$("#searchOrderID").val("");
	$('#selExchangeStatus option:eq(0)').attr('selected','selected');
	$("#searchExchangeStatus").val("");
	$('#allStatusLi').find('li').removeClass('active');
	$('#allLi').addClass('active');
}

function expressHide(){
	$("#expressNameDiv").hide();
	$("#expressCodeDiv").hide();
	$("#exchangeExpressName").val("");
	$("#exchangeExpressCode").val("");
}

function expressShow(){
	$("#expressNameDiv").show();
	$("#expressCodeDiv").show();
}

function services(exchangeID){
	var path = $("#path").val();
	var exchangeOrRefound = "1";
	var url = path+"/management/services/exchangeServices?typeID="+exchangeID+"&exchangeOrRefound="+exchangeOrRefound;
	var iWidth=850;                          //�������ڵĿ��; 
	var iHeight=600;                         //�������ڵĸ߶�; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
}