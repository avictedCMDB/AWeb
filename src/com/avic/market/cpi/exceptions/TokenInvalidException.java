package com.avic.market.cpi.exceptions;

public class TokenInvalidException extends Exception {

    private static final long serialVersionUID = 4783440717012261312L;

    public TokenInvalidException(String s) {
        super(s);
    }
    
    public TokenInvalidException(Exception e) {
        super(e);
    }
}
