package com.avic.market.cpi.exceptions;

public class NoSuchSupplierException extends Exception {

    private static final long serialVersionUID = 4783440717012261312L;

    public NoSuchSupplierException(String s) {
        super(s);
    }
    
    public NoSuchSupplierException(Exception e) {
        super(e);
    }
}
