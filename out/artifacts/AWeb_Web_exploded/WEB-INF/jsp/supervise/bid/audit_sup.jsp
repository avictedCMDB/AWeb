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
<title>��Ӧ�̱����鿴|�к��б���</title>
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
                          <td colspan="4" class="name">������Ϣ</td>
                        </tr>
                        <tr>
                          <th>�û���<span class="red">*</span></th>
                          <td colspan="3">${sup.supUserNameCN}</td>
                        </tr>
                        <tr>
                          <th width="190">ע��������<span class="red">*</span></th>
                          <td width="205">${sup.supRegName }</td>
                          <th width="190">ע�����Ա�</th>
                          <td width="205">${sup.supRegSex == '1' ? 'Ů' : '��' }</td>
                        </tr>
                        <tr>
                          <th>ע���˹̶��绰<span class="red">*</span></th>
                          <td>${sup.contactNum }</td>
                          <th>ע���˴���</th>
                          <td>${sup.supRegFax }</td>
                        </tr>
                        <tr>
                          <th>ע���˵�������<span class="red">*</span></th>
                          <td>${sup.supRegEmail }</td>
                          <th>ע�����ƶ��绰<span class="red">*</span></th>
                          <td>${sup.supRegIphone }</td>
                        </tr>
                      </table>
                      <table class="table_area">
                        <tr>
                          <td colspan="4" class="name">������Ϣ</td>
                        </tr>
                        <tr>
                          <th width="190">��ҵ����<span class="red">*</span></th>
                          <td width="205">${comp.companyName }</td>
                          <th width="190">��˾���<span class="red">*</span></th>
                          <td width="205">${comp.companyCode }</td>
                        </tr>
                        <tr>
                          <th>��ҵ���ƣ�Ӣ�ģ�</th>
                          <td colspan="3">${comp.companyNameEN }</td>
                        </tr>
                        <tr>
                          <th>����/����<span class="red">*</span></th>
                          <td>${comp.regAddrCountry }</td>
                          <th>��ҵ���ڵ�<span class="red">*</span></th>
                          <td>${comp.regAddrProvince } ${comp.regAddrCity }</td>
                        </tr>
                        <tr>
                          <th>��֯��������֤��</th>
                          <td>${comp.organizationCode}</td>
                          <th>��֯��������֤ɨ���</th>
                          <td>&nbsp;</td>
                        </tr>
                         <tr>
                          <th>Ӫҵִ�պ���</th>
                          <td>${comp.licenceCode }</td>
                          <th class="last">Ӫҵִ��ɨ���</th>
                          <td class="last">&nbsp;</td>
                        </tr>
                        <tr>
                          <th>˰��Ǽ�֤����</th>
                          <td>${comp.taxCode }</td>
                          <th class="last">˰��Ǽ�֤ɨ���</th>
                          <td class="last">&nbsp;</td>
                        </tr>
                        <tr>
                          <th>��֯����Դ</th>
                          <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                          <th>��������</th>
                          <td>${comp.economicType }</td>
                          <th class="last">��ҵ����<span class="red">*</span></th>
                          <td class="last">${comp.corporationName }</td>
                        </tr>
                        <tr>
                          <th>ע���ʲ�</th>
                          <td>${comp.regFund }</td>
                          <th class="last">����</th>
                          <td class="last">${comp.regCurrencyType }</td>
                        </tr>
                        <tr>
                          <th>��ҵ������</th>
                          <td>${comp.responsibleName }</td>
                          <th class="last">��ҵ�����˵绰</th>
                          <td class="last">${comp.responsibleTel }</td>
                        </tr>
                        <tr>
                          <th>ҵ��Χ</th>
                          <td colspan="3">${comp.mainProduct }</td>
                        </tr>
                        <tr>
                          <th>ͨѶ��ַ<span class="red">*</span></th>
                          <td>${comp.linkAddr }</td>
                          <th class="last">�ʱ�</th>
                          <td class="last">${comp.linkPostCode }</td>
                        </tr>
                        <tr>
                          <th>ְ������</th>
                          <td>${comp.employees }</td>
                          <th class="last">������Ա����</th>
                          <td class="last">${comp.technicalStaffNum }</td>
                        </tr>
                        <tr>
                          <th>��ҵ����</th>
                          <td>${comp.responsibleFax }</td>
                          <th class="last">��ҵ��������</th>
                          <td class="last">${comp.responsibleEmail }</td>
                        </tr>
                        <tr>
                          <th>��ҵ����</th>
                          <td colspan="3">&nbsp;</td>
                        </tr>
                      </table>
                      <div class="submit_btn">
                          <ul>
                              <li><button class="btn btn-default blue" onclick="window.close();">�ر�</button></li>
                          </ul>
                      </div>
                  </div>
              </div>
          <!--#matter_section--></div>
      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>