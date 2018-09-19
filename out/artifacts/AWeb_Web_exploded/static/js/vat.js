function addVatSpecialInfo(){
	$("#vatSpecilDiv").show();
}

function cancle(){
	if($("#id").val()!=""){
		$("#id").val("");
		$("#companyName").val("");
		$("#taxpayerCode").val("");
		$("#registerPath").val("");
		$("#registerTel").val("");
		$("#bankName").val("");
		$("#bankAccount").val("");
	}
	$("#vatSpecilDiv").hide();
}

function addVat(){
	var path =$("#path").val();
	if($("#companyName").val()==""){
		alert("�����뵥λ���ƣ�");
		return;
	}
	if($("#taxpayerCode").val()==""){
		alert("��������˰��ʶ���룡");
		return;
	}
	if(!isNumberOrLetter($("#taxpayerCode").val())){
		alert("��˰��ʶ�����ʽ����");
		return;
	}
	if($("#registerPath").val()==""){
		alert("������ע���ַ��");
		return;
	}
	if($("#registerTel").val()==""){
		alert("������ע��绰��");
		return;
	}
	if(!isPhoneNo($("#registerTel").val())){
		alert("��������ȷ�绰��");
		return;
	}
	if($("#bankName").val()==""){
		alert("�����뿪�����У�");
		return;
	}
	if($("#bankAccount").val()==""){
		alert("�����������˻���");
		return;
	}
	if(!isNumber( $.trim($("#bankAccount").val()))){
		alert("�����˻���ʽ����");
		return;
	}
	if($("#id").val()==""){
		document.getElementById("vatSpecialForm").action=path+"/management/vat/add";
	}else{
		document.getElementById("vatSpecialForm").action=path+"/management/vat/update";
	}
	document.getElementById("vatSpecialForm").submit();
}

function delVatSpecialInfo(){
	var path =$("#path").val();
	window.location.href=path+"/management/vat/del/"+$("#id").val();
}
function help(which){
	if($("#helpDiv"+which).is(":hidden")){
		$("#helpDiv"+which).show();
	} else{
		$("#helpDiv"+which).hide();
	}
}

function hideHelp(which){
	$("#helpDiv"+which).hide();
}

function ajaxFileUpload(beforePath,fileID,imgDivID,type) {  
	var path = $("#path").val();
	$.ajaxFileUpload({  
        url: path + '/management/vat/uploadPic', //�������������ַ  
        secureuri: false, //�Ƿ���Ҫ��ȫЭ�飬һ������Ϊfalse  
        fileElementId: fileID, //�ļ��ϴ����ID  
        dataType: 'json', //����ֵ���� һ������Ϊjson  
        enctype:'multipart/form-data',//ע��һ��Ҫ�иò���  
        success: function (data, status)  //�������ɹ���Ӧ��������  
        {  
        	data = data.replace(/<pre.*?>/g, '');  //ajaxFileUpload��Է�������Ӧ������text���ݼ���<pre style="....">text</pre>ǰ��׺  
        	data = data.replace(/<PRE.*?>/g, '');  
        	data = data.replace("<PRE>", '');  
        	data = data.replace("</PRE>", '');  
        	data = data.replace("<pre>", '');  
        	data = data.replace("</pre>", ''); 
        	var pos=data.lastIndexOf("/")+1; 
        	var picName = data.substring(pos);
        	//����DATA
        	var imgDiv = $("#"+imgDivID);
        	//var subCount = $("#inp"+type+"").val();
        	var countDiv = parseInt($("#inp"+type+"").val())+1;
        	$("#inp"+type+"").val(parseInt($("#inp"+type+"").val())+1);
        	var contentDiv = $("<div id='contentDiv"+type+"_"+countDiv+"'></div>");
        	var img = $("<img height='100px' width='100px' src='"+beforePath+data+"'/>");
        	var imgSpan = $("<a href='javascript:void(0);' onclick=\"delImage('contentDiv"+type+"_"+countDiv+"','"+picName+"','"+type+"');\">X</a>");
        	var valueInp = $("<input type='hidden' value='"+picName+"' name='imageSaveInp"+type+"'/>");
        	contentDiv.appendTo(imgDiv);
        	img.appendTo(contentDiv);
        	imgSpan.appendTo(contentDiv);
        	valueInp.appendTo(contentDiv);
        },  
        error: function (data, status, e)//��������Ӧʧ�ܴ�������  
        {  
        }  
    });
}  

function delImage(contentDiv,picName){
	debugger;
	var path = $("#path").val();
	var pos=picName.lastIndexOf("/");
	if(pos>0){
		picName = picName.substring(pos);
	}
	$.ajax({
	     type: 'POST',
	     url: path+"/management/vat/deletePic",
	     dataType: 'json',
	     data:{  
	    	 fileName : picName  
	     },  
	     success: function(data) {  
	    	 debugger;
	    	if(data.status =="success" ){  
	    		$("#"+contentDiv).remove();
	    	}  
	     },
	     error : function() {  
	    	 alert("�쳣��");  
	     } 
	});
}

function saveVatPic(){
	var path = $("#path").val();
	var inpPath1 = $("input[name='imageSaveInp1']");
    var picPath1 = new Array();
    for(var i=0;i<inpPath1.length;i++){
    	var pos=inpPath1[i].value.lastIndexOf("/");
    	if(pos>0){
    		picPath1[i] = inpPath1[i].value.substring(pos+1);
    	}else{
    		picPath1[i] = inpPath1[i].value;
    	}
    }
	var inpPath2 = $("input[name='imageSaveInp2']");
	var picPath2 = new Array();
    for(var i=0;i<inpPath2.length;i++){
    	var pos=inpPath2[i].value.lastIndexOf("/");
    	if(pos>0){
    		picPath2[i] = inpPath2[i].value.substring(pos+1);
    	}else{
    		picPath2[i] = inpPath2[i].value;
    	}
    }
	var inpPath3 = $("input[name='imageSaveInp3']");
	var picPath3 = new Array();
    for(var i=0;i<inpPath3.length;i++){
    	var pos=inpPath3[i].value.lastIndexOf("/");
    	if(pos>0){
    		picPath3[i] = inpPath3[i].value.substring(pos+1);
    	}else{
    		picPath3[i] = inpPath3[i].value;
    	}
    }
	var businessID = $("#businessIDInp").val();
	console.log(picPath1+"--"+picPath2+"--"+picPath3);
	$.ajax({
	     type: 'POST',
	     url: path+"/management/vat/savePic?businessID="+businessID+"&picPath1="+picPath1+"&picPath2="+picPath2+"&picPath3="+picPath3,
	     dataType: 'json',
	     data:{  
	     },  
	     success: function(data) {  
	    	if(data.result =="success" ){ 
	    		alert("����ɹ�������ˣ�");
	    		window.location.href=path+"/management/vat";
	    	}  
	     },
	     error : function() {  
	    	 alert("�쳣�������������ϵ��վ����Ա��");  
	     } 
	});
	//window.location.href=path+"/management/vat/savePic?businessID="+businessID+"&picPath1="+picPath1+"&picPath2="+picPath2+"&picPath3="+picPath3;
}