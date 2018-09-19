package com.avic.supervise.models;

public class Node {

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
	private Children children = new Children();

	// ���������ƴ��JSON�ַ���
	public String toString() {
		int level = Integer.valueOf(menuLevel);
		String result = "<ul class=\"tree\"><li class=\"tree-node\">"+
        						"<label>" +
                                    "<input class=\"node-check\" type=\"checkbox\">"+
        							"<div class=\"node-content\">";
		for (int i = 1; i < level; i++) {
			result = result+"<i class=\"node-icon icon-elbow-line\"></i>";
		}
		if (children != null && children.getSize() != 0) {
			result = result +							
			"<i class=\"node-icon icon-expand\"></i>";
		}else {
			result = result+"<i class=\"node-icon icon-elbow-line\"></i>";
		}
		result = result +	
                        "<input type=\"checkbox\" name=\""+parentId+"\" value=\""+id+"\" id=\""+id+"\" onclick=\"checkMenuFor('"+id+"','"+parentId+"')\"  "+("1".equals(isCheck) ? "checked":"")+">"+
						"<i class=\"node-icon icon-allot\"></i>"+
						"<span class=\"node-text node-title\">"+text+"</span>";

		if (children != null && children.getSize() != 0 ) {
			result += children.toString();
		}
		return result + "</div></label></li></ul>";
	}

	// ���Ӻ��ӽڵ�
	public void addChild(Node node) {
		this.children.addChild(node);
	}

	// �ֵܽڵ��������
	public void sortChildren() {
		if (children != null && children.getSize() != 0) {
			children.sortChildren();
		}
	}

}