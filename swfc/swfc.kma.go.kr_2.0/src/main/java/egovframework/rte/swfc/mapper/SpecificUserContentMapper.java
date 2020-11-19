package egovframework.rte.swfc.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.swfc.dto.SpecificUserContentDTO;
import egovframework.rte.swfc.mapper.simple.BasicMapper;

public interface SpecificUserContentMapper extends BasicMapper<SpecificUserContentDTO> {
	
	//public int updateResize(Map<String, Object> params);
	
	
	//public int updateState(Map<String, Object> params);
	
	//public int updateSort(Map<String, Object> params);
	public int updateContents(Map<String, Object> params);
	
	public void insertNewContent(Map<String, Object> params);
	
	public List<SpecificUserContentDTO> SelectContent(Map<String, Object> params);
	
}
