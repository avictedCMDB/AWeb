<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>商品比对管理|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/manage_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/management_campare.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/compare.js"></script>
<!-- <style media="print">  
            .noprint { display : none; }  
        </style>  
        <script language="JavaScript">  
            function doPrintSetup(){  
                //打印设置  
                printWB.ExecWB(8,1);
            }  
            function doPrintPreview(){  
                //打印预览  
                printWB.ExecWB(7,1);  
            }  
            function doPrint(){  
                //直接打印  
                printWB.ExecWB(6,6);
            }  
        </script> -->
<script language="javascript" src="${pageContext.request.contextPath}/Lodop/LodopFuncs.js"></script>
<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="install_lodop32.exe"></embed>
</object> 
<script language="javascript" type="text/javascript">
    var LODOP; //声明为全局变量 
	function prn_preview() {	
		$("#downloadDiv").empty();
		CreatePrintPage();
		LODOP.SET_PREVIEW_WINDOW(1,0,0,0,0,"");		
		LODOP.PREVIEW();	
	};
	function CreatePrintPage(){
		LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));  
		LODOP.ADD_PRINT_HTM(5,5,"100%","100%","<body leftmargin=0 topmargin=0>"+document.getElementById('div01').innerHTML+"</body>");
		LODOP.SET_PREVIEW_WINDOW(0,0,0,0,0,"");	
	};	
</script> 
</head>
<body>
<div id="downloadDiv"></div>
<div class="page-wrapper">
  <jsp:include page="header.jsp" />  
  <div id="contents">
    <div class="inner">
      <jsp:include page="left_menu.jsp">
		  <jsp:param name="menu" value="compare" />
	  </jsp:include>
      <!-- 点击取消跳转到商品页面 -->
      <input id="path" type="hidden" value="${pageContext.request.contextPath}">
      <form id="commitForm" method="post">
      	<input type="hidden" id="supOneID" name="supOneID" value="${goodsToCampare.supOneID}"/>
      	<input type="hidden" id="supTwoID" name="supTwoID" value="${goodsToCampare.supTwoID}"/>
      	<input type="hidden" id="supThreeID" name="supThreeID" value="${goodsToCampare.supThreeID}"/>
      	<input type="hidden" id="supFourID" name="supFourID" value="${goodsToCampare.supFourID}"/>
      	<input type="hidden" id="supGoodsOneID" name="supGoodsOneID" value="${goodsToCampare.supGoodsOneID}"/>
      	<input type="hidden" id="supGoodsTwoID" name="supGoodsTwoID" value="${goodsToCampare.supGoodsTwoID}"/>
      	<input type="hidden" id="supGoodsThreeID" name="supGoodsThreeID" value="${goodsToCampare.supGoodsThreeID}"/>
      	<input type="hidden" id="supGoodsFourID" name="supGoodsFourID" value="${goodsToCampare.supGoodsFourID}"/>
      	<input type="hidden" id="returnUrl" name="returnUrl" value="${goodsToCampare.returnUrl}"/>
      	<input type="hidden" id="chooseGoodsIndex" name="chooseGoodsIndex"/>
      	<input type="hidden" id="ProCheckedReason" name="ProCheckedReason"/>
      	<input type="hidden" id="remark" name="remark"/>
      	<input type="hidden" id="supGoodsOneImagePath" name="supGoodsOneImagePath" value="${supGoodsMap['one'].imagePath}"/>
      	<input type="hidden" id="supGoodsOneGoodsName" name="supGoodsOneGoodsName" value="${supGoodsMap['one'].goodsName}"/>
      	<input type="hidden" id="supGoodsOneAgreePrice" name="supGoodsOneAgreePrice" value="${supGoodsMap['one'].agreePrice}"/>
      	<input type="hidden" id="supGoodsOneBrandName" name="supGoodsOneBrandName" value="${supGoodsMap['one'].brandName}"/>
      	<input type="hidden" id="supGoodsOneProductArea" name="supGoodsOneProductArea" value="${supGoodsMap['one'].productArea}"/>
      	<input type="hidden" id="supGoodsTwoImagePath" name="supGoodsTwoImagePath" value="${supGoodsMap['two'].imagePath}"/>
      	<input type="hidden" id="supGoodsTwoGoodsName" name="supGoodsTwoGoodsName" value="${supGoodsMap['two'].goodsName}"/>
      	<input type="hidden" id="supGoodsTwoAgreePrice" name="supGoodsTwoAgreePrice" value="${supGoodsMap['two'].agreePrice}"/>
      	<input type="hidden" id="supGoodsTwoBrandName" name="supGoodsTwoBrandName" value="${supGoodsMap['two'].brandName}"/>
      	<input type="hidden" id="supGoodsTwoProductArea" name="supGoodsTwoProductArea" value="${supGoodsMap['two'].productArea}"/>
      	<input type="hidden" id="supGoodsThreeImagePath" name="supGoodsThreeImagePath" value="${supGoodsMap['three'].imagePath}"/>
      	<input type="hidden" id="supGoodsThreeGoodsName" name="supGoodsThreeGoodsName" value="${supGoodsMap['three'].goodsName}"/>
      	<input type="hidden" id="supGoodsThreeAgreePrice" name="supGoodsThreeAgreePrice" value="${supGoodsMap['three'].agreePrice}"/>
      	<input type="hidden" id="supGoodsThreeBrandName" name="supGoodsThreeBrandName" value="${supGoodsMap['three'].brandName}"/>
      	<input type="hidden" id="supGoodsThreeProductArea" name="supGoodsThreeProductArea" value="${supGoodsMap['three'].productArea}"/>
      	<input type="hidden" id="supGoodsFourImagePath" name="supGoodsFourImagePath" value="${supGoodsMap['four'].imagePath}"/>
      	<input type="hidden" id="supGoodsFourGoodsName" name="supGoodsFourGoodsName" value="${supGoodsMap['four'].goodsName}"/>
      	<input type="hidden" id="supGoodsFourAgreePrice" name="supGoodsFourAgreePrice" value="${supGoodsMap['four'].agreePrice}"/>
      	<input type="hidden" id="supGoodsFourBrandName" name="supGoodsFourBrandName" value="${supGoodsMap['four'].brandName}"/>
      	<input type="hidden" id="supGoodsFourProductArea" name="supGoodsFourProductArea" value="${supGoodsMap['four'].productArea}"/>
      	<c:if test="${!empty goodsToCampare.supCheckedID}">
      		<input type="hidden" id="compareID" name="compareID" value="${goodsToCampare.compareID}"/>
	      	<input type="hidden" id="supCheckedID" name="supCheckedID" value="${goodsToCampare.supCheckedID}"/>
	      	<input type="hidden" id="supGoodsCheckedID" name="supGoodsCheckedID" value="${goodsToCampare.supGoodsCheckedID}"/>
      	</c:if>
      </form>
   <!-- 需要打印的div 内容放到此div最后那个 -->
   <div id="div01" style="width: 515; height: 326">
      <div id="matter_section">
      	<h2>商品比对管理</h2>
      	<div class="section clearfix search_result detail_list">
          <table>
            <tr>
              <th width="100px">商品图片</th>
                <c:choose>
                	<c:when test="${empty goodsToCampare.supOneID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
	                	    <td width="200" class="add">
	                			<p class="none">暂无比对项</p><a href="javascript:void(0);" onclick="cancle();" >添加</a>
	                		</td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td width="200">
                		<p><img src="${supGoodsMap['one'].imagePath}" width="180" height="160"/></p>
                		<p>${supGoodsMap["one"].goodsName}</p>
                	   </td>
                	</c:otherwise>
                </c:choose>
                <c:choose>
                	<c:when test="${empty goodsToCampare.supTwoID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
	                	   <td width="200" class="add">
	                		<p class="none">暂无比对项</p><a href="javascript:void(0);" onclick="cancle();">添加</a>
                			</td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<td width="200">
                		<p><img src="${supGoodsMap['two'].imagePath}"  width="180" height="160"/></p>
                		<p>${supGoodsMap["two"].goodsName}</p>
                	   </td>
                	</c:otherwise>
                </c:choose>
                <c:choose>
                	<c:when test="${empty goodsToCampare.supThreeID}">
                	   <c:if test="${empty goodsToCampare.supCheckedID}">
	                	   <td width="200" class="add">
	                		<p class="none">暂无比对项</p><a href="javascript:void(0);" onclick="cancle();">添加</a>
                			</td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<td width="200">
                		<p><img src="${supGoodsMap['three'].imagePath}" width="180" height="160" /></p>
                		<p>${supGoodsMap["three"].goodsName}</p>
                	   </td>
                	</c:otherwise>
                </c:choose>
                <c:choose>
                	<c:when test="${empty goodsToCampare.supFourID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
	                	   <td width="200" class="add">
	                		<p class="none">暂无比对项</p><a href="javascript:void(0);" onclick="cancle();">添加</a>
                			</td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<td width="200">
                		<p><img src="${supGoodsMap['four'].imagePath}" width="180" height="160" /></p>
                		<p>${supGoodsMap["four"].goodsName}</p>
                	   </td>
                	</c:otherwise>
                </c:choose>
            </tr>
            <tr>
              <th>价格</th>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supOneID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
                			<td class="price"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<td class="price">￥${supGoodsMap["one"].agreePrice}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supTwoID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
                			<td class="price"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<td class="price">￥${supGoodsMap["two"].agreePrice}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supThreeID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
                			<td class="price"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<td class="price">￥${supGoodsMap["three"].agreePrice}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supFourID}">
                	   <c:if test="${empty goodsToCampare.supCheckedID}">
                			<td class="price"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<td class="price">￥${supGoodsMap["four"].agreePrice}</td>
                	</c:otherwise>
              </c:choose>
            </tr>
            <tr>
              <th>品牌</th>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supOneID}">
	                	<c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["one"].brandName}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supTwoID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["two"].brandName}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supThreeID}">
                	   <c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["three"].brandName}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supFourID}">
                	   <c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["four"].brandName}</td>
                	</c:otherwise>
              </c:choose>
            </tr>
            <tr>
              <th>产地</th>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supOneID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["one"].productArea}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supTwoID}">
                	   <c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["two"].productArea}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supThreeID}">
                	   <c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["three"].productArea}</td>
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supFourID}">
                	   <c:if test="${empty goodsToCampare.supCheckedID}">
	                		<td></td>
	                	</c:if>
                	</c:when>
                	<c:otherwise>
                		<td>${supGoodsMap["four"].productArea}</td>
                	</c:otherwise>
              </c:choose>
            </tr>
            <c:if test="${empty goodsToCampare.supCheckedID}">
	            <tr>
	              <th>移除操作</th>
	              <c:choose>
	                	<c:when test="${empty goodsToCampare.supOneID}">
	                	   <td></td>
	                	</c:when>
	                	<c:otherwise>
	                		<td><a href="javascript:void(0);" onclick="removeSupGoods(1);">移除</a></td>
	                	</c:otherwise>
	              </c:choose>
	              <c:choose>
	                	<c:when test="${empty goodsToCampare.supTwoID}">
	                	   <td></td>
	                	</c:when>
	                	<c:otherwise>
	                		<td><a href="javascript:void(0);" onclick="removeSupGoods(2);">移除</a></td>
	                	</c:otherwise>
	              </c:choose>
	              <c:choose>
	                	<c:when test="${empty goodsToCampare.supThreeID}">
	                	   <td></td>
	                	</c:when>
	                	<c:otherwise>
	                		<td><a href="javascript:void(0);" onclick="removeSupGoods(3);">移除</a></td>
	                	</c:otherwise>
	              </c:choose>
	              <c:choose>
	                	<c:when test="${empty goodsToCampare.supFourID}">
	                	   <td></td>
	                	</c:when>
	                	<c:otherwise>
	                		<td><a href="javascript:void(0);" onclick="removeSupGoods(4);">移除</a></td>
	                	</c:otherwise>
	              </c:choose>
	              
	            </tr>
            </c:if>
            <tr>
              <th class="last">是否选购</th>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supOneID}">
            	    	<c:if test="${empty goodsToCampare.supCheckedID}">
                	   	 	<td><input type="radio" name="optionsRadiosinline" id="optionsRadios1" value="1" disabled="disabled"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<c:choose>
                			<c:when test="${goodsToCampare.supGoodsOneID != goodsToCampare.supGoodsCheckedID}">
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios1" value="1"></td>
                			</c:when>
                			<c:otherwise>
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios1" value="1" checked></td>
                			</c:otherwise>
                		</c:choose>
                		 
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supTwoID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
                	    	<td><input type="radio" name="optionsRadiosinline" id="optionsRadios2" value="2" disabled="disabled"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<c:choose>
                			<c:when test="${goodsToCampare.supGoodsTwoID != goodsToCampare.supGoodsCheckedID}">
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios2" value="2"></td>
                			</c:when>
                			<c:otherwise>
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios2" value="2" checked></td>
                			</c:otherwise>
                		</c:choose>
                		 
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supThreeID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
                	    	<td><input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="3" disabled="disabled"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<c:choose>
                			<c:when test="${goodsToCampare.supGoodsThreeID != goodsToCampare.supGoodsCheckedID}">
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="3"></td>
                			</c:when>
                			<c:otherwise>
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="3" checked></td>
                			</c:otherwise>
                		</c:choose>
                		 
                	</c:otherwise>
              </c:choose>
              <c:choose>
                	<c:when test="${empty goodsToCampare.supFourID}">
                		<c:if test="${empty goodsToCampare.supCheckedID}">
                	    	<td><input type="radio" name="optionsRadiosinline" id="optionsRadios4" value="4" disabled="disabled"></td>
                		</c:if>
                	</c:when>
                	<c:otherwise>
                		<c:choose>
                			<c:when test="${goodsToCampare.supGoodsFourID != goodsToCampare.supGoodsCheckedID}">
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios4" value="4"></td>
                			</c:when>
                			<c:otherwise>
                				<td><input type="radio" name="optionsRadiosinline" id="optionsRadios4" value="4" checked></td>
                			</c:otherwise>
                		</c:choose>
                	</c:otherwise>
              </c:choose>
            </tr>
            <tr>
              <th>采购理由</th>
              <td colspan="4">
              		 <c:forEach var="reasonCode" items="${reasonCodes}" varStatus="status">
              		      <c:choose>
              		      	<c:when test="${goodsToCampare.checkedReasonList.size()>0}">
	              		      		<c:choose>
		                				<c:when test="${fn:contains(goodsToCampare.checkedReasonList, reasonCode.codeValue)}">
		                					<label class="checkbox-inline"><input type="checkbox" name="reasonRadiosinline" value="${reasonCode.codeValue}" checked>${reasonCode.codeText}</label>
		                				</c:when>
		                				<c:otherwise>
		                					<label class="checkbox-inline"><input type="checkbox" name="reasonRadiosinline" value="${reasonCode.codeValue}">${reasonCode.codeText}</label>
		                				</c:otherwise>
		                			</c:choose>
	                	   </c:when>
	                	   <c:otherwise>
		                		<label class="checkbox-inline"><input type="checkbox" name="reasonRadiosinline" value="${reasonCode.codeValue}">${reasonCode.codeText}</label>
	                	   </c:otherwise>
              		      </c:choose>
              		      
              		</c:forEach>
              </td>
            </tr>
            <tr>
              <th>补充说明</th>
              			<c:choose>
                			<c:when test="${empty goodsToCampare.supCheckedID}">
                				<td colspan="4"><textarea id="remarkTRA" name="remarkTRA" rows="3" class="form-control"></textarea></td>
                			</c:when>
                			<c:otherwise>
                				<td colspan="4"><textarea id="remarkTRA" name="remarkTRA" rows="3" class="form-control">${goodsToCampare.remark}</textarea></td>
                			</c:otherwise>
                		</c:choose>
              
            </tr>
            
          </table>
          <div class="btn_list">
            <ul>
              <li><button class="btn btn-default red" type="button" onclick="addCart();">添加到购物车</button></li>
              <c:choose>
                <c:when test="${empty goodsToCampare.supCheckedID}">
              		<li><button class="btn btn-default gray" type="button" onclick="cancle();">取消</button></li>
            	</c:when>
            	<c:otherwise>
            		<li><button class="btn btn-default gray" type="button" onclick="cancleToList();">取消</button></li>
            	</c:otherwise>
              </c:choose>
              <!-- <li><button class="btn btn-default red" type="button" onclick="javascript:prn_preview();">打印</button></li> -->
            	<li><button class="btn btn-default red" type="button" onclick="downLoadPDF();">导出PDF</button></li>
            </ul>
          </div>
          
          
        <!--.search_area--></div>
      <!--#matter_section-->	
      </div>
     </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="footer.jsp"/>
<!--.page-wrapper--></div>
</body>
</html>