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

	// 拼接孩子节点的JSON字符串
	public String toString() {
		String result = "";
		int i = 0;
		for (Iterator it = list.iterator(); it.hasNext();) {
			result += ((DepartmentNode) it.next()).toString();
		}
		return result;
	}

	// 孩子节点排序
	public void sortChildren() {
		// 对本层节点进行排序
		// 可根据不同的排序属性，传入不同的比较器，这里传入ID比较器
		Collections.sort(list, new DepartmentNodeIDComparator());
		// 对每个节点的下一层节点进行排序
		for (Iterator it = list.iterator(); it.hasNext();) {
			((DepartmentNode) it.next()).sortChildren();
		}
	}
}

/**
 * 节点比较器
 */
class DepartmentNodeIDComparator implements Comparator {
	// 按照节点编号比较
	public int compare(Object o1, Object o2) {
		BigDecimal j1 = new BigDecimal(((DepartmentNode) o1).id);
		BigDecimal j2 = new BigDecimal(((DepartmentNode) o2).id);
		return (j1.compareTo(j2));
	}
}
