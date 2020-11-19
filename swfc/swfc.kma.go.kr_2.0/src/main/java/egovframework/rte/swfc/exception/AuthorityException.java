package egovframework.rte.swfc.exception;

/**
 * 권한 오류 클래스
 * 
 */
public class AuthorityException extends RuntimeException {
    /**
     * 시리얼 버전 아이디
     */
    private static final long serialVersionUID = 1L;
    
    /**
     * 메시지를 인자로 가지는 생성자이다.
     * 
     * @param code 코드
     * @param message 메시지
     */
    public AuthorityException(String message) {
        super(message);
        
    }
}