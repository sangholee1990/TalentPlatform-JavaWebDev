package kr.co.indisystem.config.web;

import java.util.Locale;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@EnableWebMvc
@Configuration
@ComponentScan(basePackages = { "kr.co.indisystem.web" },includeFilters = @ComponentScan.Filter(Controller.class))
public class WebMvcConfig extends WebMvcConfigurerAdapter{
	

	@Override
    public void configureDefaultServletHandling( DefaultServletHandlerConfigurer configurer ){
        configurer.enable();
    }
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index");
		super.addViewControllers(registry);
	}
	
	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }
	
	@Bean
    public InternalResourceViewResolver getInternalResourceViewResolver(){
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }
	
	
    
	 
	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
		configurer.favorPathExtension(true)
              .useJaf(false)
              .ignoreAcceptHeader(true)
              .mediaType("html", MediaType.TEXT_HTML)
//              .mediaType("png", MediaType.IMAGE_PNG)
//              .mediaType("jpg", MediaType.IMAGE_JPEG)
              .mediaType("json", MediaType.APPLICATION_JSON)
              .defaultContentType(MediaType.TEXT_HTML);
	}

	@Bean
    public LocaleResolver localeResolver() {
    	SessionLocaleResolver sessionLocaleResolver = new SessionLocaleResolver();
    	sessionLocaleResolver.setDefaultLocale(Locale.KOREA);
        return sessionLocaleResolver;
    }
	
	
	@Bean
    public ReloadableResourceBundleMessageSource messageSource() {
    	ReloadableResourceBundleMessageSource resource = new ReloadableResourceBundleMessageSource();
        resource.setBasename("classpath:i18n/messages");
        resource.setFallbackToSystemLocale(false);  
        resource.setDefaultEncoding("UTF-8");
        resource.setCacheSeconds(60); // reload messages every 10 seconds
        return resource;
    }
	
    @Override
	public void addInterceptors(InterceptorRegistry registry) {
    	LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
    	localeChangeInterceptor.setParamName("lang");
		registry.addInterceptor(localeChangeInterceptor);
	}
    
    @Bean
    public AcceptHeaderLocaleResolver acceptHeaderLocaleResolver() {
        return new AcceptHeaderLocaleResolver();
    }
    
//    @Bean(name="multipartResolver")
//    public CommonsMultipartResolver createMultipartResolver() {
//      CommonsMultipartResolver resolver = new CommonsMultipartResolver();
//      resolver.setMaxUploadSize(1024 * 1024 * 10);
//      resolver.setDefaultEncoding("UTF-8");
//      return resolver;
//    }
    @Bean
    public StandardServletMultipartResolver multipartResolver(){
    	return new StandardServletMultipartResolver();
    }

}