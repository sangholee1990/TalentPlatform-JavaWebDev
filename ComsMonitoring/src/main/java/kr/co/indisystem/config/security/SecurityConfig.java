package kr.co.indisystem.config.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity( prePostEnabled = true )
@ComponentScan({ "kr.co.indisystem.*"})
public class SecurityConfig  extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private CustomAuthenticationProvider authenticationProvider;

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth ) throws Exception {
    	auth.authenticationProvider(authenticationProvider);//.userDetailsService(userServiceImpl);//
	 	//.passwordEncoder(bCryptPasswordEncoder());
    }
    
    @Bean 
	public BCryptPasswordEncoder bCryptPasswordEncoder(){
		return new BCryptPasswordEncoder(11);
	}
 
    @Override
    public void configure( WebSecurity web ) throws Exception{
        // This is here to ensure that the static content (JavaScript, CSS, etc)
        // is accessible from the login page without authentication
        web.ignoring().antMatchers( "/resouces/**" );
    }
    
    @Override
    protected void configure( HttpSecurity http ) throws Exception{
    	  http.csrf().disable();
          http.authorizeRequests().antMatchers("/*").permitAll()
                  .antMatchers("/user/manage/**", "/board/**/write", "/board/**/update", "/board/**/delete").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
          		  .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
                  .and()
              .formLogin()
              //.successHandler(successHandler)
              //.failureHandler(failureHandler)
              .loginPage("/login")
              .usernameParameter("userId")
              .passwordParameter("userPw")
              .defaultSuccessUrl("/index")
              .failureUrl("/login?error")
              //.loginProcessingUrl("/login")
              .permitAll().and();
                  
          http.logout()
          	.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
          	//.logoutSuccessHandler(logoutSuccessHandler)
          	.logoutSuccessUrl("/index")
          	.deleteCookies("JSESSIONID")
          	.invalidateHttpSession(true)
            .permitAll().and()
            .exceptionHandling()
            .accessDeniedPage("/error/403");
          
          http.sessionManagement().maximumSessions(1).maxSessionsPreventsLogin(true);

    }
    
    
}   
