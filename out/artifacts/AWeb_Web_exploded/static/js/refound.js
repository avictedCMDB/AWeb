$(document).ready(function(){
	var images = $("a[name='image_show']");
	images.each(function(index){
		$("#image_show"+index).imgbox();//加载绑定图片放大效果
	 });
	$("#expressNameDiv").hide();
	$("#expressCodeDiv").hide();
});
function searchByCode(status){
	$("#searchRefoundStatus").val(status);
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
	searchRefoundOrders();
}

function selCode(){
	$('#allStatusLi').find('li').removeClass('active');
	if($("#selRefoundStatus").val()==""){
		$("#allLi").addClass("active");
	}else if($("#selRefoundStatus").val()=="0"){
		$("#li0").addClass("active");
	}else if($("#selRefoundStatus").val()=="1"){
		$("#li1").addClass("active");
	}else if($("#selRefoundStatus").val()=="2"){
		$("#li2").addClass("active");
	}
	$("#searchRefoundStatus").val($("#selRefoundStatus").val());
}

function checkAll(){
	if($("#checkAll").is(':checked') == true){
		$(":checkbox").prop("checked",true);
	}else{
		$(":checkbox").removeAttr("checked");
	}
}


function searchRefoundOrders(){
	var path = $("#path").val();
	document.getElementById("refoundForm").action=path+"/management/refound";
	document.getElementById("refoundForm").submit();
}


function delRefoundOrders(){
	var path = $("#path").val();
	var refoundIDs = "";
	var index = $("input:checkbox[name='checkRefoundIDs']:checked").size()-1;
	$("input:checkbox[name='checkRefoundIDs']:checked").each(function(i) { // 遍历多选框
		if(i<index){
			refoundIDs += $(this).val()+",";  // 每一个被选中项的值
		}else{
			refoundIDs += $(this).val();
		}
	});
	window.location.href = path+"/management/refound/del/"+refoundIDs;
}

function closeRefound(){
	var path = $("#path").val();
	window.location.href = path+"/management/refound";
}

function orderRefoundSend(){
	var expressType = $('input[name="expressType"]:checked').val();
	if(expressType=="1"){
		if($("#refoundExpressName").val()=="" || $("#refoundExpressName").val()==null){
			alert("请输入快递公司名称！");
			return;
		}
		if($("#refoundExpressCode").val()=="" || $("#refoundExpressCode").val()==null){
			alert("请输入快递单号！");
			return;
		}
	}
	
	var path = $("#path").val();
	document.getElementById("updateExpressForm").action = path+"/management/refound/sendOrderRefound";
	document.getElementById("updateExpressForm").submit();
}

function clearSearch(){
	$("#startTime").val("");
	$("#endTime").val("");
	$("#searchRefoundID").val("");
	$("#searchSupName").val("");
	$("#searchOrderID").val("");
	$('#selRefoundStatus option:eq(0)').attr('selected','selected');
	$("#searchRefoundStatus").val("");
	$('#allStatusLi').find('li').removeClass('active');
	$('#allLi').addClass('active');
}
function expressHide(){
	$("#expressNameDiv").hide();
	$("#expressCodeDiv").hide();
	$("#refoundExpressName").val("");
	$("#refoundExpressCode").val("");
}

function expressShow(){
	$("#expressNameDiv").show();
	$("#expressCodeDiv").show();
}

function services(refoundID){
	var path = $("#path").val();
	var exchangeOrRefound = "2";
	var url = path+"/management/services/refoundServices?typeID="+refoundID+"&exchangeOrRefound="+exchangeOrRefound;;
	var iWidth=850;                          //弹出窗口的宽度; 
	var iHeight=600;                         //弹出窗口的高度; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no');
}