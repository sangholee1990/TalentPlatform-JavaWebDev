package com.gaia3d.web.user;

import java.util.Arrays;
import java.util.Collection;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.gaia3d.web.mapper.UserMapper;
import com.gaia3d.web.service.BaseService;

public class SWFCUserDetailsService extends BaseService implements UserDetailsService{
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserMapper mapper = sessionTemplate.getMapper(UserMapper.class);
		com.gaia3d.web.dto.UserDTO dto = mapper.SelectById(username);
		if(dto == null) {
			throw new UsernameNotFoundException(username);
		}
			
		Collection<GrantedAuthority> authorities = Arrays.asList((GrantedAuthority)new SimpleGrantedAuthority(dto.getRole()));
		return new WebUser(dto.getUserId(), dto.getPassword(), authorities, dto);
	}
}
