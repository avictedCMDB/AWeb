package com.avic.supervise.models;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

public class Children {

	private List list = new ArrayList();

	public int getSize() {
		return list.size();
	}

	public void addChild(Node node) {
		list.add(node);
	}

	// ƴ�Ӻ��ӽڵ��JSON�ַ���
	public String toString() {
		String result = "";
		int i = 0;
		for (Iterator it = list.iterator(); it.hasNext();) {
			result += ((Node) it.next()).toString();
		}
		return result;
	}

	// ���ӽڵ�����
	public void sortChildren() {
		// �Ա���ڵ��������
		// �ɸ��ݲ�ͬ���������ԣ����벻ͬ�ıȽ��������ﴫ��ID�Ƚ���
		Collections.sort(list, new NodeIDComparator());
		// ��ÿ���ڵ����һ��ڵ��������
		for (Iterator it = list.iterator(); it.hasNext();) {
			((Node) it.next()).sortChildren();
		}
	}
}

/**
 * �ڵ�Ƚ���
 */
class NodeIDComparator implements Comparator {
	// ���սڵ��űȽ�
	public int compare(Object o1, Object o2) {
		int j1 = Integer.parseInt(((Node) o1).id);
		int j2 = Integer.parseInt(((Node) o2).id);
		return (j1 < j2 ? -1 : (j1 == j2 ? 0 : 1));
	}
}
