package com.avic.supervise.models;

public class OrganizationInfoNode {

	/**
	 * 节点编号
	 */
	public String id;
	/**
	 * 节点内容
	 */
	public String text;
	/**
	 * 父节点编号
	 */
	public String parentId;

	public String isCheck;
	
	public String menuLevel;
	/**
	 * 孩子节点列表
	 */
	private OrganizationInfoChildren organizationInfoChildren = new OrganizationInfoChildren();

	// 先序遍历，拼接JSON字符串
	public String toString() {
		int level = Integer.valueOf(menuLevel);
		String result = "<ul class=\"tree\"><li class=\"tree-node\">"+
        						"<label>" +
                                    "<input class=\"node-check\" type=\"checkbox\">"+
        							"<div class=\"node-content\">";
		for (int i = 1; i < level; i++) {
			result = result+"<i class=\"node-icon\"></i>";
		}
		if (organizationInfoChildren != null && organizationInfoChildren.getSize() != 0) {
			result = result +							
			"<i class=\"node-icon icon-expand\"></i>";
		}else {
			result = result+"<i class=\"node-icon\"></i>";
		}
		result = result +	
                        "<i class=\"node-icon icon-allot\"></i>"+
						"<span id=\"span_"+id+"\" class=\"node-text node-title\" onclick=\"selEmployee('"+id+"');\">"+text+"</span>";
		if(level!=1){
			result = result + "<span class=\"icon-edit\"><a href=\"javascript:void(0);\" data-toggle=\"modal\" data-target=\"#change\"><i class=\"fa fa-edit\" onclick=\"showOrganizationInfoUpdate('"+id+"');\"></i></a></span><span class=\"icon-delete\"><i class=\"fa fa-close\" onclick=\"delOrganizationInfo('"+id+"');\"></i></span>";
		}

		if (organizationInfoChildren != null && organizationInfoChildren.getSize() != 0 ) {
			result += organizationInfoChildren.toString();
		}
		return result + "</div></label></li></ul>";
	}

	// 添加孩子节点
	public void addChild(OrganizationInfoNode node) {
		this.organizationInfoChildren.addDepartmentChild(node);
	}

	// 兄弟节点横向排序
	public void sortChildren() {
		if (organizationInfoChildren != null && organizationInfoChildren.getSize() != 0) {
			organizationInfoChildren.sortChildren();
		}
	}

}
