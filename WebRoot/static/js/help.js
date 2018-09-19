function search(){
	var path = $("#path").val();
	document.getElementById("helpForm").action=path+"/supervise/help";
	document.getElementById("helpForm").submit();
}

function tab(witch){
	if(witch==0){
		$("#fileDiv").hide();
		$("#supQuestionTypeDiv").hide();
		$("#contextDiv").show();
		$("#questionTypeDiv").show();
		$("#buyerQuestionTypeDiv").show();
		$("#fileName").val("");
		$("#filePath").val("");
		$("#file_name_tech").val("");
		$("#photoCover").val("");
	}else if(witch==1){
		$("#fileDiv").hide();
		$("#contextDiv").show();
		$("#questionTypeDiv").show();
		$("#buyerQuestionTypeDiv").hide();
		$("#supQuestionTypeDiv").show();
		$("#fileName").val("");
		$("#filePath").val("");
		$("#file_name_tech").val("");
		$("#photoCover").val("");
	}else{
		$("#fileDiv").show();
		$("#contextDiv").hide();
		$("#questionTypeDiv").hide();
		$("#buyerQuestionTypeDiv").hide();
		$("#supQuestionTypeDiv").hide();
		$("#context").val("");
	}
}

function addHelp(){
	$("#modalTitle").html("��Ӱ�������");
	$("#addOrUpdate").val("1");
	$("#id").val("");
	$("#fileName").val("");
	$("#filePath").val("");
	$("#helpTypeBuyer").val("");
	$("#helpTypeSup").val("");
	$("#title").val("");
	$("#context").val("");
	$("#file_name_tech").val("");
	$("#photoCover").val("");
//	$("input:radio[value='0']").attr('checked','true');
	$("input:radio[name='type'][value='0']").prop("checked", "checked");
	$("#delFileDiv").hide();
	$("#templet01").show();
}

function updateHelp(id){
	$("#modalTitle").html("�޸İ�������");
	$("#addOrUpdate").val("2");
	var path = $("#path").val();
	$.ajax({
        type: "POST",
        url: path+"/supervise/help/getHelp",
        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
        data: {
        	id:id
        },
        success: function(data) {
        	$("#id").val(data.id);
        	$("#title").val(data.title);
        	if(data.type=='0'){
        		$("#context").val(data.context);
        		$("#questionType1").find("option[value='"+data.helpTypeBuyer+"']").attr("selected",true); 
//        		$("input[name='type']").get(0).checked=true; 
        		$("input:radio[name='type'][value='0']").prop("checked", "checked");
        		$("#fileDiv").hide();
        		$("#contextDiv").show();
        		$("#buyerQuestionTypeDiv").show();
        		$("#buyerQuestionTypeDiv").show();
        		$("#supQuestionTypeDiv").hide();
        		
        	}else if(data.type=='1'){
        		$("#context").val(data.context);
        		$("#questionType2").find("option[value='"+data.helpTypeSup+"']").attr("selected",true); 
//        		$("input[name='type']").get(1).checked=true; 
        		$("input:radio[name='type'][value='1']").prop("checked", "checked");
        		$("#fileDiv").hide();
        		$("#contextDiv").show();
        		$("#supQuestionTypeDiv").show();
        		$("#buyerQuestionTypeDiv").hide();
        		$("#supQuestionTypeDiv").show();
        	}else{
        		$("#fileName").val(data.fileName);
        		$("#filePath").val(data.filePath);
        		$("#file_name_tech").val(data.fileName);
//        		$("input[name='type']").get(2).checked=true; 
        		$("input:radio[name='type'][value='2']").prop("checked", "checked");
        		$("#fileName").val(data.fileName);
        		$("#filePath").val(data.filePath);
        		$("#photoCover").val(data.fileName);
        		$("#fileDiv").show();
        		$("#contextDiv").hide();
        		$("#questionTypeDiv").hide();
        		$("#buyerQuestionTypeDiv").hide();
        		$("#supQuestionTypeDiv").hide();
        	}
        }
    });
}

function save(){
	var path = $("#path").val();
	var type = $("input[type='radio']:checked").val();
	var questionType;
	if(type=='0'){
		questionType = $('#questionType1 option:selected').val();
		$("#helpTypeBuyer").val(questionType);
	}else if(type == '1'){
		questionType = $('#questionType2 option:selected').val();
		$("#helpTypeSup").val(questionType);
	}
	
	
	
	document.getElementById("helpEditForm").action=path+"/supervise/help/editHelp";
	document.getElementById("helpEditForm").submit();
}

function ajaxFileUpload(fileID) {  
	var path = $("#path").val();
	var fn = $('input[id=uploadFile]').val();
	$.ajaxFileUpload({  
        url: path + '/supervise/help/uploadFile', //�������������ַ  
        secureuri: false, //�Ƿ���Ҫ��ȫЭ�飬һ������Ϊfalse  
        fileElementId: fileID, //�ļ��ϴ����ID  
        dataType: 'json', //����ֵ���� һ������Ϊjson  
        enctype:'multipart/form-data',//ע��һ��Ҫ�иò���  
        success: function (data, status)  //�������ɹ���Ӧ������  
        {  
        	data = data.replace(/<pre.*?>/g, '');  //ajaxFileUpload��Է�������Ӧ������text���ݼ���<pre style="....">text</pre>ǰ��׺  
        	data = data.replace(/<PRE.*?>/g, '');  
        	data = data.replace("<PRE>", '');  
        	data = data.replace("</PRE>", '');  
        	data = data.replace("<pre>", '');  
        	data = data.replace("</pre>", ''); 
        	var pos=fn.lastIndexOf("\\")+1; 
        	var fileName = fn.substring(pos);
        	$("#fileName").val(fileName);
        	$("#file_name_tech").val(fn);
        	$("#filePath").val(data);
        	$("#delFileDiv").show();
        	$("#templet01").hide();
        },  
        error: function (data, status, e)//��������Ӧʧ�ܴ�����  
        {  
        }  
    });
}  

function delFile() {
	$("#photoCover").val("");
	$("#uploadFile").val("");
	$("#fileName").val("");
	$("#file_name_tech").val("");
	$("#filePath").val("");
	$("#templet01").show();
	$("#delFileDiv").hide();
}
function showFileName(){
	$('#photoCover').val($('input[id=uploadFile]').val()); 
}

function delHelp(helpID){
	var title = $("#searchTitle").val();
	var context = $("#searchContext").val();;
	var type = $("#searceType").val();;
	var path = $("#path").val();
	if(confirm("��ȷ���Ƿ�ɾ����")){
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/help/del",
	        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
	        data: {
	        	id:helpID,
	        	searchTitle:title,
	        	searchContext:context,
	        	searceType:type
	        },
	        success: function(data) {
	        	if(data.result=="success"){
	        		document.getElementById("helpForm").action=path+"/supervise/help";
	        		document.getElementById("helpForm").submit();
	        	}
	        }
	    });
//		window.location.href = path+"/supervise/help/del?id="+helpID+"&searchTitle="+title+"&searchContext="+context+"&searceType="+type;
	}
}