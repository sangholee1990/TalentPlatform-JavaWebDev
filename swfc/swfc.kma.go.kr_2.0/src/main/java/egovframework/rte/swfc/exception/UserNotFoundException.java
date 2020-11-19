package egovframework.rte.swfc.exception;

public class UserNotFoundException extends RuntimeException {

	private static final long serialVersionUID = 5153026368092035959L;

	
	public UserNotFoundException() {
		super("사용자 정보가 존재하지 않습니다!");
	}
	
	public UserNotFoundException(String msg, Throwable e) {
		super(msg, e);
	}
}
