package com.avic.supplier.utils;

import java.io.IOException;
import java.io.PrintWriter;

import javax.crypto.SecretKey;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

import com.avic.common.constants.SessionKeys;

public class SupplierSessionFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		// �����˵�uri
		String[] notFilter = new String[] { "login" };

		// �����uri
		String uri = request.getRequestURI();
		// �Ƿ����
		boolean doFilter = true;
		for (String s : notFilter) {
			if (uri.indexOf(s) != -1) {
				// ���uri�а��������˵�uri���򲻽��й���
				doFilter = false;
				break;
			}
		}
		if (doFilter) {
			// ִ�й���
			// ��session�л�ȡ��¼��ʵ��
			Object obj = request.getSession().getAttribute(SessionKeys.LOGIN_SUP_USER);
			if (null == obj) {
				// ���session�в����ڵ�¼��ʵ�壬�򵯳�����ʾ���µ�¼
				// ����request��response���ַ�������ֹ����
				request.setCharacterEncoding("GBK");
				response.setCharacterEncoding("GBK");
				PrintWriter out = response.getWriter();
				String loginPage = request.getContextPath()+"/supplier/login";
				StringBuilder builder = new StringBuilder();
				builder.append("<script type=\"text/javascript\">");
//				builder.append("alert('��ҳ���ڣ������µ�¼��');");
				builder.append("window.top.location.href='");
				builder.append(loginPage);
				builder.append("';");
				builder.append("</script>");
				out.print(builder.toString());
			} else {
				String ifCheck  = (String) request.getSession().getAttribute(SessionKeys.COMPANY_IF_CHECK);
				if (!"1".equals(ifCheck) && !uri.contains("companyMyInfo")) {
					// ���session�в����ڵ�¼��ʵ�壬�򵯳�����ʾ���µ�¼
					// ����request��response���ַ�������ֹ����
					request.setCharacterEncoding("GBK");
					response.setCharacterEncoding("GBK");
					PrintWriter out = response.getWriter();
					String loginPage = request.getContextPath()+"/supplier/login/isNoCheck";
					StringBuilder builder = new StringBuilder();
					builder.append("<script type=\"text/javascript\">");
//					builder.append("alert('��ҳ���ڣ������µ�¼��');");
					builder.append("window.top.location.href='");
					builder.append(loginPage);
					builder.append("';");
					builder.append("</script>");
					out.print(builder.toString());
				}else{
					// ���session�д��ڵ�¼��ʵ�壬�����
					filterChain.doFilter(request, response);
				}
			}
		} else {
			// �����ִ�й��ˣ������
			filterChain.doFilter(request, response);
		}
	}
}
