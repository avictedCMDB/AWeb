

function cancle(){
	window.location.href = "/AWeb/management/invoice";
}

function chooseInvoiceFlg(type){
	debugger;
	$("#invoiceContentUL").find('li').removeClass();
	if(type==0){
		$("#invoiceContent").val($("#invoiceContent0").html());
		$("#invoiceFlag").val("0");
		$("#invoiceContent0").addClass("active");
		$("#invoiceContent1").addClass("disabled btn");
		$("#invoiceContent2").addClass("disabled btn");
		$("#invoiceContent3").addClass("disabled btn");
	}else if(type==1){
		$("#invoiceFlag").val("1");
		$("#invoiceContent").val($("#invoiceContent1").html());
		$("#invoiceContent1").addClass("active");
		$("#invoiceContent0").addClass("disabled btn");
		$("#invoiceContent2").addClass("disabled btn");
		$("#invoiceContent3").addClass("disabled btn");
	}else if(type==2){
		$("#invoiceFlag").val("2");
		$("#invoiceContent").val($("#invoiceContent2").html());
		$("invoiceContent2").addClass("active");
		$("invoiceContent1").addClass("disabled btn");
		$("invoiceContent0").addClass("disabled btn");
		$("invoiceContent3").addClass("disabled btn");
	}else if(type==3){
		$("#invoiceFlag").val("3");
		$("#invoiceContent").val($("#invoiceContent3").html());
		$("#invoiceContent3").addClass("active");
		$("#invoiceContent1").addClass("disabled btn");
		$("#invoiceContent2").addClass("disabled btn");
		$("#invoiceContent0").addClass("disabled btn");
	}
}

function saveInvoice(action){
	if($("#setDefaultCB").is(':checked') == true){
		$("#ifDefault").val("1");
	}else{
		$("#ifDefault").val("0");
	}
	if($("#invoiceNum").val()==""){
		alert("请输入纳税人识别号！");
		return;
	}	
	if($("#companyName").val()==""){
		alert("请输入发票抬头！");
		return;
	}
	if($("#invoiceContent").val()==""){
		alert("请选择发票内容！");
		return;
	}
	 var re =  /^[0-9a-zA-Z]*$/g;  //判断字符串是否为数字和字母组合     //判断正整数 /^[1-9]+[0-9]*]*$/    
     if (!re.test($("#invoiceNum").val()))  
    {  
    	 alert("纳税人识别号只能输入数字字母！");
        return ;  
     }
	
	if($("#invoiceID").val()==""){
		document.getElementById("editInvoiceForm").action=action+"/management/invoice/add";
		document.getElementById("editInvoiceForm").submit();
	}else{
		document.getElementById("editInvoiceForm").action=action+"/management/invoice/update?invoiceID="+$("#invoiceID").val();
		document.getElementById("editInvoiceForm").submit();
	}
}