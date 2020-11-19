package com.gaia3d.swfc.batch;

public class FtpException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	public FtpException() {
		super();
	}
	
    public FtpException(String message) {
        super(message);
    }
    
    public FtpException(String message, Throwable cause) {
        super(message, cause);
    }

    public FtpException(Throwable cause) {
        super(cause);
    }
}
