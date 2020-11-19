package egovframework.rte.swfc.service;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class BaseService {
private static final Logger logger = LoggerFactory.getLogger(BaseService.class);
	
	@Resource(name = "sqlSessionTemplate")
	protected SqlSession sessionTemplate;
}
