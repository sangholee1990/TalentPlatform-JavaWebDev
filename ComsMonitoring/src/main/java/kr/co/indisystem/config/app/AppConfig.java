package kr.co.indisystem.config.app;

import kr.co.indisystem.config.database.JdbcConfig;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

@Configuration
@ComponentScan(basePackages ={ "kr.co.indisystem.config" })
@Import({JdbcConfig.class})
public class AppConfig {
	 /**
     * PropertySource에 등록된 프라퍼티들을 @Value(“${property.name}”) 형태로 사용
     * */
    @Bean
    public static PropertySourcesPlaceholderConfigurer placeholderConfigurer() {
    	
    	PropertySourcesPlaceholderConfigurer propertySources = new PropertySourcesPlaceholderConfigurer();
		Resource[] resources = new ClassPathResource[] { 
				new ClassPathResource("application.properties")
		};
		propertySources.setLocations(resources);
		propertySources.setIgnoreUnresolvablePlaceholders(true);
    	
      return propertySources;
    }
	
}