function searchCompany(supID){
	var path = $("#path").val();
//	var companyName = $("#companyName").val();
//	var companyCode = $("#companyCode").val();
//	window.location.href = "${pageContext.request.contextPath}/supervise/companyInfo?companyName="+companyName+"&companyCode="+companyCode;
	document.getElementById("companyForm").action=path+"/supervise/companyInfo/businessEnterprise";
	document.getElementById("companyForm").submit();
}

function clean(){
	$("#companyName").val("");
 	$("#companyCode").val("");
 	$("#userName").val("");
 	$("#contactPerson").val("");
 	$("#contactIphone").val("");
 	$("#timeStart").val("");
 	$("#timeEnd").val("");
}

function addCompanyInfo(id){
	var path = $("#path").val();
	var adminType = $("#adminType").val();
	if(adminType=="1"){
		if(id!=""&&id!=null){
			window.location.href = path+"/supervise/companyMyInfo/init?addOrUpdate=2&id="+id+"&flg=2";
		}else{
			window.location.href = path+"/supervise/companyMyInfo/init?addOrUpdate=1&id=''"+"&flg=2";
		}
		
	}else{
		if(id!=""&&id!=null){
			window.location.href = path+"/supervise/companyInfo/initEditCompany?id="+id+"&flg=2";
		}else{
			window.location.href = path+"/supervise/companyInfo/initEditCompany?flg=2";
		}
	}
	
}

function editCompanyInfo(type){
	var path = $("#path").val();
	var id;
	var companyCode = $("#companyCode").html();
	var companyName = $("#companyName").val();
	if(companyName==""||companyName==null){
		alert("请输入公司名称!");
		return;
	}
	if(type=="1"){
		id = companyCode;
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/companyInfo/addCompanyInfo",
	        dataType: 'json',
	        data: {
	        	id:id,
	        	companyName:companyName,
	        	companyCode:companyCode
	        },
	        success: function(data) {
	        	if("success"==data.status){
	        		window.location.href=path+"/supervise/companyInfo";
	    		}else{
	    			alert(data.status);
	    		}
	        	
	        }
	    });
	}else{
		id = $("#id").val();
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/companyInfo/updCompanyInfo",
	        dataType: 'json',
	        data: {
	        	id:id,
	        	companyName:companyName
	        },
	        success: function(data) {
	        	if("success"==data.status){
	        		window.location.href=path+"/supervise/companyInfo/businessEnterprise";
	    		}else{
	    			alert(data.status);
	    		}
	        }
	    });
	}
}

function cancle(){
	var path = $("#path").val();
	window.location.href = path+"/supervise/companyInfo/businessEnterprise";
}

function delCompanyInfo(id,companyType){
	var path = $("#path").val();
	if(confirm("请确认是否进行删除操作！")){
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/companyInfo/delCompanyInfo",
	        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
	        dataType: 'json',
	        data: {
	        	id:id,
	        	companyType:companyType
	        },
	        success: function(data) {
	        	if("success"==data.status){
	        		window.location.href=path+"/supervise/companyInfo/businessEnterprise";
	    		}else{
	    			alert(data.status);
	    		}
	        }
	    });
	}
	
}

function checkInit(companyID){
	var path = $("#path").val();
	window.location.href= path+"/supervise/companyInfo/checkInit?witchPage=1&id="+companyID+"&flg=2";
}


function selDepartment(companyCode){
	var path = $("#path").val();
	window.location.href = path+"/supervise/companyInfo/selDepartment?companyCode="+companyCode;
}

function saveOrganizationInfo(){
	var path = $("#path").val();
	var parentCompanyId = $("#parentCompanyId").val();
	var companyName = $("#addCompanyName").val();
	var contactPerson = $("#addContactPerson").val();
	var contactIphone = $("#addContactIphone").val();
	var contactFax = $("#addContactFax").val();
	var contactEmail = $("#addContactEmail").val();
	if(parentCompanyId == "-1"){
		alert("请选择上级机构");
		return;
	}
	if(companyName==""||companyName==null){
		alert("请输入公司名称!");
		return;
	}
	if(contactIphone!=null&&contactIphone!=""&&!isPhoneNo(contactIphone)){
		alert("请输入正确电话！");
		return;
	}
	if(contactEmail!=null&&contactEmail!=""&&!isMail(contactEmail)){
		alert("请输入正确邮箱！");
		return;
	}
	$.ajax({
        type: "POST",
        url: path+"/supervise/companyInfo/saveOrganiizationInfo",
        dataType: 'json',
        data: {
        	companyName:companyName,
        	parentCompanyId:parentCompanyId,
        	contactPerson:contactPerson,
        	contactIphone:contactIphone,
        	contactFax:contactFax,
        	contactEmail:contactEmail
        },
        success: function(data) {
        	if("success"==data.status){
        		window.location.href=path+"/supervise/companyInfo/organizationInfo";
    		}else{
    			alert(data.status);
    		}
        	
        }
    });
}

function delOrganizationInfo(organizationInfoID){
	var path = $("#path").val();
	if(confirm("要删除该机构及所有子机构项吗？")){
		$.ajax({
	        type: "POST",
	        url: path+"/supervise/companyInfo/delOrganiizationInfo",
	        dataType: 'json',
	        data: {
	        	id:organizationInfoID
	        },
	        success: function(data) {
	        	if("success"==data.status){
	        		window.location.href=path+"/supervise/companyInfo/organizationInfo";
	    		}else{
	    			if(data.status == "havaUsersError"){
	        			alert("机构下有用户信息无法删除，请先将用户转移或删除用户信息再进行操作。");
	        		}
	    		}
	        	
	        }
	    });
	}
	
}

function showOrganizationInfoUpdate(organizationInfoID){
	var path = $("#path").val();
	$.ajax({
        type: "POST",
        url: path+"/supervise/companyInfo/showOrganizationInfo",
        dataType: 'json',
        data: {
        	id:organizationInfoID
        },
        success: function(data) {
        	var companyInfo = data.companyInfo;
        	if(companyInfo != null){
        		$("#updCompanyInfoID").val(companyInfo.id);
        		$("#updCompanyName").val(companyInfo.companyName);
        		$("#compareCompanyName").val(companyInfo.companyName);
	        	$("#updParentCompanyId option").each(function(i,n){
	                if($(n).val()==companyInfo.parentCompanyId)
	                {
	                    $(n).attr("selected",true);
	                }
	            });
            	$("#updContactPerson").val(companyInfo.contactPerson);
            	$("#updContactIphone").val(companyInfo.contactIphone);
            	$("#updContactFax").val(companyInfo.contactFax);
            	$("#updContactEmail").val(companyInfo.contactEmail);
        	}
        	
        	
        }
    });
}

function updateOrganizationInfo(){
	var path = $("#path").val();
	var id = $("#updCompanyInfoID").val();
	var companyName = $("#updCompanyName").val();
	var parentCompanyId = $("#updParentCompanyId").val();
	var contactPerson = $("#updContactPerson").val();
	var contactIphone = $("#updContactIphone").val();
	var contactFax = $("#updContactFax").val();
	var contactEmail = $("#updContactEmail").val();
	var compareCompanyName = $("#compareCompanyName").val();
	if(companyName==""||companyName==null){
		alert("请输入公司名称!");
		return;
	}
	if(contactIphone!=null&&contactIphone!=""&&!isPhoneNo(contactIphone)){
		alert("请输入正确电话！");
		return;
	}
	if(contactEmail!=null&&contactEmail!=""&&!isMail(contactEmail)){
		alert("请输入正确邮箱！");
		return;
	}
	$.ajax({
        type: "POST",
        url: path+"/supervise/companyInfo/updateOrganiizationInfo",
        dataType: 'json',
        data: {
        	id:id,
        	companyName:companyName,
        	parentCompanyId:parentCompanyId,
        	contactPerson:contactPerson,
        	contactIphone:contactIphone,
        	contactFax:contactFax,
        	contactEmail:contactEmail,
        	compareCompanyName:compareCompanyName
        },
        success: function(data) {
        	if(data.status == "success"){
        		window.location.href = path + "/supervise/companyInfo/organizationInfo";
        	}else{
        		alert(data.status);
        	}
        }
    });
}