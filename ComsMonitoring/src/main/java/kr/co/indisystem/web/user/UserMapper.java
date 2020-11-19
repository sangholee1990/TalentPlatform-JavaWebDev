package kr.co.indisystem.web.user;


import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {
	
	public User selectAuthority(String param);
	
	public int insertUser(User user);
}
