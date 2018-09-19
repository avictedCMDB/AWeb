package com.avic.supervise.models;

public class DepartmentNode {

	/**
	 * �ڵ���
	 */
	public String id;
	/**
	 * �ڵ�����
	 */
	public String text;
	/**
	 * ���ڵ���
	 */
	public String parentId;

	public String isCheck;
	
	public String menuLevel;
	/**
	 * ���ӽڵ��б�
	 */
	private DepartmentChildren departmentChildren = new DepartmentChildren();

	// ���������ƴ��JSON�ַ���
	public String toString() {
		int level = Integer.valueOf(menuLevel);
		String result = "<ul class=\"tree\"><li class=\"tree-node\">"+
        						"<label>" +
                                    "<input class=\"node-check\" type=\"checkbox\">"+
        							"<div class=\"node-content\">";
		for (int i = 1; i < level; i++) {
			result = result+"<i class=\"node-icon\"></i>";
		}
		if (departmentChildren != null && departmentChildren.getSize() != 0) {
			result = result +							
			"<i class=\"node-icon icon-expand\"></i>";
		}else {
			result = result+"<i class=\"node-icon\"></i>";
		}
		result = result +	
                        "<i class=\"node-icon icon-allot\"></i>"+
						"<span id=\"span_"+id+"\" class=\"node-text node-title\" onclick=\"selEmployee('"+id+"');\">"+text+"</span>";

		if (departmentChildren != null && departmentChildren.getSize() != 0 ) {
			result += departmentChildren.toString();
		}
		return result + "</div></label></li></ul>";
	}

	// ��Ӻ��ӽڵ�
	public void addChild(DepartmentNode node) {
		this.departmentChildren.addDepartmentChild(node);
	}

	// �ֵܽڵ��������
	public void sortChildren() {
		if (departmentChildren != null && departmentChildren.getSize() != 0) {
			departmentChildren.sortChildren();
		}
	}

}
