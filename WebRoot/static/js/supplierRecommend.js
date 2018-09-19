function search(){
	var path = $("#path").val();
	document.getElementById("supplierRecommendForm").action=path+"/supervise/supplierReommend";
	document.getElementById("supplierRecommendForm").submit();
}

function cancleRecommend(supID){
	var path = $("#path").val();
	if(confirm("ȷ��ȡ���Ƽ���")){
		window.location.href = path+"/supervise/supplierReommend/cancleRecommend/"+supID;
	}
}

function setRecommendPage(supID){
	var iWidth=715;                          //�������ڵĿ���; 
    var iHeight=295;                         //�������ڵĸ߶�; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	var path = $("#path").val();
	var url = path+"/supervise/supplierReommend/setRecommendPage/"+supID;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
}

function setRecommend(){
	var path = $("#path").val();
	//��֤��Ϣ�Ƿ���д
	var picPath = $("#supImage").val();
	var beginDate = $("#beginDate").val();
	var endDate = $("#endDate").val();
	var supID = $("#supID").val();
	if(beginDate=="" || beginDate == null){
		alert("��ѡ��ʼʱ��");
		return;
	}
	if(endDate == "" || endDate == null){
		alert("��ѡ�����ʱ��");
		return;
	}
	if(picPath=="" || picPath ==null){
		alert("��ѡ��ͼƬ");
		return;
	}
	
	
	$.ajax({
        type: "POST",
        url: path+"/supervise/supplierReommend/setRecommend",
        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
        data: {
        	beginDate:beginDate,
        	endDate:endDate,
        	supImage:picPath,
        	supID:supID
        },
        success: function(data) {
        	if("success"==data){
    			alert("�Ƽ��ɹ���");
    		}
//    		window.returnValue = "reload";
//    		window.close();
        	window.opener.location.href=path+"/supervise/supplierReommend";
    		window.close();
        }
    });
//	document.getElementById("supplierRecommendSubmitForm").action=path+"/supervise/supplierReommend/setRecommend";
//	document.getElementById("supplierRecommendSubmitForm").submit();
}

//�ϴ�ͼƬ
function ajaxFileUpload(fileID) {  
	/*if($("#lefile").val()==""){
		alert("��ѡѡ��ͼƬ��");
		return;
	}*/
	if($("#supImageAfter").val()!=""){
		alert("����ɾ��Ȼ��ѡ��ͼƬ��");
		return;
	}
	var path = $("#path").val();
	$.ajaxFileUpload({  
        url: path + '/supervise/supplierReommend/uploadPic', //�������������ַ  
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
        	$("#supPicImg").attr('src',path+data);
        	$("#supImage").val(data);
        	$("#supImageAfter").val(data);
//        	$("#photoCover").text("");
        },  
        error: function (data, status, e)//��������Ӧʧ�ܴ�������  
        {  
        	alert("�ϴ�ʧ��");
        }  
    });
}  

//ɾ��ͼƬ
function delImage(contentDiv){
	var picName = $("#supImage").val();
	var path = $("#path").val();
	var pos=picName.lastIndexOf("/");
	if(pos>0){
		picName = picName.substring(pos);
	}
	$.ajax({
	     type: 'POST',
	     url: path+"/supervise/supplierReommend/deletePic",
	     dataType: 'json',
	     data:{  
	    	 fileName : picName  
	     },  
	     success: function(data) {  
	    	if(data.status =="success" ){  
	    		$("#supPicImg").remove();
	    		$("<img width='180' height='57' id='supPicImg' src=''/>").appendTo($("#imgP"));
	    		$("#supImage").val("");
	    		$("#supImageAfter").val("");
	    	}  
	     },
	     error : function() {  
	    	 alert("�쳣��");  
	     } 
	});
}

function cancle(){
	var path = $("#path").val();
	window.close();
	window.location.href=path+"/supervise/supplierReommend";
}

function showCompany(supID){
	var path = $("#path").val();
	var iWidth=730;                          //�������ڵĿ���; 
    var iHeight=360;                         //�������ڵĸ߶�;  
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	var url = path+"/supervise/company?supID="+supID;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
}