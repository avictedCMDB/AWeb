var timer;
var actionPath;

//У��ͼƬ��С�͸�ʽ
$(document).ready(function(){	
	var myt = document.getElementById('file'); 
	myt.onchange =function(){
   	   //�����ϴ�·����input-text�ؼ���ʾ
	   $('#photoCover').val($(this).val());
	   
	   var filepath = $("input[id='file']").val();
	   if(filepath != null && filepath != ""){
		   
		   var extStart = filepath.lastIndexOf(".");
		   var nameStart = filepath.lastIndexOf("\\")+1;
		   var ext = filepath.substring(extStart, filepath.length).toUpperCase();
		   var fileName = filepath.substring(nameStart, extStart).toUpperCase();
		   if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG" && ext != ".XLS" && ext != ".XLSX"&& ext != ".DOCX"
			   && ext != ".DOC"&& ext != ".PDF") {
			   alert("�ļ�����bmp,png,gif,jpeg,jpg,xls,xlsx,doc,docx,pdf��ʽ��");
		       img_check_show("  ");
		       return false;
		   }
		   var re = /[~#^$@%&!\\-\\+*()<>:;'"{}����  ]/gi;  
		   if (re.test(fileName)) {  
		        alert("�ļ����в��������������ַ������޸ĺ��ϴ���");  
		        img_check_show("  ");
		        return;  
		   }  
	   }
	 
	   var file_size = 0;
	   if ($.browser.msie) {
	       var img = new Image();
	       img.src = filepath;
	       if (img.fileSize > 0) {
	           if (img.fileSize > 4 * 1024 * 1024) {
	               img_check_show("�ϴ��ļ���С���ܳ���4M��");
	               return false;
	           }
	       }
	   } else {
	       file_size = this.files[0].size;
	       var size = file_size / 1024;
	       if (size > 4096) {
	           img_check_show("�ϴ��ļ���С���ܳ���4M��");
	           return false;
	       }
	   }
	   $("#img_check").html("");
	   $("#img_check").hide();
	   return true;
	}
});

function img_check_show(str){
	$("#img_check").html(str);
	$("#img_check").show();
}

function startListener(){
	var xmlhttp;
	try{
		//IE 5.0 
		xmlhttp = new ActiveXObject('Msxm12.XMLHTTP');
	}catch(e){
		try{
			//IE 5.5 �����߰汾
			xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
		}catch(e){
			try{
				//���������
				xmlhttp = new XMLHttpRequest();
			}catch(e){}
		}
	}
	var progressStatusText = document.getElementById("progressBar");
	var params = "&imgCount=" + $('#imgCount').val()+"&mark='"+$('#mark').val()+"'";
	xmlhttp.open("get",actionPath+"/UploadServlet?uploadStatus=true"+params,true);
	/**�˴�Header���÷ǳ���Ҫ����������Content-type���ͣ�����ᱨ����
	*/
	 xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	 xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState == 4){
			if(xmlhttp.status == 200){
				progressStatusText.innerHTML = "";
				progressStatusText.innerHTML = xmlhttp.responseText;
				var temp = xmlhttp.responseText.indexOf("hiddenPath_");
				if (temp > 0){
					var imgCount = $("#imgCount").val();
					var imgSort = Number(imgCount)+1;
					var imgPath = $('#hiddenPath_'+imgSort).val();
					window.clearTimeout(timer);
					//��������ͼ
					$("#imgCount").val(imgSort);
					$("#realCount").val(Number($("#realCount").val())+1);
					 var extStart = imgPath.lastIndexOf(".");
					 var ext = imgPath.substring(extStart, imgPath.length).toUpperCase();
					 var imgHtml="";
					 if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG") {
						 var es = $("#photoCover").val().lastIndexOf("\\");
						 var e = $("#photoCover").val().substring(es+1, imgPath.length);
						 imgHtml = "<li id='imgli_"+imgSort+"'><a class='preview' id='imgUpload_"+imgSort+"' href='"+actionPath+"/management/specialGoods/downloadSpecialFile?specialAttachmentPath="+imgPath+"'><span style='font-size:16px;color:#0091dc;'>"+e+"</span></a><a href='javascript:void(0);' onclick='deleteImg("+imgSort+");'><img src='"+actionPath+"/static/img/icon-close_blue.png' /></a></li>";
						 
					 }else{
						 imgHtml = "<li id='imgli_"+imgSort+"'><a class='preview' id='imgUpload_"+imgSort+"' href='"+actionPath+imgPath+"'><img src='"+actionPath+imgPath+"'></a><a href='javascript:void(0);' onclick='deleteImg("+imgSort+");'><img src='"+actionPath+"/static/img/icon-close_blue.png' /></a></li>";
					 }
					
					$("#imgUl").append(imgHtml);
					$('#imgli_'+imgSort).append($('#hiddenPath_'+imgSort));
					setClickFunction('imgUpload_'+imgSort);
				}else{
					timer = window.setTimeout(startListener,1000);
				}
			}
		}
	}
	xmlhttp.send(null);
	//��Ӧ�����⴦��
	if($('#mark').val() == 'sup'){
		if($('#updateImg') != undefined){
			$('#updateImg').hide();
		}
	}
}

function setClickFunction(objId){
	$("#"+objId).imgbox();
}

function deleteImg(imgSort){
	//ɾ��ͼƬ��Ϊ������ֵ
	$('#delImgName').val($('#hiddenPath_'+imgSort).val());
	//�ϴ�ͼƬ��ťsubmit����
	$('#imgli_'+imgSort).remove();
	var realCount = Number($("#realCount").val());
	if(realCount>0){
		realCount = realCount-1;
		$("#realCount").val(realCount);
	}
	$('#cancelUploadButton').click();
}

function startUpload(path,fm){
	var params = "?imgCount=" + fm['imgCount'].value+"&delImgName="+fm['delImgName'].value+"&mark="+fm['mark'].value+"";
	if(fm.action.indexOf("?")>0){
		fm.action = fm.action.substring(0,fm.action.indexOf("?"))+params;
	}else{
		fm.action = fm.action + params;
	}
	var err_str = $("#img_check").html();
	if(err_str!=null && err_str!="" && err_str!=undefined){//ͼƬ��С��ʽУ�鲻ͨ��
		return false;
	}else{
		actionPath = path;
	    timer = window.setTimeout(startListener,1000);
		return true;//ִ���ύ
	}
}

//ɾ��ͼƬ
function cancelUpload(path){
	var xmlhttp;
	try{
	//IE 5.0 
		xmlhttp = new ActiveXObject('Msxm12.XMLHTTP');
	}catch(e){
		try{
		//IE 5.5 �����߰汾
			xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
		}catch(e){
			try{
			//���������
				xmlhttp = new XMLHttpRequest();
			}catch(e){}
		}
	}
	var progressStatusText = document.getElementById("progressBar");
	var params = "&imgCount=" + $('#imgCount').val()+"&mark="+$('#mark').val()+"&delImgName="+encodeURI(encodeURI($('#delImgName').val()));
	xmlhttp.open("get",path+"/UploadServlet?cancel=true"+params,true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	//xmlhttp.setRequestHeader("Content-type", "multipart/form-data");
	xmlhttp.onreadystatechange = function(){
		if(xmlhttp.readyState == 4){
			if(xmlhttp.status == 200){
			progressStatusText.innerHTML = "";
			progressStatusText.innerHTML = xmlhttp.responseText;
			}
		}
	}
	xmlhttp.send(null);
	return false;
}