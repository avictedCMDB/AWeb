package com.avic.common.constants;

public enum UserRole {
    BUY("ROLE_BUY"), CHECK("ROLE_CHECK"), PAY("ROLE_PAY"),CLIENT("ROLE_2C"), NONE("");
    private String value;

    private UserRole(String value) {
        this.value = value;
    }

    public String value() {
        return value;
    }
}
