package egovframework.rte.swfc.mapper;

import java.util.List;

import egovframework.rte.swfc.dto.SWFCImageMetaDTO;
import egovframework.rte.swfc.mapper.simple.BasicMapper;

public interface SWFCImageMetaMapper extends BasicMapper<SWFCImageMetaDTO> {
	List<SWFCImageMetaDTO> SelectManyMovie(Object parameter);
	List<SWFCImageMetaDTO> SelectManyWithHour(Object parameter);
	
	List<SWFCImageMetaDTO> SelectManyIntertemporalByCode(Object parameter);
	
	List<SWFCImageMetaDTO> SelectManyWithLastHour(String type);
	
	List<SWFCImageMetaDTO> SelectRecentOneForEach();
}
