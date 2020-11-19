package com.gaia3d.web.user;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.gaia3d.web.dto.UserDTO;

public class WebUser extends User {
	private static final long serialVersionUID = 1L;
	
	UserDTO detail;
	
	public WebUser(String username, String password, Collection<? extends GrantedAuthority> authorities, UserDTO detail) {
		super(username, password, authorities);
		this.detail = detail;
	}
	
	public UserDTO getDetail() {
		return detail;
	}
	
	public void setDetail(UserDTO detail) {
		this.detail = detail;
	}

}
