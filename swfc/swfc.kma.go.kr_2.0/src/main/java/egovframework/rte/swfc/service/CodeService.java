package egovframework.rte.swfc.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.swfc.dto.CodeDTO;
import egovframework.rte.swfc.mapper.CodeMapper;

@Service
public class CodeService extends BaseService {
	private static final Logger logger = LoggerFactory.getLogger(CodeService.class);
	
	public List<CodeDTO> selectSubCodeList(Object parameter) {
		CodeMapper mapper = sessionTemplate.getMapper(CodeMapper.class); 
		return mapper.SelectMany(parameter);
	}
}
