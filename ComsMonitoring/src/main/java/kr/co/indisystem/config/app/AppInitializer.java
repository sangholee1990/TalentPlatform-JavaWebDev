package kr.co.indisystem.config.app;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration.Dynamic;

import kr.co.indisystem.config.security.SecurityConfig;
import kr.co.indisystem.config.web.WebMvcConfig;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.filter.HttpPutFormContentFilter;
import org.springframework.web.multipart.support.MultipartFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer{
	
    @Override
    public void onStartup(ServletContext servletContext)
    		throws ServletException {
    	servletContext.setInitParameter("defaultHtmlEscape ", "true"); 
    	super.onStartup(servletContext);
    }
    
    @Override
    protected void registerDispatcherServlet(ServletContext servletContext) {
    	// TODO Auto-generated method stub
    	super.registerDispatcherServlet(servletContext);
    }
    
    @Override
    protected Class<?>[] getRootConfigClasses(){
        return new Class[] { AppConfig.class };
    }
 
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[] {WebMvcConfig.class, SecurityConfig.class};
    }
    
    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);
        HttpPutFormContentFilter hpfcf = new HttpPutFormContentFilter();
        MultipartFilter mpf = new MultipartFilter();
        HiddenHttpMethodFilter hmf = new HiddenHttpMethodFilter(); 
        DelegatingFilterProxy dfp = new DelegatingFilterProxy("springSecurityFilterChain");
        return new Filter[] {characterEncodingFilter, mpf, hmf, hpfcf, dfp};
    }
   
    
    @Override
    protected String[] getServletMappings(){
        return new String[] {"/"};
    }
    
    @Override
	protected void customizeRegistration(Dynamic registration) {
    	MultipartConfigElement multipartConfigElement = new MultipartConfigElement("/", 1024*1024*10, 1024*1024*10 * 2,
     		1024*1024*10 / 2);
    	registration.setMultipartConfig(multipartConfigElement);
		super.customizeRegistration(registration);
	}

}