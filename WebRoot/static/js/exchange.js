$(document).ready(function(){
	var images = $("a[name='image_show']");
	images.each(function(index){
		$("#image_show"+index).imgbox();//加载绑定图片放大效果
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
	$("input:checkbox[name='checkExchangeIDs']:checked").each(function(i) { // 遍历多选框
		if(i<index){
			exchangeIDs += $(this).val()+",";  // 每一个被选中项的值
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
			alert("请输入快递公司名称！");
			return;
		}
		if($("#exchangeExpressCode").val()=="" || $("#exchangeExpressCode").val()==null){
			alert("请输入快递单号！");
			return;
		}		
	}
	var path = $("#path").val();
	document.getElementById("updateExpressForm").action = path+"/management/exchange/sendOrderExchange";
	document.getElementById("updateExpressForm").submit();
}

function exchangeConfirm(exchangeID){
	var path = $("#path").val();
	if(confirm("请确认是否收货？")){
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
	var iWidth=850;                          //弹出窗口的宽度; 
	var iHeight=600;                         //弹出窗口的高度; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
}