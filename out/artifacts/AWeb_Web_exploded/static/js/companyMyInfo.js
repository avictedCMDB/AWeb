$(function(){
	if($("#regAddrProvince").val()!=""&&$("#regAddrProvince").val() != null){
		checkCity();
	}
	var ifCreditCode =$("#ifCreditCode").val();
	if (ifCreditCode == 1) {
		$("#noArea").hide();
		$("#yesArea").show();
	}else if(ifCreditCode == 2){
		$("#yesArea").hide();
		$("#noArea").show();
	}else{
		$("#noArea").hide();
		$("#yesArea").show();
	}
});


//ʡ������
function checkCity(){
		var path = $("#path").val();
        $("#regAddrCity").empty();
        var data = $("#regAddrProvince").val();
        var url=path+"/management/companyMyInfo/loadSubArea?parentId="+data+"&supID=1";
        $("#regAddrCity").append($("<option/>").text("��ѡ��").attr("value",""));
        $.getJSON(url,function (data) {
            $(data).each(function () {
            	var arseaLebelTwo = $("#arseaLebelTwo").val();
            	if(arseaLebelTwo==this.supAreaID){
            		$("#regAddrCity").append($("<option/>").text(this.supAreaName).attr("value",this.supAreaID).attr("selected", true));
            	}else{
            		$("#regAddrCity").append($("<option/>").text(this.supAreaName).attr("value",this.supAreaID));
            	}
                
            });
        });
}

function nextPage(){
	var path = $("#path").val();
	var companyName = $("#companyName").val();
	if(companyName == "" || companyName == null){
		alert("��������ҵ����");
		return;
	}
	var companyModel = $("#companyModel").val();
	if(companyModel == "" || companyModel == null){
		alert("��ѡ��λ����");
		return;
	}
	
	var userType="";
	var length = $('input[name="userTypes"]:checked').length-1;
	$('input[name="userTypes"]:checked').each(function(index,element){ 
		if(index == length){
			userType= userType+$(this).val(); 
		}else{
			userType= userType+$(this).val()+","; 
		}
		
	}); 
	$("#userType").val(userType);
	if(userType.length==0){
		alert("�빴ѡ�û�����");
		return;
	}
	
	var regAddrProvince = $("#regAddrProvince").val();
	if(regAddrProvince == "" || regAddrProvince == null){
		alert("��ѡ��ʡ��");
		return;
	}
	var regAddrCity = $("#regAddrCity").val();
	if(regAddrCity == "" || regAddrCity == null){
		alert("��ѡ�����");
		return;
	}
	var address = $("#address").val();
	if(address == "" || address == null){
		alert("�����뵥λ��ַ");
		return;
	}
	
	var managementTypeCode="";
	var length = $('input[name="managementTypeCodes"]:checked').length-1;
	$('input[name="managementTypeCodes"]:checked').each(function(index,element){ 
		if(index == length){
			managementTypeCode= managementTypeCode+$(this).val(); 
		}else{
			managementTypeCode= managementTypeCode+$(this).val()+","; 
		}
		
	}); 
	$("#managementType").val(managementTypeCode);
	if(managementTypeCode.length==0){
		alert("�빴ѡ��Ӫģʽ");
		return;
	}
	var contactPerson = $("#contactPerson").val();
	if(contactPerson == "" || contactPerson == null){
		alert("��������ϵ��");
		return;
	}
	var contactTel = $("#contactTel").val();
	if(contactTel == "" || contactTel == null){
		alert("������̶��绰");
		return;
	}
	if(!checkTel(contactTel)){
		alert("��������ȷ�Ĺ̶��绰");
		$("#contactTel").focus();
		return;
	}
	var contactIphone = $("#contactIphone").val();
	if(contactIphone == "" || contactIphone == null){
		alert("�������ֻ�����");
		return;
	}
	if(!checkMobile(contactIphone)){
		alert("��������ȷ���ֻ�����");
		return;
	}
	var contactEmail = $("#contactEmail").val();
	if(contactEmail == "" || contactEmail == null){
		alert("����������");
		return;
	}
	if(!checkEmail(contactEmail)){
		alert("��������ȷ����");
		return;
	}
	var contactAddress = $("#contactAddress").val();
	if(contactAddress == "" || contactAddress == null){
		alert("��������ϵ�˵�ַ");
		return;
	}
	
	var corporationName = $("#corporationName").val();
	if(corporationName == "" || corporationName == null){
		alert("�����뷨��������");
		return;
	}
	
	var companyPostcode = $("#companyPostcode").val();
	if(companyPostcode == "" || companyPostcode == null){
		alert("�����������ʱ�");
		return;
	}
	if(!checkZipCode(companyPostcode)){
		alert("��������ȷ�����ʱ�");
		return;
	}
	var corporationIphone = $("#corporationIphone").val();
	if(corporationIphone == "" || corporationIphone == null){
		alert("�����뷨���������ֻ�");
		return;
	}
	if(!checkMobile(corporationIphone)){
		alert("��������ȷ�ķ����������ֻ�");
		$("#corporationIphone").focus();
		return;
	}
	
	var corporationTel = $("#corporationTel").val();
	if(corporationTel == "" || corporationTel == null){
		alert("�����뷨�������˵�λ�绰");
		return;
	}
	if(!checkTel(corporationTel)){
		alert("��������ȷ�ķ��������˵�λ�绰");
		$("#corporationTel").focus();
		return;
	}
	
	$("#witchPage").val("2");
	document.getElementById("submitCompanyMyInfoForm").action = path+"/management/companyMyInfo/update";
	document.getElementById("submitCompanyMyInfoForm").submit();
	/*$.ajax({
	     type: 'POST',
	     url: path+"/management/vat/deletePic",
	     dataType: 'json',
	     data:{  
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName,
	    	 fileName : picName
	     },  
	     success: function(data) {  
	    	if(data.status =="success" ){  
	    		$("#"+contentDiv).remove();
	    	}  
	     },
	     error : function() {  
	    	 alert("�쳣��");  
	     } 
	});*/
	
}

function ajaxFileUpload(type,fileID) {  
	var path = $("#path").val();
	$.ajaxFileUpload({  
        url: path + '/management/companyMyInfo/uploadPic', //�������������ַ  
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
        	if(data == "fileNameError"){
        		alert("ɨ���ֻ֧��JPG,PNG,BMP,JPEG��ʽ�ļ���");
        		return;
        	}
        	if(data == "fileSizeError"){
        		alert("�ļ���󲻳���5M��");
        		return;
        	}
        	var pos=data.lastIndexOf("/")+1; 
        	var picName = data.substring(pos);
        	var url = path+data;
        	//����DATA
        	if(type=="1"){
        		var val=$('input:radio[name="optionsRadiosinline"]:checked').val();
        		if(val=='1'){
        			
            		$("#uploadLicenceFileDiv1").hide();
            		$("#licenceViewerImg1").attr("src", url); 
            		$("#licenceViewerImg1").attr("data-original",url);
            		$("#showLicenceFileDiv").show();
        		}else{
            		$("#uploadLicenceFileDiv2").hide();
            		$("#licenceViewerImg2").attr("src", url); 
            		$("#licenceViewerImg2").attr("data-original",url);
            		$("#showLicenceFileDiv2").show();
        		}
        		$("#licenceName").val(picName);
        		$("#licenceFile").val(data);
        		
        	}else if(type=="2"){
        		
        		$("#uploadOrganizationFileDiv").hide();
        		$("#organizationName").val(picName);
        		$("#organizationFile").val(data);
        		$("#organizationViewerImg").attr("src", url); 
        		$("#organizationViewerImg").attr("data-original",url);
        		$("#showOrganizationFileDiv").show();
        	}else if(type=="3"){
        		
        		$("#uploadTaxFileDiv").hide();
        		$("#taxName").val(picName);
        		$("#taxFile").val(data);
        		$("#taxViewerImg").attr("src", url); 
        		$("#taxViewerImg").attr("data-original",url);
        		$("#showTaxFileDiv").show();
        	}else if(type=="4"){
        		
        		$("#uploadBankFileDiv").hide();
        		$("#bankFileName").val(picName);
        		$("#bankFile").val(data);
        		$("#bankViewerImg").attr("src", url); 
        		$("#bankViewerImg").attr("data-original",url);
        		$("#showBankFileDiv").show();
        	}else if(type=="5"){
        		
        		$("#uploadQuFileDiv").hide();
        		$("#quFileName").val(picName);
        		$("#quFile").val(data);
        		$("#quViewerImg").attr("src", url); 
        		$("#quViewerImg").attr("data-original",url);
        		$("#showQuFileDiv").show();
        	}else if(type=="6"){
        		
        		$("#uploadSecurityFileDiv").hide();
        		$("#securityFileName").val(picName);
        		$("#securityFile").val(data);
        		$("#securityViewerImg").attr("src", url); 
        		$("#securityViewerImg").attr("data-original",url);
        		$("#showSecurityFileDiv").show();
        	}else if(type=="7"){
        		
        		$("#uploadImportAndExportFileDiv").hide();
        		$("#importAndExportFileName").val(picName);
        		$("#importAndExportFile").val(data);
        		$("#importAndExportViewerImg").attr("src", url); 
        		$("#importAndExportViewerImg").attr("data-original",url);
        		$("#showImportAndExportFileDiv").show();
        	}else if(type=="8"){
        		
        		$("#uploadBusinessFileDiv").hide();
        		$("#businessFileName").val(picName);
        		$("#businessFile").val(data);
        		$("#businessViewerImg").attr("src", url); 
        		$("#businessViewerImg").attr("data-original",url);
        		$("#showBusinessFileDiv").show();
        	}
        },  
        error: function (data, status, e)//��������Ӧʧ�ܴ�������  
        {  
        }  
    });
}  

function delFile(type){
	var path = $("#path").val();
	var picName = "";
	if(type=="1"){
		picName = $("#licenceName").val();
	}else if(type=="2"){
		picName = $("#organizationName").val();
	}else if(type=="3"){
		picName = $("#taxName").val();
	}else if(type=="4"){
		picName = $("#bankFileName").val();
	}else if(type=="5"){
		picName = $("#quFileName").val();
	}else if(type=="6"){
		picName = $("#securityFileName").val();
	}else if(type=="7"){
		picName = $("#importAndExportFileName").val();
	}else if(type=="8"){
		picName = $("#businessFileName").val();
	}
	$.ajax({
	     type: 'POST',
	     url: path+"/management/companyMyInfo/deletePic",
	     dataType: 'json',
	     data:{  
	    	 fileName : picName  
	     },  
	     success: function(data) {  
	    	if(data.status =="success" ){  
	    		if(type=="1"){
	    			var val=$('input:radio[name="optionsRadiosinline"]:checked').val();
	        		if(val=='1'){
	        			$("#showLicenceFileDiv").hide();
	            		$("#uploadLicenceFileDiv1").show();
	        		}else{
	        			$("#uploadLicenceFileDiv2").show();
	            		$("#showLicenceFileDiv2").hide();
	        		}
	        		$("#licenceName").val("");
	        		$("#licenceFile").val("");
	        	}else if(type=="2"){
	        		$("#showOrganizationFileDiv").hide();
	        		$("#organizationName").val("");
	        		$("#organizationFile").val("");
	        		$("#showBusinessFileDiv").show();
	        	}else if(type=="3"){
	        		$("#showTaxFileDiv").hide();
	        		$("#taxName").val("");
	        		$("#taxFile").val("");
	        		$("#uploadTaxFileDiv").show();
	        	}else if(type=="4"){
	        		$("#showBankFileDiv").hide();
	        		$("#bankFileName").val("");
	        		$("#bankFile").val("");
	        		$("#uploadBankFileDiv").show();
	        	}else if(type=="5"){
	        		$("#showQuFileDiv").hide();
	        		$("#quFileName").val("");
	        		$("#quFile").val("");
	        		$("#uploadQuFileDiv").show();
	        	}else if(type=="6"){
	        		$("#showSecurityFileDiv").hide();
	        		$("#securityFileName").val("");
	        		$("#securityFile").val("");
	        		$("#uploadSecurityFileDiv").show();
	        	}else if(type=="7"){
	        		$("#showImportAndExportFileDiv").hide();
	        		$("#importAndExportFileName").val("");
	        		$("#importAndExportFile").val("");
	        		$("#uploadImportAndExportFileDiv").show();
	        	}else if(type=="8"){
	        		$("#showBusinessFileDiv").hide();
	        		$("#businessFileName").val("");
	        		$("#businessFile").val("");
	        		$("#uploadBusinessFileDiv").show();
	        	}
	    	}  
	     },
	     error : function() {  
	    	 alert("�쳣��");  
	     } 
	});
}

function saveManagementMyInfo(){
	 var val=$('input:radio[name="optionsRadiosinline"]:checked').val();
	 $("#ifCreditCode").val(val);
	 if(val=='1'){
		 var socialCreditCode = $("#socialCreditCode").val();
		 if(socialCreditCode == "" || socialCreditCode == null){
			 alert("������ͳһ������ô���");
			 return;
		 }
		 var regFund1 = $("#regFund1").val();
		 $("#regFund").val(regFund1);
		 var companyDetail1 = $("#companyDetail1").val();
		 $("#companyDetail").val(companyDetail1);
		 
	 }else if(val == '2'){
		 var organizationCode = $("#organizationCode").val();
		 if(organizationCode=="" || organizationCode == null){
			 alert("��������֯��������֤");
			 return;
		 }
		 var organizationFile = $("#organizationFile").val();
		 if(organizationFile=="" || organizationFile == null){
			 alert("���ϴ���֯��������֤ɨ���");
			 return;
		 }
		 var licenceCode = $("#licenceCode").val();
		 if(licenceCode == "" || licenceCode == null){
			 alert("������Ӫҵִ�պ���");
			 return;
		 }
		 
		 var taxCode = $("#taxCode").val();
		 if(taxCode==""||taxCode==null){
			 alert("������˰��Ǽ�֤����");
			 return;
		 }
		 
		 var taxFile = $("#taxFile").val();
		 if(taxFile==""||taxFile==null){
			 alert("���ϴ�˰��Ǽ�֤����ɨ���");
			 return;
		 }
		 
		 var regFund2 = $("#regFund2").val();
		 $("#regFund").val(regFund2);
		 var companyDetail2 = $("#companyDetail2").val();
		 $("#companyDetail").val(companyDetail2);
		 
	 }
	 var regFund = $("#regFund").val();
	 if(regFund=="" || regFund==null){
		 alert("������ע���ʽ�");
		 return;
	 }
	 var companyDetail = $("#companyDetail").val();
	 if(companyDetail == "" || companyDetail == null){
		 alert("�����뾭Ӫ��Χ");
		 return;
	 }
	 var licenceFile = $("#licenceFile").val();
	 if(licenceFile==""||licenceFile==null){
		 alert("���ϴ�Ӫҵִ��ɨ���");
		 return;
	 }
	 
	 var bankName = $("#bankName").val();
	 if(bankName==""||bankName==null){
		 alert("�����뿪������");
		 return;
	 }
	 var bankCode = $("#bankCode").val();
	 if(bankCode==""||bankCode==null){
		 alert("���������л������˺�");
		 return;
	 }
	 var bankFile = $("#bankFile").val();
	 if(bankFile==""||bankFile==null){
		 alert("���ϴ���������֤ɨ���");
		 return;
	 }
	 
	var path = $("#path").val();
	$("#witchPage").val("3");
	document.getElementById("submitCompanyMyInfoForm2").action = path+"/management/companyMyInfo/update";
	document.getElementById("submitCompanyMyInfoForm2").submit();
}

function clearRegFund(type){
	if(type=='1'){
		if ($('#noRegFund1').is(':checked')) {
			$("#regFund1").val("0");
			$("#regFund1").attr("disabled",true); 
			$("#yuan1").attr("disabled",true); 
			$("#ut1").attr("disabled",true);
		}else{
			$('#regFund1').removeAttr("disabled"); 
			$('#yuan1').removeAttr("disabled"); 
			$('#ut1').removeAttr("disabled"); 
		}
		 
	}else if(type=='2'){
		if ($('#noRegFund2').is(':checked')) {
			$("#regFund2").val("0");
			$("#regFund2").attr("disabled",true);
			$("#yuan2").attr("disabled",true); 
			$("#ut2").attr("disabled",true); 
		}else{
			$('#regFund2').removeAttr("disabled"); 
			$('#yuan2').removeAttr("disabled"); 
			$('#ut2').removeAttr("disabled"); 
		}
	}
}

function checkEmail(str){
    var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
    if(re.test(str)){
        return true;
    }else{
        return false;
    }
}

function checkMobile(str) {
    var re = /^1\d{10}$/;
    if (re.test(str)) {
        return true;
    } else {
        return false;
    }
}

function checkTel(str) {
	RegExp = /^0\d{2,3}-\d{7,8}$/;
	if (RegExp.test(str) == false) {
		return true;
	}else{
		return false;
	}
}

function checkZipCode(str) {
    var re = /^[1-9][0-9]{5}$/;
    if (re.test(str)) {
        return true;
    } else {
        return false;
    }
}

function checkFile(fileID){
        var filepath = $("input[id='"+fileID+"']").val();
        var extStart = filepath.lastIndexOf(".");
        var ext = filepath.substring(extStart, filepath.length).toUpperCase();
        if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG") {
            alert("ͼƬ����bmp,png,gif,jpeg,jpg��ʽ");
            $("#fileType").text("");
            $("#fileSize").text("");
            return false;
        } 
        var file_size = 0;
       /* if ($.browser.msie) {
            var img = new Image();
            img.src = filepath;
                if (img.fileSize > 0) {
                    if (img.fileSize > 5 * 1024) {
                        alert("ͼƬ������5MB��");
                        return false;
                    } 
                }
        } else {*/
            file_size = this.files[0].size;
            var size = file_size / 1024;
            if (size > 5) {
                alert("�ϴ���ͼƬ��С���ܳ���5M��");
                return false;
            } 
        /*}*/
        return true;
}