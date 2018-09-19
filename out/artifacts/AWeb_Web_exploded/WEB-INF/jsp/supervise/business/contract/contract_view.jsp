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
<title>�ɹ����ƽ̨|�к��б���</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/bid_contract_info_new.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/fonts/font-awesome/css/font-awesome.css" rel="stylesheet">
<!-- Fontello CSS -->
<link href="${pageContext.request.contextPath}/static/fonts/fontello/css/fontello.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/rollover.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my97DatePicker/My97DatePicker/WdatePicker.js"></script></link>


</head>


<body>

  <div id="contents">
      <div class="inner">
          <div id="matter_section">
              <h2>�ɹ���ͬ</h2>
              <p class="code">��ͬ��ţ�${contract.contractId}</p>
              <div class="summary">
                <p><span class="border_bottom">${proj.purchaserName }</span>�����¼�ơ��׷������� <span class="border_bottom">${sup.supName }</span>�����¼�ơ��ҷ�������ƽ�ȡ���Ը����ƽ����ʵ����֮�����ϣ��ͼ׷�<span class="border_bottom">${proj.projName }</span>��Ŀ����Ŀ���<span class="border_bottom">${proj.projId}</span>�����ҷ��ɹ�<span class="border_bottom">${subs }</span>���ˣ����Ѻ�Э��һ�£���������ͬ�����ʹ�ͬ���ء�</p>
              </div>
              <div class="section list_notice">
                  <h3>һ�������嵥���۸�</h3>
                  <div class="notice_inner add_inner">
                    <table>
                      <tr>
                        <th width="60">���</th>
                        <th>Ʒ��</th>
                        <th width="100">����ͺ�</th>
                        <th width="80">����</th>
                        <th width="200">�������</th>
                      </tr>
                      <c:forEach varStatus="sta" var="i" items="${mtrs }">
                      <tr>
                        <td>${sta.index + 1 }</td>
                        <td>${i.materBrand }</td>
                        <td>${i.materModel }</td>
                        <td>${i.materNum }</td>
                        <td>${i.subjectName }</td>
                      </tr>
                      </c:forEach>
                    </table>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>������ͬ�ܽ��</h3>
                  <div class="notice_inner">
                    <p>��ͬ�ܽ��Ϊ������ң���д��<span class="border_bottom">${total }</span>��Сд��<span class="border_bottom"><fmt:formatNumber value="${sup.realCurrentQuota }" currencySymbol="" type="currency"></fmt:formatNumber></span>�����ú�ͬ�ܽ���Ѱ���<span class="border_bottom">${aparam.p2 }</span>������ѡ����շ��Լ��������õȣ���</p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>�������ʽ������ </h3>
                  <div class="notice_inner">
                    <p class="none-indent">1�����ʽ��<span class="border_bottom">${aparam.p3_1 }</span></p>
                    <p class="none-indent">2��������ȣ�<span class="border_bottom">${aparam.p3_2}</span></p>
                    <p class="none-indent">3������Լ����<span class="border_bottom">${aparam.p3_3 }</span></p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>�ġ����ｻ�� </h3>
                  <div class="notice_inner">
                    <p>1������ʱ�䣺<span class="border_bottom">${aparam.p4_1 }</span></p>
                    <p>2�������ص㣺<span class="border_bottom">${aparam.p4_2 }</span></p>
                    <p>3���ջ��ˣ�<span class="border_bottom">${aparam.p4_3_1 }</span>����ϵ��ʽ��<span class="border_bottom">${aparam.p4_3_2 }</span></p>
                    <p>4��������ʽ��<span class="border_bottom">${aparam.p4_4 }</span></p>
                    <p>5�����估���óе���<span class="border_bottom">${aparam.p4_5 }</span></p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>�塢����Ȩ������ת��</h3>
                  <div class="notice_inner">
                    <p>��ͬ���»�����ʧ������ķ��գ��Ի��ｻ����ת�����׷����ڼ׷�δ���屾��ͬ�ܼۿ���ǰ����ͬ���»��������Ȩ���ҷ����С�</p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>������������</h3>
                  <div class="notice_inner">
                    <p>1���׷�Ӧ������ȡ��������ִ�׷�ָ���ص㵱�հ��ձ���ͬԼ����׼�Ի���������գ�����ó�������ģ�������׼<span class="border_bottom">${aparam.p6_1_1 }</span>����������<span class="border_bottom">${aparam.p6_1_2 }</span></p>
                    <p>2������Ʒ�ơ��ͺš������������Ȳ����ϱ���ͬԼ���ģ��׷�Ӧ����Ϊ���ܻ����ͬʱ�����ջ���<span class="border_bottom">${aparam.p6_2_1 }</span>�������ҷ�������顣�ҷ��ڽӵ��׷�����֪ͨ��<span class="border_bottom">${aparam.p6_2_2 }</span>���ڣ�Ӧ���Ի���������к˲飬�羭�ҷ�ȷ�ϻ����������ȷʵ���ڣ��ҷ�Ӧ������ȷ�Ϻ�<span class="border_bottom">${aparam.p6_2_3 }</span>���ڣ���ȡ��������������ȴ�ʩ�ﵽ����ͬԼ����׼�����˫���Ի������ս���������飬˫��ͬ����<span class="border_bottom">${aparam.p6_2_4 }</span>������������������Ի�����м��飬�����ܸü�������ļ������϶�������׷����ջ���<span class="border_bottom">${aparam.p6_2_5 }</span>����δ���ҷ��������ģ���Ϊ�������պϸ� </p>
                    <p>3���������պϸ��<span class="border_bottom">${aparam.p6_3 }</span>���ڣ��׷�Ӧ���ҷ��������պϸ񱨸档</p>
                    <p>4���׷�������ԭ�򱣹ܡ�ʹ�á��������Ƶ���ɻ��������½��ģ�����������顣</p>
                    <p>5������Լ����<span class="border_bottom">${aparam.p6_5 }</span></p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>�ߡ�������׼</h3>
                  <div class="notice_inner">
                    <p>����������������׼�������µ�<span class="border_bottom">${aparam.p7_0 }</span>��ִ�У�</p>
                    <p>1������<span class="border_bottom">${aparam.p7_1 }</span>1.��׼ִ�У����ұ�׼/��ҵ��׼/�������ұ�׼����</p>
                    <p>2��������ִ�У�������Ϊ����ͬ�ĸ�����</p>
                    <p>3����˫���̶�Ҫ��ִ�У�����Ҫ��Ϊ<span class="border_bottom">${aparam.p7_3 }</span></p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>�ˡ���װҪ��</h3>
                  <div class="notice_inner">
                    <p>��˫�����й涨�⣬�ҷ��ṩ�Ļ����Ӧ����׼������ʩ���а�װ���ð�װӦ��Ӧ��Զ�������䡢���������𡢷���ͷ�Ұ��װж����ȷ�����ﰲȫ�����˵ּ׷�ָ���Ľ����ص㡣���ڰ�װ����������Ļ��������ʧ�����ҷ��е����Ρ�</p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>�š��ʱ���</h3>
                  <div class="notice_inner">
                    <p>1������ͬ���µĻ����ʱ���Ϊ<span class="border_bottom">${aparam.p9_1_1 }</span>�꣬��<span class="border_bottom">${aparam.p9_1_2 }</span>���㡣</p>
                    <p>2���ʱ����ڣ��ҷ����յ��׷��������ⷴ����Ӧ��<span class="border_bottom">${aparam.p9_2 }</span></span>��֮�ڲ�ȡ�������������˻��ȴ�ʩ�����</p>
                    <p>3������Լ����<span class="border_bottom">${aparam.p9_3 }</span></p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>ʮ��ΥԼ����</h3>
                  <div class="notice_inner">
                    <p>1���׷�ΥԼ���Σ�</p>
                    <div class="response">
                      <p>��1���׷���;�˻��ģ�Ӧ���ҷ��⳥�˻����ֻ���<span class="border_bottom">${aparam.p10_1_1 }</span>��ΥԼ��</p>
                      <p>��2���׷�δ��˫��Լ��ʱ���ṩ����Ҫ�󡢰�װ��Ҫ��ģ����ҷ��Ľ������ڵ���˳���⣬ÿ˳��һ�գ�Ӧ��˳�ӽ������ֻ�����<span class="border_bottom">${aparam.p10_1_2_1 }</span>���㣬���ҷ�֧��ΥԼ����<span class="border_bottom">${aparam.p10_1_2_2 }</span>�����Բ����ṩ�ģ�����;�˻�������</p>
                      <p>��3���׷����ڸ���ģ�ÿ����һ�գ�Ӧ�����ڸ�����<span class="border_bottom">${param.p10_1_3 }</span>���㣬���ҷ�֧��ΥԼ��</p>
                      <p>��4���׷��������ص���ջ�����Ϣ����ʹ�ҷ����ܰ��ڽ����ģ���ط��ռ���ʧ�ɼ׷��е���</p>
                      <p>��5������Լ����<span class="border_bottom">${aparam.p10_1_5 }</span>��ΥԼ��</p>

                    </div>
                    <p>2���ҷ�ΥԼ���Σ�</p>
                    <div class="response">
                      <p>��1���ҷ����ܽ����ģ�Ӧ��׷��������ܽ������ֻ���<span class="border_bottom">${aparam.p10_2_1 }</span></p>
                      <p>��2���ҷ���������Ʒ�֡��ͺš��������������������ͬ�涨�ģ���׷�ͬ�����ã�Ӧ�����ۼۣ��׷��������õģ�Ӧ���ݾ�����������ҷ������������������������˻������е����֧����ȫ�����á�</p>
                      <p>��3���ҷ�������װ�����Ϻ�ͬ�涨���뷵�޻����°�װ�ģ��ҷ������޻����°�װ�����е����֧����ȫ�����á��׷���Ҫ���޻����°�װ��Ҫ���⳥��ʧ�ģ��ҷ�Ӧ�⳥�׷��ò��ϸ��װ����ںϸ���Ĳ�۲��֡����װ������ɻ����𻵻���ʧ�ģ����ҷ������⳥��</p>
                      <p>��4���ҷ����ڽ����ģ�ÿ����һ�գ�Ӧ�������ڽ������<span class="border_bottom">${aparam.p10_2_4_1 }</span>���㣬��׷�֧��ΥԼ�𣬲��⳥�׷���������ܵ���ʧ�������ڽ�������<span class="border_bottom">${aparam.p10_2_4_2 }</span>�գ��׷���Ȩ��ֹ��ͬ���ɾ����ܵ�ȫ����ʧҪ���ҷ������⳥��</p>
                      <p>��5���ʱ����ڣ�����ҷ�δ����Լ�������ڲ�ȡ���ȴ�ʩ�ģ��׷���Ȩ���д������ɴ˲����ķ��պͷ������ҷ��е���</p>
                      <p>��6������Լ����<span class="border_bottom">${aparam.p10_2_6 }</span></p>
                    </div>

                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>ʮһ�����ɿ���</h3>
                  <div class="notice_inner">
                    <p>�κ�һ�����ڲ��ɿ���ԭ�������к�ͬʱ��Ӧ�ڲ��ɿ����¼�������<span class="border_bottom">${aparam.p11 }</span>������Է�ͨ�����Լ�����ܸ��Է���ɵ���ʧ����ȡ���йػ����Ĳ��ɿ���֤����˫��Э���������С��������л��߲����к�ͬ������������ɲ��ֻ�ȫ������е�ΥԼ���Ρ�</p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>ʮ����������</h3>
                  <div class="notice_inner">
                    <p>����ͬ�����й�������������ȫ�����飬�ס���˫��Ӧ�Ѻ�Э�̽�������������������<span class="border_bottom">${aparam.p12_0_1 }</span>����˫��δ�ܴ��һ�µģ��κ�һ����ѡ�����е�<span class="border_bottom">${aparam.p12_0_2 }</span>�ַ�ʽ�����</p>
                    <p>1���������ύ<span class="border_bottom">${aparam.p12_1 }</span>�ٲ�ίԱ���ٲã�</p>
                    <p>2��������<span class="border_bottom">${aparam.p12_2 }</span>����Ժ�������ϡ�</p>
                  </div>
              <!--.list_notice--></div>
              <div class="section list_notice">
                  <h3>ʮ������ͬ��Ч������</h3>
                  <div class="notice_inner">
                    <p>1��������ͬ�涨Ӧ����ΥԼ���⳥�𡢱��ܱ������Լ����־�����ʧ��Ӧ������ȷ���κ�<span class="border_bottom">${aparam.p13_1 }</span>���ڣ���һ������һ�����壬�������ڸ���Ĺ涨������</p>
                    <p>2��Լ����ΥԼ����ΪΥԼ����ʧ�⳥��˫��û��Լ��ΥԼ���Ԥ���⳥��ļ��㷽���ģ���ʧ�⳥��Ӧ���൱��ΥԼ����ɵ���ʧ��������ͬ���к�ɻ�õ����棬�����ó���Υ����ͬһ��������ͬʱӦ��Ԥ��������Υ����ͬ������ɵ���ʧ��</p>
                    <p>3������ͬδ�������ɼס���˫������Э��ȷ�������������油���ͬ�������ͬ����Ϊ����ͬ����Ч��ɲ��֣��뱾��ͬ����ͬ�ȷ���Ч����</p>
                    <p>4������ͬ�κ������Ϊ�Ƿ�����Ч�򲻿�ǿ��ִ�в���Ӱ�챾��ͬ���������Ч������ǿ��ִ���ԡ�</p>
                    <p>5������ͬ��˫��ʩ�ӵ�λ����ӡ�»���Ȩ��������ǩ�������Խ���һ��ʩ����ɺ�������Ч����˫������ͬ���⣬�κ�һ�����ò���ת�û�ȫ��ת����Ӧ���еĺ�ͬ����</p>
                    <p>6������ͬ��Ч�󣬱���ͬ��ɫ��ӡ�漴����Ϊ��ͬԭ����˫���Դ˾������Ͽɡ�</p>
                    <p>7������Լ����<span class="border_bottom">${aparam.p13_7 }</span></p>
                  </div>
              <!--.list_notice--></div>
              <div class="signo clearfix">
                <p class="attention">�����������ģ�Ϊ˫��ǩ��ҳ�棩</p>
                <div class="signo01 clearfix">
                  <dl class="clearfix">
                    <dt>�׷�(����)</dt>
                    <dd></dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>�ҷ�(����)</dt>
                    <dd></dd>
                  </dl>
                </div>
                <div class="signo02 clearfix">
                  <dl class="clearfix">
                    <dt>����Ȩ������ǩ������ </dt>
                    <dd><span class="border_bottom">${aparam.a_sign }</span></dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>����Ȩ������ǩ������</dt>
                    <dd><span class="border_bottom">${bparam.b_sign }</span></dd>
                  </dl>
                </div>
                <div class="signo03 clearfix">
                  <dl class="clearfix">
                    <dt>���ڣ�</dt>
                    <dd><span class="border_bottom">${aparam.a_year }</span>��<span class="border_bottom">${aparam.a_month }</span>��<span class="border_bottom">${aparam.a_day }</span>��</dd>
                  </dl>
                  <dl class="clearfix">
                    <dt>���ڣ�</dt>
                    <dd><span class="border_bottom">${bparam.b_year }</span>��<span class="border_bottom">${bparam.b_month }</span>��<span class="border_bottom">${bparam.b_day }</span>��</dd>
                  </dl>
                </div>
				              <div class="submit_btn">
                 <ul>
                    <li><button class="btn btn-default blue" onclick="window.open('${pageContext.request.contextPath}/supervise/contract/word?projId=${proj.projId }&busi_type=${busi_type}');">����word</button></li>
					<li><button class="btn btn-default blue" onclick="$('.submit_btn').hide();window.print();$('.submit_btn').show();">��ӡ</button></li>
                    <li><button class="btn btn-default gray_cart" onclick="window.close();">�ر�</button></li>
                 </ul>
              </div>
            </div>
              </div>
          <!--#matter_section--></div>

      <!--.inner--></div>
  <!--#contents--></div>
</body>
</html>