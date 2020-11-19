package egovframework.rte.swfc.exception;

public class ReportNotFoundException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public ReportNotFoundException() {
		super("예특보문이 존재하지 않습니다!");
	}

}
