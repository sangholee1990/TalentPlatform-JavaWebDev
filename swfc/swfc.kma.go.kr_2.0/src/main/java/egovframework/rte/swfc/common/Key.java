package egovframework.rte.swfc.common;

import egovframework.rte.swfc.common.Code.Role;

public class Key {

	public class User {
		/*
		 * 사용자 아이디
		 */
		public static final String USER_ID = "USERID";
		/*
		 * 사용자명
		 */
		public static final String USER_NAME = "NAME";
		/*
		 * 비밀번호
		 */
		public static final String USER_PASSWORD = "USERPWD";
		/*
		 * 권한
		 */
		public static final String USER_ROLE = "ROLE";
		/*
		 * 사용자 정보
		 */
		public static final String USER_INOF = "USER_INFO";
	}
	
	public static void main(String[] args){
		System.out.println(Role.ROLE_ADMIN.getLevel());
	}
}
