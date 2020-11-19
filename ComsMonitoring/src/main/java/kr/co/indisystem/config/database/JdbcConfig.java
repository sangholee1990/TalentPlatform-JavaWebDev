package kr.co.indisystem.config.database;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;

import kr.co.indisystem.exception.ExceptionAdvice;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@PropertySource(value = { "classpath:application.properties" })
@Import({MybatisConfig.class})
public class JdbcConfig {
	
	private static final Logger logger = LoggerFactory.getLogger(ExceptionAdvice.class);
	
	@Autowired
	private Environment environment;
	
    @Bean
    public DataSource dataSource() throws Exception {
    	DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(environment.getRequiredProperty("jdbc.driverClassName"));
		dataSource.setUrl(environment.getRequiredProperty("jdbc.url"));
		dataSource.setUsername(environment.getRequiredProperty("jdbc.username"));
		dataSource.setPassword(environment.getRequiredProperty("jdbc.password"));	
        return dataSource;
    }

    @Bean
    public SqlSessionFactoryBean sqlSessionFactoryBean(DataSource dataSource) throws IOException{
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        sessionFactory.setTypeAliasesPackage("kr.co.indisystem.web");
        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:kr/co/indisystem/web/**/*.xml") );//.getResources("classpath:mapper/**/*.xml")
        return sessionFactory;
    }
    
    /**
     * 

     */
//    @Bean
//    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory){
//        return new SqlSessionTemplate(sqlSessionFactory);
//    }
    
    /**
     * 데이터베이스 트랜젝션 등록
     * 
     * */
    @Bean
    public DataSourceTransactionManager transactionManager(DataSource dataSource){
        return new DataSourceTransactionManager(dataSource);
    }
    
    
}
