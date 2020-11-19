package kr.co.indisystem.web.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl{
	
//	@Autowired
//	private DataSourceTransactionManager tx;
//	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private UserMapper userMapper;


	public User selectAuthority(String username) {
		return userMapper.selectAuthority(username);
	}
	
	@Transactional
	public int insertUser(User user) {
		int result = 0;
		user.setRole("ROLE_ANONYMOUS");
		user.setUserPw(bCryptPasswordEncoder.encode(user.getUserPw()));
		result =  userMapper.insertUser(user);
	    return result;

	}
	
}
