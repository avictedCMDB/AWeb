package com.avic.supplier.models;

import com.avic.supplier.utils.BaseModels;

public class SupplierExpress extends BaseModels {

		private String expressId;
		
		private String expressCode;
		
		private String expressName;
		
		private String ifDefault;
		
		private String supId;

		public String getExpressId() {
			return expressId;
		}

		public void setExpressId(String expressId) {
			this.expressId = expressId;
		}

		public String getExpressCode() {
			return expressCode;
		}

		public void setExpressCode(String expressCode) {
			this.expressCode = expressCode;
		}

		public String getExpressName() {
			return expressName;
		}

		public void setExpressName(String expressName) {
			this.expressName = expressName;
		}

		public String getIfDefault() {
			return ifDefault;
		}

		public void setIfDefault(String ifDefault) {
			this.ifDefault = ifDefault;
		}

		public String getSupId() {
			return supId;
		}

		public void setSupId(String supId) {
			this.supId = supId;
		}
		
		
}