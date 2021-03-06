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
<title>采购监管平台|中航招标网</title>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function query(action){
	
	document.getElementById("queryForm").action=action;
	document.getElementById("queryForm").submit();
	
}
function toPage(action){
	window.location.href = action;
}
function updateIsPublish(action ,id,isPublish,noticeSubject){
	if (isPublish == 0) {
		if(confirm("公告【"+noticeSubject+"】已发布，是否撤销发布？")){
			$.ajax({

			     type: 'POST',

			     url: action,

				    data : {
					'isPublish' : '1',
					'id' : id
				} ,

			    success: function (data){
			    	alert('【'+noticeSubject+'】撤销发布成功！');
			    	query('${pageContext.request.contextPath}/supervise/news');
			    } ,

			    dataType: 'json',
			    
			    cache:false,
			    
			});
		}
	}else{
		if(confirm("是否发布【"+noticeSubject+"】公告？")){
			$.ajax({

			     type: 'POST',

			     url: action,

				    data : {
						'isPublish' : '0',
						'id' : id
				} ,

			    success: function (data){
			    	alert('【'+noticeSubject+'】发布成功！');
			    	query('${pageContext.request.contextPath}/supervise/news');
			    } ,

			    dataType: 'json',
			    
			    cache:false,
			    
			});
		}
	}
}
function updateIsTop(action ,id,isTop,noticeSubject){
	if (isTop == 0) {
		if(confirm("公告【"+noticeSubject+"】已置顶，是否撤销置顶？")){
			$.ajax({

			     type: 'POST',

			     url: action,

				    data : {
					'isTop' : '1',
					'id' : id
				} ,

			    success: function (data){
			    	alert('【'+noticeSubject+'】撤销置顶成功！');
			    	query('${pageContext.request.contextPath}/supervise/news');
			    } ,

			    dataType: 'json',
			    
			    cache:false,
			    
			});
		}
	}else{
		if(confirm("是否置顶【"+noticeSubject+"】公告？")){
			$.ajax({

			     type: 'POST',

			     url: action,

				    data : {
						'isTop' : '0',
						'id' : id
				} ,

			    success: function (data){
			    	alert('【'+noticeSubject+'】置顶成功！');
			    	query('${pageContext.request.contextPath}/supervise/news');
			    } ,

			    dataType: 'json',
			    
			    cache:false,
			    
			});
		}
	}
}
function deleteNews(action ,id,noticeSubject){
	if(confirm("是否删除公告【"+noticeSubject+"】？")){
		$.ajax({

		     type: 'POST',

		     url: action,

			    data : {
					'id' : id
			} ,

		    success: function (data){
		    	alert('【'+noticeSubject+'】删除成功！');
		    	query('${pageContext.request.contextPath}/supervise/news');
		    } ,

		    dataType: 'json',
		    
		    cache:false,
		    
		});
	}
}

</script>

</head>

<body>
<div class="page-wrapper">
  <jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../left.jsp">
    		<jsp:param value="news" name="menu"/>
    	</jsp:include>
      <div id="matter_section">
      	<h2>公告管理</h2>
      	<div class="search_area section">
      	<form id="queryForm">
          <div class="search_list clearfix">
            <dl class="clearfix first">
              <dt>标题：</dt>
              <dd>
                <input type="text" class="form-control" name="noticeSubject" value="${websiteNoticeParam.noticeSubject}"/>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>类型：</dt>
              <dd>
                <select class="form-control" name="noticeType">
                  <option value="" selected="selected">全部</option>
                  <option value="0"  <c:if test="${websiteNotice.noticeType == '0'}">selected="selected"</c:if>>公告信息</option>
                  <option value="1" <c:if test="${websiteNotice.noticeType == '1'}">selected="selected"</c:if>>公司动态</option>
                </select>
              </dd>
            </dl>
            <dl class="clearfix last">
              <dt>发布时间</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" name="publishSatrDate" value="${websiteNoticeParam.publishSatrDate}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>至</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" name="publishEndDate" value="${websiteNoticeParam.publishEndDate}" class="form-control special_input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red" onclick="query('${pageContext.request.contextPath}/supervise/news')">查询</button></li>
              <li><button type="button" class="btn btn-default red" onclick="toPage('${pageContext.request.contextPath}/supervise/news/inserPage')">新增</button></li>
            </ul>
          </div>
          </form>
        <!--.search_area--></div>
      	<div class="search_result section">
          <table border="0">
            <tr>
              <th width="90">标题</th>
              <th width="50">类型</th>
              <th width="50">已阅者</th>
              <th width="50">发布</th>
              <th width="50">置顶</th>
              <th width="50">发布时间</th>
              <th width="140" class="last">操作</th>
            </tr>
            <c:forEach var="websiteNotice" items="${websiteNoticeList}" varStatus="status">
	            <tr>
	               <td>${websiteNotice.noticeSubject}</td>
	               <td>
	               		<c:if test="${websiteNotice.noticeType == '0'}">
	               			公告信息
	               		</c:if>
	               		<c:if test="${websiteNotice.noticeType == '1'}">
	               			公司动态
	               		</c:if>
	               </td>
	               <td>${websiteNotice.browseCount}</td>
	               <td>
				   		<c:if test="${websiteNotice.isPublish == '0'}">
	               			是
	               		</c:if>
	               		<c:if test="${websiteNotice.isPublish == '1'}">
	               			否
	               		</c:if>
				   </td>
				   <td>
				   		<c:if test="${websiteNotice.isTop == '0'}">
	               			是
	               		</c:if>
	               		<c:if test="${websiteNotice.isTop == '1'}">
	               			否
	               		</c:if>
				   </td>
	               <td>${websiteNotice.publishDate}</td>
	               <td><a href="#" onclick="updateIsPublish('${pageContext.request.contextPath}/supervise/news/updateIsPublish','${websiteNotice.id}','${websiteNotice.isPublish}','${websiteNotice.noticeSubject}')">
	               	   <c:if test="${websiteNotice.isPublish == '0'}">
	               			撤销发布
	               		</c:if>
	               		<c:if test="${websiteNotice.isPublish == '1'}">
	               			发布
	               		</c:if>
	               	    </a>
	               	    <a href="#" onclick="updateIsTop('${pageContext.request.contextPath}/supervise/news/updateIsTop','${websiteNotice.id}','${websiteNotice.isTop}','${websiteNotice.noticeSubject}')">
	               	   <c:if test="${websiteNotice.isTop == '0'}">
	               			撤销置顶
	               		</c:if>
	               		<c:if test="${websiteNotice.isTop == '1'}">
	               			置顶
	               		</c:if>
	               	    </a>
		               <a href="#" onclick="toPage('${pageContext.request.contextPath}/supervise/news/updatePage?id=${websiteNotice.id}')">修改</a>
		               <a href="#" onclick="deleteNews('${pageContext.request.contextPath}/supervise/news/deleteNews','${websiteNotice.id}','${websiteNotice.noticeSubject}')">删除</a>
		           </td>
	            </tr>
            </c:forEach>
          </table>
        <!--.search_result--></div>
      	<jsp:include page="../page.jsp" />
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

