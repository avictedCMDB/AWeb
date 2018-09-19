
$(document).ready(function(){
	var images = $("a[name='image_show']");
	if(images.length>0){
		images.each(function(index){
			$("#image_show"+index).imgbox();//���ذ�ͼƬ�Ŵ�Ч��
		 });
	}
});


function search(){
	var path = $("#path").val();
	document.getElementById("orderForm").action=path+"/management/audit/auditorAudit";
	document.getElementById("orderForm").submit();
}
function clearSearchParam(){
	$("#startTime").val("");
	$("#endTime").val("");
	$("#searchGoodsName").val("");
	$("#searchOrderId").val("");
	$("#searchSupName").val("");
}
//${pageContext.request.contextPath}/management/audit/confirm?orderID=${audit.orderID}&searchFlg=2
function showAuditDiv(searchFlg,orderID){
	var path = $("#path").val();
	var orderStatus = $("#orderStatus").val();
	var url = path+"/management/audit/confirm?orderID="+orderID+"&searchFlg="+searchFlg+"&orderStatus="+orderStatus;
	/*var result = window.open(url,window,'width:800px;height:650px;status:no;');
	if(result != "" && result != null && result != 'undefined'){
		window.location.reload();
	}*/
	var iWidth=650;                          //�������ڵĿ���; 
    var iHeight=600;                         //�������ڵĸ߶�; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
	
}

function auditSubmit(){
	var path = $("#path").val();
	var orderStatus = $("#orderStatus").val();
	if($("input[name='optionsRadiosinline']:checked").val()==""){
		alert("��ѡ����˽����");
		return;
	}
	/*if($("#auditReviewRemark").val()==""){
		alert("��������������");
		return;
	}*/
	var orderID = $("#orderID").val();
	//��ȡͼƬ·��
	var imgArray = new Array();
	var imgObj = $('input:hidden[name=hidden_path]');
	imgObj.each(function(i){
		imgArray.push(imgObj[i].value);
	});
	var imagePaths = imgArray.join(",");
	
	$.ajax({
        type: "POST",
        url: path+"/management/audit/auditConfirm",
        contentType:"application/x-www-form-urlencoded; charset=utf-8", 
        data: {
        	orderID:orderID,
        	reviewRemark:$("#auditReviewRemark").val(),
        	reviewResult:$("input[name='optionsRadiosinline']:checked").val(),
        	imagePaths:imagePaths
        },
        success: function(data) {
        	if("success"==data){
    			alert("��˳ɹ���");
    		}
//    		window.returnValue = "reload";
//    		window.close();
        	window.opener.location.href=path+"/management/audit/auditorAudit?orderStatus="+orderStatus;
    		window.close();
        }
    });
	
//	$("#reviewResult").val($("input[name='optionsRadiosinline']:checked").val());
//	$("#reviewRemark").val($("#auditReviewRemark").val());
//	document.getElementById("auditForm").action="";
//	document.getElementById("auditForm").submit();
}

function cacleParentWindow(){
	window.close();
}

function selectOrderStatus(orderStatus){
	var path = $("#path").val();
	$("#orderStatus").val(orderStatus);
	document.getElementById("orderForm").action=path+"/management/audit/auditorAudit";
	document.getElementById("orderForm").submit();
}

function showCompare(orderID){
	var iWidth=950;                          //�������ڵĿ���; 
    var iHeight=600;                         //�������ڵĸ߶�; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	var path = $("#path").val();
	var url = path+"/management/compare/auditCompare?orderID="+orderID;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no');
}