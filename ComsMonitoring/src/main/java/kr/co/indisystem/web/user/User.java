package kr.co.indisystem.web.user;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

@Alias("User")
public class User implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String role;
	
	@NotEmpty
	@Size(min=1, max=10, message="아아아")
	private String userPw;
	
	
	@NotEmpty
	@Size(min=1, max=10, message="아아아")
	private String userId;
	
	@NotEmpty
	
	private String confirmPassword;
	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	
	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();    
        authorities.add(new SimpleGrantedAuthority(role));
		return authorities;
	}	
	
	public boolean isAccountNonExpired() {
		return true;
	}

	
	public boolean isAccountNonLocked() {
		return true;
	}

	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public String toString() {
		return "User [role=" + role + ", userPw=" + userPw + ", userId="
				+ userId + "]";
	}
	
	
}
