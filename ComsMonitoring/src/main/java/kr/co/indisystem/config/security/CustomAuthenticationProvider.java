package kr.co.indisystem.config.security;

import java.util.Collection;

import kr.co.indisystem.web.user.User;
import kr.co.indisystem.web.user.UserServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider{

	@Autowired
	private UserServiceImpl userService; 
	
	@Autowired
	private MessageSource messageSource;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public Authentication authenticate(Authentication authentication)
			throws AuthenticationException {
		String userId = authentication.getName();
        String password = (String) authentication.getCredentials();

        
        Collection<? extends GrantedAuthority> authorities = null;

        if(userId.trim().equals("")){
        	throw new UsernameNotFoundException(messageSource.getMessage("security.error.UsernameNotFoundException", null, null));
        }
        
    	User user = userService.selectAuthority(userId);
    	
        if(user == null){
        	throw new UsernameNotFoundException(messageSource.getMessage("security.error.UsernameNotFoundException", null, null));
        }
        
        if (!bCryptPasswordEncoder.matches(password, user.getUserPw())){
        	throw new BadCredentialsException(messageSource.getMessage("security.error.BadCredentialsException", null, null));
        }
        authorities = user.getAuthorities();
        
        user.setUserPw(null);//비밀번호 저장 안함
            
        return new UsernamePasswordAuthenticationToken(user, password, authorities);

	}

	@Override
	public boolean supports(Class<?> authentication) {
		 return true;
	}

}
