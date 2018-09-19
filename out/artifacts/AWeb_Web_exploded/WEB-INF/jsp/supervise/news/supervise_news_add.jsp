<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>�ɹ����ƽ̨|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_common.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/css/supervise_news.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet"/>
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/kindeditor-4.1.7/kindeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/kindeditor-4.1.7/lang/zh-CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script>
        KindEditor.ready(function(K) {
                window.editor = K.create('#editor_id', {
    				uploadJson : '${pageContext.request.contextPath}/static/js/kindeditor-4.1.7/jsp/upload_json.jsp',
    				newlineTag : 'br',
    				afterUpload : function(url, data, name) { //�ϴ��ļ���ִ�еĻص�����������Ϊ3������
    		            if(name=="image" || name=="multiimage"){ //�����������ϴ�ͼƬʱ
    		                var img = new Image(); 
    		            	img.src = url;
    		                img.onload = function(){ //ͼƬ���������ɲ��ܻ�ȡ�ߴ�
    		                    if(img.width>383 || img.height > 649) {
    		                    	window.editor.html(window.editor.html().replace('<img src="' + url + '"','<img src="' + url + '"height="649" width="383"'));
    		                    }
    		                }
    		            }
    		        }
    			});
        });
        function saveNews(action,isPublish){
        	if($('#noticeSubject').val() == ''){
        		alert('�����빫����⣡');
        		return false;
        	}
        	if($('#beginDate').val() == ''){
        		alert('�����빫�濪ʼʱ�䣡');
        		return false;
        	}
        	if($('#endDate').val() == ''){
        		alert('�����빫��������ڣ�');
        		return false;
        	}
        	if($('#endDate').val() < $('#beginDate').val()){
        		alert('��ʼ���ڲ��ܴ��ڽ������ڣ�');
        		return false;
        	}
        	editor.sync();
        	var html = $('#editor_id').val();
        	if(html == ''){
        		alert('�����빫�����ݣ�');
        		return false;
        	}
    		$.ajax({

   		     type: 'POST',

   		     url: action,

   			    data : {
   					'id' : $('#newsId').val(),
   					'noticeType' : $('#noticeType').val(),
   					'noticeSubject' : $('#noticeSubject').val(),
   					'beginDate' : $('#beginDate').val(),
   					'endDate' : $('#endDate').val(),
   					'isPublish':isPublish,
   					'content' : html
   			} ,

   		    success: function (data){
   		    	if(isPublish == 0){
   		    		alert('�����ɹ���');
   		    	}else{
   		    		alert('����ɹ�!');
   		    	}
   		    	window.location.href = '${pageContext.request.contextPath}/supervise/news';
   		    } ,

   		    dataType: 'json',
   		    
   		    cache:false,
   		    
   		});
        }
        
</script>
</head>

<body>
<div class="page-wrapper">
 <jsp:include page="../header.jsp" />
  
  <input type="hidden" name="id" id="newsId" value="${websiteNotice.id}"/>
  <div id="contents">
    <div class="inner">
     <jsp:include page="../left.jsp">
    		<jsp:param value="news" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
        <h2>�������</h2>
        <div id="add_area">
          <dl class="clearfix date_list">
            <dt>�������ͣ�</dt>
            <dd class="select_input">
              <select class="form-control" id="noticeType">
                <option value="0" <c:if test="${websiteNotice.noticeType == '0'}">selected="selected"</c:if>>������Ϣ</option>
                <option value="1" <c:if test="${websiteNotice.noticeType == '1'}">selected="selected"</c:if>>��˾��̬</option>
              </select>
            </dd>
          </dl>
          <dl class="clearfix">
            <dt>���⣺</dt>
            <dd class="title_input">
              <input class="form-control" type="text" name="noticeSubject" id="noticeSubject" value="${websiteNotice.noticeSubject}" maxlength="100"/>
            </dd>
          </dl>
          <div class="date clearfix">
            <dl class="clearfix date">
              <dt>��ʼʱ�䣺</dt>
              <dd class="special">
                <div class="input-group">
                  <input type="text" id="beginDate" name="beginDate" value="${websiteNotice.beginDate}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon special"><i class="fa fa-calendar"></i></span>
                </div>
              </dd>
            </dl>
            <dl class="clearfix date last">
              <dt>����ʱ�䣺</dt>
              <dd class="special">
                <div class="input-group">
                  <input type="text" id="endDate" name="endDate" value="${websiteNotice.endDate}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon special"><i class="fa fa-calendar"></i></span>
                </div>
              </dd>
            </dl>
          </div>
          <dl class="clearfix">
            <dt>�������ݣ�</dt>
            <dd>
              <textarea id="editor_id" name="content" style="width:700px;height:300px;">
				${websiteNotice.contentString}
			</textarea>
            </dd>
          </dl>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="saveNews('${pageContext.request.contextPath}/supervise/news/saveNews','1')">����</button></li>
              <li><button type="button" class="btn btn-default red" onclick="saveNews('${pageContext.request.contextPath}/supervise/news/saveNews','0')">����</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="history.go(-1);">����</button></li>
            </ul>
          </div>
        </div>
         
      <!--#matter_section-->  
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
<script type="text/javascript">
function radioShow(){
 var myradio=document.getElementsByName("myradio");
 var div=document.getElementById("c").getElementsByTagName("div");
 for(i=0;i<div.length;i++){
  if(myradio[i].checked){
   div[i].style.display="block";
   }
   else{
   div[i].style.display="none";
   }
  }
 }
</script>
</body>
</html>
