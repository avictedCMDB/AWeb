$(document).ready(function(){
	//ȫѡ�¼�
	$('#allchecked').click(function(){
		var allcheck = $("#allchecked").is(':checked');
		$('input[name="subCheckbox"]').attr('checked',allcheck);
		getTotalText();
	});
	var type = $('input[name="isRelease"]:checked').val();
	if(type=='1'){
		$("#supDL").hide();
	}
	/*var path = $("#path").val();
	var updateImgCount = parseInt($('#updateImgCount').val());
	//�������ͼ
	$("#imgCount").val($('#updateImgCount').val());
	$("#realCount").val($('#updateImgCount').val());
	
	for ( var i = 0; i < updateImgCount; i++) {
		 var extStart = $("#updatePaths_"+i).val().lastIndexOf(".");
		 var ext = $("#updatePaths_"+i).val().substring(extStart, $("#updatePaths_"+i).val().length).toUpperCase();
		 var imgHtml="";
		 if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG") {
			 var es = $("#updatePaths_"+i).val().lastIndexOf("/");
			 var e = $("#updatePaths_"+i).val().substring(es+1, $("#updatePaths_"+i).val().length);
			 imgHtml = "<li id='imgli_"+i+"'><a class='preview' id='imgUpload_"+i+"' href='"+path+"/management/specialGoods/downloadSpecialFile?specialAttachmentPath="+$("#updatePaths_"+i).val()+"'><span style='font-size:16px;color:#0091dc;'>"+e+"</span></a><a href='javascript:void(0);' onclick='deleteImg("+i+");'><img src='"+path+"/static/img/icon-close_blue.png' /></a></li>";
			 
		 }else{
			 imgHtml = "<li id='imgli_"+i+"'><a class='preview' id='imgUpload_"+i+"' href='"+path+$("#updatePaths_"+i).val()+"'><img src='"+path+$("#updatePaths_"+i).val()+"'></a><a href='javascript:void(0);' onclick='deleteImg("+i+");'><img src='"+path+"/static/img/icon-close_blue.png' /></a></li>";
		 }
		
		$("#imgUl").append(imgHtml);
		$('#imgli_'+i).append($('#hiddenPath_'+i));
		setClickFunction('imgUpload_'+i);
	}*/
	
});

function gotoSelectSupPage(sup_type){
	var url = $('#path').val()+'/management/specialGoods/supSelect?o='+sup_type;
	var iWidth=600;                          //�������ڵĿ��; 
    var iHeight=500;                         //�������ڵĸ߶�; 
	var iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	window.open(url, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no, status=no,modal=yes');
}

function childCallParentMethod(){
	setTimeout("fnDelayed()",100);
}

function fnDelayed(){
	//Ϊhtml���ӹ�Ӧ��img
	var newSupIds = $('#new_sup_id').val();
	var supInfoStr = ''
	if(newSupIds!=null && newSupIds!=''){
		supInfoStr = getSelectedSupHtml(newSupIds);
		$('.list_inner').prepend(supInfoStr);
	}
}

//��ȡ��Ӧ��imgHtml
function getSelectedSupHtml(newSupIds){
	var dataArr = new Array();
	if(newSupIds.indexOf(',')!=-1){
		dataArr = newSupIds.split(',');
	}else{
		dataArr.push(newSupIds); 
	}
	
	var strHtmlArr = new Array();
	$(dataArr).each(function(){
		var supDetail = this.split('_');
		strHtmlArr.push(" <li id='"+supDetail[1]+"'>"+supDetail[0]
			+"<a href='javascript:void(0);' onclick='removeSup(this);'><img src='"+$('#path').val()+"/static/img/icon-close_blue.png'/></a></li>");
	});
	return strHtmlArr.join("");
}

//�Ƴ���Ӧ��
function removeSup(aSupImgObj){
	var supIds = $('#sup_id').val();
	var idStr = '';
	var strs = supIds.split(",");
	for ( var i = 0; i < strs.length; i++) {
		if (strs[i] == $(aSupImgObj).parent().attr('id')) {
			continue;
		}else {
			idStr = idStr + strs[i] + ',';
		}
	}
	if (idStr.length != 0) {
		idStr = idStr.substring(0, idStr.length - 1);
	}
	//supIds=supIds.replace(idStr,'');
	$('#sup_id').val(idStr);
	$(aSupImgObj).parent().remove();
}

function doSave(path){
	var goods_name = $('#goodsName').val();
	if(goods_name == null || goods_name == ''){
		alert('������д��Ʒ���ƣ����ύ��');
		$('#goodsName').focus();
		return;
	}
	var goods_desc_new = $('#goods_desc_new').val();
	if(goods_desc_new == null || goods_desc_new == ''){
		alert('������д��Ʒ���������ύ��');
		$('#goods_desc_new').focus();
		return;
	}
	
	var auditImages = $('input[name=auditImages]');
    var picPath1 = new Array();
    for(var i=0;i<auditImages.length;i++){
    	var pos=auditImages[i].value.lastIndexOf("/");
    	if(pos>0){
    		picPath1[i] = auditImages[i].value.substring(pos+1);
    	}else{
    		picPath1[i] = auditImages[i].value;
    	}
    }
	if(picPath1.length <= 0){
		alert('�����ϴ���Ʒ���������ύ��');
		return;
	}
	var closeDate = $('#closeDate').val();
	if(closeDate == null || closeDate == ''){
		alert('������д��ֹ���ڣ����ύ��');
		$('#closeDate').focus();
		return;
	}
    var type = $('input[name="isRelease"]:checked').val();
    var supIds = "";
    if(type=='0'){
    	supIds = $('#sup_id').val();
    	if(supIds == null || supIds == ''){
    		alert('����ѡ��Ӧ�̣����ύ��');
    		return;
    	}
    }
	
	$.ajax({
	    url: path+"/management/specialGoods/doSave?goods_desc_new="+encodeURI(encodeURI(goods_desc_new))
	    	+"&sup_id="+supIds+"&auditImages="+picPath1+"&isRelease="+type
	    	+"&goodsName="+$('#goodsName').val()+"&closeDate="+$('#closeDate').val(),
	    type: "POST",
	    contentType : 'application/json;charset=gbk', //��������ͷ��Ϣ
	    dataType:"json",
	    success: function(data){
	    	if(data.result=='ok'){
	    		window.location.href=path+"/management/specialGoods/offStandardRequirePage";
	    	}else if(data.result=='failed'){
	    		alert("���������Ѿ����ڣ�������������ƣ�");
	    		return;
	    	}else{
	    		alert('ϵͳæ�����Ժ����ԡ�');
	    	}
	    },
	    error: function(res){
            alert('ϵͳæ�����Ժ����ԡ�');
        }
	});
}

function showSupDl(type){
	if(type=='1'){
		$("#supDL").hide();
	}else{
		$("#supDL").show();
	}
	
}


function doUpdate(path){
	var goods_name = $('#goodsName').val();
	if(goods_name == null || goods_name == ''){
		alert('������д��Ʒ���ƣ����ύ��');
		$('#goodsName').focus();
		return;
	}
	var goods_desc_new = $('#goods_desc_new').val();
	if(goods_desc_new == null || goods_desc_new == ''){
		alert('������д��Ʒ���������ύ��');
		$('#goods_desc_new').focus();
		return;
	}
	
	/*var imgSize = $('input:hidden[name=hidden_path]');
	var f = $('#file').val();
	if(imgSize == null || imgSize.length <=0){
		alert('�����ϴ���Ʒ���������ύ��');
		return;
	}*/
	var closeDate = $('#closeDate').val();
	if(closeDate == null || closeDate == ''){
		alert('������д��ֹ���ڣ����ύ��');
		$('#closeDate').focus();
		return;
	}
    var type = $('input[name="isRelease"]:checked').val();
    var supIds = "";
    if(type=='0'){
    	supIds = $('#sup_id').val();
    	if(supIds == null || supIds == ''){
    		alert('����ѡ��Ӧ�̣����ύ��');
    		return;
    	}
    }
	
	var auditImages = $('input[name=auditImages]');
    var picPath1 = new Array();
    for(var i=0;i<auditImages.length;i++){
    	var pos=auditImages[i].value.lastIndexOf("/");
    	if(pos>0){
    		picPath1[i] = auditImages[i].value.substring(pos+1);
    	}else{
    		picPath1[i] = auditImages[i].value;
    	}
    }
	if(auditImages.length <=0){
		alert('�����ϴ���Ʒ���������ύ��');
		return;
	}
	
	$.ajax({
	    url: path+"/management/specialGoods/updateSpecial?auditImages="+picPath1,
	    type: "POST",
	    data:{  
	    	 id : $('#ID').val(),
	    	 goods_desc_new : goods_desc_new,
	    	 sup_id : supIds,
	    	 isRelease : type,
	    	 goodsName :$('#goodsName').val(),
	    	 closeDate :$('#closeDate').val()
	    	 
	     },
	    dataType:"json",
	    success: function(data){
	    	if(data.result=='ok'){
	    		window.location.href=path+"/management/specialGoods/offStandardRequirePage";
	    	}else if(data.result=='failed'){
	    		alert("���������Ѿ����ڣ�������������ƣ�");
	    		return;
	    	}else{
	    		alert('ϵͳæ�����Ժ����ԡ�');
	    	}
	    },
	    error: function(res){
            alert('ϵͳæ�����Ժ����ԡ�');
        }
	});
}

function cancelReason(path){
	var cancelReason = $("#cancelReason").val();
	if(cancelReason == "" || cancelReason == null){
		alert("�������������ɣ�");
		return;
	}
	$.ajax({
	    url: path+"/management/specialGoods/cancellation",
	    type: "POST",
	    data:{  
	    	 id : $('#ID').val(),
	    	 cancelReason : cancelReason
	    	 
	     },
	    dataType:"json",
	    success: function(data){
	    	if(data.status=='success'){
	    		window.location.href=path+"/management/specialGoods/offStandardRequirePage";
	    	}else{
	    		alert('ϵͳæ�����Ժ����ԡ�');
	    	}
	    },
	    error: function(res){
            alert('ϵͳæ�����Ժ����ԡ�');
        }
	});
}

function ajaxFileUpload(beforePath,fileID,imgDivID) {  
	var path = $("#path").val();
	$.ajaxFileUpload({  
        url: path + '/management/specialGoods/uploadPic', //�������������ַ  
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
        	if(data == "fileNameSpecialError"){
        		alert("�ļ����в������������ַ������޸ĺ��ϴ���");
        		return;
        	}
        	
        	if(data == "fileNameError"){
        		alert("�ļ�����bmp,png,gif,jpeg,jpg,xls,xlsx,doc,docx,pdf��ʽ��");
        		return;
        	}
        	if(data == "fileSizeError"){
        		alert("�ļ���󲻳���2M��");
        		return;
        	}
        	
        	var pos=data.lastIndexOf("/")+1; 
        	var picName = data.substring(pos);
        	
        	//����DATA
        	var imgDiv = $("#"+imgDivID);
        	//var subCount = $("#inp"+type+"").val();
        	var countDiv = parseInt($("#auditCount").val())+1;
        	$("#auditCount").val(parseInt($("#auditCount").val())+1);
        	var contentDiv = $("<div id='contentDiv_"+countDiv+"'></div>");
        	var img;
        	if(data.toLowerCase().indexOf(".jpg") > 0 || data.toLowerCase().indexOf(".png") > 0 || data.toLowerCase().indexOf(".bmp") > 0 || data.toLowerCase().indexOf(".jpeg") > 0 || data.toLowerCase().indexOf(".gif") > 0)
        	{
        		img = $("<img height='100px' width='100px' src='"+beforePath+data+"'/>");
        	}else{
        		img = $("<a href=\""+path+"/management/specialGoods/downloadSpecialFile?specialAttachmentPath="+data+"\" class=\"download\">"+picName+"</a>");
        	}
        	var imgSpan = $("<a href='javascript:void(0);' onclick=\"delImage('contentDiv_"+countDiv+"','"+picName+"');\">X</a>");
        	var valueInp = $("<input type='hidden' value='"+picName+"' name='auditImages'/>");
        	contentDiv.appendTo(imgDiv);
        	img.appendTo(contentDiv);
        	imgSpan.appendTo(contentDiv);
        	valueInp.appendTo(contentDiv);
        },  
        error: function (data, status, e)//��������Ӧʧ�ܴ�����  
        {  
        }  
    });
}  

function delImage(contentDiv,picName){
	var path = $("#path").val();
	var pos=picName.lastIndexOf("/");
	if(pos>0){
		picName = picName.substring(pos);
	}
	$.ajax({
	     type: 'POST',
	     url: path+"/management/specialGoods/deletePic",
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