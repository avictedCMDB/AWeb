<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>��Ӧ�̹�������|�к��ɹ���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/supplier_delivery.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/supplierUtil.js"></script>
</head>

<body>
<div class="page-wrapper">
<jsp:include page="../header.jsp" />
  
  
  <div id="contents">
    <div class="inner">
    	
    	<jsp:include page="../menu.jsp" />
      <div id="matter_section">
      	<h2>��������</h2>
      	<form id="queryForm" method="post">
      	<div class="search_area section">
          <div class="search_list clearfix">
            <dl class="clearfix">
              <dt>�µ�ʱ��</dt>
              <dd>
                <ul class="clearfix">
                  <li>
                    <div class="input-group">
                      <input type="text" class="form-control special_input">
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                  <li>��</li>
                  <li class="last">
                    <div class="input-group">
                      <input type="text" class="form-control special_input">
                      <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                  </li>
                </ul>
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>�������</dt>
              <dd>
                <input type="text" class="form-control">
              </dd>
            </dl>
            <dl class="last clearfix">
              <dt>�ɹ���λ</dt>
              <dd>
                <input type="text" class="form-control">
              </dd>
            </dl>
            <dl class="clearfix">
              <dt>������ַ</dt>
              <dd class="special_list">
                <select class="form-control" name="area" id="area" onchange="queryAreaSub('${pageContext.request.contextPath}/supplier/delivery/loadSubArea')">
                  <option value="">��ѡ��</option>
                  <c:forEach var="areas" items="${areasList}" varStatus="status">
				      <option value="${areas.supAreaID}">${areas.supAreaName}</option>
				  </c:forEach>
            	</select>
                <select class="form-control" name="areaSub" id="areaSub" onchange="queryAreaSubTo('${pageContext.request.contextPath}/supplier/delivery/loadSubArea')">
            	</select>
                <select class="form-control" name="areaLast" id="areaLast">
            </select>
              </dd>
            </dl>
          </div>
          <div class="btn_list">
            <ul>
              <li><button type="button" class="btn btn-default red">��ѯ</button></li>
              <li><button type="button" class="btn btn-default gray" onclick="clearForm(this.form)">���</button></li>
            </ul>
          </div>
        <!--.search_area--></div>
        </form>
      	<div class="search_result">
          <div class="state_list">
            <ul>
              <li class="active"><a href="#">��������Ϣ</a></li>
              <li><a href="#">��������Ϣ</a></li>
              <li class="delete"><button class="btn btn-default red" type="button">���ɷ�����</button></li>
            </ul>
          </div>
          <table border="0">
            <tr>
              <th colspan="3">��Ʒ��Ϣ</th>
              <th width="95">����(Ԫ)</th>
              <th width="75">��������</th>
              <th width="95">����������</th>
              <th width="110">���(Ԫ)</th>
              <th width="110" class="last">����</th>
            </tr>
            <tr class="company">
              <td colspan="8" class="order_info">
                <input type="checkbox"><span>�к�����</span><span>���� ������ ������ ����������·5��Զ������B��20���к���ó</span><span>������</span><span>01084891594</span>
              </td>
            </tr>
            <tr class="company">
              <td colspan="8" class="order_info order_num">
                <input type="checkbox"><span>2016-03-18</span><span>�����ţ�<a href="#">D10000311000</a></span>
              </td>
            </tr>
            <tr>
              <td width="40"><input type="checkbox"></td>
              <td class="right_none"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" /></a></p></td>
              <td width="387" class="left_none"><a href="#">���� M&G ��������ճ����ֽAS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
              <td class="price">1.54</td>
              <td class="num">10</td>
              <td>1</td>
              <td class="price">1.54</td>
              <td><a href="#">���ɷ�����</a></td>
            </tr>
            <tr>
              <td width="40"><input type="checkbox"></td>
              <td class="right_none"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" /></a></p></td>
              <td width="387" class="left_none"><a href="#">���� M&G ��������ճ����ֽAS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
              <td class="price">1.54</td>
              <td class="num">10</td>
              <td>1</td>
              <td class="price">1.54</td>
              <td><a href="#">���ɷ�����</a></td>
            </tr>
            <tr>
              <td width="40"><input type="checkbox"></td>
              <td class="right_none"><p class="img_pro"><a href="#"><img src="img/management/img-order.jpg" /></a></p></td>
              <td width="387" class="left_none"><a href="#">���� M&G ��������ճ����ֽAS32A10110 3"*2" 76mm*51mm 100ҳ/������ɫ��40��/��</a></td>
              <td class="price">1.54</td>
              <td class="num">10</td>
              <td>1</td>
              <td class="price">1.54</td>
              <td><a href="#">���ɷ�����</a></td>
            </tr>
            
          </table>
        <!--.search_result--></div>
      	<div class="page">
          <ul class="pagination">
            <li><a href="#">&laquo;</a></li>
            <li><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li class="active"><a href="#">3</a></li>
            <li>...</li>
            <li><a href="#">99</a></li>
            <li><a href="#">100</a></li>
            <li><a href="#">&raquo;</a></li>
          </ul>
        </div>
      <!--#matter_section-->	
      </div>
    <!--.inner--></div>
  <!--#contents--></div>
<jsp:include page="../footer.jsp" />
<!--.page-wrapper--></div>
</body>
</html>