package com.avic.supervise.models;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

public class DepartmentChildren {

	private List list = new ArrayList();

	public int getSize() {
		return list.size();
	}

	public void addChild(DepartmentNode node) {
		list.add(node);
	}
	
	public void addDepartmentChild(DepartmentNode departmentNode) {
		list.add(departmentNode);
	}

	// ƴ�Ӻ��ӽڵ��JSON�ַ���
	public String toString() {
		String result = "";
		int i = 0;
		for (Iterator it = list.iterator(); it.hasNext();) {
			result += ((DepartmentNode) it.next()).toString();
		}
		return result;
	}

	// ���ӽڵ�����
	public void sortChildren() {
		// �Ա���ڵ��������
		// �ɸ��ݲ�ͬ���������ԣ����벻ͬ�ıȽ��������ﴫ��ID�Ƚ���
		Collections.sort(list, new DepartmentNodeIDComparator());
		// ��ÿ���ڵ����һ��ڵ��������
		for (Iterator it = list.iterator(); it.hasNext();) {
			((DepartmentNode) it.next()).sortChildren();
		}
	}
}

/**
 * �ڵ�Ƚ���
 */
class DepartmentNodeIDComparator implements Comparator {
	// ���սڵ��űȽ�
	public int compare(Object o1, Object o2) {
		BigDecimal j1 = new BigDecimal(((DepartmentNode) o1).id);
		BigDecimal j2 = new BigDecimal(((DepartmentNode) o2).id);
		return (j1.compareTo(j2));
	}
}