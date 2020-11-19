package kr.co.indisystem.config.database;

import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MybatisConfig {
	@Bean
	MapperScannerConfigurer mapperScannerConfigurer()  throws Exception{
		MapperScannerConfigurer mapperScanner = new MapperScannerConfigurer();
		mapperScanner.setBasePackage("kr.co.indisystem.web");
		//mapperScanner.setSqlSessionTemplateBeanName("sqlSessionTemplate");
		return mapperScanner;
	}
}
