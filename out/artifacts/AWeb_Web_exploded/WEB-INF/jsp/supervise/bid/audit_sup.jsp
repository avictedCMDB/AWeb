<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>供应商报名查看|中航招标网</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_project_check_form.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bid/management/common.js"></script>

</head>

<body>
  <div id="contents">
      <div class="inner">
          <div id="matter_section">
              <div class="result_section section">
                  <div class="result_inner">
                    <table class="table_area">
                        <tr>
                          <td colspan="4" class="name">基本信息</td>
                        </tr>
                        <tr>
                          <th>用户名<span class="red">*</span></th>
                          <td colspan="3">${sup.supUserNameCN}</td>
                        </tr>
                        <tr>
                          <th width="190">注册人姓名<span class="red">*</span></th>
                          <td width="205">${sup.supRegName }</td>
                          <th width="190">注册人性别</th>
                          <td width="205">${sup.supRegSex == '1' ? '女' : '男' }</td>
                        </tr>
                        <tr>
                          <th>注册人固定电话<span class="red">*</span></th>
                          <td>${sup.contactNum }</td>
                          <th>注册人传真</th>
                          <td>${sup.supRegFax }</td>
                        </tr>
                        <tr>
                          <th>注册人电子邮箱<span class="red">*</span></th>
                          <td>${sup.supRegEmail }</td>
                          <th>注册人移动电话<span class="red">*</span></th>
                          <td>${sup.supRegIphone }</td>
                        </tr>
                      </table>
                      <table class="table_area">
                        <tr>
                          <td colspan="4" class="name">机构信息</td>
                        </tr>
                        <tr>
                          <th width="190">企业名称<span class="red">*</span></th>
                          <td width="205">${comp.companyName }</td>
                          <th width="190">公司编号<span class="red">*</span></th>
                          <td width="205">${comp.companyCode }</td>
                        </tr>
                        <tr>
                          <th>企业名称（英文）</th>
                          <td colspan="3">${comp.companyNameEN }</td>
                        </tr>
                        <tr>
                          <th>国家/地区<span class="red">*</span></th>
                          <td>${comp.regAddrCountry }</td>
                          <th>企业所在地<span class="red">*</span></th>
                          <td>${comp.regAddrProvince } ${comp.regAddrCity }</td>
                        </tr>
                        <tr>
                          <th>组织机构代码证号</th>
                          <td>${comp.organizationCode}</td>
                          <th>组织机构代码证扫描件</th>
                          <td>&nbsp;</td>
                        </tr>
                         <tr>
                          <th>营业执照号码</th>
                          <td>${comp.licenceCode }</td>
                          <th class="last">营业执照扫描件</th>
                          <td class="last">&nbsp;</td>
                        </tr>
                        <tr>
                          <th>税务登记证号码</th>
                          <td>${comp.taxCode }</td>
                          <th class="last">税务登记证扫描件</th>
                          <td class="last">&nbsp;</td>
                        </tr>
                        <tr>
                          <th>组织人来源</th>
                          <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                          <th>经济类型</th>
                          <td>${comp.economicType }</td>
                          <th class="last">企业法人<span class="red">*</span></th>
                          <td class="last">${comp.corporationName }</td>
                        </tr>
                        <tr>
                          <th>注册资产</th>
                          <td>${comp.regFund }</td>
                          <th class="last">币种</th>
                          <td class="last">${comp.regCurrencyType }</td>
                        </tr>
                        <tr>
                          <th>企业负责人</th>
                          <td>${comp.responsibleName }</td>
                          <th class="last">企业负责人电话</th>
                          <td class="last">${comp.responsibleTel }</td>
                        </tr>
                        <tr>
                          <th>业务范围</th>
                          <td colspan="3">${comp.mainProduct }</td>
                        </tr>
                        <tr>
                          <th>通讯地址<span class="red">*</span></th>
                          <td>${comp.linkAddr }</td>
                          <th class="last">邮编</th>
                          <td class="last">${comp.linkPostCode }</td>
                        </tr>
                        <tr>
                          <th>职工人数</th>
                          <td>${comp.employees }</td>
                          <th class="last">技术人员人数</th>
                          <td class="last">${comp.technicalStaffNum }</td>
                        </tr>
                        <tr>
                          <th>企业传真</th>
                          <td>${comp.responsibleFax }</td>
                          <th class="last">企业电子邮箱</th>
                          <td class="last">${comp.responsibleEmail }</td>
                        </tr>
                        <tr>
                          <th>企业概述</th>
                          <td colspan="3">&nbsp;</td>
                        </tr>
                      </table>
                      <div class="submit_btn">
                          <ul>
                              <li><button class="btn btn-default blue" onclick="window.close();">关闭</button></li>
                          </ul>
                      </div>
                  </div>
              </div>
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>