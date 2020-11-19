package egovframework.rte.swfc.mapper;

import java.util.List;

import egovframework.rte.swfc.dto.CodeDTO;
import egovframework.rte.swfc.mapper.simple.BasicMapper;

public interface CodeMapper extends BasicMapper<CodeDTO> {
	List<CodeDTO> SelectMany(Object parameter);
}
