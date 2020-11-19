package com.gaia3d.web.mapper;

import java.util.List;

import com.gaia3d.web.dto.SWFCImageMetaDTO;
import com.gaia3d.web.mapper.simple.BasicMapper;

public interface SWFCImageMetaMapper extends BasicMapper<SWFCImageMetaDTO> {
	List<SWFCImageMetaDTO> SelectManyMovie(Object parameter);
	List<SWFCImageMetaDTO> SelectManyWithHour(Object parameter);
	
	List<SWFCImageMetaDTO> SelectManyIntertemporalByCode(Object parameter);
	
	List<SWFCImageMetaDTO> SelectManyWithLastHour(String type);
}
